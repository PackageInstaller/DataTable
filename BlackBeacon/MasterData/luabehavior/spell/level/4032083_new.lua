local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)

function M:_init()
  Base._init(self)
  self.init_guide = false
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "M31", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "M32", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "M33", 0, 0, "tp3", 0, 0, 4, 99)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "M34", 0, 0, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_scene_tips(60831, true, {})
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    self:to_next_guide("guide2", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100804)
    else
      start_skill_teach(100804)
    end
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.npc, self.npc, 4032087, 1)
    cast_magic(self.npc, self.npc, 4032085, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100810 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    self:guide_timeout(2, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id or 100100805 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    elseif g:step_elapse() > 1 then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100806 == skill_id or 100100807 == skill_id or 100100808 == skill_id or 100100805 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    elseif g:step_elapse() > 1 then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    cast_magic(self.monster2, self.monster2, 10001001, 1)
    cast_magic(self.monster3, self.monster3, 10001001, 1)
    cast_magic(self.monster4, self.monster4, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    set_scene_tips(60831, false, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1999217, 0)
    show_skill_teach_tips(100803, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
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
    request_end_teach_level(true)
    remove_npc(self.monster1)
    remove_npc(self.monster2)
    remove_npc(self.monster3)
    remove_npc(self.monster4)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100803 == tips_id then
    set_scene_tips(801019, true, {})
    set_scene_tips(60831, true, {})
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

return M
