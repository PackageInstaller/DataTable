local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")

local function _limit(new_value, config, limit_attr_name, index)
  if nil == index then
    if nil == config[limit_attr_name] then
      return new_value
    end
    return math.min(new_value, config[limit_attr_name])
  end
  local limit_arr = config[limit_attr_name]
  if nil == limit_arr then
    return new_value
  end
  if nil == limit_arr[index] then
    return new_value
  end
  return math.min(new_value, limit_arr[index])
end

local LIMIT_FILTER = {
  LiveTime = {
    "LiveTimeLimit"
  },
  AtkCD = {"AtkCDLimit"},
  SizeX = {
    "MissileSizeLimit",
    1
  },
  SizeY = {
    "MissileSizeLimit",
    2
  },
  SizeZ = {
    "MissileSizeLimit",
    3
  },
  OffsetX = {
    "MissileOffsetLimit",
    1
  },
  OffsetY = {
    "MissileOffsetLimit",
    2
  },
  OffsetZ = {
    "MissileOffsetLimit",
    3
  }
}
local ALLOW_FILTER = {
  LiveTime = true,
  SizeX = true,
  SizeY = true,
  SizeZ = true,
  OffsetX = true,
  OffsetY = true,
  OffsetZ = true,
  magic = true,
  AtkCD = true,
  EffectScale = true,
  EffectTimeScale = true,
  BornPosition = true
}
local CHANGE_MODE = {REPLACE = 0, ALTER = 1}

local function _limit_dynamic_attr(config, attr_name, new_value)
  local filter = LIMIT_FILTER[attr_name]
  if filter then
    return _limit(new_value, config, filter[1], filter[2])
  else
    return new_value
  end
end

local ReplacedMissileConfig = Util.create_class()

local function _replace_new_value(self, replace_data, k, v, config)
  local new_value = replace_data[k]
  if new_value then
    if replace_data.__CHANGE_MODE__ == CHANGE_MODE.ALTER then
      new_value = new_value + v
    end
    self[k] = _limit_dynamic_attr(config, k, new_value)
    if "LiveTime" == k then
      self.__HOOKED_LIFE_TIME__ = true
    end
  else
    self[k] = v
  end
end

function ReplacedMissileConfig:_init(missile_id, replace_data)
  local config = ShareRes.get_missile(missile_id)
  for rk in pairs(replace_data) do
    if ReplacedMissileConfig[rk] then
      _replace_new_value(self, replace_data, rk, ReplacedMissileConfig[rk], config)
    end
  end
  for k, v in pairs(config) do
    _replace_new_value(self, replace_data, k, v, config)
  end
  self.__HOOKED__ = true
end

function ReplacedMissileConfig:on_destroy()
  local missile_id = self.Id
  local config = missile_id and ShareRes.get_missile(missile_id)
  for k, v in pairs(self) do
    if ReplacedMissileConfig.__index[k] or config and nil == config[k] then
      self[k] = nil
    end
  end
end

local M = Util.create_class()

function M:_init()
  self.v_dic = {}
  self.v_pool = LuaObjPoolMgr.get_pool("mssile_config_hook_pool") or LuaObjPoolMgr.register("mssile_config_hook_pool", 30, ReplacedMissileConfig)
  self:copy_missile_defualt_values()
end

function M:copy_missile_defualt_values()
  local missiles = ShareRes.create("skill.missile")
  if not missiles or not missiles.DEFUALT_VALUES then
    return
  end
  local defualt_values = missiles.DEFUALT_VALUES
  local mt_index = ReplacedMissileConfig.__index
  if mt_index and not mt_index.__GET_METATABLE_SUC then
    for k, v in pairs(defualt_values) do
      if not mt_index[k] then
        mt_index[k] = v
      end
    end
    mt_index.__GET_METATABLE_SUC = true
  end
end

function M:hook(missile_id, attr_name, new_value, change_mode)
  if not ALLOW_FILTER[attr_name] then
    Log.Error("该字段的修改未开放，请去找程序看看能不能开放这个字段", attr_name, debug.traceback())
    return
  end
  local hooker_data = self.v_dic[missile_id]
  if nil == hooker_data then
    hooker_data = {}
    self.v_dic[missile_id] = hooker_data
  end
  hooker_data[attr_name] = new_value
  hooker_data.__CHANGE_MODE__ = change_mode
end

function M:get_config(missile_id)
  local hooker_data = self.v_dic[missile_id]
  if nil == hooker_data then
    return ShareRes.get_missile(missile_id)
  end
  local new_config = self.v_pool:new_obj(missile_id, hooker_data)
  self.v_dic[missile_id] = nil
  return new_config
end

function M:return_config(config)
  if config.__HOOKED__ then
    self.v_pool:destroy_obj(config)
  end
end

function M:clear()
  self.v_dic = {}
  local active_objs = self.v_pool:get_active_objs()
  for obj in pairs(active_objs) do
    self.v_pool:destroy_obj(obj)
  end
end

return M
