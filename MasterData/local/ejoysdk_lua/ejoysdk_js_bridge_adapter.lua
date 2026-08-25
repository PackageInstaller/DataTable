local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local unpack = table.unpack or _ENV.unpack
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "js_bridge_adapter"
local M = {}
M.VER = {V1 = "v1", V2 = "v2"}

local function get_module(module_name)
  if module_name then
    if not E.Utils.start_with(module_name, "sdk_test") and not E.Utils.start_with(module_name, "ejoysdk_lua") and not E.Utils.start_with(module_name, "ejoysdk_windows_launcher") and not string.find(module_name, "ejoysdk_quickstart.") and not string.find(module_name, "ejoysdk_demo.") then
      module_name = "ejoysdk_lua." .. tostring(module_name)
    end
    do return require, tostring(module_name) end
    return require, tostring(module_name)
  else
    return nil
  end
end

local _id_to_function = {}

local function callback_function(func_id, callback_params, use_output2)
  if use_output2 then
    if M.output2 then
      M.output2(func_id, callback_params)
    end
  elseif M.output then
    M.output(func_id, callback_params)
  end
end

local function return_function(func_id, return_params, use_output2)
  do return callback_function, func_id, return_params end
  return callback_function, func_id, return_params, use_output2
end

local function create_callback_function(_module, _func, func_id, use_output2)
  local function callback(...)
    local ret = (...)
    
    if type(ret) ~= "table" or ret.ver ~= M.VER.V2 then
      ret = {
        ...
      }
    end
    callback_function(func_id, ret, use_output2)
  end
  
  return callback
end

local function parse_function_param(module_name, func_name, param, use_output2)
  local param_type = type(param)
  if "table" == param_type then
    local func_id = param._func_id
    if func_id then
      local callback_func = create_callback_function(module_name, func_name, func_id, use_output2)
      _id_to_function[func_id] = callback_func
      param = callback_func
    else
      for key, value in pairs(param) do
        param[key] = parse_function_param(module_name, func_name, value, use_output2)
      end
    end
  end
  return param
end

local function table_maxn(t)
  local mn = 0
  for k, _ in pairs(t) do
    if k > mn then
      mn = k
    end
  end
  return mn
end

local function parse_function(module_name, body, use_output2)
  local module = get_module(module_name)
  local func_name = body["function"]
  E.LOG.debug(TAG, "parse function, module >> " .. tostring(module_name) .. ", func_name >> " .. tostring(func_name))
  if func_name and module then
    local invoke_fun = module
    string.gsub(func_name, "[^\\.]+", function(w)
      invoke_fun = invoke_fun[w]
    end)
    if invoke_fun and "function" == type(invoke_fun) then
      local params = body.params or {}
      local sync_call = body.syncCall or false
      local func_params = {}
      for i, param in ipairs(params) do
        if type(param) == "table" then
          func_params[i] = parse_function_param(module_name, func_name, param, use_output2)
        else
          func_params[i] = param
        end
      end
      E.LOG.debug(TAG, "pcall function, sync_call >> " .. tostring(sync_call))
      local call_result = {
        pcall(invoke_fun, unpack(func_params))
      }
      local ok = call_result[1]
      if ok then
        E.LOG.debug(TAG, "pcall function return, sync_call >> " .. tostring(sync_call))
        if sync_call then
          local func_id = params._func_id or ""
          for _, param in ipairs(params) do
            if type(param) == "table" and param._func_id then
              func_id = param._func_id
            end
          end
          local call_result_len = table_maxn(call_result)
          if call_result_len > 1 then
            table.remove(call_result, 1)
            E.LOG.debug(TAG, "return params count: " .. tostring(#call_result))
          else
            call_result = {}
          end
          E.LOG.debug(TAG, "return function >> " .. tostring(sync_call))
          return_function(func_id, call_result, use_output2)
        end
      else
        E.LOG.warn(TAG, "调用函数失败, module: " .. tostring(module_name) .. ", function: " .. tostring(func_name) .. ", error: " .. tostring(call_result[2]))
      end
    end
  else
    E.LOG.debug(TAG, "parse function, module or function name is nil")
  end
end

local function parse_call(body, use_output2)
  E.LOG.debug(TAG, "lua adapter input(plain): " .. tostring(body))
  if not body or type(body) ~= "table" then
    return
  else
    local module_name = body.module
    if not module_name or not get_module(module_name) then
      return
    end
    parse_function(module_name, body, use_output2)
  end
end

local function parse_call2(body)
  parse_call(body, true)
end

M.input = parse_call
M.output = nil
M.input2 = parse_call2
M.output2 = nil
return M
