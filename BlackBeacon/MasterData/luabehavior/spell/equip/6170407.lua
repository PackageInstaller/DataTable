local M = Util.create_class()
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local team_hero_list = {}
local ability = 50007
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

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 5 == get_skill_cfg(skill_id).SkillType then
    for k, v in pairs(team_hero_list) do
      cast_magic(v, v, 61704071, level)
    end
  end
end

return M
