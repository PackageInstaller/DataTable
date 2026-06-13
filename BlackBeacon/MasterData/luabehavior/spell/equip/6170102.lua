local M = Util.create_class()
local team_hero_list = {}
local ability = 20002
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
  if self.npc == get_come_on_hero() then
    for k, v in pairs(team_hero_list) do
      cast_magic(v, v, 61701021, level)
    end
  end
end

function M:on_room_change()
  if self.npc == get_come_on_hero() then
    for k, v in pairs(team_hero_list) do
      cast_magic(v, v, 61701021, level)
    end
  end
end

return M
