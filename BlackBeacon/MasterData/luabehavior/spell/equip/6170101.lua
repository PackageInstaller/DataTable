local M = Util.create_class()
local ability = 20001
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_npc_born(npc)
  if 1 ~= get_role_kind(npc) and get_come_on_hero() == self.npc then
    cast_magic(self.npc, npc, 61701011, level)
  end
end

return M
