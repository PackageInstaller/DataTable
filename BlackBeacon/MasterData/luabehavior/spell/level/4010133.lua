local M = Util.create_class()

function M:_init()
  self.cast_timer = 0
  self.control = 0
end

function M:on_frame()
  local now_time = get_npc_time(self.npc)
  if 0 == self.control then
    self.cast_timer = get_npc_time(self.npc) + 5
    self.control = 1
  end
  if now_time >= self.cast_timer and 1 == self.control then
    cast_magic(self.npc, self.npc, 4010132, 1)
    self.control = 0
  end
end

return M
