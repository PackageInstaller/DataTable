local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local msgpack = require("ejoysdk_lua.libs.msgpack")
local unpack = table.unpack or _ENV.unpack
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local util = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "lua_adapter"
local native_call_lua_upload_now = false
local gangplank_inited = false
local has_listen_gangplank_inited = false
local stat_action_cache = {}

local function get_module(module_name)
  if module_name then
    if not E.Utils.start_with(module_name, "sdk_test") and not E.Utils.start_with(module_name, "ejoysdk_lua") and not string.find(module_name, "ejoysdk_quickstart.") and not string.find(module_name, "ejoysdk_demo.") then
      module_name = "ejoysdk_lua." .. tostring(module_name)
    end
    do return require, tostring(module_name) end
    return require, tostring(module_name)
  else
    return nil
  end
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

local function output(msg)
  _ejoysdk.log("lua adapter output: " .. tostring(msg))
  if M.output then
    M.output(msg)
  end
  if E.Sysinfo.os() == "ios" then
    if _ejoysdk.lua_adapter_output then
      _ejoysdk.lua_adapter_output(msg)
    end
  elseif E.Sysinfo.os() == "android" then
    E.invoke("LUA_ADAPTER_OUTPUT", {message = msg})
  end
end

local function gangplank_inited_listen_action()
  gangplank_inited = true
  for _, v in pairs(stat_action_cache) do
    ESTAT.stat_action_with_limit(TAG, v.stat_key, v.action, v.action_type, v.stat_param or {})
  end
  stat_action_cache = {}
end

local function record_param_value(t, v)
  if type(v) == "boolean" then
    table.insert(t, v)
  elseif type(v) == "userdata" then
    table.insert(t, "_userdata_placeholder")
  elseif type(v) == "nil" then
    table.insert(t, "_nil_placeholder")
  elseif type(v) == "string" then
    table.insert(t, "_string_placeholder")
  elseif type(v) == "table" then
    table.insert(t, "_table_placeholder")
  elseif type(v) == "thread" then
    table.insert(t, "_thread_placeholder")
  elseif type(v) == "number" then
    if v > 100000000000 then
      table.insert(t, "_big_number_placeholder")
    else
      table.insert(t, v)
    end
  elseif type(v) == "function" then
    table.insert(t, "_function_placeholder")
  else
    table.insert(t, "_unknown_placeholder")
  end
end

local function is_jf_open_native_bridge_lua_from_cc()
  local cc_config = ECC.get_config(ECC.NAMESPACE.EJOYSDK_BIZ)
  local jf_config = cc_config and cc_config.config and cc_config.config.jf_config
  if jf_config and jf_config.is_open_native_bridge_lua then
    return true
  end
  return false
end

local function exe_stat_action(stat_key, action, action_type, stat_param)
  assert(stat_key, "stat_key miss")
  assert(action, "action miss")
  assert(action_type, "action_type miss")
  assert(stat_param, "stat_param miss")
  if gangplank_inited then
    ESTAT.stat_action_with_limit(TAG, stat_key, action, action_type, stat_param)
  else
    if not has_listen_gangplank_inited then
      has_listen_gangplank_inited = true
      local ET = require("ejoysdk_lua.ejoysdk_topic")
      ET.subscribe(ET.gangplank.INITED, gangplank_inited_listen_action)
    end
    local cache_item = {}
    cache_item.stat_key = stat_key
    cache_item.action = action
    cache_item.action_type = action_type
    cache_item.stat_param = stat_param
    table.insert(stat_action_cache, cache_item)
  end
end

local _id_to_function = {}

local function callback_function(module_name, func_name, func_id, callback_params)
  local callback_value = {
    module = module_name,
    ["function"] = func_name,
    _func_id = func_id,
    params = _ejoysdk_crypt.base64encode(msgpack.encode(callback_params or {}) or ""),
    type = "callback"
  }
  if callback_value.module and callback_value["function"] and callback_value._func_id then
    local call_data = {}
    if is_jf_open_native_bridge_lua_from_cc() then
      local stat_key = string.format("[callback]%s-%s", tostring(callback_value.module), tostring(callback_value["function"]))
      local action_type = stat_key
      call_data.callback_func_id = callback_value._func_id or ""
      call_data.type = "native_call_lua_callback"
      call_data.module = tostring(callback_value.module)
      call_data["function"] = tostring(callback_value["function"])
      local stat_param = {}
      stat_param._call_data = call_data
      stat_param.is_priority_high = native_call_lua_upload_now
      exe_stat_action(stat_key, "native_call_lua_callback", action_type, stat_param)
    end
    
    local function print_log()
      local call_data_params = {}
      for _, v in pairs(callback_params or {}) do
        record_param_value(call_data_params, v)
      end
      local call_data_copy = util.deepcopy(call_data)
      call_data_copy.params_value = call_data_params
      E.LOG.debug(TAG, call_data_copy)
    end
    
    pcall(print_log)
  end
  local ok, encode_json = pcall(JSON.encode, callback_value)
  if ok then
    output(encode_json)
  else
    _ejoysdk.log("不支持的回调值, module：" .. module_name .. " ,function: " .. tostring(func_name))
  end
end

