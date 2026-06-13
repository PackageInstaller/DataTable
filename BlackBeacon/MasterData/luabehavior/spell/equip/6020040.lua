local M = Util.create_class()

function M:_init(npc)
  self.magic_set = 0
end

function M:on_frame()
  if 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 6021071, 1)
    self.magic_set = 1
  end
end

return M
