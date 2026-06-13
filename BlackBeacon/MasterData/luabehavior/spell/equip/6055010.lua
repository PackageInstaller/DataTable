local M = Util.create_class()

function M:_init()
  self.magic_added = false
end

function M:on_hero_showup_or_back(npc, is_showup)
  if npc == self.npc and is_showup and not self.magic_added then
    cast_magic(self.npc, self.npc, 61550101, 0)
    self.magic_added = true
  elseif npc == self.npc and not is_showup and self.magic_added then
    abort_magic_by_id(self.npc, 61550101, 1)
    self.magic_added = false
  end
end

return M
