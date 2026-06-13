local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_frame()
  if 0 == self.magic_set and not check_npc_status(self.npc, 1) then
    self.magic_set = 1
    self.settlementTime = get_npc_time(self.npc) + 0.1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    set_ui_object_visible("fight", "JoystickContent", true)
    enter_guide(2004)
    self.magic_set = 2
  end
  if 2 == self.magic_set then
    self.magic_set = 3
    abort_magic_by_id(self.npc, 4010171)
  end
end

return M
