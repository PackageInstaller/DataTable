local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local time
local remove_key = {}

function M:_init()
  Base._init(self)
  self.skill01 = {
    {
      2010260202,
      2010260203,
      2010260204,
      2010260205
    },
    10,
    0,
    0,
    0,
    get_skill_cfg(2010260202).CastTime,
    get_skill_cfg(2010260202).AfterTime
  }
  self.skill01_combo = 1
  self.target = nil
  self.group_choice = 0
  self.control = 0
  self.move_to_pos = {}
  self.is_chance_pos = true
  self.hp = 0
  self.hit_numbs = 0
  self.stun_state = false
  self.stun_time = 0
  self.do_after_list = {}
  self.do_after_timer = {}
  self.interval_timer = 2
  self.is_cast_skill02 = false
  self.skill02_danmu = {
    2010260211,
    10,
    0,
    0,
    0,
    get_skill_cfg(2010260211).CastTime,
    get_skill_cfg(2010260211).AfterTime
  }
  self.skill02_danmu_missile_id = {
    [0] = {201026021221, 201026021222},
    [1] = {
      201026021201,
      201026021202,
      201026021203,
      201026021204,
      201026021205,
      201026021206,
      201026021207,
      201026021208
    },
    [2] = {201026021209}
  }
  self.land_missile_id = {201026021110}
  self.cast_missile_time = 0
  self.cast_missile_numbs = 0
  self.skill02_danmu_pos = {}
  self.skill02_danmu_rounds_name = {
    "danmu1",
    "danmu2",
    "danmu3",
    "danmu4",
    "danmu5",
    "danmu6",
    "danmu7"
  }
  self.skill02_danmu_rounds = 1
  self.is_cast_skill03 = false
  self.skill03_combo = 1
  self.skill03_jiguang = {
    {2010260222, 2010260223},
    10,
    0,
    0,
    0,
    get_skill_cfg(2010260222).CastTime,
    get_skill_cfg(2010260222).AfterTime
  }
  self.skill03_shanxian_pos = {
    {
      nil,
      240,
      20
    },
    {
      nil,
      -225,
      25
    },
    {
      nil,
      0,
      10
    }
  }
  self.cast_skill03_to_pos = nil
  self.hit_skill_id = {2010260231, 2010260232}
  self.retreat_skill_id = 2010260233
  self.end_skill_id = 2010260251
  self.teach_skill01 = true
end

function M:skill02_danmu_pos_logic()
  self.skill02_danmu_rounds = self.skill02_danmu_rounds + 1
end

function M:on_start()
  set_keyframe_enable(self.npc, 201026020202, false, true)
  if get_cur_room_id() == 103307 then
    set_keyframe_enable(self.npc, 201026020202, true, false)
  end
  set_npc_ignore_sync_area(self.npc, false)
  cast_magic(self.npc, self.npc, 2010260205, 1)
  set_npc_controller(self.npc, 1)
  play_timeline("timeline_Aten_State2_open", 0, 1, nil, false, true, true)
  self.born_skill_timer = get_time() + 0.2
  cast_magic(self.npc, self.npc, 103313, 0)
  self:xRay()
  SceneMgr:room_offset_shadow_api(0, 2, 2)
end

function M:wander_logic()
  if self.target and not self.state2_finish then
    switch_move_type(self.npc, 2)
    move_to_pos(self.npc, self.move_to_pos)
  else
    stop_move(self.npc)
  end
end

function M:skill02_logic()
  if 1 == self.is_cast_skill02 and time >= self.cast_missile_time then
    self.cast_missile_time = time + 0.5
    self.is_cast_skill02 = 2
    self:skill02_danmu_pos_logic()
  end
  if 2 == self.is_cast_skill02 and time >= self.cast_missile_time then
    cast_missile(self.npc, nil, self.skill02_danmu_pos[self.cast_missile_numbs].x, self.skill02_danmu_pos[self.cast_missile_numbs].z, self.skill02_danmu_missile_id[0][2], 1)
    self.cast_missile_time = time + 0.2
    self.cast_missile_numbs = self.cast_missile_numbs + 1
    if self.cast_missile_numbs > 8 then
      self.cast_missile_time = time + 3
      self.cast_missile_numbs = 1
      self.is_cast_skill02 = false
    end
  end
end

function M:skill03_logic()
  if self.is_cast_skill03 then
    set_npc_turnpos(self.npc, self.cast_skill03_to_pos)
  end
end

function M:stun_logic()
  if self.stun_state and time >= self.stun_time then
    self.stun_state = false
    exit_stun(self.npc)
  end
end

