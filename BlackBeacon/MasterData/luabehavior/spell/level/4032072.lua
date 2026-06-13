local M = Util.create_class()

function M:_init()
  self.combo_guide = nil
end

function M:on_frame()
  self:search_target()
  if not self.combo_guide and not check_npc_status(self.npc, 1) then
    set_sync_var("combo_guide", 0)
    self.teahctime1 = get_npc_time(self.npc)
    self.combo_guide = 0
  end
  if self.combo_guide and 0 == self.combo_guide and 1 == get_sync_var("combo_guide") and get_npc_time(self.npc) > self.teahctime1 + 2 and self.target then
    start_skill_teach(100703)
    set_scene_tips(60721, true, {})
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(5019)
    self.combo_guide = 1
  end
  if self.combo_guide and 20 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 + 3 then
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_scene_tips(60722, true, {})
    enter_guide(5020)
    self.combo_guide = 21
  end
  if self.combo_guide and 90 == self.combo_guide then
    set_sync_var("combo_guide", 91)
    set_scene_tips(60722, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self.combo_guide = 91
    self.teahctime1 = get_npc_time(self.npc)
  end
  if self.combo_guide and 91 == self.combo_guide and get_npc_time(self.npc) > self.teahctime1 then
    show_skill_teach_tips(100702, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_sync_var("combo_guide", 92)
    self.combo_guide = 92
  end
  if 92 == self.combo_guide and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    remove_scene_effect("jiaohu")
    remove_npc(self.god1)
    set_sync_var("combo_guide", 99)
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    self.combo_guide = 99
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100702 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60723, true, {})
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 30, nil, 1)
end

function M:on_finish_guide(guide_id)
  if 5020 == guide_id then
    self.teahctime1 = get_npc_time(self.npc)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_scene_tips(60721, false, {})
    self.combo_guide = 90
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id)
end

function M:on_input(input_id)
end

function M:on_touch_up(output_id, iscancel)
  if 19 == output_id and 1 == self.combo_guide then
    set_skill_state(1, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self.teahctime1 = get_npc_time(self.npc)
    self.combo_guide = 20
  end
end

return M
