local M = Util.create_class()
local tool = import("common.tool")
local Const = import("common.lua_behavior_const")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local role_tool = import("common.role_tool")

function M:_init(npc)
  self.in_water = 0
  self.is_in_water = false
  self.in_water_time = 99999999
  self.in_water_interval = 3
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 201005010101, self.on_water_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 201005010101, self.on_water_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 201005060101, self.on_water_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 201005060101, self.on_water_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 201005070101, self.on_water_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 201005070101, self.on_water_catch_npc, self)
end

function M:on_water_catch_npc(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_water = self.in_water + 1
    if self.is_in_water == false then
      self.in_water_time = get_npc_time(self.npc)
      self.is_in_water = true
    end
  end
end

function M:on_water_release_npc(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_water = self.in_water - 1
    if self.in_water < 0 then
      self.in_water = 0
    end
    if 0 == self.in_water then
      self.is_in_water = false
      abort_magic_by_id(self.npc, 2010050114, 1)
      abort_magic_by_id(self.npc, 2010050115, 1)
      abort_magic_by_id(self.npc, 2010050118, 1)
      abort_magic_by_id(self.npc, 2010050111, 1)
    end
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc ~= self.npc then
    return
  end
  if not is_showup then
    self.is_in_water = false
    self.in_water = 0
    abort_magic_by_id(self.npc, 2010050114, 1)
    abort_magic_by_id(self.npc, 2010050115, 1)
    abort_magic_by_id(self.npc, 2010050118, 1)
    abort_magic_by_id(self.npc, 2010050111, 1)
  end
end

function M:on_frame()
  if self.is_in_water == false then
    return
  end
  if get_npc_time(self.npc) > self.in_water_time + self.in_water_interval and not check_magic(self.npc, 2010050118) then
    cast_magic(self.npc, self.npc, 2010050118, 1)
  end
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 201005010101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 201005010101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 201005060101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 201005060101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 201005070101, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 201005070101, self)
end

return M
