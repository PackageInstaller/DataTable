local Base = import("spell.base.teach_level_base")
local roleTool = import("common.role_tool")
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
  self.teammateling = get_scene_hero_by_poskey(21)
  self.teammateming = get_come_on_hero()
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, 2, "tp3", 0, 0, 4, 99)
    self.npc_pos = get_npc_pos(self.teammateming)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.monster1, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.teammateming, self.teammateming, 4032115, 1)
      cast_magic(self.teammateming, self.teammateming, 4032116, 1)
      restart_skill_teach(101104)
    else
      cast_magic(self.teammateming, self.teammateming, 4032115, 1)
      cast_magic(self.teammateming, self.teammateming, 4032116, 1)
      start_skill_teach(101104)
    end
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100101101)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101109 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(100101102)
    self:to_next_step()
  end)
  g:add_step():listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010110802 then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101108)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101101 == skill_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(100101103)
    self:to_next_step(1)
  end)
  
  function M:on_finish_guide(guide_id)
    if 100101103 == guide_id then
      self:to_next_step(1)
    end
  end
  
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    cast_magic(self.monster2, self.monster2, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_guide("guide11", 1.5)
  end)
  g:start()
end

function M:teach_guide11()
  local g = self:create_guide("guide11")
  g:add_step(function()
    flash_to_pos(self.teammateming, self.npc_pos.x, self.npc_pos.z)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 2, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 2, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.teammateming, self.monster1, 4032119, 1)
    cast_magic(self.teammateming, self.monster2, 4032119, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.teammateming, self.teammateming, 4032115, 1)
      cast_magic(self.teammateming, self.teammateming, 4032116, 1)
      restart_skill_teach(101104)
    else
      cast_magic(self.teammateming, self.teammateming, 4032115, 1)
      cast_magic(self.teammateming, self.teammateming, 4032116, 1)
      start_skill_teach(101104)
      set_scene_tips(61106, true, {})
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010110801 then
      set_skill_state(1, true)
    end
  end):listen("on_missile_end_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010110801 and 3 == g:step_index() then
      set_skill_state(2, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill3", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:back_to_step(2, 1)
    end
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101120 == skill_id then
      self:to_next_step()
    end
  end):listen("on_skill_end", function(npc, skill_id, skill_type)
    if 100101120 == skill_id and g:step_index() < 4 then
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_missile_begin_pos", function(owner, pos_x, pos_z, missile_cfg, missile)
    if missile_cfg.Id == 10010110802 then
      set_skill_state(2, true)
      set_ui_object_visible("fight", "JoystickContent", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_scene_tips(61106, false, {})
    remove_npc(self.monster1)
    remove_npc(self.monster2)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_guide("guide2", 1.5)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    flash_to_pos(self.teammateming, self.npc_pos.x, self.npc_pos.z)
    stop_move(self.teammateming)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      self.local_skill_state1 = false
    else
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100101104)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101141 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101105)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100193 == skill_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    remove_npc(self.monster1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    local newHero = get_scene_hero_by_poskey(21)
    local newRole = newHero and newHero:get_behavior()
    roleTool:changeRole(Const.INPUT_CODE.QTE1, nil, newRole)
    remove_missile_by_id(10010114103, self.teammateming, true)
    remove_missile_by_id(10010114102, self.teammateming, true)
    self:to_next_guide("guide3", 1.5)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    remove_missile_by_id(10010114201, self.teammateming, true)
    remove_missile_by_id(10010114202, self.teammateming, true)
    flash_to_pos(self.teammateming, self.npc_pos.x, self.npc_pos.z + 1)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, 1, "tp3", 0, 0, 4, 99)
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, 1, "tp3", 0, 0, 4, 99)
    self.monster3 = add_npc_by_pos_key(1, 20101502, "bornpoint", -1, -1, "tp3", 0, 0, 4, 99)
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 1, -1, "tp3", 0, 0, 4, 99)
    cast_magic(self.teammateming, self.monster1, 4032119, 1)
    cast_magic(self.teammateming, self.monster2, 4032119, 1)
    cast_magic(self.teammateming, self.monster3, 4032119, 1)
    cast_magic(self.teammateming, self.monster4, 4032119, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step(0.1)
  end)
  g:add_step(function(back_form)
    if back_form then
      self.local_skill_state1 = false
    else
    end
    set_ui_object_visible("fight", "Btn_skill7", true)
    cast_magic(self.teammateming, self.teammateming, 4032992, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101106)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101181 == skill_id then
      self:to_next_step(5)
    end
  end)
  g:add_step(function()
    abort_magic_by_id(self.monster1, 4032119)
    abort_magic_by_id(self.monster2, 4032119)
    abort_magic_by_id(self.monster3, 4032119)
    abort_magic_by_id(self.monster4, 4032119)
    set_scene_tips(61106, true, {})
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.teammateming, self.teammateming, 1999217, 0)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_combo_tips({11}, true)
    create_navigator_effect("end", true, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    set_scene_tips(801019, true, {})
    self.finished_teach_guide = true
    self:end_teach_guide()
  end)
  g:start()
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.teammateming, 2)
  if characeter_energy <= 200 then
    cast_magic(self.teammateming, self.teammateming, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.teammateming, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_hit(npc, skill_id)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  self:call_guide_listen_func("on_missile_collide", m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
end

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_magic_end(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_end", npc, target, magic_id)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_begin_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  self:call_guide_listen_func("on_missile_end_pos", owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_input(input_id)
  self:call_guide_listen_func("on_input", input_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_enter_area(npc, area)
  if self.finished_teach_guide == true and area.Key == "end" then
    joystick_end()
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "JoystickContent", false, true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
  end
end

return M
