local M = Util.create_class()
local Vec3 = require("base.vec3")
local Math = require("base.mathx")
local SCENE_ROOT = "Root"
local GROUP_CTRL_OBJ = "GroupCtrlObj"
local UnityFind = CS.UnityEngine.GameObject.Find
local Effect_fast1 = 1033010101
local Effect_fast2 = 1033010102
local Effect_mid1 = 1033010103
local Effect_mid2 = 1033010104
local Effect_long1 = 1033010105
local Effect_long2 = 1033010106
local Effect_mid11 = 1033010111

function M:_init(npc)
  self.switch_effect_cfg0 = {
    [1] = {
      8.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg0_1 = {
    [1] = {
      0,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg1 = {
    [1] = {
      0,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg1_1 = {
    [1] = {
      0,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg1_2 = {
    [1] = {
      1.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    },
    [2] = {
      1.5,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg2_1 = {
    [1] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg2_2 = {
    [1] = {
      0,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    },
    [3] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [4] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [5] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [6] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    },
    [7] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [8] = {
      1,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg2_3 = {
    [1] = {
      0,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg2_4 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg3_1 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg3_2 = {
    [1] = {
      0.3,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg3_3 = {
    [1] = {
      0.5,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_1 = {
    [1] = {
      0.75,
      0,
      {Effect_fast1}
    }
  }
  self.switch_effect_cfg4_1_1 = {
    [1] = {
      1.5,
      0.5,
      {Effect_mid11}
    },
    [2] = {
      1.5,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_2 = {
    [1] = {
      0,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_3 = {
    [1] = {
      0,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg4_4 = {
    [1] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    },
    [2] = {
      1,
      0,
      {Effect_fast1, Effect_fast2}
    }
  }
  self.switch_effect_cfg4_5 = {
    [1] = {
      1,
      0.5,
      {Effect_mid11}
    }
  }
  self.switch_effect_cfg4_6 = {
    [1] = {
      0,
      0,
      {Effect_fast1}
    }
  }
  self.switch_effect_cfg6_0 = {
    [1] = {
      0,
      0,
      {}
    }
  }
  self.switch_effect_cfg6_1 = {
    [1] = {
      0,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg7_1 = {
    [1] = {
      6.2,
      1.7,
      {Effect_mid1, Effect_mid2}
    }
  }
  self.switch_effect_cfg7_2 = {
    [1] = {
      1.95,
      0,
      {Effect_fast1, Effect_fast1}
    }
  }
  self.v_move_npc_group_ids = {
    10330201,
    10330302,
    10330304,
    10330204,
    10330305,
    10330401,
    10330402,
    10330403,
    10330404,
    10330102,
    10330502,
    10330503
  }
  self.v_born_magic_ids = {1033010107}
  self.v_born_magic_buff_ids = {}
  self.v_is_move_scene_down = true
  self.v_step_index = 1
  self.v_step_start_time = 0
  self.v_root_trans = UnityFind(SCENE_ROOT).transform
  self.v_enable_collision_stuck = true
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 100100156 == skill_id then
    if get_cur_room_id() == 103307 then
      set_sync_var("state2", true)
      self:start_switch_scene_effect(self.switch_effect_cfg7_1, false, nil, "103307—1")
      self.round2 = true
      set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    end
    if get_cur_room_id() == 20531 then
      set_sync_var("state2", true)
      self:start_switch_scene_effect(self.switch_effect_cfg7_1, false, nil, "20531—1")
      self.round2 = true
      set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    end
    if get_cur_room_id() == 20532 then
      set_sync_var("state2", true)
      self:start_switch_scene_effect(self.switch_effect_cfg7_1, false, nil, "20533—1")
      self.round2 = true
      set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    end
    if get_cur_room_id() == 20533 then
      set_sync_var("state2", true)
      self:start_switch_scene_effect(self.switch_effect_cfg7_1, false, nil, "20534—1")
      self.round2 = true
      set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    end
    if get_cur_room_id() == 20534 then
      set_sync_var("state2", true)
      self:start_switch_scene_effect(self.switch_effect_cfg7_1, false, nil, "20534—1")
      self.round2 = true
      set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    end
    abort_magic_by_id(self.target, 1999215, 1)
  end
  if 100100157 == skill_id then
    abort_magic_by_id(self.target, 1999215, 1)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if 100100156 == skill_id then
    start_stroy(2031703)
    set_sceneobj_visible_save_state("Fx_Fuwen2", true)
    set_sceneobj_visible_save_state("Fx_Fuwen1", false)
    change_focus_follow_speed(1000)
    set_npc_pos(self.hero, "bornpoint3")
    set_npc_pos(self.target, "M3")
    set_sceneobj_visible_save_state("/GroupCtrlObj/103307/Sc04_build_01_pre (1)", false)
    set_sceneobj_visible_save_state("/GroupCtrlObj/103307/Sc04_build_01_pre (2)", false)
    cast_magic(self.hero, self.hero, 103312, 0)
    if get_cur_room_id() == 103307 then
      set_sceneobj_visible_save_state("103307—1/103307—1", false)
    end
    if get_cur_room_id() == 20531 then
      set_sceneobj_visible_save_state("20531—1/20531—1", false)
    end
    if get_cur_room_id() == 20532 then
      set_sceneobj_visible_save_state("20533—1/20533—1", false)
    end
    if get_cur_room_id() == 20533 then
      set_sceneobj_visible_save_state("20533—1/20533—1", false)
    end
    if get_cur_room_id() == 20534 then
      set_sceneobj_visible_save_state("20534—1/20534—1", false)
    end
    cast_magic(self.npc, self.target, 1999215, 1)
  end
  if 100100157 == skill_id then
    cast_magic(self.npc, self.target, 1999215, 1)
  end
end

function M:on_input(input_id)
  if 60 == input_id and get_sync_var("H1001001_103307") and not check_magic(self.npc, 103311) then
    if get_cur_room_id() == 103307 then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "103307—1")
    end
    if get_cur_room_id() == 20531 then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20531—1")
    end
    if get_cur_room_id() == 20532 then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20533—1")
    end
    if get_cur_room_id() == 20533 then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
    end
    if get_cur_room_id() == 20534 then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
    end
    set_sceneobj_visible_save_state("/GroupCtrlObj/103307/Sc04_build_01_pre", false)
  end
end

function M:on_born_behavior()
  if get_cur_room_id() == 103306 then
    cast_magic(self.npc, self.npc, 1033010115, 0)
    self:start_switch_scene_effect(self.switch_effect_cfg6_0, false)
    cast_magic(self.npc, self.npc, 1033010109, 0)
  end
  if get_cur_room_id() == 103303 and is_pass_room() then
    self:start_switch_scene_effect(self.switch_effect_cfg2_4, true)
  end
  if get_cur_room_id() == 103301 then
    cast_magic(self.npc, self.npc, 1033010114, 0)
  end
  if get_cur_room_id() == 103307 then
    cast_magic(self.npc, self.npc, 1033010116, 0)
  end
end

function M:on_story_begin(story_id)
  if 100103152 == story_id then
    self:stop_switch_scene_effect()
  end
end

function M:on_story_finish(story_id)
  if 1031302 == story_id then
    self:start_switch_scene_effect(self.switch_effect_cfg2_3, false)
  end
  if 1031301 == story_id then
    self:start_switch_scene_effect(self.switch_effect_cfg0_1, false)
  end
end

function M:on_enter_area(npc, area)
  if npc == get_come_on_hero() then
    if area.Tag == "zhangai1" and self.v_is_move_scene_down then
      if get_cur_room_id() == 103307 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "103307—1")
      end
      if get_cur_room_id() == 20531 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20531—1")
      end
      if get_cur_room_id() == 20532 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20533—1")
      end
      if get_cur_room_id() == 20533 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
      end
      if get_cur_room_id() == 20534 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
      end
      cast_magic(self.npc, self.npc, 103311, 0)
      cast_magic(self.npc, self.npc, 103308, 0)
      cast_magic(self.npc, self.npc, 103309, 0)
    elseif area.Tag == "zhangai2" and not self.v_is_move_scene_down then
      if get_cur_room_id() == 103307 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "103307—1")
      end
      if get_cur_room_id() == 20531 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20531—1")
      end
      if get_cur_room_id() == 20532 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20533—1")
      end
      if get_cur_room_id() == 20533 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
      end
      if get_cur_room_id() == 20534 then
        self:start_switch_scene_effect(self.switch_effect_cfg4_3, false, nil, "20534—1")
      end
      cast_magic(self.npc, self.npc, 103311, 0)
      cast_magic(self.npc, self.npc, 103308, 0)
      cast_magic(self.npc, self.npc, 103309, 0)
    end
    if area.Key == "0" then
      self:start_switch_scene_effect(self.switch_effect_cfg0, false)
      remove_area("0", "")
    elseif area.Key == "1" then
      self:start_switch_scene_effect(self.switch_effect_cfg4_6, false)
      remove_area("1", "")
    elseif area.Key == "1.1" then
      self:start_switch_scene_effect(self.switch_effect_cfg1_1, false)
      remove_area("1.1", "")
    elseif area.Key == "camera2" then
    elseif area.Key == "2" then
      if not is_pass_room() then
        self:start_switch_scene_effect(self.switch_effect_cfg2_1, false)
        remove_area("2", "")
      end
    elseif area.Key == "2.1" then
      set_scene_camera(115)
      set_sceneobj_visible_save_state("LevelObj2/TIMELINE3_3_3_0", true)
      self:start_switch_scene_effect(self.switch_effect_cfg2_2, false)
    elseif area.Key == "3" then
      self.is3 = true
      self:start_switch_scene_effect(self.switch_effect_cfg3_1, true)
      remove_area("3", "")
    elseif area.Key == "camera" then
      self:disable_collision_stuck()
    elseif area.Key == "4" then
      self:start_switch_scene_effect(self.switch_effect_cfg4_1, false)
      remove_area("4", "")
    elseif area.Key == "timeline" then
      abort_magic_by_id(self.npc, 1033010109, 0)
      self:start_switch_scene_effect(self.switch_effect_cfg3_3, true)
      remove_area("timeline", "")
    elseif area.Key == "7" then
      self:start_switch_scene_effect(self.switch_effect_cfg6_1, false)
      remove_area("7", "")
    elseif area.Key == "up" then
    elseif area.Key == "8" then
      self:start_switch_scene_effect(self.switch_effect_cfg3_1, true)
      abort_magic_by_id(self.npc, 1033010109, 0)
      remove_area("8", "")
    elseif area.Key == "yuanpan1" then
      self.yuanpan1 = true
    elseif area.Key == "guide" and not self.guide1_end then
      enter_guide(1033072)
      cast_magic(self.npc, self.npc, 103307, 0)
      self.guide1_end = true
    elseif area.Key == "guide2" and not self.guide2_end then
      cast_magic(self.npc, self.npc, 103307, 0)
      enter_guide(1033076)
      self.guide2_end = true
    end
  end
end

function M:on_leave_area(npc, area)
  if npc == get_come_on_hero() then
    if area.Key == "camera" then
      self:enable_collision_stuck()
    end
    if area.Key == "7" then
      self:enable_collision_stuck()
    end
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 3001039013 == magic_id then
    self:pause_switch_scene_effect()
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 3001039013 == magic_id then
    self:restart_switch_scene_effect()
  end
end

function M:on_timeline_end(timeline_name)
  if "TIMELINE3_1_1_0" == timeline_name then
    switch_bgm_block("bgm_future_aten", 1)
  end
  if "TIMELINE3_BOSS_0" == timeline_name then
    set_sceneobj_visible_save_state("Fx_Fuwen1", true)
    switch_bgm_block("bgm_future_aten", 3)
    change_root_pos_and_rota(0, 0, 860, -90, 0, 0)
    self.hero = get_come_on_hero()
    set_sceneobj_visible_save_state("LevelObj", false)
  end
  if "timeline3_3men" == timeline_name then
    abort_magic_by_id(self.npc, 1033010109)
    self:start_switch_scene_effect(self.switch_effect_cfg4_4, true)
  end
  if "timeline3_3daota" == timeline_name then
    cast_magic(self.npc, self.npc, 1033010109, 0)
    self:start_switch_scene_effect(self.switch_effect_cfg4_5, false)
  end
  if "timeline_Aten_State2_open" == timeline_name then
    self.guide1timer = get_time() + 0.8
    self.hero = get_come_on_hero()
  end
end

function M:on_timeline_begin(timeline_name)
  if "TIMELINE3_BOSS_0" == timeline_name then
    change_root_pos_and_rota(0, 0, 0, 0, 0, 0)
    switch_bgm_block("bgm_future_aten", 2)
  end
end

function M:on_play_finish(cfg)
  if cfg == self.switch_effect_cfg2_2 then
    set_scene_camera(111)
    start_stroy(1031302)
    cast_magic(self.npc, self.npc, 1033010109, 0)
  end
  if cfg == self.switch_effect_cfg4_1 then
    self:start_switch_scene_effect(self.switch_effect_cfg4_1_1, true)
  end
  if cfg == self.switch_effect_cfg7_1 and not self.v_is_move_scene_down then
    if get_cur_room_id() == 103307 then
      self:start_switch_scene_effect(self.switch_effect_cfg7_2, false, nil, "103307—1")
    end
    if get_cur_room_id() == 20531 then
      self:start_switch_scene_effect(self.switch_effect_cfg7_2, false, nil, "20531—1")
    end
    if get_cur_room_id() == 20532 then
      self:start_switch_scene_effect(self.switch_effect_cfg7_2, false, nil, "20533—1")
    end
    if get_cur_room_id() == 20533 then
      self:start_switch_scene_effect(self.switch_effect_cfg7_2, false, nil, "20534—1")
    end
    if get_cur_room_id() == 20534 then
      self:start_switch_scene_effect(self.switch_effect_cfg7_2, false, nil, "20534—1")
    end
  end
end

function M:on_move_scene(is_down)
  if is_down then
    self:apply_second_scene_illumination()
  else
    self:apply_defualt_scene_illumination()
  end
end

function M:on_room_pass(roomid)
  if 103304 == roomid then
    self:clear_timer()
    cast_magic(self.npc, self.npc, 1033010109, 0)
    if self.v_is_move_scene_down == false then
      self:start_switch_scene_effect(self.switch_effect_cfg3_2, false)
      self:start_switch_scene_effect(self.switch_effect_cfg3_2, false)
    end
  end
end

function M:on_frame()
  if get_sync_var("break5") and not self.v_is_move_scene_down then
    set_sync_var("break5", false)
    self:clear_timer()
    self:start_switch_scene_effect(self.switch_effect_cfg4_3, false)
    self:start_switch_scene_effect(self.switch_effect_cfg4_3, false)
  end
  if get_sync_var("103303_pass") then
    set_sync_var("103303_pass", false)
    self:start_switch_scene_effect(self.switch_effect_cfg2_4, true)
  end
  if get_sync_var("1dead") then
    set_sync_var("1dead", false)
    self:clear_timer()
    self:start_switch_scene_effect(self.switch_effect_cfg0_1, false)
    self:start_switch_scene_effect(self.switch_effect_cfg0_1, false)
  end
  if get_sync_var("timeline") then
    set_sync_var("timeline", false)
    self:clear_timer()
    if not self.v_is_move_scene_down then
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false)
      self:start_switch_scene_effect(self.switch_effect_cfg4_3, false)
    end
    cast_magic(self.npc, self.npc, 1033010109, 0)
  end
  if self.guide1timer and get_time() > self.guide1timer then
    enter_guide(1033071)
    self.guide1timer = nil
  end
  if get_sync_var("BOOK_off") and not self.v_is_move_scene_down then
    set_sync_var("BOOK_off", false)
    self:clear_timer()
    self:stop_switch_scene_effect()
    self:start_switch_scene_effect(self.switch_effect_cfg4_6, false)
  end
  if get_sync_var("BOOK_on") then
    set_sync_var("BOOK_off", false)
    set_sync_var("BOOK_on", false)
    self:start_switch_scene_effect(self.switch_effect_cfg3_1, true)
  end
  if get_sync_var("camera2") then
    set_sync_var("camera2", false)
    self:start_switch_scene_effect(self.switch_effect_cfg1_2, true)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 201026020202 and not self.guide1finish then
    set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
    set_sceneobj_visible_save_state("scene_timeline_camerastop", true)
    set_keyframe_enable(self.hero, 201026020202, false, true)
    set_keyframe_enable(self.npc, 201026020202, false, true)
    self.guide1finish = 1
    if get_cur_room_id() == 103307 then
      enter_guide(1033073)
    end
  end
  if missile_cfg.Id == 201026025101 then
    set_sceneobj_visible_save_state("/GroupCtrlObj/103307/Sc04_build_01_pre", true)
    if not self.v_is_move_scene_down then
      if get_cur_room_id() == 103307 then
        self:start_switch_scene_effect(self.switch_effect_cfg6_0, false, nil, "103307—1")
      end
      if get_cur_room_id() == 20531 then
        self:start_switch_scene_effect(self.switch_effect_cfg6_0, false, nil, "20531—1")
      end
      if get_cur_room_id() == 20532 then
        self:start_switch_scene_effect(self.switch_effect_cfg6_0, false, nil, "20533—1")
      end
      if get_cur_room_id() == 20533 then
        self:start_switch_scene_effect(self.switch_effect_cfg6_0, false, nil, "20534—1")
      end
      if get_cur_room_id() == 20534 then
        self:start_switch_scene_effect(self.switch_effect_cfg6_0, false, nil, "20534—1")
      end
    end
    self.yuanpan1 = nil
  end
end

function M:on_finish_guide(guide_id)
  if 1033071 == guide_id then
    set_sceneobj_visible_save_state("scene_timeline_camerashake", true)
  end
  if 1033072 == guide_id then
    abort_magic_by_id(self.npc, 103307)
  end
  if 1033073 == guide_id then
    set_sceneobj_visible_save_state("scene_timeline_camerashake", true)
  end
  if 1033074 == guide_id then
    abort_magic_by_id(self.npc, 103307)
  end
  if 1033075 == guide_id then
    abort_magic_by_id(self.npc, 103307)
  end
  if 1033076 == guide_id then
    abort_magic_by_id(self.npc, 103307)
  end
  if 1033077 == guide_id then
    abort_magic_by_id(self.npc, 103307)
  end
end

function M:pause_switch_scene_effect()
  self:clear_timer()
  self.v_pause_used_time = get_npc_time(self.npc) - self.v_step_start_time
end

function M:restart_switch_scene_effect()
  self:clear_timer()
  if self.v_step_cfg == nil then
    return
  end
  self:start_switch_scene_effect(self.v_cur_cfg, self.v_is_loop, self.v_pause_used_time)
end

function M:stop_switch_scene_effect()
  self:clear_timer()
  self.v_step_index = 1
  self.v_step_cfg = nil
end

function M:start_switch_scene_effect(tb, is_loop, used_time, go_path)
  self.v_cur_cfg = tb
  self.v_is_loop = is_loop
  self:clear_timer()
  if tb then
    self.v_step_cfg = tb[self.v_step_index]
    if self.v_step_cfg then
      self.v_step_start_time = get_npc_time(self.npc)
      self.v_timer = Timer:add_timer(self.npc.uuid .. "step_timer", self.v_step_cfg[1] - (used_time or 0), function()
        for index = 1, #self.v_step_cfg[3] do
          cast_magic(self.npc, get_come_on_hero(), self.v_step_cfg[3][index], 0)
        end
        self.v_magic_timer = Timer:add_timer(self.npc.uuid .. "cast_magic_timer", self.v_step_cfg[2], function()
          play_common_sound("Sound_screen_witch")
          self.v_is_move_scene_down = not self.v_is_move_scene_down
          self.v_step_index = self.v_step_index + 1
          if self.v_step_index > #tb and is_loop then
            self.v_step_index = 1
          end
          if go_path then
            self:move_go(go_path)
          else
            self:move_scene_root()
          end
          self:move_npc()
          self:move_functional_npc()
          if self.v_enable_collision_stuck then
            self:check_hero_stuck()
          end
          self:start_switch_scene_effect(tb, is_loop, nil, go_path)
        end)
      end, nil, nil, nil, true)
    else
      self.v_step_index = 1
      self.v_step_cfg = nil
      self:on_play_finish(tb)
    end
  end
end

local group_ctrl_obj

function M:find_go_in_group_ctrl_obj(go_path)
  if not group_ctrl_obj or group_ctrl_obj:IsNull() then
    group_ctrl_obj = UnityFind(GROUP_CTRL_OBJ)
    if not group_ctrl_obj or group_ctrl_obj:IsNull() then
      return
    end
  end
  return group_ctrl_obj.transform:Find(go_path)
end

local find_go_trans_cache = {}

function M:move_go(go_path)
  local go_trans = find_go_trans_cache[go_path]
  if not go_trans or go_trans:IsNull() then
    local go = self:find_go_in_group_ctrl_obj(go_path)
    if not go then
      return
    end
    go_trans = go.transform
    find_go_trans_cache[go_path] = go_trans
  end
  local pos = go_trans.position
  go_trans:SetPositionA(pos.x, pos.y + (self.v_is_move_scene_down and -1000 or 1000), pos.z)
  self:on_move_scene(not self.v_is_move_scene_down)
end

function M:move_scene_root()
  if self.v_root_trans == nil then
    return
  end
  local pos = self.v_root_trans.position
  self.v_root_trans.position = Vec3.New(pos.x, pos.y + (self.v_is_move_scene_down and -1000 or 1000), pos.z)
  self:on_move_scene(not self.v_is_move_scene_down)
end

function M:move_npc()
  local all_npc = SceneMgr:get_all_npc()
  if not all_npc then
    return
  end
  for _, npc in pairs(all_npc) do
    local need_move = false
    for index = 1, #self.v_move_npc_group_ids do
      if self.v_move_npc_group_ids[index] == npc:get_group_id() then
        need_move = true
      end
    end
    if npc.id == 10330101 then
      need_move = true
    end
    if need_move then
      local dy = self.v_is_move_scene_down and -1000 or 1000
      npc.v_last_land_height = npc.v_last_land_height and npc.v_last_land_height + dy
      npc.v_land_height = npc.v_land_height and npc.v_land_height + dy
      npc:set_pos_by_delta(0, dy, 0)
      npc:enable_ragdoll_animator(self.v_is_move_scene_down)
    end
  end
end

function M:move_functional_npc()
  local all_func_npc = SceneMgr:get_all_functional_npc()
  for _, npc in pairs(all_func_npc) do
    npc:set_pos_by_delta(0, self.v_is_move_scene_down and -1000 or 1000, 0)
  end
end

function M:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_magic_timer then
    Timer:remove_timer(self.v_magic_timer)
    self.v_magic_timer = nil
  end
end

function M:on_remove()
  self:clear_timer()
end

local AstarHelper = CS.Game.AstarHelper

function M:check_hero_stuck()
  if not self:is_in_plat() then
    self:check_stuck_in_base_region()
  end
end

local dir_tb = {
  Vec3.right,
  Vec3.left,
  Vec3.forward,
  Vec3.back
}
local dist_tb = {
  1,
  2,
  4
}

function M:check_stuck_in_base_region()
  local hero = Global.hero
  local hero_pos = hero:get_pos_vec3()
  local offset_y = self.v_is_move_scene_down and 0 or -1000
  local map = SceneMgr:get_scene_map()
  local region = map:get_base_region()
  local gg = region:get_gg()
  local x, y, z = hero_pos.x, hero_pos.y + offset_y, hero_pos.z
  local body_size = hero.navigator_ctrl:get_body_size()
  local is_walkable = AstarHelper.IsGridSuitableForBodyOfGraph(body_size, x, y, z, gg)
  if is_walkable then
    return
  end
  local success, new_x, new_y, new_z
  if get_cur_room_id() == 103306 then
    success, new_x, new_y, new_z = AstarHelper.GetNeartSuitablePosForBody(body_size, 20, x, y, z, gg)
  else
    success, new_x, new_y, new_z = AstarHelper.GetNeartSuitablePosForBody(body_size, 5, x, y, z, gg)
  end
  if success then
    hero:set_pos(new_x, new_y - offset_y, new_z)
    hero:update_pos_height()
  end
end

function M:is_in_plat()
  local hero = Global.hero
  if not hero then
    return
  end
  local x, y, z = hero:get_pos()
  local new_y = y + 1000
  local cid, plat = SceneMgr:get_plat_mgr():get_region_at_pos(x, z, new_y)
  if plat then
    return true
  end
  new_y = y - 1000
  local cid, plat = SceneMgr:get_plat_mgr():get_region_at_pos(x, z, new_y)
  if plat then
    return true
  end
end

function M:enable_collision_stuck()
  self.v_enable_collision_stuck = true
end

function M:disable_collision_stuck()
  self.v_enable_collision_stuck = false
end

function M:on_npc_born(npc)
  for i = 1, #self.v_move_npc_group_ids do
    if npc:get_group_id() == self.v_move_npc_group_ids[i] then
      for j = 1, #self.v_born_magic_ids do
        cast_magic(npc, npc, self.v_born_magic_ids[j], 0)
      end
    end
  end
  if npc:get_group_id() == 10330302 then
    abort_magic_by_id(self.npc, 1033010109, 0)
    self:start_switch_scene_effect(self.switch_effect_cfg2_4, true)
  end
  if get_npc_id(npc) == 20102602 then
    self.target = npc
  end
end

function M:apply_defualt_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_defualt_scene_illumination()
end

function M:apply_second_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_second_scene_illumination()
end

return M