function M:on_enter_area(npc, area)
  if npc == self.target and not is_cast_skill_time(self.npc, 2010260231) and not is_cast_skill_time(self.npc, 2010260232) and not self.stun_state then
    if area.Tag == "zihui" then
      set_sync_var("aten_tips", true)
      self.control = 4
      cast_magic(self.npc, self.npc, 100010102, 0)
    end
    if area.Tag == "r1s1" then
      self.control = 1
      self.skill01_combo = 1
    end
    if area.Tag == "r1s2" then
      self.control = 1
      self.skill01_combo = 1
    end
    if area.Tag == "r1s3" then
      self.control = 3
    end
    if area.Tag == "r1s4" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1.5,
          z = z1 + 1
        },
        {
          x = x1 - 1.5,
          z = z1 + 3
        },
        {
          x = x1 - 1.5,
          z = z1 + 5
        },
        {
          x = x1 - 1.5,
          z = z1 + 7
        },
        {
          x = x1 + 1.5,
          z = z1 + 12
        },
        {
          x = x1 + 1.5,
          z = z1 + 14
        },
        {
          x = x1 + 1.5,
          z = z1 + 16
        },
        {
          x = x1 + 1.5,
          z = z1 + 18
        }
      }
      self.control = 2
      cast_magic(self.npc, self.npc, 103306, 0)
    end
    if area.Tag == "r1s5" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "r2s1" then
      set_sceneobj_visible_save_state("scene_timeline_r2s1", true)
      set_sceneobj_visible_save_state("scene_timeline_r2s3", true)
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1.5,
          z = z1 + 1
        },
        {
          x = x1 - 1.5,
          z = z1 + 3
        },
        {
          x = x1 - 1.5,
          z = z1 + 5
        },
        {
          x = x1 - 1.5,
          z = z1 + 7
        },
        {
          x = x1 + 1.5,
          z = z1 + 12
        },
        {
          x = x1 + 1.5,
          z = z1 + 14
        },
        {
          x = x1 + 1.5,
          z = z1 + 16
        },
        {
          x = x1 + 1.5,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "r2s2" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "r2s3" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1.5,
          z = z1 + 1
        },
        {
          x = x1 - 1.5,
          z = z1 + 3
        },
        {
          x = x1 - 1.5,
          z = z1 + 5
        },
        {
          x = x1 - 1.5,
          z = z1 + 7
        },
        {
          x = x1 + 1.5,
          z = z1 + 12
        },
        {
          x = x1 + 1.5,
          z = z1 + 14
        },
        {
          x = x1 + 1.5,
          z = z1 + 16
        },
        {
          x = x1 + 1.5,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "r2s4" then
      self.skill03_combo = 2
      self.control = 3
      set_sceneobj_visible_save_state("scene_timeline_r2s2", true)
    end
    if area.Tag == "r2s5" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1.5,
          z = z1 + 1
        },
        {
          x = x1 - 1.5,
          z = z1 + 3
        },
        {
          x = x1 - 1.5,
          z = z1 + 5
        },
        {
          x = x1 - 1.5,
          z = z1 + 7
        },
        {
          x = x1 + 1.5,
          z = z1 + 12
        },
        {
          x = x1 + 1.5,
          z = z1 + 14
        },
        {
          x = x1 + 1.5,
          z = z1 + 16
        },
        {
          x = x1 + 1.5,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "r2s6" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1.5,
          z = z1 + 1
        },
        {
          x = x1 - 1.5,
          z = z1 + 3
        },
        {
          x = x1 - 1.5,
          z = z1 + 5
        },
        {
          x = x1 - 1.5,
          z = z1 + 7
        },
        {
          x = x1 + 1.5,
          z = z1 + 12
        },
        {
          x = x1 + 1.5,
          z = z1 + 14
        },
        {
          x = x1 + 1.5,
          z = z1 + 16
        },
        {
          x = x1 + 1.5,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "r2s7" then
      self.control = 3
    end
    if area.Tag == "r2s8" then
      self.control = 1
      self.skill01_combo = 4
    end
    if area.Tag == "r2s9" then
      self.control = 1
      self.skill01_combo = 4
    end
    if area.Tag == "S11" then
      self.control = 1
      self.skill01_combo = 1
    end
    if area.Tag == "S14" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "S13" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "S17" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1,
          z = z1 + 1
        },
        {
          x = x1 - 1,
          z = z1 + 3
        },
        {
          x = x1 - 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 7
        },
        {
          x = x1 + 1,
          z = z1 + 12
        },
        {
          x = x1 + 1,
          z = z1 + 14
        },
        {
          x = x1 + 1,
          z = z1 + 16
        },
        {
          x = x1 + 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "S15" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "S19" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "S16" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "S20" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "ST1" then
      set_sceneobj_visible_save_state("20531_bridge/20531_bridge01", true)
    end
    if area.Tag == "ST2" then
      set_sceneobj_visible_save_state("20531_bridge/20531_bridge02", true)
    end
    if area.Tag == "S22" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "S21" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "S23" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "S24" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "S25" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "R11" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "R12" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "R13" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "R14" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "R15" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "R17" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "R16" then
      self.control = 1
      self.skill01_combo = 2
      set_sceneobj_visible_save_state("20533_bridge/20533_bridge1", true)
    end
    if area.Tag == "R18" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "R20" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "R19" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 11
        },
        {
          x = x1 - 1,
          z = z1 + 13
        },
        {
          x = x1 - 1,
          z = z1 + 15
        },
        {
          x = x1 + 1,
          z = z1 + 21
        },
        {
          x = x1 + 1,
          z = z1 + 23
        }
      }
      self.control = 2
    end
    if area.Tag == "R21" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "R22" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 10
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 + 1,
          z = z1 + 19
        },
        {
          x = x1 + 1,
          z = z1 + 21
        }
      }
      self.control = 2
    end
    if area.Tag == "R23" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 10
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "R24" then
      self.skill03_combo = 1
      self.control = 4
    end
    if area.Tag == "R25" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1,
          z = z1 + 1
        },
        {
          x = x1 - 1,
          z = z1 + 3
        },
        {
          x = x1 - 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 7
        },
        {
          x = x1 + 1,
          z = z1 + 15
        },
        {
          x = x1 + 1,
          z = z1 + 17
        },
        {
          x = x1 + 1,
          z = z1 + 19
        },
        {
          x = x1 + 1,
          z = z1 + 21
        }
      }
      self.control = 2
    end
    if area.Tag == "TIME" then
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge01", true)
    end
    if area.Tag == "K14" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 - 1,
          z = z1 + 1
        },
        {
          x = x1 - 1,
          z = z1 + 3
        },
        {
          x = x1 - 1,
          z = z1 + 5
        },
        {
          x = x1 - 1,
          z = z1 + 7
        },
        {
          x = x1 + 1,
          z = z1 + 15
        },
        {
          x = x1 + 1,
          z = z1 + 17
        },
        {
          x = x1 + 1,
          z = z1 + 19
        },
        {
          x = x1 + 1,
          z = z1 + 21
        }
      }
      self.control = 2
    end
    if area.Tag == "K11" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "K12" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "TIME1" then
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge02", true)
    end
    if area.Tag == "K13" then
      self.control = 1
      self.skill01_combo = 2
    end
    if area.Tag == "K15" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "K17" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "K18" then
      self.skill03_combo = 1
      self.control = 3
    end
    if area.Tag == "K19" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "K16" then
      self.control = 1
      self.skill01_combo = 3
    end
    if area.Tag == "K20" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge04", true)
    end
    if area.Tag == "K21" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "K22" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 11
        },
        {
          x = x1 - 1,
          z = z1 + 13
        },
        {
          x = x1 + 1,
          z = z1 + 17
        },
        {
          x = x1 + 1,
          z = z1 + 19
        }
      }
      self.control = 2
    end
    if area.Tag == "K23" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 11
        },
        {
          x = x1 - 1,
          z = z1 + 13
        },
        {
          x = x1 - 1,
          z = z1 + 15
        },
        {
          x = x1 - 1,
          z = z1 + 17
        }
      }
      self.control = 2
    end
    if area.Tag == "K24" then
      self.skill03_combo = 2
      self.control = 3
    end
    if area.Tag == "K25" then
      self.skill03_combo = 2
      self.control = 3
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge05", true)
    end
    if area.Tag == "K27" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 + 1,
          z = z1 + 5
        },
        {
          x = x1 + 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 12
        },
        {
          x = x1 - 1,
          z = z1 + 14
        },
        {
          x = x1 - 1,
          z = z1 + 16
        },
        {
          x = x1 - 1,
          z = z1 + 18
        }
      }
      self.control = 2
    end
    if area.Tag == "K28" then
      self.control = 1
      self.skill01_combo = 4
    end
    if area.Tag == "K29" then
      local x1, z1 = get_scene_map_pos_postion(self.skill02_danmu_rounds_name[self.skill02_danmu_rounds])
      self.skill02_danmu_pos = {
        {
          x = x1 + 1,
          z = z1 + 1
        },
        {
          x = x1 + 1,
          z = z1 + 3
        },
        {
          x = x1 - 1,
          z = z1 + 7
        },
        {
          x = x1 - 1,
          z = z1 + 9
        },
        {
          x = x1 - 1,
          z = z1 + 11
        },
        {
          x = x1 + 1,
          z = z1 + 15
        },
        {
          x = x1 - 1,
          z = z1 + 19
        },
        {
          x = x1 - 1,
          z = z1 + 21
        }
      }
      self.control = 2
    end
    if area.Tag == "K30" then
      self.control = 1
      self.skill01_combo = 4
    end
    if area.Tag == "K31" then
      self.control = 1
      self.skill01_combo = 4
    end
  end
