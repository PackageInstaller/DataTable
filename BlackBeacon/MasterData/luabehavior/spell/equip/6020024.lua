local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_frame()
  if get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4) <= 0.3 and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 6021036, 1)
    self.magic_set = 1
  end
  if get_npc_attr(self.npc, 1) / get_npc_attr(self.npc, 4) >= 0.5 and 1 == self.magic_set then
    self.magic_set = 0
  end
end

return M
