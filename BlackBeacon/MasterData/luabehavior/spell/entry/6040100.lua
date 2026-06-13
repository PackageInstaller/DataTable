local M = Util.create_class()

function M:_init(npc)
  self.timer = 999
  self.trigger_time = get_time()
  self.active = false
end

function M:on_frame()
  local nowtime = get_time()
  if get_npc_attr(self.npc, 1) < get_npc_attr(self.npc, 4) * 0.3 then
    self.active = true
  end
  if self.active and nowtime > self.trigger_time then
    cast_missile(self.npc, self.npc, nil, nil, 60400000106, 0)
    self.trigger_time = nowtime + self.timer
  end
end

return M
