local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_cjson"
local M = {}
local JSON
if _ejoysdk_lua_cjson then
  JSON = _ejoysdk_lua_cjson
  
  function M.newArray()
    local empty_array = {}
    local array_meta_table = {
      __len = function(tbl)
        local count = 0
        for _ in pairs(tbl) do
          count = count + 1
        end
        return count
      end
    }
    setmetatable(empty_array, array_meta_table)
    return empty_array
  end
  
  M.is_cjson = true
else
  _ejoysdk.log(TAG .. "#inner using lunajson as cjson-parser")
  JSON = require("ejoysdk_lua.libs.lunajson")
  
  function M.newArray()
    return {
      [0] = 0
    }
  end
  
  M.is_cjson = false
end

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

local function encodeFunction(json_, ...)
  local ok, result = pcall(JSON.encode, json_, ...)
  if ok then
    return result
  else
    return nil
  end
end

local function encodeEmptyTableAsArray(json_, ...)
  if JSON.encode_empty_table_as_array then
    JSON.encode_empty_table_as_array(true)
  end
  local ok, result = pcall(JSON.encode, json_, ...)
  if JSON.encode_empty_table_as_array then
    JSON.encode_empty_table_as_array(false)
  end
  if ok then
    return result
  else
    return nil
  end
end

local function prepareFunction()
  if _ejoysdk.os() == "android" then
    local E = require("ejoysdk_lua.ejoysdk")
    local os_version = E.Sysinfo.os_version() or ""
    local os_version_number = tonumber(os_version) or 20
    if os_version_number <= 19 then
      _ejoysdk.log(TAG .. "#inner using lunajson as cjson-parser (Android: " .. tostring(os_version_number) .. "<= 19)")
      JSON = require("ejoysdk_lua.libs.lunajson")
      
      function M.newArray()
        return {
          [0] = 0
        }
      end
    end
  end
end

M.safe_decode = decodeFunction
M.safe_encode = encodeFunction
M.encode = encodeFunction
M.decode = decodeFunction
M.prepare = prepareFunction
M.encode_as_array = encodeEmptyTableAsArray
return M
