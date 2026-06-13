local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, 0, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      remove_missile_by_id(10010161103, self.npc)
      remove_missile_by_id(10010161102, self.npc)
      remove_missile_by_id(10010161101, self.npc)
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101609)
      self:to_next_step()
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      set_ui_object_visible("fight", "Btn_skill1", true)
      set_ui_object_visible("fight", "JoystickContent", true)
      set_ui_object_visible("fight", "Btn_skill4", true)
      set_ui_object_visible("fight", "Btn_skill5", true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    remove_missile_by_id(10010161103, self.npc)
    remove_missile_by_id(10010161102, self.npc)
    remove_missile_by_id(10010161101, self.npc)
    cast_magic(self.npc, self.npc, 4032165, 1)
    self:to_next_guide("guide2", 0)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      remove_missile_by_id(10010161103, self.npc)
      remove_missile_by_id(10010161102, self.npc)
      remove_missile_by_id(10010161101, self.npc)
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101610)
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101610)
      set_scene_tips(61610, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
    if 19 == input_id then
      start_long_click_skill()
    end
  end):listen("on_touch_up", function(output_id, iscancel, input_time)
    if 19 == output_id and input_time >= 2 and true ~= iscancel then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(7, function()
      self:back_to_step(2)
    end)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101612 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 10 or 100101612 ~= skill_id and 100101619 ~= skill_id and 100101618 ~= skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
    self:guide_timeout(7, function()
      self:back_to_step(2, 1)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if missile_cfg.Id == 10010162903 or missile_cfg.Id == 10010162904 then
      self:cancel_guide_timeout()
      set_skill_state(2, true)
      set_scene_tips(61611, true, {})
      self:to_next_step(3)
    elseif g:step_elapse() > 10 then
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61610, false, {})
    remove_missile_by_id(10010161103, self.npc)
    remove_missile_by_id(10010161102, self.npc)
    remove_missile_by_id(10010161101, self.npc)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
    cast_magic(self.npc, self.npc, 4032165, 1)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_teach_tips(101604, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  self:add_energy()
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

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 100116, 1)
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
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