end

function M:skill_main_logic()
  time = get_time()
  self:wander_logic()
  self:skill02_logic()
  self:skill03_logic()
  if 1 == self.control then
    self.control = 0
    abort_skill(self.npc)
    lookat_npc(self.npc, self.target, 1)
    cast_skill(self.npc, self.target, self.skill01[1][self.skill01_combo], nil, nil)
    self.skill01_combo = 1
  end
  if 2 == self.control then
    self.control = 0
    local random = math.random(1, 3)
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill02_danmu[1], nil, nil)
    self.group_choice = 5
  end
  if 3 == self.control and self.target then
    self.control = 0
    lookat_position(self.npc, self.move_to_pos.x, self.move_to_pos.z, 1)
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.skill03_jiguang[1][self.skill03_combo], nil, nil)
  end
  if 4 == self.control then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.end_skill_id, nil, nil)
  end
  if 5 == self.control then
    cast_skill(self.npc, nil, self.retreat_skill_id, nil, nil)
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if skill_id == self.skill02_danmu[1] then
    self.is_cast_skill02 = 1
    self.cast_missile_numbs = 1
  end
  if 100100156 == skill_id then
    exit_stun(self.npc)
    abort_skill(self.npc, 1)
    cast_skill(self.npc, self.npc, self.hit_skill_id[1], 1)
    self.control = 0
    self.state1_finish = true
    if get_cur_room_id() == 103307 then
      self.skill02_danmu_rounds = 2
    end
    if get_cur_room_id() == 20531 then
      self.skill02_danmu_rounds = 3
    end
    if get_cur_room_id() == 20532 then
      self.skill02_danmu_rounds = 3
    end
    if get_cur_room_id() == 20533 then
      self.skill02_danmu_rounds = 2
    end
    if get_cur_room_id() == 20534 then
      self.skill02_danmu_rounds = 2
    end
  end
  if 100100157 == skill_id then
    exit_stun(self.npc)
    abort_skill(self.npc, 1)
    cast_skill(self.npc, self.npc, self.hit_skill_id[2], 1)
    self.control = 0
    self.state2_finish = true
  end
  if skill_id == self.hit_skill_id[1] or skill_id == self.hit_skill_id[2] then
    set_enable_transparent(self.npc, false)
    cast_magic(self.npc, self.npc, 100104, 1)
    self.hit_numbs = 0
  end
  if skill_id == self.retreat_skill_id then
    cast_magic(self.npc, self.npc, 100104, 1)
    enable_shadow(self.npc, false)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 201026025101 then
    if not self.state1_finish then
      self.skill02_danmu_rounds = 1
    else
      if get_cur_room_id() == 103307 then
        self.skill02_danmu_rounds = 2
        set_sceneobj_visible_save_state("scene_timeline_r2_replay", true)
        set_sceneobj_visible_save_state("scene_timeline_r2s1", false)
        set_sceneobj_visible_save_state("scene_timeline_r2s2", false)
        set_sceneobj_visible_save_state("scene_timeline_r2s3", false)
        set_sceneobj_visible_save_state("scene_timeline_camerashake", false)
      end
      if get_cur_room_id() == 20531 then
        self.skill02_danmu_rounds = 3
        set_sceneobj_visible_save_state("20531_bridge/20531_bridge1_re", true)
        set_sceneobj_visible_save_state("20531_bridge/20531_bridge01", false)
        set_sceneobj_visible_save_state("20531_bridge/20531_bridge02", false)
      end
      if get_cur_room_id() == 20532 then
        self.skill02_danmu_rounds = 3
        set_sceneobj_visible_save_state("20533_bridge/20533_bridge1_re", true)
        set_sceneobj_visible_save_state("20533_bridge/20533_bridge1", false)
      end
      if get_cur_room_id() == 20533 then
        self.skill02_danmu_rounds = 2
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge1_re", true)
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge01", false)
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge02", false)
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge03", false)
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge04", false)
        set_sceneobj_visible_save_state("20534_bridge/20534_bridge05", false)
      end
    end
  end
  if hit_target ~= self.npc then
    return
  end
  if hit_target == self.npc and (missile_cfg.Id == 201026020201 or missile_cfg.Id == 201026020301 or missile_cfg.Id == 201026020302 or missile_cfg.Id == 201026020401 or missile_cfg.Id == 201026020402) then
    self.hit_numbs = self.hit_numbs + 1
    cast_magic(self.npc, self.npc, 2010260211, 1)
    cast_magic(self.npc, self.npc, 2010260207, 1)
  end
  if missile_cfg.Id == 10010015402 then
    cast_magic(self.npc, self.npc, 2010260212, 1)
    cast_magic(self.npc, self.target, 1001602, 1)
    cast_magic(self.npc, self.npc, 1001601, 1)
    enter_stun(self.npc, false, 3)
    abort_skill(self.npc)
    self.stun_state = true
    self.stun_time = time + 2
  end
