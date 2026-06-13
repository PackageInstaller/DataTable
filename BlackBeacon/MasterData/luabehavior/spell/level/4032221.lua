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

local butterfly_magic = 1022072

local function cancel_callback()
  set_ui_object_visible("fight", "Btn_skill5", true)
  set_ui_object_visible("fight", "JoystickContent", true)
  set_ui_object_visible("fight", "Btn_skill4", true)
  set_ui_object_visible("fight", "Btn_skill1", true)
  set_ui_object_visible("fight", "Btn_skill3", true)
  set_ui_object_visible("fight", "Btn_skill7", true)
end

function M:_init()
  local god = get_god_npc()
  cast_magic(god, god, 4032226)
  Base._init(self)
  replace_team_pos_data(1, true)
  self.lichi = get_come_on_hero()
  self.init_guide = false
  clear_fight_ui_objs()
end

function M:teach_guide0()
  local g = self:create_guide("guide0")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    self.lichi_pos = get_npc_pos(self.lichi)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", false)
    enter_guide(100102201)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step()
  end)
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.lichi, self.lichi, 4032222, 1)
      restart_skill_teach(102202)
    else
      start_skill_teach(102202)
    end
    set_ui_object_visible("fight", "Btn_skill1", true)
    self:to_next_step()
  end)
  
  local function func_skill_begin(npc, skill_id, skill_type)
    local target_skill_id = 100102201 + g:step_index() - 4
    if target_skill_id == skill_id then
      set_skill_state(g:step_index() - 3, true)
      local delay = 0
      self:to_next_step(delay)
    else
      set_skill_state(g:step_index() - 3, false)
      self:back_to_step(3, 1)
    end
  end
  
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step():listen("on_skill_begin", func_skill_begin)
  g:add_step(function()
    self:to_next_step(1.8)
  end)
  g:add_step(function()
    cast_magic(self.lichi, self.monster2, 10001001, 1)
    self:to_next_step()
  end)
  g:add_step(function()
    self:to_next_guide("guide1", 2)
  end)
  g:start()
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 3.5, "tp3", 0, 0, 4, 99)
    self.monster2_pos = get_npc_pos(self.monster2)
    flash_to_pos(self.lichi, self.lichi_pos.x, self.lichi_pos.z, self.lichi_pos.y)
    cast_magic(self.monster2, self.monster2, 4032905, 1)
    cast_magic(self.lichi, self.lichi, 4032225, 1)
    lookat_npc(self.lichi, self.monster2, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102217)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102217 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100102202)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102202 == guide_id then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill4", false)
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102203)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102203 == guide_id then
      self:to_next_step(0)
    end
  end)
  g:add_step(function()
    enter_guide(100102210)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102210 == guide_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102204)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102204 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(100102210)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102210 == guide_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    cast_magic(self.lichi, self.lichi, 4032223)
    enter_guide(100102205)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102205 == guide_id then
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102206)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill5", false)
    if 100102206 == guide_id then
      self:to_next_step(2.4)
    end
  end)
  g:add_step(function()
    enter_guide(100102207)
    self:to_next_step()
  end)
  g:add_step():listen("on_magic_begin", function(npc, target, magic_id)
    if magic_id == butterfly_magic then
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step(0.01)
    end
  end)
  g:add_step(function()
    enter_guide(100102208)
  end):listen("on_magic_begin", function(npc, target, magic_id)
    if magic_id == butterfly_magic then
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step(0.01)
    end
  end)
  g:add_step(function()
    enter_guide(100102218)
  end):listen("on_skill_begin", function(npc, skill_id)
    if 100102240 == skill_id then
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(100102211)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102211 == guide_id then
      self:to_next_guide("guide2", 2)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function(back_form)
    if back_form then
      cast_magic(self.lichi, self.lichi, 4032222)
      restart_skill_teach(102201)
      local role = self.lichi:get_behavior()
      local thunderDao1 = role.icons.thunderDao1
      local sk2 = role.btns.sk2
      sk2:setIcon(thunderDao1)
    else
      set_scene_tips(62201, true, {})
      start_skill_teach(102201)
    end
    flash_to_pos(self.lichi, self.lichi_pos.x, self.lichi_pos.z, self.lichi_pos.y)
    flash_to_pos(self.monster2, self.monster2_pos.x, self.monster2_pos.z, self.monster2_pos.y)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102230 == skill_id then
      set_skill_state(1, true)
      self:to_next_step()
    elseif g:step_elapse() > 60 or 100102230 ~= skill_id then
      set_skill_state(1, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102233 == skill_id or 100102231 == skill_id then
      set_skill_state(2, true)
      self:to_next_step()
    elseif 100102201 == skill_id then
      set_skill_state(2, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102232 == skill_id or 100102234 == skill_id then
      set_skill_state(3, true)
      cast_magic(self.lichi, self.lichi, 403211911)
      self:to_next_step()
    elseif 100102201 == skill_id then
      set_skill_state(3, false)
      self:back_to_step(1, 1)
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id)
    if 100102241 == skill_id then
      self:cancel_guide_timeout()
      set_skill_state(4, true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    self:guide_timeout(10.5, function()
      set_skill_state(5, false)
      self:back_to_step(1)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100102248 == skill_id then
      set_skill_state(5, true)
      self:cancel_guide_timeout()
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id)
    if 100102240 == skill_id then
      self:to_next_step(1.5)
    end
  end)
  g:add_step(function()
    set_scene_tips(62201, false, {})
    self:to_next_guide("guide3", 2)
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 4, "tp3", 0, 0, 4, 99)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_sync_var("close_counterattack", 1)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "JoystickContent", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self.monster1_pos = get_npc_pos(self.monster1)
    cast_magic(self.lichi, self.lichi, 4032223)
    flash_to_pos(self.lichi, self.lichi_pos.x, self.lichi_pos.z + 8, self.lichi_pos.y)
    flash_to_pos(self.monster2, self.monster2_pos.x, self.monster2_pos.z, self.monster2_pos.y)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(100102212)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    if 100102212 == guide_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step(2.5)
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill5", true)
    enter_guide(100102216)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step(2)
  end)
  g:add_step(function()
    cast_magic(self.lichi, self.lichi, 4032224)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(100102213)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step()
  end)
  g:add_step(function()
    enter_guide(100102214)
    self:to_next_step()
  end)
  g:add_step():listen("on_finish_guide", function(guide_id)
    self:to_next_step(3)
  end)
  g:add_step(function()
    cast_magic(self.lichi, self.lichi, 10001006)
    set_ui_object_visible("fight", "Btn_skill7", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(100102215)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_end", function(npc, skill_id, is_time_out, is_break)
    if 100102260 == skill_id then
      self:to_next_guide("guide7", 1)
    end
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    flash_to_pos(self.lichi, self.lichi_pos.x, self.lichi_pos.z, self.lichi_pos.y)
    flash_to_pos(self.monster1, self.monster1_pos.x, self.monster1_pos.z, self.monster1_pos.y)
    flash_to_pos(self.monster2, self.monster2_pos.x, self.monster2_pos.z, self.monster2_pos.y)
    set_scene_tips(62202, true, {})
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
    remove_missile_by_id(10010161103, self.lichi)
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    cast_magic(self.lichi, self.lichi, 4032167, 1)
    cast_magic(self.lichi, self.lichi, 4032168, 1)
    cast_magic(self.lichi, self.lichi, 4032165, 1)
    self.pos1 = get_npc_pos(self.god1)
    self:to_next_step()
  end)
  g:add_step(function()
    show_skill_combo_tips({22}, true)
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
  local characeter_energy = get_npc_attr(self.lichi, 2)
  if characeter_energy <= 200 then
    cast_magic(self.lichi, self.lichi, 4032991, 1)
  end
end

function M:on_frame()
  Base.on_frame(self)
  self:add_energy()
  if not self.init_guide and not check_npc_status(self.lichi, 1) then
    self.init_guide = true
    self:teach_guide0()
  end
end

function M:on_skill_teach_tips_close(tips_id)
  if 102201 == tips_id then
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
