local M = Util.create_class()
local team_hero_list = {}
local ability = 10003
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
    cast_magic(self.npc, self.npc, 61700031, level)
  end
end

function M:on_room_change(npc)
  if self.npc == npc then
    cast_magic(npc, npc, 61700031, level)
  end
end

return M
