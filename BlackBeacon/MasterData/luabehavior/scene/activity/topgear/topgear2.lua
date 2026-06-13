local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    20106012,
    "M10",
    0,
    0,
    "M10",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "M10",
    0,
    0,
    "M10",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M10",
    0,
    0,
    "M10",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    20101902,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "center",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M11",
    0,
    0,
    "M11",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  }
}
lMonster.RANDOW_VAL_103 = {
  [1] = {
    1,
    20106111,
    "M11",
    0,
    0,
    "M11",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20101902,
    "M7",
    0,
    0,
    "M7",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20101902,
    "M8",
    0,
    0,
    "M8",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_104 = {
  [1] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  }
}
lMonster.RANDOW_VAL_105 = {
  [1] = {
    1,
    20105409,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20101902,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20101902,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_106 = {
  [1] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  },
  [5] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm5"
  }
}
lMonster.RANDOW_VAL_107 = {
  [1] = {
    1,
    20105607,
    "center",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_108 = {
  [1] = {
    1,
    20102102,
    "M8",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20102102,
    "M9",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_109 = {
  [1] = {
    1,
    20102102,
    "M1",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20102102,
    "M2",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_110 = {
  [1] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  },
  [5] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm5"
  }
}
lMonster.RANDOW_VAL_111 = {
  [1] = {
    1,
    20105308,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  }
}
lMonster.RANDOW_VAL_112 = {
  [1] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20106012,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  },
  [3] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    20106012,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  },
  [5] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm5"
  }
}
lMonster.RANDOW_VAL_113 = {
  [1] = {
    1,
    20105607,
    "center",
    0,
    0,
    "center",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    3001013,
    "M12",
    0,
    0,
    "M12",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_114 = {
  [1] = {
    1,
    20102102,
    "M8",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20102102,
    "M9",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_115 = {
  [1] = {
    1,
    20102102,
    "M1",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm1"
  },
  [2] = {
    1,
    20102102,
    "M2",
    0,
    0,
    "center",
    0,
    0,
    4,
    "monster1",
    "mm2"
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.random_id = 1
  self:get_best_conf_monster_level(self.random_id)
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.wz_SceneCounter = SceneCounter.NewObj(self)
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.monster_list = {}
  self.random_id = 1
  self.challenge_max_time = 120
  self.challenge_max_counter = 15
  self.is_finished = false
end

function M:on_enter()
  self:add_trap()
  self.random_id = 1
  self.wz_SceneCounter:AddNormalCounter(801011, self.challenge_max_counter, 1)
  self.wz_SceneCounter:AddTimeCounter(801012, self.challenge_max_time, 2)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:set_scene_tips(801016, true)
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
end

function M:add_monster()
  if self.random_id <= 15 then
    self.list_id = 100 + self.random_id
  elseif self.random_id > 15 then
    if not self.repeatnum or self.repeatnum and 5 == self.repeatnum then
      self.repeatnum = 1
    else
      self.repeatnum = self.repeatnum + 1
    end
    self.list_id = 110 + self.repeatnum
  end
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. self.list_id]) do
    local key = data[10]
    local lv = self:get_best_conf_monster_level(self.random_id)
    local args = {
      _tunpack(data, 1, 9)
    }
    args[10] = lv
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
    local mod = math.fmod(self.random_id, 3)
    local tips_id = {
      [0] = 4030114,
      [1] = 4030105,
      [2] = 4030111
    }
    self:cast_magic(self[monsterName], self[monsterName], tips_id[mod], 0)
  end
  if self.random_id > 0 then
    local normalCounter = self.wz_SceneCounter:GetNormalCounter(801011)
    normalCounter:AddCnt()
  end
end

function M:clear_monster()
  self.random_id = -1
  for _, monster in ipairs(self.monster_list) do
    self:remove_npc(monster)
  end
end

function M:add_trap()
  self.flag_npc = self:add_npc_by_pos_key(1, 3201002, "center", 0, 0, "center", 0, 0, 4, 0)
end

function M:on_npc_dead(npc)
  if npc == self.flag_npc then
    self:add_monster()
    self.wz_SceneCounter:GetTimeCounter(801012):Start()
    self:set_scene_tips(801013, true)
  else
    local count = #self.monster_list
    for i = count, 1, -1 do
      local monster = self.monster_list[i]
      if monster == npc then
        table.remove(self.monster_list, i)
        if 0 == #self.monster_list and not self.is_finished then
          self:pass_round()
          self.random_id = self.random_id + 1
          if 5 == self.random_id then
            self:cast_magic(Global.hero, Global.hero, 320102, 0)
          end
          self:add_monster()
          local mod = math.fmod(self.random_id, 3)
          local tips_id = {
            [0] = 801015,
            [1] = 801013,
            [2] = 801014
          }
          self:set_scene_tips(tips_id[mod], true)
        end
      end
    end
  end
end

function M:on_time_counter_end(counter_id)
  if 801012 ~= counter_id then
    return
  end
  self.is_finished = true
  self:clear_monster()
  self:set_scene_tips(40012, true)
  self:open_all_transmit()
  self:fight_end(true)
end

function M:on_frame()
  if self:check_magic(Global.hero, 320104) then
    self:abort_magic_by_id(Global.hero, 320104)
    self:set_scene_tips(801016, false)
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
end

function M:on_load(data)
end

return M
