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
  self.teammateming = get_scene_hero_by_poskey(21)
  clear_fight_ui_objs()
  self.teammateluogesi = get_come_on_hero()
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    self.monster1_pos = get_npc_pos(self.monster1)
    set_ui_object_visible("fight", "Btn_skill2", false)
    set_ui_object_visible("fight", "Btn_skill8", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self:to_next_step(1)
  end)
  g:add_step(function(back_form)
    if back_form then
      restart_skill_teach(101401)
      flash_to_pos(self.teammateluogesi, self.monster1_pos.x, self.monster1_pos.z - 2.2)
      flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:decrease(5)
        luogesi.spBar:increase(3)
      end
      abort_skill(self.teammateluogesi, 1)
    else
      start_skill_teach(101401)
      set_scene_tips(61401, true, {})
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:increase(3)
      end
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101419)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100101400 + g:step_index() - 2
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 2, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    else
      set_skill_state(g:step_index() - 2, false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_skill_state(2, false)
      self:back_to_step(2, 1.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_skill_state(3, false)
      self:back_to_step(2, 1.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:guide_timeout(1.5, function()
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_skill_state(4, false)
      self:back_to_step(2, 1.5)
    end)
  end):listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    on_up_skill_btn(15, false)
    set_scene_tips(61401, false, {})
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    abort_magic_by_id(self.teammateluogesi, 101436)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100101415)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.teammateluogesi and 100101431 == skill_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101418)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.teammateluogesi and 100101444 == skill_id then
      self:to_next_step(3.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(100101420)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101183 == skill_id then
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032992, 1)
      self:to_next_step(0.3)
    end
  end)
  g:add_step(function()
    enter_guide(100101423)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.teammateluogesi then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.teammateluogesi, self.monster1, 10001001, 1)
    self:to_next_guide("guide5", 1)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    self.monster1_pos = get_npc_pos(self.monster1)
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
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032145, 1)
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032146, 1)
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:decrease(5)
      end
      abort_magic_by_id(self.teammateluogesi, 101437, 1)
      restart_skill_teach(101404)
    else
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032145, 1)
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032146, 1)
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:decrease(5)
      end
      start_skill_teach(101404)
    end
    flash_to_pos(self.teammateluogesi, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101411)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if npc == self.teammateluogesi and 100101431 == skill_id then
      set_skill_state(1, true)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(0.4)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100101413)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101403 == skill_id then
      set_skill_state(2, true)
      self:to_next_step(0.3)
    else
      set_skill_state(2, false)
      self:back_to_step(2, 1)
      self:cancel_guide_timeout()
    end
  end)
  g:add_step(function()
    enter_guide(100101414)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101404 == skill_id then
      set_skill_state(3, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:cancel_guide_timeout()
      self:to_next_step(0.5)
    else
      set_skill_state(3, false)
      self:back_to_step(2, 1)
      self:cancel_guide_timeout()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100101412)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101432 == skill_id then
      set_skill_state(4, true)
      self:cancel_guide_timeout()
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(0.3)
    else
      set_skill_state(4, false)
      self:back_to_step(2, 1)
      self:cancel_guide_timeout()
    end
  end)
  g:add_step(function()
    cast_magic(self.teammateluogesi, self.monster1, 10001001, 1)
    self:to_next_guide("guide2", 2)
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    flash_to_pos(self.teammateluogesi, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    self:to_next_step(1.5)
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032145, 1)
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032146, 1)
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:decrease(5)
      end
      flash_to_pos(self.teammateluogesi, self.monster1_pos.x, self.monster1_pos.z - 1)
      flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z)
      abort_magic_by_id(self.teammateluogesi, 101437, 1)
      restart_skill_teach(101405)
    else
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032145, 1)
      cast_magic(self.teammateluogesi, self.teammateluogesi, 4032146, 1)
      local luogesi = self.teammateluogesi:get_behavior()
      if luogesi then
        luogesi.spBar:decrease(5)
      end
      abort_magic_by_id(self.teammateluogesi, 101436, 1)
      start_skill_teach(101405)
    end
    abort_magic_by_id(self.teammateluogesi, 101437, 1)
    abort_magic_by_id(self.teammateluogesi, 101436, 1)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100101416)
    self:to_next_step()
  end)
  g:add_step(function()
    self:guide_timeout(3, function()
      set_skill_state(1, false)
      abort_skill(self.teammateluogesi, true)
      clear_input(2, true)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:back_to_step(2, 2)
    end)
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101460 == skill_id then
      self.skill03_loop_time = get_npc_time(self.teammateluogesi) + 0.8
      start_long_click_skill()
    end
    if 100101462 == skill_id and get_npc_time(self.teammateluogesi) >= self.skill03_loop_time then
      self:cancel_guide_timeout()
      self:to_next_step(0.4)
    elseif 100101462 == skill_id then
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:cancel_guide_timeout()
      self:back_to_step(2, 2)
    end
  end)
  g:add_step(function()
    if check_npc_status(self.monster1, 2) then
      set_skill_state(1, true)
      self:to_next_step(1.3)
    else
      set_skill_state(1, false)
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:back_to_step(2, 2)
    end
  end)
  g:add_step(function()
    enter_guide(100101417)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100101462 == skill_id then
      self:to_next_step(0.3)
    end
  end)
  g:add_step(function()
    cast_magic(self.teammateluogesi, self.monster1, 10001001, 1)
    self:to_next_step(1.5)
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    show_skill_combo_tips({14, 1402}, true)
    create_navigator_effect("end", true, true)
    self.hero = get_come_on_hero()
    flash_to_pos(self.hero, self.monster1_pos.x, self.monster1_pos.z - 2.2)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
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
  local characeter_energy = get_npc_attr(self.teammateluogesi, 2)
  if characeter_energy <= 200 then
    cast_magic(self.teammateluogesi, self.teammateluogesi, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.teammateluogesi, 1) then
    self.init_guide = true
    self:teach_guide1()
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

function M:on_magic_begin(npc, target, magic_id)
  self:call_guide_listen_func("on_magic_begin", npc, target, magic_id)
end

function M:on_magic_end(npc, target, magic_id)
  self:call_guide_listen_func("on_on_magic_end", npc, target, magic_id)
end

function M:on_touch_up(output_id, iscancel, input_time)
  self:call_guide_listen_func("on_touch_up", output_id, iscancel, input_time)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  self:call_guide_listen_func("on_skill_end", npc, skill_id, is_time_out, is_break, behavior_abort)
end

function M:on_finish_guide(guide_id)
  self:call_guide_listen_func("on_finish_guide", guide_id)
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
