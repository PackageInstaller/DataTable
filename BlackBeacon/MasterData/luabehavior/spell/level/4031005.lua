local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_start()
end

function M:on_frame()
  if 0 == self.magic_set then
    self.settlementTime = get_npc_time(self.npc) + 1
    self.magic_set = 1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    cast_magic(self.npc, self.npc, 4031004, 0)
    self.magic_set = 2
  end
end

return M
