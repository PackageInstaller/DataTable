local M = Util.create_class()

function M:_init()
  self.magic_set = 0
end

function M:on_start()
  self.settlementTime = get_npc_time(self.npc) + 0.5
end

function M:on_frame()
  if 0 == get_sync_var("zeroth1") then
    set_npc_hp_visible(self.npc, false)
    set_can_searched(self.npc, false)
    if get_sync_var("zeroth") and get_sync_var("zeroth") <= 6 and get_npc_time(self.npc) > self.settlementTime then
      set_ui_object_visible("fight", "MainEnemyBloodList", false)
      self.settlementTime = get_npc_time(self.npc) + 0.5
    end
  elseif 1 == get_sync_var("zeroth1") then
    set_npc_hp_visible(self.npc, true)
    set_can_searched(self.npc, true)
    if 0 == self.magic_set then
      set_ui_object_visible("fight", "MainEnemyBloodList", true)
      self.magic_set = 1
    end
  end
end

return M
