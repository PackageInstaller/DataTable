local M = Util.create_class()
local team_hero_list = {}
local time = 0
local add_time = 0
local ability = 10006
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
end

function M:on_frame()
  time = get_time()
  if time >= add_time and self.npc == get_come_on_hero() then
    add_time = time + 5
    cast_magic(self.npc, self.npc, 61700061, level)
  end
end

return M
