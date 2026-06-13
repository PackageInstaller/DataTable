local M = Util.create_class()

function M:_init()
  set_ui_object_visible("fight", "Btn_skill5", false)
  set_ui_object_visible("fight", "JoystickContent", false)
  set_ui_object_visible("fight", "Btn_skill4", false)
  set_ui_object_visible("fight", "Btn_skill1", false)
  set_ui_object_visible("fight", "Btn_skill3", false)
  set_ui_object_visible("fight", "Btn_skill7", false)
  set_ui_object_visible("fight", "TeamHeads", false)
  self.before_start_time = 3.35
  self.start_time = nil
  self.gap_time = 0.35
  self.end_time = nil
  self.guide1_end = false
  self.before_start = false
  self.guide_start = false
  self.guide = true
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if 1000042 == magic_id and self.guide then
    set_ui_object_visible("fight", "Btn_skill3", true)
    enter_guide(100401)
    self.guide = false
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 2010380107 == skill_id and self.guide_start == false then
    self.start_time = get_npc_time(self.npc)
    self.before_start = true
  end
end

function M:on_finish_guide(guide_id)
  if 100401 == guide_id then
    self.end_time = get_npc_time(self.npc)
    self.guide1_end = true
  end
  if 100402 == guide_id then
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "TeamHeads", true)
  end
end

function M:on_frame()
  if self.guide1_end and get_npc_time(self.npc) >= self.end_time + self.gap_time then
    self.end_time = nil
    self.guide1_end = false
    enter_guide(100402)
  end
end

return M
