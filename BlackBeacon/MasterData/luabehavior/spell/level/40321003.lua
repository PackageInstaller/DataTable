local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local tip = Util.format_str("是否退出关卡")
local sure_btn = Util.format_str("是")
local cancel_btn = Util.format_str("否")
local tool = import("common.tool")

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
  local god = get_god_npc()
  cast_magic(god, god, 403210039)
  abort_magic_by_id(god, 4032226)
  Base._init(self)
  self.hero_ling = get_come_on_hero()
  self.hero_shamashi = get_scene_hero_by_poskey(21)
  self.hero_enji = get_scene_hero_by_poskey(22)
  clear_fight_ui_objs()
  self.init_guide = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20101502, "bornpoint", 0, 2, "tp3", 0, 0, 4, 1)
    cast_magic(self.monster1, self.monster1, 4032905, 1)
    set_sync_var("in_daze", 1)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_scene_tips(60005, true, {})
    self:to_next_step(0.05)
  end)
  g:add_step(function()
    enter_guide(10010017)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("on_finish_guide", function(guide_id)
    if 10010017 == guide_id then
      set_ui_object_visible("fight", "Btn_skill7", true)
      local hero = get_come_on_hero()
      cast_magic(hero, hero, 100010101)
      cast_magic(hero, hero, 100010103)
      cast_magic(hero, hero, 100010104)
      enter_guide(10010018)
      self:to_next_step()
    end
  end)
  g:add_step(function()
  end):listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step()
  end)
  g:add_step(function()
  end):listen("after_damage", function(npc, target)
    if not self.time then
      self.time = 0
    end
    self.time = self.time + 1
    if self.time > 5 then
      local hero = get_come_on_hero()
      abort_magic_by_id(hero, 100010101)
      abort_magic_by_id(hero, 100010103)
      abort_magic_by_id(hero, 100010104)
      self:to_next_step(0.2)
    end
  end)
  g:add_step(function()
    local god = get_god_npc()
    cast_magic(god, god, 403210031)
    enter_guide(10010019)
  end):listen("on_finish_guide", function(guide_id)
    if 10010019 == guide_id then
      self:to_next_step(2)
    end
  end)
  g:add_step(function()
    enter_guide(10010020)
  end):listen("on_finish_guide", function(guide_id)
    if 10010020 == guide_id then
      local hero = get_come_on_hero()
      cast_magic(hero, hero, 100010101)
      cast_magic(hero, hero, 100010103)
      cast_magic(hero, hero, 100010104)
      set_ui_object_visible("fight", "JoystickContent", true)
      self:to_next_step(7)
    end
  end)
  g:add_step(function()
    print("114514")
  end):listen("after_damage", function(npc, target)
    self.time = self.time + 1
    if self.time > 20 then
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    local god = get_god_npc()
    cast_magic(god, god, 403210032)
    set_ui_object_visible("fight", "ChangHero1", true)
    enter_guide(10010021)
  end):listen("on_finish_guide", function(guide_id)
    if 10010021 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    enter_guide(10010026)
  end):listen("on_finish_guide", function(guide_id)
    if 10010026 == guide_id then
      self:to_next_step(1.7)
    end
  end)
  g:add_step(function()
    enter_guide(10010024)
  end):listen("on_finish_guide", function(guide_id)
    if 10010024 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", true)
      set_ui_object_visible("fight", "ChangHero2", true)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    enter_guide(10010022)
  end):listen("on_finish_guide", function(guide_id)
    if 10010022 == guide_id then
      set_ui_object_visible("fight", "ChangHero1", false)
      set_ui_object_visible("fight", "ChangHero2", false)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(10010025)
  end):listen("on_finish_guide", function(guide_id)
    set_ui_object_visible("fight", "ChangHero1", true)
    set_ui_object_visible("fight", "ChangHero2", true)
    self:to_next_guide("guide4", 8)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "end", 0, 0, "end", 0, 0, 2, 1)
    self.pos2 = get_npc_pos(self.god1)
    self.hero = get_come_on_hero()
    self:to_next_step()
  end)
  g:add_step(function()
    local god = get_god_npc()
    cast_magic(god, god, 4032997)
    show_skill_combo_tips({40321003}, true)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_scene_tips(801019, true, {})
    create_scene_effect("Fx_Transmit2", self.pos2, 999, "jiaohu")
    create_navigator_effect("end", true, true)
    self.hero = get_come_on_hero()
    self.finished_teach_guide = true
    set_scene_tips(801019, true, {})
    self:end_teach_guide()
  end)
  g:start()
end

function M:on_frame()
  Base.on_frame(self)
  if not self.init_guide and not check_npc_status(self.npc, 1) then
    self.init_guide = true
    self:teach_guide1()
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.finished_teach_guide == true then
    create_navigator_effect("end", true, true)
  end
  if is_showup then
    set_fight_ui_object_visible("Btn_skill1", true)
    set_fight_ui_object_visible("Btn_skill3", true)
    set_fight_ui_object_visible("Btn_skill4", true)
    set_fight_ui_object_visible("Btn_skill5", true)
    set_fight_ui_object_visible("Btn_skill7", true)
    set_fight_ui_object_visible("Btn_lock7", true)
    set_fight_ui_object_visible("JoystickContent", true)
  end
end

function M:on_start()
  ComnMgr.LinkMgr:setTriggerOption(Const.SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.ONLY_LINK)
end

function M:on_remove()
  ComnMgr.LinkMgr:clearTriggerOption()
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

function M:after_damage(npc, target)
  self:call_guide_listen_func("after_damage", npc, target)
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
