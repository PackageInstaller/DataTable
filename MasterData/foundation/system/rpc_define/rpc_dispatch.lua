local string = _ENV.string
local tunpack = table.unpack
local cmd_funcs = {}
local key_funcs = {}
local M = {}

local function get_cls_mro(mod_name)
  local mod = package.loaded[mod_name]
  local mro = {mod}
  while true do
    local mt = getmetatable(mod)
    if mt and mod.__super then
      table.insert(mro, mod.__super)
      mod = mod.__super
    else
      break
    end
  end
  return mro
end

function M.add_comp_path(comp, mod_name)
  local mro = get_cls_mro(mod_name)
  for i = #mro, 1, -1 do
    M.add_path(comp, mro[i])
  end
end

function M.add_path(comp, mod)
  local funcs = rpc_collection.get_mod_funcs(mod)
  if funcs then
    for _, info in ipairs(funcs) do
      local key = comp .. "." .. info.func_name
      info.key = key
      info.mod_name = comp
      key_funcs[key] = info
    end
  end
end

function M.add_full_path(sproto_mod, obj, mod_name)
  local mro = get_cls_mro(mod_name)
  for i = #mro, 1, -1 do
    local funcs = rpc_collection.get_mod_funcs(mro[i])
    if not funcs then
      return
    end
    for _, info in ipairs(funcs) do
      local cmd = sproto_mod .. "." .. info.func_name
      info.obj = obj
      cmd_funcs[cmd] = info
    end
  end
end

function M.get_func_info_by_cmd(cmd)
  return cmd_funcs[cmd]
end

function M.get_func_info_by_key(key)
  return key_funcs[key]
end

function M.unpack_params(params, t, key)
  local args = {}
  local ok = true
  for i, param in ipairs(params) do
    local mt = param[3]
    local v = t[i]
    local new_v
    ok, new_v = pcall(mt.value, v)
    if ok then
      args[i] = new_v
    else
      args = string.format("rpc_func %s parameter(%d, %s) get error type %s", key, i, mt.type_name(), type(v))
      break
    end
  end
  return ok, args
end

function M.cmd_dispatch(obj, cmd, t)
  local info = cmd_funcs[cmd]
  if not info then
    return false, string.format("no cmd %s", cmd)
  end
  do return M.key_dispatch, obj, info.key end
  return M.key_dispatch, obj, info.key, t
end

function M.key_dispatch(obj, key, t)
  local target = obj
  local func_info = key_funcs[key]
  if not func_info then
    return false, string.format("rpc not defined key=%s", key)
  end
  if not target then
    return false, string.format("no target key=%s", key)
  end
  local func = func_info.func
  if func_info.params then
    local ok, result = M.unpack_params(func_info.params, t, key)
    if not ok then
      return false, result
    end
    do return xpcall, func, debug.traceback, target, tunpack(result, 1, #func_info.params) end
    return xpcall, func, debug.traceback, target, tunpack(result, 1, #func_info.params)
  else
    do return xpcall, func, debug.traceback end
    return xpcall, func, debug.traceback, target, debug.traceback, target, tunpack(result, 1, #func_info.params)
  end
end

return M
