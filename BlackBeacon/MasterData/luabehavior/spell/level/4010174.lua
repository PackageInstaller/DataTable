local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
end

function M:on_frame()
  if 0 == self.magic_set then
    self.magic_set = 1
    self.settlementTime = get_npc_time(self.npc) + 1
  end
  if 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    self.magic_set = 2
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(2007)
    abort_magic_by_id(self.npc, 4010174)
  end
end

return M