local function return_function(module_name, func_name, func_id, return_params)
  local return_value = {
    module = module_name,
    ["function"] = func_name,
    params = _ejoysdk_crypt.base64encode(msgpack.encode(return_params or {}) or ""),
    _func_id = func_id,
    type = "return"
  }
  local ok, encode_json = pcall(JSON.encode, return_value)
  if ok then
    output(encode_json)
  else
    _ejoysdk.log("不支持的返回值, module：" .. module_name .. " ,function: " .. tostring(func_name))
    return_value.params = {}
    output(JSON.encode(return_value))
  end
  if return_value.module and return_value["function"] and return_value._func_id then
    local call_data = {}
    if is_jf_open_native_bridge_lua_from_cc() then
      local stat_key = string.format("[return]%s-%s", return_value.module, return_value["function"])
      local action_type = stat_key
      call_data.return_func_id = return_value._func_id or ""
      call_data.type = "native_call_lua_return"
      call_data.module = return_value.module or ""
      call_data["function"] = return_value["function"] or ""
      if not ok then
        call_data.has_error = "return_value_type_error"
      else
        call_data.has_error = "no_error"
      end
      local stat_param = {}
      stat_param._call_data = call_data
      stat_param.is_priority_high = native_call_lua_upload_now
      exe_stat_action(stat_key, "native_call_lua_return", action_type, stat_param)
    end
    
    local function print_log()
      local call_data_params = {}
      for _, v in pairs(return_params or {}) do
        record_param_value(call_data_params, v)
      end
      local call_data_copy = util.deepcopy(call_data)
      call_data_copy.params_value = call_data_params
      E.LOG.debug(TAG, call_data_copy)
    end
    
    pcall(print_log)
  end
end

local function create_callback_function(module, func, func_id)
  local function callback(...)
    callback_function(module, func, func_id, {
      ...
    })
  end
  
  return callback
end

local function parse_function_param(module_name, func_name, param)
  local param_type = type(param)
  if "table" == param_type then
    local func_id = param._func_id
    if func_id then
      local callback_func = create_callback_function(module_name, func_name, func_id)
      _id_to_function[func_id] = callback_func
      param = callback_func
    else
      for key, value in pairs(param) do
        param[key] = parse_function_param(module_name, func_name, value)
      end
    end
  end
  return param
end

local function parse_function(module_name, body)
  require("ejoysdk_lua.native.core.init")
  local module = get_module(module_name)
  local func_name = body["function"]
  if func_name and module then
    local invoke_fun = module
    string.gsub(func_name, "[^\\.]+", function(w)
      invoke_fun = invoke_fun[w]
    end)
    if invoke_fun and "function" == type(invoke_fun) then
      local params = body.params or {}
      local func_id = body._func_id or ""
      _ejoysdk.log("log moudle function params")
      E.log({params = params})
      local func_params = {}
      local params_size = table_maxn(params)
      for i = 1, params_size do
        local param = params[i]
        if type(param) == "table" then
          func_params[i] = parse_function_param(module_name, func_name, param)
        else
          func_params[i] = param
        end
      end
      E.LOG.debug(TAG, "invoke_fun >>")
      E.log(func_params)
      local result = {}
      local ok
      ok, result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10] = pcall(invoke_fun, unpack(func_params, 1, params_size))
      local return_params = {}
      if ok then
        if #result > 0 then
          for i = 1, #result do
            return_params[i] = result[i]
          end
          _ejoysdk.log("return params count: " .. tostring(#return_params))
        end
        return_function(module_name, func_name, func_id, return_params)
      else
        _ejoysdk.log("调用函数失败, module: " .. module_name .. ", function: " .. func_name .. ", error: " .. tostring(result[1]))
      end
    end
  end
end

local function return_variable(module_name, variable_name, variable)
  local callback_value = {
    module = module_name,
    variable = variable_name,
    value = variable
  }
  output(JSON.encode(callback_value))
end

local function parse_variable(module_name, body)
  local module = get_module(module_name)
  local variable_name = body.variable
  if variable_name then
    local variable = module[variable_name]
    if variable then
      return_variable(module_name, variable_name, variable)
    end
  end
end

local function parse_call(body_b64, is_plain)
  _ejoysdk.log("lua adapter input(b64): " .. tostring(body_b64))
  local body = body_b64
  if not is_plain then
    local body_bin = _ejoysdk_crypt.base64decode(body_b64)
    body = msgpack.decode(body_bin)
  end
  if not body or type(body) ~= "table" then
    return
  else
    local module_name = body.module
    if not module_name or not get_module(module_name) then
      return
    end
    if body["function"] then
      local call_data = {}
      if is_jf_open_native_bridge_lua_from_cc() then
        local stat_key = string.format("[call]%s-%s", tostring(module_name), tostring(body["function"]))
        local action_type = stat_key
        call_data.return_func_id = body._func_id or ""
        call_data.module = tostring(module_name)
        call_data["function"] = tostring(body["function"])
        call_data.type = "native_call_lua"
        local stat_param = {}
        stat_param._call_data = call_data
        stat_param.is_priority_high = native_call_lua_upload_now
        exe_stat_action(stat_key, "native_call_lua", action_type, stat_param)
      end
      
      local function print_log()
        local call_data_params = {}
        if body.params and type(body.params) == "table" then
          for _, v in pairs(body.params or {}) do
            record_param_value(call_data_params, v)
          end
        end
        local call_data_copy = util.deepcopy(call_data)
        call_data_copy.params_value = call_data_params
        E.LOG.debug(TAG, call_data_copy)
      end
      
      pcall(print_log)
    end
    parse_function(module_name, body)
    parse_variable(module_name, body)
  end
end

M.input = parse_call
return M
