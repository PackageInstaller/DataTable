local M = {}
local TAG = "message#"
local MAX_ID = 10000000
local FUNC_ID = 0
local inner_callback_temp_cache = {}
local outside_callback_weak_cache = {}
setmetatable(outside_callback_weak_cache, {__mode = "v"})

local function gen_fun_id()
  FUNC_ID = (FUNC_ID + 1) % MAX_ID
  local func_id_str = tostring(FUNC_ID)
  return func_id_str
end

local function cache_callback(func_id, func)
  inner_callback_temp_cache[func_id] = func
  outside_callback_weak_cache[func_id] = func
end

function M.recycle_callback(func_id)
  inner_callback_temp_cache[func_id] = nil
end

function M.find_callback(func_id)
  return inner_callback_temp_cache[func_id] or outside_callback_weak_cache[func_id]
end

local function generate_func_params(func)
  local func_id = gen_fun_id()
  local func_params = {}
  func_params._func_id = func_id
  cache_callback(func_id, func)
  _ejoysdk.log(TAG .. "generate_func_params, cache callback, func_id:" .. tostring(func_id) .. ", func:" .. tostring(func))
  return func_params
end

local function parse_table_params(param)
  local table_param = {}
  for k, sub_param in pairs(param) do
    if type(sub_param) == "function" then
      table_param[k] = generate_func_params(sub_param)
    elseif type(sub_param) == "table" then
      table_param[k] = parse_table_params(sub_param)
    else
      table_param[k] = sub_param
    end
  end
  return table_param
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

function M.serialize_call_to_message(module_name, fn_name, sync_cb, ...)
  local message = {}
  message.module = module_name
  message["function"] = fn_name
  local packed_params = {
    ...
  }
  local func_params = {}
  local params_size = table_maxn(packed_params)
  for idx = 1, params_size do
    local param = packed_params[idx]
    if "function" == type(param) then
      func_params[idx] = generate_func_params(param)
    elseif type(param) == "table" then
      func_params[idx] = parse_table_params(param)
    else
      func_params[idx] = param
    end
  end
  if sync_cb then
    local sync_cb_param = generate_func_params(sync_cb)
    table.insert(func_params, sync_cb_param)
  end
  message.params = func_params
  return message
end

function M.parse_message_to_call(message)
  local Bridge = require("ejoysdk_lua.ejoysdk_js_bridge_adapter")
  Bridge.input2(message)
end

return M
