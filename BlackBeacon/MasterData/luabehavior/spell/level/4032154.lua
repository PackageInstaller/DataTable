local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, 1, "tp3", 0, 0, 4, 99)
    cast_magic(self.npc, self.npc, 4032157, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032155, 1)
      cast_magic(self.npc, self.npc, 4032157, 1)
      cast_magic(self.npc, self.npc, 4032159, 1)
      cast_magic(self.npc, self.npc, 40321510, 1)
      restart_skill_teach(101508)
    else
      start_skill_teach(101508)
      set_scene_tips(61508, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.npc, self.npc, 4032155, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101521 == skill_id then
      self:to_next_step()
    elseif 100101521 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster1 and 100101521 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101521 ~= skill_id then
      set_skill_state(1, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101526 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif 100101526 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(2, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101522 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 2 or 100101522 ~= skill_id then
      self:cancel_guide_timeout()
      set_skill_state(2, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101531 == skill_id then
      set_skill_state(3, true)
      self:to_next_step()
    elseif npc == self.npc and 100101531 ~= skill_id then
      set_skill_state(3, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      self:back_to_step(3, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101532 == skill_id then
      set_skill_state(4, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 3 or 100101532 ~= skill_id then
      self:cancel_guide_timeout()
      set_skill_state(4, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(2, function()
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101501 == skill_id then
      set_skill_state(5, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 2 or 100101501 ~= skill_id then
      self:cancel_guide_timeout()
      set_skill_state(5, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101502 == skill_id then
      set_skill_state(6, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101502 ~= skill_id then
      set_skill_state(6, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101503 == skill_id then
      set_skill_state(7, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101503 ~= skill_id then
      set_skill_state(7, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101504 == skill_id then
      set_skill_state(8, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101504 ~= skill_id then
      set_skill_state(8, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61508, false, {})
    self:to_next_guide("guide2", 1.5)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032158, 1)
    cast_magic(self.npc, self.npc, 4032155, 1)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      on_up_skill_btn(15, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      cast_magic(self.npc, self.npc, 4032158, 1)
      restart_skill_teach(101509)
    else
      cast_magic(self.npc, self.npc, 4032158, 1)
      start_skill_teach(101509)
      set_scene_tips(61509, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101541 == skill_id then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step(1)
    elseif 100101541 ~= skill_id then
      set_skill_state(1, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      abort_skill(self.npc)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101505 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 5 or 100101505 ~= skill_id then
      set_skill_state(2, false)
      abort_skill(self.npc)
      on_up_skill_btn(15, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:cancel_guide_timeout()
      self:back_to_step(2, 3)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      abort_skill(self.npc)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101506 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101506 ~= skill_id then
      set_skill_state(3, false)
      abort_skill(self.npc)
      on_up_skill_btn(15, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:cancel_guide_timeout()
      self:back_to_step(2, 3)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      abort_skill(self.npc)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101507 == skill_id then
      set_skill_state(4, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101507 ~= skill_id then
      set_skill_state(4, false)
      abort_skill(self.npc)
      on_up_skill_btn(15, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:cancel_guide_timeout()
      self:back_to_step(2, 3)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      abort_skill(self.npc)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101508 == skill_id then
      set_skill_state(5, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101508 ~= skill_id then
      set_skill_state(5, false)
      abort_skill(self.npc)
      on_up_skill_btn(15, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:cancel_guide_timeout()
      self:back_to_step(2, 3)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      abort_skill(self.npc)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101509 == skill_id then
      set_skill_state(6, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 1 or 100101509 ~= skill_id then
      set_skill_state(6, false)
      abort_skill(self.npc)
      on_up_skill_btn(15, false)
      cast_magic(self.npc, self.npc, 4032157, 1)
      self:cancel_guide_timeout()
      self:back_to_step(2, 3)
    end
  end)
  g:add_step(function()
    set_scene_tips(61509, false, {})
    cast_magic(self.npc, self.npc, 4032157, 1)
    cast_magic(self.npc, self.npc, 4032159, 1)
    cast_magic(self.npc, self.npc, 40321510, 1)
    cast_magic(self.npc, self.npc, 4032155, 1)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_scene_tips(61509, false, {})
    cast_magic(self.npc, self.npc, 4032158, 1)
    cast_magic(self.npc, self.npc, 4032159, 1)
    cast_magic(self.npc, self.npc, 40321510, 1)
    cast_magic(self.npc, self.npc, 4032155, 1)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    show_skill_teach_tips(101504, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    if check_magic(self.npc, 101546) then
      abort_magic_by_id(self.npc, 101546)
      abort_magic_by_id(self.npc, 101547)
      abort_magic_by_id(self.npc, 101548)
    end
    request_end_teach_level(true)
    remove_npc(self.monster1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101401 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(61407, true, {})
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_begin_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

return M
