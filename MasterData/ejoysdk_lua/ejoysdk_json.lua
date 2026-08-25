local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_json"
local M = {}
local JSON
if _ejoysdk and _ejoysdk.log then
  _ejoysdk.log(TAG .. "#using lunajson as json-parser")
end
JSON = require("ejoysdk_lua.libs.lunajson")

function M.newArray()
  return {
    [0] = 0
  }
end

M.is_cjson = false

local function cjsonEncodeEmptyTableAsArray(json_, ...)
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

local function encodeWithOptionFunction(json_, opts, ...)
  if M.is_cjson and opts and opts.encode_all_empty_array then
    do return cjsonEncodeEmptyTableAsArray, json_, ... end
    return cjsonEncodeEmptyTableAsArray, json_, ...
  end
  local ok, result = pcall(JSON.encode, json_, ...)
  if ok then
    return result
  else
    return nil
  end
end

local is_lua51 = _VERSION == "Lua 5.1"
if is_lua51 then
  function encodeWithOptionFunction(json_, opts, ...)
    if M.is_cjson and opts and (opts.encode_empty_array or opts.encode_all_empty_array) then
      do return cjsonEncodeEmptyTableAsArray, json_, ... end
      
      return cjsonEncodeEmptyTableAsArray, json_, ...
    end
    local ok, result = pcall(JSON.encode, json_, ...)
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

function M.enable_cjson(_enable)
  local version_support = false
  if _ejoysdk_lua_cjson and _ejoysdk_lua_cjson.is_support_global then
    version_support = _ejoysdk_lua_cjson.is_support_global()
  end
  if not version_support then
    if _ejoysdk and _ejoysdk.log then
      _ejoysdk.log(TAG .. "#native version not support global cjson")
    end
    return
  end
  if _ejoysdk and _ejoysdk.os and _ejoysdk.os() == "android" and _ejoysdk.sync_call then
    local json_ret = _ejoysdk.sync_call("com/ejoy/ejoysdk/LuaCall", "SYSINFO_OS_VERSION", "{}", "")
    local os_version = (json_ret and decodeFunction(json_ret) or {}).value or ""
    local os_version_number = tonumber(os_version) or 20
    if os_version_number <= 19 then
      _enable = false
    end
  end
  if _enable and _ejoysdk_lua_cjson then
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
    if _ejoysdk and _ejoysdk.log then
      _ejoysdk.log(TAG .. "#using cjson as json-parser")
    end
  else
    JSON = require("ejoysdk_lua.libs.lunajson")
    
    function M.newArray()
      return {
        [0] = 0
      }
    end
    
    M.is_cjson = false
  end
  M.encode = encodeFunction
  M.safe_encode = encodeFunction
  M.safe_decode = decodeFunction
  M.decode = decodeFunction
  M.encode_with_option = encodeWithOptionFunction
end

if not is_lua51 then
  M.enable_cjson(true)
end

function M._debug_hook_and_check(cb)
  if M.is_cjson == true then
    _ejoysdk.log(TAG .. "#start hook")
    local LUAJSON = require("ejoysdk_lua.libs.lunajson")
    local UTIL = require("ejoysdk_lua.ejoysdk_utils")
    local E = require("ejoysdk_lua.ejoysdk")
    local options = {
      string_cmp_func = function(ta, tb)
        return ta:gsub("\\/", "/") == tb
      end
    }
    local sp = {
      [0] = 0
    }
    
    local function replaceNewJsonArray(tmp)
      if type(tmp) == "table" then
        if getmetatable(tmp) and getmetatable(tmp).__len and 0 == getmetatable(tmp).__len(tmp) then
          tmp = sp
        else
          for k, v in pairs(tmp) do
            tmp[k] = replaceNewJsonArray(v)
          end
        end
      end
      return tmp
    end
    
    local function resetJsonArray(tmp)
      if tmp == sp then
        tmp = {}
      elseif type(tmp) == "table" then
        for k, v in pairs(tmp) do
          tmp[k] = resetJsonArray(v)
        end
      end
      return tmp
    end
    
    local function hookEncodeFunction(json_, ...)
      local result_old = encodeFunction(json_, ...)
      local ok, result_hook = pcall(LUAJSON.encode, json_, ...)
      if not ok then
        result_hook = nil
      end
      local r1, _ra, _rb = UTIL.deep_equals(result_old, result_hook, options)
      if not r1 then
        E.LOG.debug("using_cjson", "check array again")
        E.log(json_)
        replaceNewJsonArray(json_)
        ok, result_hook = pcall(LUAJSON.encode, json_, ...)
        resetJsonArray(json_)
        E.log(json_)
        E.log(result_hook)
        if not ok then
          result_hook = nil
        end
        r1, _ra, _rb = UTIL.deep_equals(result_old, result_hook, options)
        if not r1 then
          E.LOG.error("using_cjson", "cjson return the different result!!, hookEncodeFunction:")
          E.log(_ra)
          E.log(_rb)
          E.log_traceback()
          if cb then
            cb(r1, _ra, _rb)
          end
        end
      end
      return result_old
    end
    
    local function hookDecodeFunction(json_, ...)
      local result_old = decodeFunction(json_, ...)
      local result_hook
      if "" == json_ then
        result_hook = nil
      else
        local ok, result_hook_temp = pcall(LUAJSON.decode, json_, ...)
        if ok then
          result_hook = result_hook_temp
        end
      end
      local r1, ra, rb = UTIL.deep_equals(result_old, result_hook)
      if not r1 then
        E.LOG.error("using_cjson", "cjson return the different result!!, hookDecodeFunction:")
        E.log(ra)
        E.log(rb)
        E.log_traceback()
        if cb then
          cb(r1, ra, rb)
        end
      end
      return result_old
    end
    
    local function hookEncodeWithOptionFunction(json_, opts, ...)
      local result_old = encodeWithOptionFunction(json_, opts, ...)
      local ok, result_hook = pcall(LUAJSON.encode, json_, ...)
      if not ok then
        result_hook = nil
      end
      local r1, _ra, _rb = UTIL.deep_equals(result_old, result_hook, options)
      if not r1 then
        E.LOG.debug("using_cjson", "check array again")
        replaceNewJsonArray(json_)
        ok, result_hook = pcall(LUAJSON.encode, json_, ...)
        resetJsonArray(json_)
        if not ok then
          result_hook = nil
        end
        r1, _ra, _rb = UTIL.deep_equals(result_old, result_hook, options)
        if not r1 then
          E.LOG.error("using_cjson", "cjson return the different result!!, hookEncodeWithOptionFunction:")
          E.log(_ra)
          E.log(_rb)
          E.log_traceback()
          if cb then
            cb(r1, _ra, _rb)
          end
        end
      end
      return result_old
    end
    
    M.encode = hookEncodeFunction
    M.safe_encode = hookEncodeFunction
    M.safe_decode = hookDecodeFunction
    M.decode = hookDecodeFunction
    M.encode_with_option = hookEncodeWithOptionFunction
  end
end

return M
