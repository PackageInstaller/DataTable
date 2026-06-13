local Base = import("spell.base.teach_level_base")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack

function M:_init()
  Base._init(self)
  self.nmb = 0
  self.init_guide = false
  self.exercise_rec = false
  self.HP_rec = false
end

function M:teach_guide1()
  local g = self:create_guide("guide1")
  g:add_step(function()
    play_video("timeline-1.mp4", true, 0, 0)
    set_sync_var("prologue", true)
    set_ui_object_visible("fight", "Btn_skill7", false)
    self:to_next_step()
  end)
  g:add_step():listen("on_video_play_end", function()
    start_stroy(201406)
    self:to_next_step()
  end)
  g:add_step(function()
    set_sceneobj_visible("LevelObj/Sc04_build_02A_pre", false)
    set_sceneobj_visible("LevelObj/zhuzi_six", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_02_anim", true)
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("Sc0401_timeline/wall/wall_1(CHAR_BLOCK)", true)
    self:to_next_step()
  end)
  g:add_step(function()
    set_sceneobj_visible("Sc0401_timeline/wall/wall_2(CHAR_BLOCK)", false)
    self:to_next_step()
  end)
  g:add_step(function()
    set_sceneobj_visible("LevelObj/Sc04_build_01ani_pre/Sc04_onesixth_01 (2)", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (3)", true)
    self:to_next_step()
  end)
  g:add_step(function()
    set_sceneobj_visible("LevelObj/Sc04_build_01ani_pre/Sc04_onesixth_01 (3)", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (4)", true)
    self:to_next_step()
  end)
  g:add_step(function()
    self.god1 = add_npc_by_pos_key(1, 3001024, "M1", 0, 0, "M1", 0, 0, 2, 1)
    self.pos1 = get_npc_pos(self.god1)
    create_scene_effect("Fx_Transmit2", self.pos1, 999, "jiaohu")
    cast_magic(self.npc, self.npc, 4010207, 1)
    self.HP_rec = true
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_scene_camera(100010002)
    enter_guide(1001001)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.5)
  end)
  g:add_step():listen("on_enter_area", function(npc, area)
    if npc == self.npc and area.Key == "M1" then
      stop_move(self.npc)
      clear_input()
      remove_scene_effect("jiaohu")
      set_ui_object_visible("fight", "JoystickContent", false)
      set_scene_camera(100010004)
      set_sceneobj_visible("LevelObj/Sc04_build_01ani_pre/Sc04_onesixth_01 (1)", false)
      set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (2)", true)
      set_sceneobj_visible("LevelObj/Sc04_build_01ani_pre/Sc04_onesixth_01 (4)", false)
      set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (6)", true)
      set_sceneobj_visible("Sc0401_timeline/wall/wall_2(CHAR_BLOCK)", true)
      set_sceneobj_visible("Sc0401_timeline/wall/wall_3(CHAR_BLOCK)", true)
      set_sceneobj_visible("timeline1_2_office", true)
      cast_magic(self.npc, self.npc, 100455, 1)
      self:guide_timeout(1, function()
        cast_magic(self.npc, self.npc, 100473, 1)
      end, "cam1")
      set_sceneobj_visible("sence_noise_1", false)
      set_sceneobj_visible("sence_quiet_1", true)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    self.monster1 = add_npc_by_pos_key(1, 20106001, "M11", 0, 0, "M1", 0, 0, 4, 1)
    set_sync_var("close_counterattack", 1)
    cast_magic(self.npc, self.npc, 4010139, 1)
    cast_magic(self.npc, self.npc, 4032003, 1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self.monster2 = add_npc_by_pos_key(1, 20106001, "M5", 0, 0, "M1", 0, 0, 4, 1)
    set_sceneobj_visible("LevelObj/Sc04_build_01ani_pre/Sc04_onesixth_01 (5)", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (6)", true)
    set_sceneobj_visible("timeline1_3_office", true)
    cast_magic(self.npc, self.npc, 100455, 1)
    self:guide_timeout(1, function()
      cast_magic(self.npc, self.npc, 100473, 1)
    end, "cam1")
    self:to_next_step(1)
  end)
  g:add_step(function()
    cast_skill(self.monster1, self.npc, 20106002)
    self:to_next_step(0.6)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(1001007)
    set_ui_object_visible("fight", "Btn_skill3", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill3", false)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    enter_guide(1001008)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster2 then
      cast_magic(self.monster2, self.monster2, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:to_next_step()
    end
    if hit_target == self.monster1 then
      cast_magic(self.monster1, self.monster1, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill1", false)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", false)
    set_sceneobj_visible("sence_quiet_1", true)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    enter_guide(1001006)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    self:to_next_step()
  end)
  g:add_step():listen("on_npc_hp_zero", function(npc)
    if npc == self.monster1 or npc == self.monster2 then
      set_ui_object_visible("fight", "Btn_skill1", false)
      on_up_skill_btn(15, false)
      self:to_next_guide("guide2", 1.5)
    end
  end)
  g:start()
end

function M:teach_guide2()
  local g = self:create_guide("guide2")
  g:add_step(function()
    self.monster3 = add_npc_by_pos_key(1, 20106101, "M4", 0, 0, "M1", 0, 0, 4, 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step(1)
  end)
  g:add_step(function()
    stop_move(self.monster3)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", false)
    set_sceneobj_visible("sence_quiet_1", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", false)
    on_up_skill_btn(15, false)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(1001002)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 10001003, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100181 == skill_id then
      self:to_next_step()
    end
  end):listen("on_npc_hp_zero", function(npc)
    if npc == self.monster3 then
      self:to_next_guide("guide3", 1)
    end
  end)
  g:add_step(function()
    self:guide_timeout(5, function()
      self:back_to_step(6)
    end)
  end):listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if 100100183 == skill_id and hit_target == self.monster3 then
      cast_magic(self.monster3, self.monster3, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill3", true)
      change_follow_target(0)
      self:cancel_guide_timeout()
      self:to_next_guide("guide3", 1)
    elseif g:step_elapse() > 3 then
      self:cancel_guide_timeout()
      self:back_to_step(6, 0)
    end
  end)
  g:start()
end

function M:teach_guide3()
  local g = self:create_guide("guide3")
  g:add_step(function()
    self.monster4 = add_npc_by_pos_key(1, 20106015, "M3", 0, 0, "M1", 0, 0, 4, 1)
    self.monster5 = add_npc_by_pos_key(1, 20106015, "M5", 0, 0, "M1", 0, 0, 4, 1)
    set_sync_var("close_counterattack", 1)
    self:to_next_step()
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 10001005, 1)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster4 or hit_target == self.monster5 then
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster4 or hit_target == self.monster5 then
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster4 or hit_target == self.monster5 then
      set_ui_object_visible("fight", "Btn_skill1", false)
      set_ui_object_visible("fight", "Btn_skill3", false)
      on_up_skill_btn(15, false)
      self:to_next_step(0.5)
    end
  end)
  g:add_step(function()
    cast_magic(self.npc, self.npc, 10001003, 1)
    set_ui_object_visible("fight", "Btn_skill4", true)
    self:to_next_step()
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", false)
    set_sceneobj_visible("sence_quiet_1", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    enter_guide(1001003)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    self:to_next_step(1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", true)
    enter_guide(1001009)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    cast_magic(self.npc, self.npc, 10001003, 1)
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    self:to_next_step()
  end)
  g:add_step():listen("on_npc_hp_zero", function(npc)
    if npc == self.monster5 then
      self:to_next_step()
    end
    if npc == self.monster4 then
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_npc_hp_zero", function(npc)
    if npc == self.monster5 then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step()
    end
    if npc == self.monster4 then
      set_ui_object_visible("fight", "Btn_skill5", false)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill1", false)
    on_up_skill_btn(15, false)
    self:to_next_guide("guide4", 1)
  end)
  g:start()
end

function M:teach_guide4()
  local g = self:create_guide("guide4")
  set_sync_var("WXNL", true)
  g:add_step(function()
    self.monster11 = add_npc_by_pos_key(1, 20106015, "M1", 0, 0, "M6", 0, 0, 4, 1)
    self:guide_timeout(1, function()
      self.monster12 = add_npc_by_pos_key(1, 20106015, "M2", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster1")
    self:guide_timeout(2, function()
      self.monster13 = add_npc_by_pos_key(1, 20106015, "M3", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster2")
    self:guide_timeout(3, function()
      self.monster14 = add_npc_by_pos_key(1, 20106015, "M9", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster3")
    self:guide_timeout(3.5, function()
      self.monster15 = add_npc_by_pos_key(1, 20106015, "M15", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster4")
    self:guide_timeout(4, function()
      self.monster16 = add_npc_by_pos_key(1, 20106015, "M8", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster5")
    self:guide_timeout(7, function()
      self.monster17 = add_npc_by_pos_key(1, 20106015, "M6", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster6")
    self:guide_timeout(8, function()
      self.monster18 = add_npc_by_pos_key(1, 20106015, "M14", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster7")
    self:guide_timeout(8.5, function()
      self.monster19 = add_npc_by_pos_key(1, 20106015, "M13", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster8")
    self:guide_timeout(9, function()
      self.monster20 = add_npc_by_pos_key(1, 20106015, "M5", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster9")
    self.exercise_rec = true
    cast_magic(self.npc, self.npc, 10001002, 1)
    self:to_next_step(2)
  end)
  g:add_step(function()
    enter_guide(1001010)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self.exercise_rec = true
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100131 == skill_id then
      set_ui_object_visible("fight", "Btn_skill5", false)
      set_ui_object_visible("fight", "Btn_skill1", true)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_npc_hp_zero", function(npc)
    if npc == self.monster11 or npc == self.monster12 or npc == self.monster13 or npc == self.monster14 or npc == self.monster15 or npc == self.monster16 or npc == self.monster17 or npc == self.monster18 or npc == self.monster19 or npc == self.monster20 then
      self.nmb = self.nmb + 1
      cast_magic(self.npc, self.npc, 10001002, 1)
      if 10 == self.nmb then
        set_ui_object_visible("fight", "Btn_skill1", false)
        set_ui_object_visible("fight", "Btn_skill3", false)
        on_up_skill_btn(15, false)
        self:to_next_step()
      end
    end
  end)
  g:add_step(function()
    self:to_next_guide("guide5", 2)
  end)
  g:start()
end

function M:teach_guide5()
  local g = self:create_guide("guide5")
  g:add_step(function()
    play_timeline("TIMELINE0_1_2_0", 0, 1, nil, false, true)
    cast_magic(self.npc, self.npc, 4010212, 1)
    self.exercise_rec = false
    self:to_next_step()
  end)
  g:add_step(function()
    self.monster11 = add_npc_by_pos_key(1, 20106001, "M14", 0, 0, "M6", 0, 0, 4, 1)
    self:guide_timeout(0.3, function()
      self.monster12 = add_npc_by_pos_key(1, 20106001, "M12", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster1")
    self:guide_timeout(0.5, function()
      self.monster13 = add_npc_by_pos_key(1, 20106001, "M12", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster2")
    self:guide_timeout(0.8, function()
      self.monster14 = add_npc_by_pos_key(1, 20106001, "M13", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster3")
    self:guide_timeout(1, function()
      self.monster15 = add_npc_by_pos_key(1, 20106001, "M11", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster4")
    self:guide_timeout(1.3, function()
      self.monster16 = add_npc_by_pos_key(1, 20106001, "M15", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster5")
    set_sync_var("in_daze", 1)
    cast_magic(self.npc, self.npc, 4032011, 1)
    set_npc_pos(self.npc, "M6")
    lookat_npc(self.npc, self.monster15)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step()
  end)
  g:add_step():listen("on_timeline_end", function(timeline_name)
    if "TIMELINE0_1_2_0" == timeline_name then
      cast_magic(self.npc, self.npc, 4010213, 1)
      set_sceneobj_visible("sence_noise_1", false)
      set_sceneobj_visible("sence_quiet_1", true)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    enter_guide(1001005)
    set_ui_object_visible("fight", "Btn_skill5", true)
    self:to_next_step(0.1)
  end)
  g:add_step():listen("on_skill_hit", function(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
    if hit_target == self.monster11 or hit_target == self.monster12 or hit_target == self.monster13 or hit_target == self.monster14 or hit_target == self.monster15 or hit_target == self.monster16 then
      cast_magic(self.monster11, self.monster11, 10001001, 1)
      cast_magic(self.monster12, self.monster12, 10001001, 1)
      cast_magic(self.monster13, self.monster13, 10001001, 1)
      cast_magic(self.monster14, self.monster14, 10001001, 1)
      cast_magic(self.monster15, self.monster15, 10001001, 1)
      cast_magic(self.monster16, self.monster16, 10001001, 1)
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_end", function(npc, skill_id)
    if 100100132 == skill_id then
      set_ui_object_visible("fight", "Btn_skill4", false)
      self:to_next_step()
    end
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    self:to_next_step()
  end)
  g:add_step(function()
    self:to_next_guide("guide6", 0)
  end)
  g:start()
end

function M:teach_guide6()
  local g = self:create_guide("guide5")
  g:add_step(function()
    self.monster11 = add_npc_by_pos_key(1, 20106001, "M14", 0, 0, "M6", 0, 0, 4, 1)
    self:guide_timeout(0.3, function()
      self.monster12 = add_npc_by_pos_key(1, 20106001, "M3", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster1")
    self:guide_timeout(0.5, function()
      self.monster13 = add_npc_by_pos_key(1, 20106001, "M11", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster2")
    self:guide_timeout(0.5, function()
      self.monster14 = add_npc_by_pos_key(1, 20106001, "M13", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster3")
    self:guide_timeout(0.8, function()
      self.monster15 = add_npc_by_pos_key(1, 20106001, "M12", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster4")
    self:guide_timeout(0.8, function()
      self.monster16 = add_npc_by_pos_key(1, 20106001, "M11", 0, 0, "M6", 0, 0, 4, 1)
    end, "monster5")
    set_sync_var("in_daze", 1)
    cast_magic(self.npc, self.npc, 10001006, 1)
    lookat_npc(self.npc, self.monster15)
    set_ui_object_visible("fight", "JoystickContent", false)
    self:to_next_step(2)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", false)
    set_sceneobj_visible("sence_quiet_1", true)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_ui_object_visible("fight", "Btn_skill7", true)
    enter_guide(2024)
    self:to_next_step(0.1)
  end)
  g:add_step(function()
    set_sceneobj_visible("sence_noise_1", true)
    set_sceneobj_visible("sence_quiet_1", false)
    set_ui_object_visible("fight", "Btn_skill7", false)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(1)
  end)
  g:add_step(function()
    self:to_next_guide("guide7", 4)
  end)
  g:start()
end

function M:teach_guide7()
  local g = self:create_guide("guide7")
  g:add_step(function()
    play_video("timeline-2.mp4", true, 1, 1)
    set_ui_object_visible("fight", "JoystickContent", true)
    self:to_next_step(0.5)
  end)
  g:add_step(function()
    self.monster16 = add_npc_by_pos_key(1, 201046, "M10", 0, 0, "center", 0, 0, 4, 1)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (2)", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (6)", false)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_02_anim", false)
    set_sceneobj_visible("Sc0401_timeline/wall/wall_4(CHAR_BLOCK)", true)
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_npc_pos(self.npc, "M12")
    lookat_npc(self.npc, self.monster16)
    set_sceneobj_visible("sence_noise_1", false)
    set_sceneobj_visible("sence_quiet_1", true)
    set_scene_camera(20104601)
    self:to_next_step()
  end)
  g:add_step():listen("on_video_play_end", function()
    set_sync_var("story1304", true)
    set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (6)", true)
    start_stroy(201001)
    self:to_next_step()
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 100100167 == skill_id then
      set_sceneobj_visible("Sc0401_timeline/Sc04_build_01_anim (2)", true)
      self:to_next_step()
    end
  end)
  g:add_step():listen("on_skill_begin", function(npc, skill_id, skill_type)
    if 20104613 == skill_id or 20104610 == skill_id then
      self:guide_timeout(3, function()
        start_stroy(201002)
      end, "stroy1")
      self:to_next_step()
    end
  end):listen("on_npc_hp_zero", function(npc)
    if npc.id == 201046 then
      cast_magic(self.npc, self.npc, 4032011, 0)
      start_stroy(201003)
      self.quit_scene = true
      request_end_teach_level(true)
      self:end_teach_guide(5)
    end
  end)
  g:add_step():listen("on_npc_hp_zero", function(npc)
    if npc.id == 201046 then
      cast_magic(self.npc, self.npc, 4032011, 0)
      self:to_next_step(1)
    end
  end)
  g:add_step(function()
    self.quit_scene = true
    request_end_teach_level(true)
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
  if self.exercise_rec and get_npc_attr(self.npc, 3) < 90 then
    cast_magic(self.npc, self.npc, 10001002, 0)
  end
  if self.HP_rec and get_npc_attr(self.npc, 1) < 299 then
    cast_magic(self.npc, self.npc, 10001004, 0)
  end
  if self.finished_teach_guide and not self.quit_scene and check_npc_distance_to_pos(self.npc, self.pos1.x, self.pos1.z, 1, 1) then
    self.quit_scene = true
    remove_scene_effect("jiaohu")
    cast_magic(self.npc, self.npc, 100173, 1)
    cast_magic(self.npc, self.npc, 100175, 1)
    set_ui_object_visible("fight", "Main", false)
    request_end_teach_level(true)
  end
end

function M:search_target()
end

function M:on_skill_begin(npc, skill_id, skill_type)
  self:call_guide_listen_func("on_skill_begin", npc, skill_id, skill_type)
end

function M:on_skill_end(npc, skill_id)
  self:call_guide_listen_func("on_skill_end", npc, skill_id)
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

function M:on_npc_hp_zero(npc)
  self:call_guide_listen_func("on_npc_hp_zero", npc)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  self:call_guide_listen_func("on_skill_hit", npc, skill_id, hit_target, hit_type, missile_cfg, missile)
end

function M:on_npc_dead(npc)
  self:call_guide_listen_func("on_npc_dead", npc)
end

function M:on_enter_area(npc, area)
  self:call_guide_listen_func("on_enter_area", npc, area)
end

function M:on_timeline_end(timeline_name)
  self:call_guide_listen_func("on_timeline_end", timeline_name)
end

function M:on_video_play_end()
  self:call_guide_listen_func("on_video_play_end")
end

function M:on_npc_born(npc)
  if npc == self.monster3 then
    change_follow_target(1, self.monster3, {
      10,
      10,
      {
        x = 0,
        y = -0.2,
        z = -1.8
      },
      1.3,
      1,
      0.1
    })
  end
end

return M
