local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local rogueMgr = import("common.rogueManager")
local skill_id = 617119101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost
local damage_missile = 61711910101

function M:_init(npc)
  self.npc = get_god_npc()
  self:get_level()
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function M:on_input(input_id)
  if 60 == input_id then
    local hero = get_come_on_hero()
    if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
      cast_skill(self.npc, hero, skill_id, nil, nil)
      remove_missile_by_id(damage_missile)
      cast_missile3(hero, hero, nil, nil, damage_missile)
      cast_magic(hero, hero, rogueMgr.shengguang)
      CommonRole.indicator_slowdown_off(self)
    else
      cast_magic(self.npc, self.npc, 100158, 1)
    end
  end
end

function M:get_level()
  skill_level = get_god_skill_level()
  local skill_id_list = {
    [1] = 617119101,
    [2] = 617119102,
    [3] = 617119103
  }
  local shengguang_list = {
    [1] = 61711111,
    [2] = 61711115,
    [3] = 61711115
  }
  if skill_id_list[skill_level] then
    skill_id = skill_id_list[skill_level]
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(skill_level)
    rogueMgr.shengguang = shengguang_list[skill_level]
    if 3 == skill_level then
      self.on_magic_end = self.on_magic_end_Lv3
    end
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
end

function M:on_magic_end(npc, target, magic_id, magic_kind, magic_type, magic_type)
  if magic_id == rogueMgr.shengguang then
    remove_missile_by_id(damage_missile)
  end
end

function M:on_magic_end_Lv3(npc, target, magic_id, magic_kind, magic_type, magic_type)
  if magic_id == rogueMgr.shengguang then
    remove_missile_by_id(damage_missile)
    cast_missile3(target, target, nil, nil, 61711910303)
  end
end

return M
