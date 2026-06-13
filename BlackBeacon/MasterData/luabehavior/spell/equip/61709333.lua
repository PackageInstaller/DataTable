local M = Util.create_class()
local tool = import("common.tool")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
  self.missile_id = 61709910101
  self.god_missile_id = 61709920301
  self.is_in_water = false
  self.in_water = 0
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.missile_id, self.on_water_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.missile_id, self.on_water_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.god_missile_id, self.on_god_water_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.god_missile_id, self.on_god_water_release_npc, self)
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.god_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.god_missile_id, self)
end

function M:on_god_water_release_npc(owner, target_npc, missile_cfg, missile)
  self:on_water_release_npc(owner, target_npc, missile_cfg, missile)
end

function M:on_god_water_catch_npc(owner, target_npc, missile_cfg, missile)
  self:on_water_catch_npc(owner, target_npc, missile_cfg, missile)
end

function M:on_water_catch_npc(owner, target_npc, missile_cfg, missile)
  if target_npc == self.npc then
    self.in_water = self.in_water + 1
    if not self.is_in_water then
      self.is_in_water = true
      if rogueMgr.level_water and (not check_magic(self.npc, 61709311) or not check_magic(self.npc, 61709312)) then
        local level_6170931 = get_ability_level(30017) or 1
        cast_magic(self.npc, self.npc, 61709311, level_6170931)
        cast_magic(self.npc, self.npc, 61709312, level_6170931)
      end
      if rogueMgr.element_add_water and not check_magic(self.npc, 61709342) then
        cast_magic(self.npc, self.npc, 61709342)
      end
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
      if rogueMgr.level_water then
        abort_magic_by_id(self.npc, 61709311)
        abort_magic_by_id(self.npc, 61709312)
      end
      abort_magic_by_id(self.npc, 61709221)
      if rogueMgr.element_add_water then
        abort_magic_by_id(self.npc, 61709342)
      end
    end
  end
end

return M
