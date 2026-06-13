local M = Util.create_class()
local target_list = {}
local team_hero_list = {}
local ability = 60002
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_npc_born(npc)
  if 1 ~= get_role_kind(npc) and get_come_on_hero() == self.npc then
    cast_magic(self.npc, npc, 61705021, level)
  end
end

return M
