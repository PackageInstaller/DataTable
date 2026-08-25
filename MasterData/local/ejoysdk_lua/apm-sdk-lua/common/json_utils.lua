local E = require("ejoysdk_lua.ejoysdk")
local M = {}
M.__index = M
local LOGGER = "apm_json_utils"
local _cjson_lib_path

function M.set_cjson_lib_path(cjson_lib_path)
  E.LOG.debug(LOGGER, "set json-parser, cjson_lib_path:" .. cjson_lib_path)
  if type(cjson_lib_path) == "string" and "" ~= cjson_lib_path then
    _cjson_lib_path = cjson_lib_path
    M.init()
  end
end

function M.init()
  local JSON
  if _cjson_lib_path then
    local ok, module = pcall(require, _cjson_lib_path)
    if ok and module and module.decode and module.encode then
      E.LOG.debug(LOGGER, "using cjson as json-parser, cjson_lib_path:" .. _cjson_lib_path)
      JSON = module
    end
  end
  if not JSON then
    E.LOG.debug(LOGGER, "using ejoysdk_cjson as json-parser")
    JSON = require("ejoysdk_lua.ejoysdk_cjson")
  end
  
  local function encodeFunction(obj)
    if type(JSON.encode_with_option) == "function" then
      do return JSON.encode_with_option, obj end
      return JSON.encode_with_option, obj, {encode_empty_array = true}
    end
    do return JSON.encode end
    return JSON.encode, obj, {encode_empty_array = true}
  end
  
  M.encode = encodeFunction
  
  local function decodeFunction(json_str, ...)
    if "" == json_str then
      return nil
    else
      local ok, result = pcall(JSON.decode, json_str, ...)
      if ok then
        return result
      else
        return nil
      end
    end
  end
  
  M.safe_decode = decodeFunction
  M.decode = decodeFunction
end

return M
