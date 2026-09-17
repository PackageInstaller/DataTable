local cjson
local function loadcjson()
    cjson = require "cjson"
end

if pcall(loadcjson) then

print("use cjson")

json = {}

function json.encode(var)
    local r, msg = pcall(cjson.encode, var)
    if r then return msg end
    print(msg)
end

function json.decode(str)
    local r, msg = pcall(cjson.decode, str)
    if r then return msg end
    print(msg)
end

json.null = cjson.null

else

print("use luajson")

require "luajson"

end