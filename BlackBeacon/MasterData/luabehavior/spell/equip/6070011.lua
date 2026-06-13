local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 10
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 6
}
local skill_id = 607000012
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost

function M:_init(npc)
  self.skill_missile_id = 60700001101
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, npc, self.skill_missile_id, self.on_timestop_catch_missile, self, 6070011)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, npc, self.skill_missile_id, self.on_timestop_release_missile, self, 6070011)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.skill_missile_id, self.on_timestop_catch_npc, self, 6070011)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.skill_missile_id, self.on_timestop_release_npc, self, 6070011)
end

function M:on_start()
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  for k, v in pairs(team_hero_list) do
    cast_magic(v, v, 6170109, 0)
  end
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.skill_missile_id, self)
end

function M:on_timestop_catch_missile(owner, target_missile_cfg, target_missile, missile_cfg, missile, target_missile_owner)
  if missile_cfg.Id == self.skill_missile_id and not check_magic(get_come_on_hero(), 6170107) then
    set_missile_dt(target_missile, 0)
  end
end

function M:on_timestop_release_missile(owner, target_missile, missile_cfg, missile)
  if missile_cfg.Id == self.skill_missile_id and not check_magic(get_come_on_hero(), 6170107) then
    set_missile_dt(target_missile, 1)
  end
end

function M:on_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    cast_magic(self.npc, target_npc, 61701082, 1)
  end
end

function M:on_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    abort_magic_by_id(target_npc, 61701082)
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    self.target = search_npc(self.npc, 4, 15, Const.LOCK_ON_TAG, 1)
    set_npc_target(self.npc, self.target)
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
      set_indicator_active(60, true, true)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel then
    cast_skill(self.npc, nil, skill_id, nil, nil)
    set_indicator_active(60, false)
    CommonRole.indicator_slowdown_off(self)
  end
end

function M:on_frame()
end

return M
