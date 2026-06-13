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
  if 1 == self.magic_set and self.target and 3 == get_sync_var("rock_in_daze") then
    self.magic_set = 2
    cast_skill(self.npc, self.target, 20102105, nil, nil)
    cast_magic(self.target, self.target, 100173, 1)
    cast_magic(self.target, self.target, 100175, 1)
    cast_magic(self.target, self.target, 399933, 1)
    cast_magic(self.target, self.target, 4010193, 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    stop_skill_joystick_move(self.target)
    clear_input()
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    self.settlementTime = get_npc_time(self.npc) + 1.15
  end
  if 2 == self.magic_set and get_npc_time(self.npc) > self.settlementTime then
    abort_magic_by_id(self.target, 100173)
    abort_magic_by_id(self.target, 100175)
    set_ui_object_visible("fight", "Btn_skill3", true)
    enter_guide(2001)
    self.magic_set = 3
  end
  if 4 == self.magic_set and (check_magic(self.target, 1999095) or get_npc_time(self.npc) > self.settlementTime2) then
    self.magic_set = 5
    abort_magic_by_id(self.target, 399933)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    if not check_magic(self.target, 1001305) then
      set_ui_object_visible("fight", "Btn_skill4", true)
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(2011)
    set_sync_var("rock_in_daze", 4)
    abort_magic_by_id(self.npc, 4010176)
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
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local check_rlt = check_magic(m1_owner, 1999125)
  if m1_owner == self.npc and 5 == m1_cfg.MissileTypeTag and 3 == m2_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_rlt then
    self.v_trigger_counter_skill = true
    self.settlementTime = get_npc_time(self.npc) + 0.23
  end
end

return M
