local param_types = require("Foundation.System.rpc_define.param_types")
local tinsert = table.insert
local select = _ENV.select
local getinfo = debug.getinfo
local type = _ENV.type
local string = _ENV.string
local FunctionDef, DecoratorDef
local tmp_list = {}
local tmp_list_count = 0
local all_func_info = {}
local loaded_mod = {}
local M = {}
local Paramsas = {
  S = param_types.Str,
  N = param_types.Num,
  I = param_types.Int,
  B = param_types.Bool,
  T = param_types.Table
}

function M.rpc_function(...)
  local params = M.rpc_params(...)
  do return M.decorator end
  return M.decorator, function(info)
    if #params > 0 then
      info.params = params
    end
  end
end

function M.rpc_params(...)
  local params = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    if "string" == type(v) then
      local paramType = Paramsas[v]
      if not paramType then
        error("无法识别参数别名类型：%s", v)
      end
      v = paramType(i)
    end
    tinsert(params, v)
  end
  return params
end

function M.decorator(decoratorFunc)
  local func_info = getinfo(2)
  local info = {
    decorator = decoratorFunc,
    line = func_info.currentline,
    source = func_info.source
  }
  tmp_list[info.line] = info
  tmp_list_count = tmp_list_count + 1
end

function M.rpc_register_mod(mod_name, mod)
  if 0 == tmp_list_count then
    return
  end
  if all_func_info[mod] then
    M.clear_rpc_function()
    return
  end
  local func_list = {}
  local orderd_func = {}
  for k, v in pairs(mod) do
    if "function" == type(v) and not string.startswith(k, "__") then
      local func_info = getinfo(v)
      table.insert(orderd_func, {
        mod = mod,
        line = func_info.linedefined,
        source = func_info.source,
        func_name = k,
        func = v
      })
    end
  end
  table.sort(orderd_func, function(a, b)
    return a.line < b.line
  end)
  for i, rpcDef in pairs(tmp_list) do
    for ii, rpcFunc in ipairs(orderd_func) do
      if rpcFunc.line >= rpcDef.line then
        tinsert(func_list, rpcFunc)
        local func = rpcDef.decorator(rpcFunc)
        if nil ~= func and func ~= rpcDef.func then
          rawset(mod, rpcFunc.func_name, func)
        end
        break
      end
    end
  end
  assert(tmp_list_count == #func_list, "在预处理lua文件时找不到对应的函数，模块名：" .. mod_name)
  M.clear_rpc_function()
  if nil == loaded_mod[mod_name] then
    all_func_info[mod] = func_list
    loaded_mod[mod_name] = mod
  else
    mod = loaded_mod[mod_name]
    M.update_mod_funcs(mod, func_list)
  end
end

function M.update_mod_funcs(mod, new_func_list)
  local func_list = all_func_info[mod]
  for _, new in ipairs(new_func_list) do
    local found = false
    for _, old in ipairs(func_list) do
      if old.func_name == new.func_name then
        found = true
        old.params = new.params
        break
      end
    end
    if not found then
      tinsert(func_list, new)
    end
  end
end

function M.add_or_replace_func(mod_name, func_name, func, clear)
  local mod = loaded_mod[mod_name]
  if not mod then
    return
  end
  local func_info = getinfo(func)
  local line = func_info.linedefined
  local found
  for i = line - 1, line - 3, -1 do
    if tmp_list[i] then
      tmp_list[i].func_name = func_name
      found = tmp_list[i]
      break
    end
  end
  if found then
    M.update_mod_funcs(mod, {found})
  end
  if nil == clear then
    clear = true
  end
  if clear then
    M.clear_rpc_function()
  end
end

function M.clear_rpc_function()
  tmp_list = {}
  tmp_list_count = 0
end

function M.get_mod_funcs(mod)
  return all_func_info[mod]
end

return M
