request_owner_password() {
    domain=$1
    client_id=$2
    client_secret=$3
    username=$4
    password=$5
    
    curl -sX POST --url "https://$domain/oauth/token" \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data-urlencode "audience=https://kpi.eu.auth0.com/api/v2/" \
        --data-urlencode "grant_type=http://auth0.com/oauth/grant-type/password-realm" \
        --data-urlencode "client_id=$client_id" \
        --data-urlencode "client_secret=$client_secret" \
        --data-urlencode "username=$username" \
        --data-urlencode "password=$password" \
        --data-urlencode "scope=offline_access" \
        --data-urlencode "realm=Username-Password-Authentication"
}

request_refresh_token() {
    domain=$1
    client_id=$2
    client_secret=$3
    token=$4
    
    curl -sX POST --url "https://$domain/oauth/token" \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data-urlencode "grant_type=refresh_token" \
        --data-urlencode "client_id=$client_id" \
        --data-urlencode "client_secret=$client_secret" \
        --data-urlencode "refresh_token=$token"
}


runt() {
    echo -e "\n"
    res=$(request_owner_password $1 $2 $3 $4 $5)
    echo -e "$res\n"
    
    token=$(echo "$res" | jq .refresh_token | tr -d '"')
    echo -e "refresh_token: $token\n"
    
    res=$(request_refresh_token $1 $2 $3 $token)
    echo -e "$res\n"
    token=$(echo "$res" | jq .access_token | tr -d '"')
    echo -e "access_token: $token\n"
    echo -e "\n"
}

domain=kpi.eu.auth0.com
kpi_id=JIvCO5c2IBHlAe2patn6l6q5H35qxti0
kpi_secret=ZRF8Op0tWM36p1_hxXTU-B0K_Gq_-eAVtlrQpY24CasYiDmcXBhNS6IJMNcz1EgB
usr=vladtarasuk03@gmail.com
passwrd=#Bibus35
runt $domain $kpi_id $kpi_secret $usr $passwrd

