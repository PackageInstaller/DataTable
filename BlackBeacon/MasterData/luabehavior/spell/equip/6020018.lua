local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_frame()
  if 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 6021021, 1)
    self.magic_set = 1
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc ~= self.npc then
    return
  end
  if true == is_showup and check_magic(self.npc, 6021021) then
    cast_magic(self.npc, self.npc, 6021041, 1)
    cast_magic(self.npc, self.npc, 6021021, 1)
  end
end

return M
