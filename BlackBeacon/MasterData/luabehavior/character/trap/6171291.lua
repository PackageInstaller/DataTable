local M = Util.create_class()
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local skill_area = {
  type = 1,
  res = "FX_text_kong",
  sizex = 14
}
local skill_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 2,
  sizey = 5
}
local skill_id = 617129101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost
local missile_shoot = 61712910101
local missile_back = 61712910102
local missile_judge = 61712910103

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function M:on_remove()
end

function M:on_input(input_id)
  if 60 == input_id then
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
      set_indicator_active(60, true, true)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel and get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
    local hero = get_come_on_hero()
    self.pos = {}
    self.pos.x, self.pos.y = get_indicator_pos(output_id)
    self.born_pos = {}
    self.born_pos = get_npc_pos(hero)
    cast_skill(self.npc, self.npc, skill_id)
    remove_missile_by_id(missile_shoot)
    remove_missile_by_id(missile_back)
    remove_missile_by_id(missile_judge)
    cast_missile3(hero, nil, self.born_pos.x, self.born_pos.z, missile_shoot, nil, self.pos.x, self.pos.y)
    set_indicator_active(60, false)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == missile_shoot and not is_break then
    local hero = get_come_on_hero()
    cast_missile3(hero, hero, pos_x, pos_z, missile_back)
    local level = get_god_skill_level()
    if 3 == self.level then
      tool:castMagicToTeam(617129103, 1, hero)
    end
  end
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  local kind = get_role_kind(npc)
  if 1 ~= kind then
    return
  end
  if 617129101 == magic_id and 1 == get_role_kind(target) then
    remove_missile_by_id(missile_back)
    remove_missile_by_id(missile_judge)
    if 3 == self.level then
      tool:abortMagicToTeam(617129103)
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  local hero = get_come_on_hero()
  if 617129102 == magic_id then
    local possibility = math.random()
    if possibility > 0.7 then
      rogueMgr.random_cast_fragment(rogueMgr, hero, 1, 3, target)
    end
    return
  end
  if npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if not skAct then
    return
  end
  remove_missile_by_id(missile_shoot)
  remove_missile_by_id(missile_back)
  remove_missile_by_id(missile_judge)
end

function M:get_level()
  local skill_data = {
    [1] = {id = 617129101},
    [2] = {id = 617129102},
    [3] = {id = 617129103}
  }
  self.level = get_god_skill_level()
  if self.level >= 1 and self.level <= 3 then
    local data = skill_data[self.level]
    skill_id = data.id
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(self.level)
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
end

return M
