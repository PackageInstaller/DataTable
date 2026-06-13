local M = Util.create_class()
local team_hero_list = {}
local ability = 40003
local level = 1

function M:_init(npc)
  team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
end

function M:on_start()
  level = get_ability_level(ability)
  if get_come_on_hero() == self.npc then
    for k, v in pairs(team_hero_list) do
      cast_magic(v, v, 61703031, level)
    end
  end
end

return M
