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
    self.monster1 = add_npc_by_pos_key(1, 20101502, "center", 0, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101606)
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101606)
      set_scene_tips(61606, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101612 + g:step_index() - 3
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
    if target_skill_id == skill_id then
      on_up_skill_btn(20, false)
      set_skill_state(g:step_index() - 2, true)
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    set_scene_tips(61606, false, {})
    set_ui_object_visible("fight", "Btn_skill5", false)
    on_up_skill_btn(20, false)
    self:to_next_guide("guide2", 1.5)
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
      remove_missile_by_id(10010161101, self.npc)
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      restart_skill_teach(101607)
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101607)
      set_scene_tips(61607, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032144, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101617 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(6, function()
      self:back_to_step(2, 1)
    end)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101612 == skill_id then
      self:to_next_step()
      self:cancel_guide_timeout()
    elseif g:step_elapse() > 10 then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010161101 then
      set_skill_state(2, true)
      self:to_next_step(1)
    else
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61607, false, {})
    remove_missile_by_id(10010161103, self.npc)
    remove_missile_by_id(10010161101, self.npc)
    cast_magic(self.npc, self.npc, 4032165, 1)
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
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
      restart_skill_teach(101608)
    else
      cast_magic(self.npc, self.npc, 4032167, 1)
      cast_magic(self.npc, self.npc, 4032168, 1)
      cast_magic(self.npc, self.npc, 4032165, 1)
      start_skill_teach(101608)
      set_scene_tips(61608, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032144, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101617 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    else
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(6, function()
      self:back_to_step(2)
    end)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101612 == skill_id then
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif g:step_elapse() > 10 then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010161101 then
      set_skill_state(2, true)
      self:to_next_step()
    else
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(6, function()
      self:back_to_step(2)
    end)
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100101612 == skill_id then
      self:to_next_step()
      self:cancel_guide_timeout()
    elseif g:step_elapse() > 10 or 100101612 ~= skill_id then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 4032167, 1)
    cast_magic(self.npc, self.npc, 4032168, 1)
  end):listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010161102 then
      set_skill_state(3, true)
      self:to_next_step(1)
    else
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    set_scene_tips(61608, false, {})
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
    show_skill_teach_tips(101603, true)
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
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
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

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
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
