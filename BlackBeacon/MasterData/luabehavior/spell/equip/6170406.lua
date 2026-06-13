local M = Util.create_class()
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local team_hero_list = {}
local ability = 50006
local level = 1

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if 7 == damage_sign then
    cast_magic(npc, target, 61704061, level)
  end
end

return M
