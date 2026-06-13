local M = Util.create_class()
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local team_hero_list = {}
local ability = 50008
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and is_showup then
    cast_magic(self.npc, self.npc, 61704081, level)
  end
end

return M
