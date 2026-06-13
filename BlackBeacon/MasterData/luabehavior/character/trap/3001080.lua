local M = Util.create_class()

function M:_init(npc)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  cast_skill(npc, npc, 300108001, nil, nil)
  npc.search = {}
  set_can_searched(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  self.time = get_time() + 1.5
end

function M:on_frame()
  if get_time() >= self.time then
    set_npc_dead(self.npc, nil, false)
    remove_npc(self.npc)
  end
end

return M
