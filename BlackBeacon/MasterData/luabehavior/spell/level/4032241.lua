local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")
local kuileishi_biaoji = 102403
local kuilei_biaoji = 102404

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
  replace_team_pos_data(1, true)
  self.yuli = get_come_on_hero()
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    self.yuli_pos = get_npc_pos(self.yuli)
    lookat_npc(self.yuli, self.monster1, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102401)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100102402)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100102403)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    cast_magic(self.yuli, self.yuli, 4032232)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102404)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102405)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(1.2)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102406)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102414)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102415)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
      restart_skill_teach(102401)
      abort_magic_by_id(self.yuli, kuilei_biaoji)
      abort_magic_by_id(self.yuli, kuileishi_biaoji)
    else
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
      cast_magic(self.monster1, self.monster1, 4032905, 1)
      self.monster1_pos = get_npc_pos(self.monster1)
      set_scene_tips(62401, true, {})
      start_skill_teach(102401)
    end
    flash_to_pos(self.yuli, self.yuli_pos.x, self.yuli_pos.z, self.yuli_pos.y)
    lookat_npc(self.yuli, self.monster1, 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102423 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100102423 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      set_skill_state(2, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102431 == skill_id or 100102433 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif 100102423 ~= skill_id and 100102424 ~= skill_id and 100102425 ~= skill_id and 100102426 ~= skill_id and 100102427 ~= skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      set_skill_state(3, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102441 == skill_id or 1001024141 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif 100102432 ~= skill_id and 1001024131 ~= skill_id and 1001024132 ~= skill_id then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      set_skill_state(4, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102443 == skill_id or 1001024143 == skill_id then
      set_skill_state(4, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.2)
    elseif 100102431 == skill_id then
      set_skill_state(4, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      set_skill_state(5, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102444 == skill_id or 1001024144 == skill_id then
      set_skill_state(5, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.2)
    elseif 100102431 == skill_id then
      set_skill_state(5, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      set_skill_state(6, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102445 == skill_id or 1001024145 == skill_id then
      set_skill_state(6, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:cancel_guide_timeout()
      self:to_next_step(1)
    elseif 100102431 == skill_id then
      set_skill_state(6, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    set_scene_tips(62401, false, {})
    self:to_next_guide("guide4", 3)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function(back_form)
    if back_form then
      abort_skill(self.npc)
      restart_skill_teach(102402)
      abort_magic_by_id(self.yuli, kuilei_biaoji)
      abort_magic_by_id(self.yuli, kuileishi_biaoji)
    else
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
      cast_magic(self.monster1, self.monster1, 4032905, 1)
      set_ui_object_visible("fight", "Btn_skill1", true)
      set_ui_object_visible("fight", "Btn_skill4", true)
      set_ui_object_visible("fight", "Btn_skill5", true)
      set_ui_object_visible("fight", "JoystickContent", true)
      self.monster1_pos = get_npc_pos(self.monster1)
      set_scene_tips(62401, true, {})
      start_skill_teach(102402)
    end
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
    flash_to_pos(self.yuli, self.yuli_pos.x, self.yuli_pos.z, self.yuli_pos.y)
    lookat_npc(self.yuli, self.monster1, 1)
    enter_guide(100102410)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102401 == skill_id then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:cancel_guide_timeout()
      set_skill_state(2, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102402 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(1, function()
      self:cancel_guide_timeout()
      set_skill_state(3, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102403 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_skill_state(3, true)
      self:to_next_step(0.5)
      self:cancel_guide_timeout()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102411)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102406 == skill_id then
      clear_input(2, true)
      force_finish_cur_guide()
      self:cancel_guide_timeout()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(0.8)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102412)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_scene_tips(62401, false, {})
    self:to_next_guide("guide5", 2)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    abort_skill(self.yuli, true)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
    flash_to_pos(self.yuli, self.yuli_pos.x, self.yuli_pos.z, self.yuli_pos.y)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    cast_magic(self.yuli, self.yuli, 10001006)
    enter_guide(100102413)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_guide("guide7", 8)
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    set_scene_tips(62401, true, {})
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    self:to_next_step()
  end)
  g:add_step(function()
    remove_missile_by_id(10010161103, self.yuli)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.yuli, self.yuli, 4032167, 1)
    cast_magic(self.yuli, self.yuli, 4032168, 1)
    cast_magic(self.yuli, self.yuli, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({24}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    create_navigator_effect("end", true, true)
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.yuli, 2)
  if characeter_energy <= 200 then
    cast_magic(self.yuli, self.yuli, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.yuli, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101803 == tips_id then
  end
end

function M:search_target()
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, is_time_out, is_break)
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

function M:check_magic(npc, magic_id)
  self:call_guide_listen_func("check_magic", npc, magic_id)
end

function M:check_npc_status(npc, int)
  self:call_guide_listen_func("check_npc_status", npc, int)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self:call_guide_listen_func("after_damage", npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
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
