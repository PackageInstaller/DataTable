local M = Util.create_class()
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local team_hero_list = {}
local time = 0
local interval_time = 0
local ability = 50005
local level = 1
local is_recover = true

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

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and true == is_showup then
    local target = search_npc(self.npc, 4, 10, nil, 1)
    if target then
      time = get_time()
      if time >= interval_time then
        interval_time = time + 5
        cast_magic(self.npc, self.npc, 61704051, level)
      end
    end
  end
end

return M
