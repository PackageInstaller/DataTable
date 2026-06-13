local M = Util.create_class()

function M:_init()
end

function M:on_frame()
  if self.target then
    cast_magic(self.npc, self.npc, 6031003, 1)
    cast_magic(self.npc, self.npc, 6031021, 1)
  end
end

return M
