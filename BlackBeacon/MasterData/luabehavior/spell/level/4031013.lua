local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_start()
end

function M:on_frame()
  self:search_target()
  if 1 == get_sync_var("lookdrop") and self.target and get_npc_time(self.target) > self.settlementTime and not check_npc_status(self.target, 1) then
    self.settlementTime = get_npc_time(self.target) + 1
    set_sync_var("lookdrop", 3)
  end
  if 3 == get_sync_var("lookdrop") and self.target then
    if check_npc_distance(self.target, self.npc, 1, true) then
      set_sync_var("lookdrop", 4)
    elseif get_npc_time(self.target) > self.settlementTime then
      lookat_npc(self.target, self.npc, 0)
      focus_npc(self.npc)
      set_scene_tips(50009, true, {})
      set_sync_var("lookdrop", 4)
    end
  end
  if 4 == get_sync_var("lookdrop") and self.target and check_npc_distance(self.target, self.npc, 1, true) then
    clear_focal()
    set_scene_tips(50009, false, {})
    set_sync_var("lookdrop", 5)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 2, 30, nil, 1)
end

return M
