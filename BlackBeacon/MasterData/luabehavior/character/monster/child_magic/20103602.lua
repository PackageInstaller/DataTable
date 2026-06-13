local M = Util.create_class()

function M:_init()
  self.timer_set = 0
  self.blooding_set = 0
  self.over_timer = 0
end

function M:on_frame()
  if 0 == self.timer_set then
    cast_magic(self.npc, self.npc, 201037002, 1)
    self.over_timer = get_npc_time(self.npc) + 1
    self.timer_set = 1
  end
  local now_time = get_npc_time(self.npc)
  if now_time > self.over_timer and 1 == self.timer_set then
    self.over_timer = now_time + 1
    cast_magic(self.npc, self.npc, 201037002, 1)
    self.blooding_set = self.blooding_set + 1
  end
  if 3 == self.blooding_set then
    self.timer_set = 2
  end
end

return M
