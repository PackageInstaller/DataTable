local M = Util.create_class()

function M:_init()
  self.magic_level = nil
end

function M:on_fate_book_battle_start()
  if self.npc == get_come_on_hero() then
    cast_magic(self.npc, self.npc, 66604801)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc and not is_showup then
    abort_magic_by_id(self.npc, 66604801)
  end
end

return M
