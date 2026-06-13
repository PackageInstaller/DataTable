local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")

local function sure_callback()
  set_scene_tips(801019, false, {})
  remove_scene_effect("jiaohu")
  set_ui_object_visible("fight", "Main", false)
  request_end_teach_level(true)
end

local Florence = import("character.role.1001009_new")

local function cancel_callback()
  set_ui_object_visible("fight", "Btn_skill5", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill1", true)
  set_ui_object_visible("fight", "Btn_skill3", true)
  set_ui_object_visible("fight", "Btn_skill7", true)
end

function M:_init()
  Base._init(self)
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    enter_guide(5025)
    self:to_next_step()
  end)
  g:add_step(function()
    set_scene_tips(60921, true, {})
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", true)
    start_skill_teach(100903)
    play_ui_fight_button_effect({"Skill_Guid", 4})
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100912 == skill_id then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "JoystickContent", false)
      joystick_end()
      set_ui_object_visible("fight", "Btn_skill7", false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill3", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1.8)
    else
      set_skill_state(1, false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    enter_guide(5026)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and (100100917 == skill_id or 100100918 == skill_id) then
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_skill_state(2, true)
      self:to_next_step(1.6)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.monster1, 10001001, 1)
    enter_guide(5027)
    self:to_next_step(2.5)
  end)
  g:add_step(function()
    abort_skill(self.npc, 1)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    lookat_npc(self.npc, self.monster2)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    play_ui_fight_button_effect({"Skill_Guid", 4})
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100903)
      play_ui_fight_button_effect({"Skill_Guid", 4})
    else
      start_skill_teach(100903)
      play_ui_fight_button_effect({"Skill_Guid", 4})
      flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100100912 == skill_id then
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc and 100100912 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_end", function(npc, skill_id)
    if npc == self.npc and 100100912 == skill_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      self:back_to_step(8)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc and (100100918 == skill_id or 100100917 == skill_id) then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "JoystickContent", false)
      joystick_end()
      self:cancel_guide_timeout()
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.monster2, 10001001, 1)
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    self:to_next_guide("guide2", 3)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      joystick_end()
      abort_skill(self.npc, 1)
      cast_magic(self.npc, self.monster3, 10001001, 1)
      flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
      lookat_npc(self.npc, self.monster3)
      cast_magic(self.npc, self.npc, 100116, 0)
      set_ui_object_visible("fight", "Btn_skill5", true)
      play_ui_fight_button_effect({"Skill_Guid", 4})
      self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
      set_sync_var("in_daze", 1)
      set_sync_var("close_counterattack", 1)
      restart_skill_teach(100904)
    else
      joystick_end()
      cast_magic(self.npc, self.npc, 100116, 0)
      set_ui_object_visible("fight", "Btn_skill5", true)
      play_ui_fight_button_effect({"Skill_Guid", 4})
      self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
      set_sync_var("in_daze", 1)
      set_sync_var("close_counterattack", 1)
      lookat_npc(self.npc, self.monster3)
      start_skill_teach(100904)
      enter_guide(5028)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100922 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(0)
    end
  end)
  g:add_step(function()
    set_scene_tips(60921, false, {})
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(1.75)
  end)
  g:add_step(function()
    set_scene_tips(60928, true, {})
    enter_guide(5029)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc and 100100913 == skill_id then
      self:to_next_step(0)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100919 == skill_id then
        self:to_next_step(0)
      elseif 100100913 ~= skill_id then
        set_skill_state(2, false)
        set_ui_object_visible("fight", "Btn_skill5", false)
        self:back_to_step(1, 2)
      end
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.npc and 100100919 == skill_id and missile_cfg.Id == 10010091902 then
      set_skill_state(2, true)
      cast_magic(self.npc, self.monster3, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    enter_guide(5033)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    self:to_next_step(2.5)
  end)
  g:add_step(function()
    abort_skill(self.npc, 1)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    enter_guide(5031)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100905)
      flash_to_pos(self.monster4, self.monster2_pos.x, self.monster2_pos.z)
    else
      start_skill_teach(100905)
    end
    lookat_npc(self.npc, self.monster4)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100922 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(0)
    else
      set_skill_state(1, false)
      self:back_to_step(11, 3)
    end
  end)
  g:add_step(function()
    self:guide_timeout(4.5, function()
      self:back_to_step(11)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100918 == skill_id or 100100917 == skill_id then
        set_skill_state(2, true)
        self:cancel_guide_timeout()
        self:to_next_step(0)
      elseif 100100910 ~= skill_id then
        set_skill_state(2, false)
        self:back_to_step(11, 3)
      end
    end
  end)
  g:add_step(function()
    self:guide_timeout(4.5, function()
      self:back_to_step(11)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100918 == skill_id or 100100917 == skill_id then
        set_skill_state(3, true)
        self:cancel_guide_timeout()
        self:to_next_step(0)
      elseif 100100910 ~= skill_id then
        set_skill_state(3, false)
        self:back_to_step(11, 3)
      end
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.npc then
      if 100100919 == skill_id then
        self:to_next_step(0)
      elseif 100100910 ~= skill_id and 100100913 ~= skill_id then
        set_skill_state(5, false)
        self:back_to_step(11, 3)
      end
    end
  end)
  g:add_step():listen("on_skill_end", function(npc, skill_id)
    if npc == self.npc and 100100919 == skill_id then
      set_skill_state(4, true)
      cast_magic(self.npc, self.monster4, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", false)
    joystick_end()
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_scene_tips(60928, false, {})
    self:to_next_guide("guide3", 0)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.npc, self.monster1, 4032119, 1)
    cast_magic(self.npc, self.monster2, 4032119, 1)
    cast_magic(self.npc, self.npc, 4032992, 0)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 0.5)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    enter_guide(5030)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100914 == skill_id then
      self:to_next_step(6)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:to_next_guide("guide5", 0.5)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    cast_magic(self.npc, self.npc, 1999217, 0)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({9}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    flash_to_pos(self.npc, self.monster2_pos.x, self.monster2_pos.z - 2)
    lookat_npc(self.npc, self.monster1)
    create_navigator_effect("end", true, true)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    set_scene_tips(60921, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.first_check_guide and check_npc_status(self.npc, 0) then
    self.first_check_guide = true
  end
  if not self.init_guide and not check_npc_status(self.npc, 1) and self.first_check_guide then
    self.init_guide = true
    self:teach_guide1()
  end
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 200 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100902 == tips_id then
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.npc, 2)
  if characeter_energy <= 100 then
    cast_magic(self.npc, self.npc, 4032991, 1)
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn, cancel_btn)
  end
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

return M
