local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local role = get_come_on_hero():get_behavior()
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
  replace_team_pos_data(1, true)
  self.mesera = get_come_on_hero()
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.mesera, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
      lookat_npc(self.monster1, self.mesera, false)
      flash_to_pos(self.mesera, self.mesera_pos.x, self.mesera_pos.z, self.mesera_pos.y)
      lookat_npc(self.mesera, self.monster1, false)
      set_ui_object_visible("fight", "Btn_skill1", true)
      restart_skill_teach(102501)
    else
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
      cast_magic(self.monster1, self.monster1, 4032905, 1)
      lookat_npc(self.monster1, self.mesera, 1)
      set_sync_var("in_daze", 1)
      set_sync_var("close_counterattack", 1)
      self.monster1_pos = get_npc_pos(self.monster1)
      self.mesera_pos = get_npc_pos(self.mesera)
      lookat_npc(self.mesera, self.monster1, 1)
      start_skill_teach(102501)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102501 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100102501 ~= skill_id then
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(2, 2)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3.6, function()
      set_skill_state(2, false)
      self:back_to_step(2, 0)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102502 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif 100102502 ~= skill_id then
      set_skill_state(2, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 2)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3.6, function()
      set_skill_state(3, false)
      self:back_to_step(2, 0)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102503 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step(1.2)
    elseif 100102503 ~= skill_id then
      set_skill_state(3, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 2)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    enter_guide(100102501)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102501 == guide_id then
      self:to_next_guide("guide2", 2)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.monster2_pos = get_npc_pos(self.monster2)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.mesera, self.monster2, 4032119, 1)
    set_sync_var("in_daze", 0)
    flash_to_pos(self.mesera, self.monster2_pos.x, self.monster2_pos.z - 2)
    lookat_npc(self.mesera, self.monster2, true)
    self:to_next_step(0)
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 2010280101 == skill_id then
      self:to_next_step(0.75)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100102502)
  end):listen("on_magic_begin", function(npc, target, magic_id)
    if 1999126 == magic_id then
      set_ui_object_visible("fight", "Btn_skill3", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(100102503)
  end):listen("on_finish_guide", function(guide_id)
    if 100102503 == guide_id then
      self:to_next_step(0.7)
    end
  end)
  g:add_step(function()
    enter_guide(100102504)
  end):listen("on_finish_guide", function(guide_id)
    if 100102504 == guide_id then
      self:to_next_step(1.4)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster2, self.monster2, 10001001, 1)
    enter_guide(100102505)
  end):listen("on_finish_guide", function(guide_id)
    if 100102505 == guide_id then
      self:to_next_guide("guide3", 2)
    end
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    self.monster3 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.monster3_pos = get_npc_pos(self.monster3)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    cast_magic(self.mesera, self.monster3, 4032119, 1)
    set_sync_var("in_daze", 0)
    flash_to_pos(self.mesera, self.monster3_pos.x, self.monster3_pos.z - 2)
    lookat_npc(self.mesera, self.monster3, true)
    self:to_next_step(0)
  end)
  g:add_step(function(back_form)
    if back_form then
      flash_to_pos(self.monster3, self.monster3_pos.x, self.monster3_pos.z, self.monster3_pos.y)
      flash_to_pos(self.mesera, self.monster3_pos.x, self.monster3_pos.z - 1.8)
      lookat_npc(self.monster3, self.mesera, true)
      lookat_npc(self.mesera, self.monster3, true)
      set_skill_ban_use(1, true)
      restart_skill_teach(102502)
    else
      set_skill_ban_use(1, true)
      flash_to_pos(self.mesera, self.monster3_pos.x, self.monster3_pos.z - 1.8)
      lookat_npc(self.mesera, self.monster3, true)
      start_skill_teach(102502)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_magic_begin", function(npc, target, magic_id)
    if 1999126 == magic_id then
      set_skill_state(1, true)
      set_skill_ban_use(1, false)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102513 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0)
    elseif 100102513 ~= skill_id then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102503 == skill_id then
      set_skill_state(3, true)
      self:cancel_guide_timeout()
      self:to_next_step(1.2)
    elseif 100102503 ~= skill_id then
      set_skill_state(3, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    enter_guide(100102506)
  end):listen("on_finish_guide", function(guide_id)
    if 100102506 == guide_id then
      self:to_next_step(4.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100102511)
  end):listen("on_finish_guide", function(guide_id)
    if 100102511 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    enter_guide(100102512)
  end):listen("on_finish_guide", function(guide_id)
    if 100102512 == guide_id then
      self:to_next_step(6.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    flash_to_pos(self.monster3, self.monster3_pos.x, self.monster3_pos.z, self.monster3_pos.y)
    flash_to_pos(get_come_on_hero(), self.monster3_pos.x, self.monster3_pos.z - 1.8)
    lookat_npc(self.monster3, self.mesera, true)
    lookat_npc(get_come_on_hero(), self.monster3, true)
    set_skill_ban_use(1, true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100102513)
  end):listen("on_finish_guide", function(guide_id)
    if 100102513 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(1.3)
    end
  end)
  g:add_step(function()
    enter_guide(100102515)
  end):listen("on_finish_guide", function(guide_id)
    if 100102515 == guide_id then
      self:to_next_step(0)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster3, self.monster3, 10001001, 1)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.monster4 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster4, self.monster4, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster4_pos = get_npc_pos(self.monster4)
    flash_to_pos(self.mesera, self.mesera_pos.x, self.mesera_pos.z, self.mesera_pos.y)
    lookat_npc(self.monster4, self.mesera, false)
    lookat_npc(self.mesera, self.monster4, false)
    set_skill_ban_use(1, false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100102507)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102506 == skill_id then
      print("重击引导完成")
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(3.83, function()
      print("时间到了回退")
      self:back_to_step(2, 0)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102503 == skill_id then
      print("技能对了不回退", skill_id)
      if missile_cfg.Id == 10010250308 then
        print("子弹对了不回退", missile_cfg.Id)
        self:cancel_guide_timeout()
        cast_magic(self.mesera, hit_target, 10001001, 1)
        self:to_next_step()
      end
    end
    print("回退吗", skill_id)
    if 100102503 ~= skill_id and 100102506 ~= skill_id then
      self:cancel_guide_timeout()
      self:back_to_step(2, 0)
    end
  end)
  g:add_step(function()
    set_skill_ban_use(1, true)
    self:to_next_guide("guide5", 3)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function(back_form)
    if back_form then
      flash_to_pos(self.monster5, self.monster5_pos.x, self.monster5_pos.z, self.monster5_pos.y)
      flash_to_pos(self.mesera, self.mesera_pos.x, self.mesera_pos.z, self.mesera_pos.y)
      lookat_npc(self.monster5, self.mesera, true)
      lookat_npc(self.mesera, self.monster5, true)
      set_ui_object_visible("fight", "Btn_skill1", true)
      restart_skill_teach(102504)
    else
      self.monster5 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
      self.monster5_pos = get_npc_pos(self.monster5)
      cast_magic(self.monster5, self.monster5, 4032905, 1)
      set_sync_var("in_daze", 1)
      set_sync_var("close_counterattack", 1)
      self.monster5_pos = get_npc_pos(self.monster5)
      flash_to_pos(self.mesera, self.monster5_pos.x, self.monster5_pos.z - 2)
      self.mesera_pos = get_npc_pos(self.mesera)
      lookat_npc(self.mesera, self.monster5, true)
      lookat_npc(self.monster5, self.mesera, true)
      set_skill_ban_use(1, false)
      start_skill_teach(102504)
    end
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100102506 == skill_id then
      set_skill_state(1, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    elseif 100102506 ~= skill_id then
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 2)
    end
  end)
  g:add_step(function()
    self:guide_timeout(3.83, function()
      set_skill_state(2, false)
      self:back_to_step(1, 0)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102503 == skill_id or 100102506 == skill_id then
      print("技能对了不回退", skill_id)
      if missile_cfg.Id == 10010250308 then
        print("子弹对了不回退", missile_cfg.Id)
        self:cancel_guide_timeout()
        set_skill_state(2, true)
        self:to_next_step()
      end
    else
      self:cancel_guide_timeout()
      set_skill_state(2, false)
      self:back_to_step(1, 0)
    end
  end)
  g:add_step(function()
    enter_guide(100102506)
  end):listen("on_finish_guide", function(guide_id)
    if 100102506 == guide_id then
      self:to_next_step(1.85)
    end
  end)
  g:add_step(function()
    cast_magic(self.mesera, self.monster5, 10001001, 1)
    self:to_next_guide("guide6", 2)
  end)
  g:start()
end

function M:teach_guide6()
  local g = self:create_guide("guide6")
  g:add_step(function()
    enter_guide(100102516)
  end):listen("on_finish_guide", function(guide_id)
    if 100102516 == guide_id then
      set_skill_ban_use(5, true)
      self:to_next_step(5)
    end
  end)
  g:add_step(function()
    abort_magic_by_id(self.mesera, 10250051)
    enter_guide(100102517)
  end):listen("on_finish_guide", function(guide_id)
    if 100102517 == guide_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    self.monster6 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster6, self.monster6, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster6_pos = get_npc_pos(self.monster6)
    flash_to_pos(self.mesera, self.mesera_pos.x, self.mesera_pos.z - 2)
    lookat_npc(self.mesera, self.monster6, true)
    lookat_npc(self.monster6, self.mesera, true)
    lookat_npc(self.monster6, self.mesera, true)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_skill_ban_use(1, true)
    set_skill_ban_use(4, true)
    set_skill_ban_use(5, false)
    set_ui_object_visible("fight", "ChangHero1", false)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100102514)
  end):listen("on_finish_guide", function(guide_id)
    if 100102514 == guide_id then
      set_skill_ban_use(5, true)
      self:to_next_step(1.1)
    end
  end)
  g:add_step(function()
    set_skill_ban_use(4, false)
    enter_guide(100102515)
  end):listen("on_finish_guide", function(guide_id)
    if 100102515 == guide_id then
      self:to_next_step(0)
    end
  end)
  g:add_step(function()
    enter_guide(100102508)
  end):listen("on_finish_guide", function(guide_id)
    if 100102508 == guide_id then
      self:to_next_step(0.6)
    end
  end)
  g:add_step(function()
    enter_guide(100102509)
  end):listen("on_finish_guide", function(guide_id)
    if 100102509 == guide_id then
      self:to_next_step(0.8)
    end
  end)
  g:add_step(function()
    set_skill_ban_use(5, false)
    enter_guide(100102515)
  end):listen("on_finish_guide", function(guide_id)
    if 100102515 == guide_id then
      self:to_next_step(0)
    end
  end)
  g:add_step(function()
    enter_guide(100102510)
  end):listen("on_finish_guide", function(guide_id)
    if 100102510 == guide_id then
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_skill_ban_use(1, false)
    enter_guide(100102506)
  end):listen("on_finish_guide", function(guide_id)
    if 100102506 == guide_id then
      self:to_next_step(1.85)
    end
  end)
  g:add_step(function()
    cast_magic(self.mesera, self.monster6, 10001001, 1)
    self:to_next_guide("guide7", 2)
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    show_skill_combo_tips({
      2501,
      2502,
      2503
    }, true)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.monster7 = add_npc_by_pos_key(1, 20101502, "bornpoint", -2, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster7, self.monster7, 4032905, 1)
    self.monster7_pos = get_npc_pos(self.monster7)
    flash_to_pos(self.mesera, self.monster7_pos.x, self.monster7_pos.z - 2)
    lookat_npc(self.mesera, self.monster7)
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
    set_scene_tips(62501, true, {})
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
  local characeter_energy = get_npc_attr(self.mesera, 2)
  if characeter_energy <= 200 then
    cast_magic(self.mesera, self.mesera, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.mesera, 1) then
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
