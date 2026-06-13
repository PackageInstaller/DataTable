local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local ground_npc = get_come_on_hero()
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")
local nengliang100 = 403211911
local nengliang0 = 403211912
local nengliang75 = 403211913

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
  set_ui_object_visible("fight", "ChangHero1", false)
  self.has_referenced_ui = false
  self.hero = get_come_on_hero()
  self.teammate = get_scene_hero_by_poskey(21)
  clear_fight_ui_objs()
  self.init_guide = false
end

function M:teach_guide10()
  if not self.do_once then
    set_ui_object_visible("fight", "Btn_skill2", false)
    self.do_once = true
  end
end

function M:teach_guide11()
  local g = self:create_guide("guide1")
  g:add_step(function()
    if get_config_id(ground_npc) == 1001019 then
      char_visible(false)
      set_cursor_enable(self.hero, false)
    end
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.hero = get_come_on_hero()
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    enter_guide(100101901)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      enter_guide(100101901)
      set_ui_object_visible("fight", "Btn_skill1", true)
      local role = self.hero:get_behavior()
      cast_magic(self.hero, self.hero, 100116, 0)
      remove_missile_by_id(10010181101, self.hero)
      cast_magic(self.hero, self.hero, 4032167, 1)
      cast_magic(self.hero, self.hero, 4032168, 1)
      cast_magic(self.hero, self.hero, 4032165, 1)
      cast_magic(self.hero, self.hero, 10001010, 1)
      restart_skill_teach(101901)
    else
      cast_magic(self.hero, self.hero, 100116, 0)
      cast_magic(self.hero, self.hero, 4032167, 1)
      cast_magic(self.hero, self.hero, 4032168, 1)
      cast_magic(self.hero, self.hero, 4032165, 1)
      start_skill_teach(101901)
      set_scene_tips(61901, true, {})
    end
    cast_magic(self.hero, self.hero, 403211913)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101900 + g:step_index() - 3
    if target_skill_id == skill_id and npc == self.hero then
      set_skill_state(g:step_index() - 3, true)
      self:to_next_step()
    end
    if npc == self.hero and target_skill_id ~= skill_id then
      set_skill_state(g:step_index() - 3, false)
      remove_npc(self.monster1)
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
      self.hero = get_come_on_hero()
      self.pos1 = get_npc_offset_position(self.monster1, nil, 0, 1)
      flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(3, 2)
    end
  end
  
  g:add_step():listen("on_skill_hit", func_skill_begin)
  g:add_step():listen("on_skill_hit", func_skill_begin)
  g:add_step():listen("on_skill_hit", func_skill_begin)
  g:add_step(function()
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101902)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 100101904 == skill_id then
      set_skill_state(4, true)
      cast_magic(self.hero, self.hero, nengliang100)
      self:to_next_step(0.8)
    end
    if npc == self.hero and 100101904 ~= skill_id then
      set_skill_state(4, false)
      remove_npc(self.monster1)
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
      self.hero = get_come_on_hero()
      self.pos1 = get_npc_offset_position(self.monster1, nil, 0, 1)
      flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:back_to_step(3, 2)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    self.hero = get_come_on_hero()
    cast_magic(self.hero, self.hero, 10001010, 1)
    set_ui_object_visible("fight", "JoystickContent", false)
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self.pos1 = get_npc_offset_position(self.monster1, nil, 0, 1)
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    set_scene_tips(61901, false, {})
    set_scene_tips(61903, true, {})
    self:to_next_step(0.2)
  end)
  g:add_step(function()
    enter_guide(100101903)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101934 == skill_id then
      self:to_next_step(2.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20102802, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster2, self.monster2, 10001012)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101906)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    print("skill_id", skill_id)
    if 100100193 == skill_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_scene_tips(61903, false, {})
    enter_guide(100101907)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100101908)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if npc == self.hero then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_scene_tips(61902, true, {})
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster2, 10001001, 1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    self.hero = get_come_on_hero()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.pos1 = get_npc_offset_position(self.monster1, nil, 180, 2)
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    remove_missile_by_id(100101913205)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100101909)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101921 == skill_id then
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(100101910)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 1001019104 == skill_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.hero, self.monster1, 10001001, 1)
    set_scene_tips(61902, false, {})
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    if get_config_id(ground_npc) == 1001019 then
      char_visible(false)
      set_cursor_enable(self.hero, false)
    end
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.pos1 = get_npc_offset_position(self.monster1, nil, 0, 2)
    flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.hero, self.hero, 100116, 0)
      remove_missile_by_id(10010181101, self.hero)
      cast_magic(self.hero, self.hero, 4032167, 1)
      cast_magic(self.hero, self.hero, 4032168, 1)
      cast_magic(self.hero, self.hero, 4032165, 1)
      restart_skill_teach(101901)
    else
      cast_magic(self.hero, self.hero, 100116, 0)
      cast_magic(self.hero, self.hero, 4032167, 1)
      cast_magic(self.hero, self.hero, 4032168, 1)
      cast_magic(self.hero, self.hero, 4032165, 1)
      start_skill_teach(101901)
      set_scene_tips(61901, true, {})
    end
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101900 + g:step_index() - 2
    if target_skill_id == skill_id and npc == self.hero then
      set_skill_state(g:step_index() - 2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    end
    if npc == self.hero and target_skill_id ~= skill_id then
      set_skill_state(g:step_index() - 2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      self:back_to_step(2)
    end)
  end):listen("on_skill_hit", func_skill_begin)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 1001019104 == skill_id then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_scene_tips(61901, false, {})
    self:to_next_guide("guide2", 1)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.hero, self.hero, 100116, 1)
      restart_skill_teach(101911)
    else
      self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
      cast_magic(self.hero, self.hero, 100116, 1)
      start_skill_teach(101911)
      set_scene_tips(61902, true, {})
      self.hero = get_come_on_hero()
      self.pos1 = get_npc_offset_position(self.monster1, nil, 0, 2)
      flash_to_pos(self.hero, self.pos1.x, self.pos1.z)
    end
    remove_missile_by_id(100101913205)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    cast_magic(self.hero, self.hero, 4032184, 1)
    cast_magic(self.hero, self.hero, 4032185, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101921 == skill_id then
      set_skill_state(1, true)
      self:to_next_step(0.5)
    elseif 1001019161 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(2, function()
      self:back_to_step(1, 0)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, skill_type)
    if 1001019104 == skill_id then
      set_skill_state(2, true)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    elseif g:step_elapse() > 2 then
      set_skill_state(2, false)
      self:cancel_guide_timeout()
      self:back_to_step(1, 1)
    end
  end)
  g:add_step(function()
    cast_magic(self.monster1, self.monster1, 10001001, 1)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_scene_tips(61902, false, {})
    cast_magic(self.hero, self.hero, 1999217, 0)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self:to_next_step()
  end)
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    remove_missile_by_id(10010161103, self.hero)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.hero, self.hero, 4032167, 1)
    cast_magic(self.hero, self.hero, 4032168, 1)
    cast_magic(self.hero, self.hero, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_combo_tips({19}, true)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    self.hero = get_come_on_hero()
    create_navigator_effect("end", true, true)
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:add_energy()
  local characeter_energy = get_npc_attr(self.hero, 2)
  if characeter_energy <= 200 then
    cast_magic(self.hero, self.hero, 4032991, 1)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:teach_guide10()
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.hero, 1) then
    self.init_guide = true
    self:teach_guide11()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 101903 == tips_id then
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

function M:check_magic(npc, magic_id)
  self:call_guide_listen_func("check_magic", npc, magic_id)
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

return M