end

function M:on_skill_end(npc, skill_id, skill_type)
  if 201026025101 == skill_id then
    if get_cur_room_id() == 100307 then
      set_sceneobj_visible_save_state("scene_timeline_r2_replay", false)
    end
    if get_cur_room_id() == 20531 then
      set_sceneobj_visible_save_state("20531_bridge/20531_bridge1_re", false)
    end
    if get_cur_room_id() == 20532 then
      set_sceneobj_visible_save_state("20533_bridge/20533_bridge1_re", false)
    end
    if get_cur_room_id() == 20533 then
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge1_re", false)
    end
  end
  if 2010260251 == skill_id then
    if get_cur_room_id() == 100307 then
      set_sceneobj_visible_save_state("scene_timeline_r2_replay", false)
    end
    if get_cur_room_id() == 20531 then
      set_sceneobj_visible_save_state("20531_bridge/20531_bridge1_re", false)
    end
    if get_cur_room_id() == 20532 then
      set_sceneobj_visible_save_state("20533_bridge/20533_bridge1_re", false)
    end
    if get_cur_room_id() == 20533 then
      set_sceneobj_visible_save_state("20534_bridge/20534_bridge1_re", false)
    end
  end
  if npc == self.npc then
    self.control = 0
  end
  if skill_id == self.skill01[1][1] and self.teach_skill01 then
    self.teach_skill01 = false
  end
  if skill_id == self.skill02_danmu[1] then
    self.is_cast_skill02 = false
    self.cast_missile_time = 0
  end
  if skill_id == self.hit_skill_id then
    set_enable_transparent(self.npc, true)
  end
  if skill_id == self.hit_skill_id[1] then
    cast_skill(self.npc, nil, self.retreat_skill_id)
  end
  if skill_id == self.retreat_skill_id or skill_id == self.hit_skill_id[1] or skill_id == self.hit_skill_id[2] then
    abort_magic_by_id(self.npc, 100104)
    enable_shadow(self.npc, true)
  end
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == self.skill02_danmu_missile_id[0][2] then
    self:do_after(self, function()
      cast_missile(self.npc, nil, pos_x, pos_z, self.skill02_danmu_missile_id[2][1], 1)
    end, 0.85)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_self_missile_collide(otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  if other_missile_cfg.Id == self.land_missile_id[1] and self_missile_cfg.Id == 201026021209 then
    remove_missile(self_missile, true)
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 15, 100, nil, 1)
end

function M:do_after(self, func, time)
  self.do_after_list[func] = true
  self.do_after_timer[func] = get_npc_time(self.npc) + time
end

function M:do_after_frame(self)
  UtilTable.clear_map(remove_key)
  local now_time = get_npc_time(self.npc)
  for task, _ in pairs(self.do_after_list) do
    if now_time > self.do_after_timer[task] then
      task()
      remove_key[task] = true
    end
  end
  for key, _ in pairs(remove_key) do
    self.do_after_list[key] = nil
  end
end

function M:on_frame()
  CommonMonster.monster_on_frame(self)
  self:do_after_frame(self)
  if self.skill_main_logic_active then
    self:skill_main_logic()
  end
  self:search_target()
  self:stun_logic()
  if self.born_skill_timer and get_time() >= self.born_skill_timer then
    cast_skill(self.npc, nil, self.retreat_skill_id)
    self.born_skill_timer = nil
    self.skill_main_logic_active = true
  end
  if self.target and self.is_chance_pos then
    self.is_chance_pos = false
    local posx, posz = get_scene_map_pos_postion("bornpoint3")
    self.move_to_pos = {x = posx, z = posz}
    lookat_npc(self.npc, self.target)
  end
end

function M:on_npc_hp_zero(npc)
end

return M
