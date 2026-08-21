
local crypt = require "crypt"

local CommonBusiness = {}

function CommonBusiness.GetAuthDate()
	local date = os.date("%a, %d %b %Y %X GMT", luautil.getGmtStamp())
	return date
end

function CommonBusiness.GenAuth(method, date, url)
	local secretAcccessKeyID  = "db0123456db0123456"
	local secretAccessKey = "abcdef01234567890abcdef01234567890"

	local stringToSign = method .. "\n" .. date .. "\n" .. url

	local signature = crypt.base64encode(crypt.hmac_sha1(secretAccessKey, stringToSign))
	local authorization = "HMS" .. " " .. secretAcccessKeyID .. ":" .. signature; 

	return authorization
end

return CommonBusiness