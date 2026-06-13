local Util = require("utils.util")
local Config = require("config")
local M = Util.create_class()
local _sformat = string.format
local _insert = table.insert
local POOL_INFOS = {}
local POOLS = {}

function M.register(key, max_free_count, class)
  assert(nil == POOL_INFOS[key], _sformat("lua_obj_pool_mgr: error %s exist", key))
  local pool_info = {
    class = class,
    max_free_count = max_free_count,
    free_count = 0,
    active_count = 0,
    free_objs = {},
    active_objs = setmetatable({}, Config.VALUE_WEAK_METATABLE),
    key = key
  }
  local pool = M:new(pool_info)
  POOL_INFOS[key] = pool_info
  POOLS[key] = pool
  return pool
end

function M.release_all_pool()
  M.release_all_pool_active_objs()
  M.release_all_pool_free_objs()
  UtilTable.clear_map(POOLS)
  UtilTable.clear_map(POOL_INFOS)
end

function M.print_all_pool()
  for key, pool in pairs(POOLS) do
    Log.Error("pool: ", key, " active_count: ", pool:get_active_count(), " free_count: ", pool:get_free_count())
  end
end

function M.check_exist(key)
  return nil ~= POOLS[key]
end

function M.get_pool(key)
  return POOLS[key]
end

function M.release_all_pool_active_objs()
  for _, pool in pairs(POOLS) do
    pool:release_active_objs()
  end
end

function M.release_all_pool_free_objs()
  for _, pool in pairs(POOLS) do
    pool:release_free_objs()
  end
end

function M:_init(pool_info)
  self.v_pool_info = pool_info
end

function M:get_active_objs()
  return self.v_pool_info.active_objs
end

function M:new_obj(...)
  local free_count = self.v_pool_info.free_count
  local obj
  if free_count > 0 then
    obj = self.v_pool_info.free_objs[free_count]
    obj:_init(...)
    self.v_pool_info.free_objs[free_count] = nil
    self.v_pool_info.free_count = free_count - 1
    self.v_pool_info.active_objs[obj] = true
    self.v_pool_info.active_count = self.v_pool_info.active_count + 1
  else
    obj = self.v_pool_info.class:new(...)
    self.v_pool_info.active_objs[obj] = true
    self.v_pool_info.active_count = self.v_pool_info.active_count + 1
    if self.v_pool_info.active_count >= 500 then
      if not self.v_throw_to_many_error_lock then
        Global.log.Error("too many active lua objs, count : ", self.v_pool_info.active_count, "   key:  ", self.v_pool_info.key, debug.traceback())
      end
      self.v_throw_to_many_error_lock = GAME_RELEASE
    else
      self.v_throw_to_many_error_lock = nil
    end
  end
  if UNITY_EDITOR then
    obj.___destroy_in_pool = false
  end
  return obj
end

function M:destroy_obj(obj)
  if UNITY_EDITOR then
    if obj.___destroy_in_pool then
      Log.Error("重复destroy lua obj!!", self.v_pool_info.key, debug.traceback())
    end
    obj.___destroy_in_pool = true
  end
  obj:on_destroy()
  self.v_pool_info.active_objs[obj] = nil
  self.v_pool_info.active_count = self.v_pool_info.active_count - 1
  if self.v_pool_info.free_count < self.v_pool_info.max_free_count then
    _insert(self.v_pool_info.free_objs, obj)
    self.v_pool_info.free_count = self.v_pool_info.free_count + 1
  end
end

function M:get_active_count()
  return self.v_pool_info.active_count
end

function M:get_free_count()
  return self.v_pool_info.free_count
end

function M:release_active_objs()
  for active_obj, _ in pairs(self.v_pool_info.active_objs) do
    self:destroy_obj(active_obj)
  end
  self.v_throw_to_many_error_lock = nil
  UtilTable.clear_map(self.v_pool_info.active_objs)
end

function M:call_free_objs_on_release()
  for key, obj in pairs(self.v_pool_info.free_objs) do
    if obj and obj.on_release then
      obj:on_release()
    end
  end
end

function M:release_free_objs()
  self:call_free_objs_on_release()
  self.v_pool_info.free_count = 0
  self.v_throw_to_many_error_lock = nil
  UtilTable.clear_map(self.v_pool_info.free_objs)
end

return M
