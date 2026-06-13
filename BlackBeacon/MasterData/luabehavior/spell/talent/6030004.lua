local M = Util.create_class()

function M:_init()
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc ~= self.npc then
    return
  end
  if npc == self.npc and true == is_showup then
    cast_magic(self.npc, self.npc, 6031002, 1)
    cast_magic(self.npc, self.npc, 6031020, 1)
  end
end

return M
