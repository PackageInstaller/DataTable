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
  print("退出教学关")
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
  self.hero = get_come_on_hero()
  self.teammateyilei = get_scene_hero_by_poskey(21)
  cast_magic(self.hero, self.hero, 10001010, 1)
  cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
  clear_fight_ui_objs()
  self.init_guide = false
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    self.do_once = true
  end
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20102805, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
    cast_magic(self.hero, self.hero, 10001010, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_scene_tips(60001, true, {})
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
    else
    end
    set_scene_tips(60001, true, {})
    cast_magic(self.npc, self.npc, 4032012, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(10010001)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.monster1 and 2010280501 == skill_id then
      cast_magic(self.npc, self.npc, 4032996)
      self:to_next_step(0.6)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100100012)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100101 == skill_id then
      self:to_next_step(0.9)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100100011)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster1, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(3)
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20102805, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    set_scene_tips(60002, true, {})
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.monster2 and 2010280501 == skill_id then
      self:to_next_step(0.8)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100100013)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster2 then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster2, 10001001, 1)
    set_scene_tips(60002, false, {})
    self:to_next_step(3)
  end)
  g:add_step(function()
    self.monster3 = add_npc_by_pos_key(1, 20101503, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    self.hero = get_come_on_hero()
    self.pos1 = get_npc_offset_position(self.monster3, nil, 0, 0.5)
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
    cast_magic(self.hero, self.hero, 10001010, 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_scene_tips(60003, true, {})
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(10010005)
    set_ui_object_visible("fight", "ChangHero1", true)
  end):listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    cast_magic(self.monster3, self.monster3, 3190014, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_element_aborn_start", function(npc, element)
    if npc == self.monster3 then
      set_skill_state(1, true)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    self.hero = get_come_on_hero()
    cast_magic(self.hero, self.monster3, 10001001, 1)
    cast_magic(self.hero, self.hero, 10001010, 1)
    set_scene_tips(60003, false, {})
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide1_1()
  local g = self:create_guide("guide1_1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20102805, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_scene_tips(60001, true, {})
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(100805)
    else
      start_skill_teach(100805)
    end
    set_scene_tips(60003, true, {})
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.monster1 and 2010280501 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(10010001)
    self:to_next_step()
  end)
  g:add_step():listen("on_input", function(input_id)
    if 15 == input_id then
      start_long_click_skill()
    end
  end):listen("on_touch_up", function(output_id, iscancel, input_time)
    if 15 == output_id and input_time >= 0.15 and not iscancel then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      clear_input()
      self:to_next_step(0.1)
    else
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(2, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster1, 10001001, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(2)
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20102805, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    set_scene_tips(60002, true, {})
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.monster2 and 2010280501 == skill_id then
      self:to_next_step(0.2)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(10010002)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster2 then
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster2, 10001001, 1)
    set_scene_tips(60002, false, {})
    self:to_next_step(3)
  end)
  g:add_step(function()
    self.monster3 = add_npc_by_pos_key(1, 20101503, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "ChangHero1", true)
    cast_magic(self.monster3, self.monster3, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_scene_tips(60003, true, {})
    enter_guide(10010005)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster4 = add_npc_by_pos_key(1, 20101104, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    set_scene_tips(60004, true, {})
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    self.pos1 = get_npc_offset_position(self.monster4, nil, 0, 1)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    cast_magic(self.hero, self.hero, 10001010, 1)
    cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
    self:to_next_step(0.2)
  end)
  g:add_step(function()
    enter_guide(10010006)
    self:to_next_step()
  end)
  g:add_step():listen("on_element_aborn_start", function(npc, element)
    if npc == self.monster4 then
      change_follow_target_new(1, self.monster4, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        2,
        1,
        1,
        0,
        1
      })
      cast_magic(self.monster4, self.monster4, 1999220, 1)
      self:to_next_step(0.7)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(10010003)
    self.hero = get_come_on_hero()
    cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
    cast_magic(self.hero, self.hero, 10001010, 1)
  end):listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "ChangHero1", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    change_follow_target_new(4)
  end):listen("on_element_aborn_start", function(npc, element)
    if npc == self.monster4 then
      cast_magic(self.monster4, self.monster4, 10001009, 1)
      cast_magic(self.monster4, self.monster4, 1999220, 1)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    self.hero = get_come_on_hero()
    cast_magic(self.hero, self.hero, 10001010, 1)
    cast_magic(self.teammateyilei, self.teammateyilei, 10001010, 1)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    enter_guide(10010004)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster4, 10001001, 1)
    self:to_next_guide("guide4", 2)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    self.monster1 = add_npc_by_pos_key(1, 20101104, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.monster1)
    self.pos2 = get_npc_pos(self.god1)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z - 2)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({40321002}, true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_scene_tips(801019, true, {})
    create_scene_effect("Fx_Transmit2", self.pos2, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    self.finished_teach_guide = true
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
  self:teach_guide10()
  if not self.init_guide and not check_npc_status(self.npc, 1) and get_npc_id(self.hero) == 1001001 then
    self.init_guide = true
    self:teach_guide1()
  end
  if not self.init_guide and not check_npc_status(self.npc, 1) and get_npc_id(self.hero) == 1001008 then
    self.init_guide = true
    self:teach_guide1_1()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 100001 == tips_id then
    set_scene_tips(801019, true, {})
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

function M:on_element_aborn_start(npc, element)
  self:call_guide_listen_func("on_element_aborn_start", npc, element)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
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

function M:after_damage(npc, target)
  if target.id == 20101104 and not check_magic(target, 3190013) then
    cast_magic(target, target, 3190014, 1)
    cast_magic(target, target, 3190013, 1)
  end
end

return M
