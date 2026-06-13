local M = Util.create_class()
local tool = import("common.tool")
local is_niubi = false

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if get_magic_kind_num(npc, 61709) >= 1 and self.npc == get_come_on_hero() and self.npc ~= npc then
    cast_magic(self.npc, self.npc, 61709361, self.level)
  end
end

function M:_init(npc)
end

function M:on_fate_book_battle_start()
  self.level = get_ability_level(30022) or 1
end

function M:on_start()
  self.level = get_ability_level(30022) or 1
end

return M
