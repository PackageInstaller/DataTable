local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_lunajson"
local M = {}
local JSON
if _ejoysdk and _ejoysdk.log then
  _ejoysdk.log(TAG .. "#old using lunajson")
end
JSON = require("ejoysdk_lua.libs.lunajson")

function M.newArray()
  return {
    [0] = 0
  }
end

M.is_cjson = false

local function encodeWithOptionFunction(json_, _opts, ...)
  local ok, result = pcall(JSON.encode, json_, ...)
  if ok then
    return result
  else
    return nil
  end
end

local function encodeFunction(json_, ...)
  local ok, result = pcall(JSON.encode, json_, ...)
  if ok then
    return result
  else
    return nil
  end
end

M.encode = encodeFunction
M.safe_encode = encodeFunction

local function decodeFunction(json_, ...)
  if "" == json_ then
    return nil
  else
    local ok, result = pcall(JSON.decode, json_, ...)
    if ok then
      return result
    else
      return nil
    end
  end
end

M.safe_decode = decodeFunction
M.decode = decodeFunction
M.encode_with_option = encodeWithOptionFunction
return M
