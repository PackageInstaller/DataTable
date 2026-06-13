local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.settlementTime2 = 0
end

function M:on_frame()
  self:search_target()
  if 0 == self.magic_set and self.target then
    self.magic_set = 1
    abort_magic_by_id(self.npc, 100173, 1)
    abort_magic_by_id(self.npc, 100174, 1)
  end
  if 11 == self.magic_set and self.target then
    self.magic_set = 2
    self.settlementTime = get_npc_time(self.npc) + 0.8
  end
  if 2 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    abort_magic_by_id(self.target, 100173)
    abort_magic_by_id(self.target, 100175)
    set_ui_object_visible("fight", "Btn_skill3", true)
    enter_guide(2001)
    self.magic_set = 3
  end
  if 4 == self.magic_set and (check_magic(self.target, 1999095) and get_npc_time(self.npc) > self.settlementTime or get_npc_time(self.npc) > self.settlementTime2) then
    self.magic_set = 5
    abort_magic_by_id(self.target, 399933)
    set_ui_object_visible("fight", "Btn_lock7", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(2011)
  end
  if 6 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    enter_guide(2013)
    abort_magic_by_id(self.npc, 4010214)
    self.magic_set = 7
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_finish_guide(guide_id)
  if 2001 == guide_id then
    self.magic_set = 4
    self.settlementTime2 = get_npc_time(self.npc) + 2
  end
  if 2011 == guide_id then
    self.magic_set = 6
    self.settlementTime = get_npc_time(self.npc) + 1
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if 20106003 == skill_id then
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target, 1)
    cast_skill(self.npc, self.target, 20106002, nil, nil)
    self.magic_set = 11
  end
end

return M
