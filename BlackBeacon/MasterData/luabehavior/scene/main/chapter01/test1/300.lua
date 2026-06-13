local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    20106003,
    "M1",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106003,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    20106003,
    "M1",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106003,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    20106003,
    "M3",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    20106003,
    "M4",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_103 = {
  [1] = {
    1,
    20106003,
    "M1",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    20106003,
    "M2",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    20106003,
    "M3",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    20106003,
    "M4",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [5] = {
    1,
    20106003,
    "M3",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  },
  [6] = {
    1,
    20106003,
    "M4",
    0,
    0,
    "tp3",
    -1,
    -1,
    4,
    1
  }
}
lMonster.RANDOW_VAL_104 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    201009,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    201009,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    1
  }
}
local Monster_plus = {}
Monster_plus.RANDOW_VAL_101 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_102 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_103 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  }
}
Monster_plus.RANDOW_VAL_104 = {
  [1] = {
    1,
    201009,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201009,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    1
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self:set_sync_var("cancel_born_skill", true)
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.monster_list = {}
  self.random_id = 1
  self.wave = 1
end

function M:on_enter()
  self:enable_god_skill(false)
  self:set_mapview_transmit(false)
  self:cast_magic(Global.hero, Global.hero, 4010212, 0)
  self:play_timeline("Timeline 01", 0, 0)
  self:timer_call_out("Timeline 01", function()
    self:add_monster()
    self:cast_magic(Global.hero, Global.hero, 4010213, 0)
    self.add = true
  end, 23)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
  end
end

function M:add_monster()
  local list_id = 101
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    self.monster_list[#self.monster_list + 1] = monster
  end
end

function M:add_monster2()
  local list_id = 102
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster2 = self:add_npc_by_pos_key(_tunpack(args))
    self.monster_list[#self.monster_list + 1] = monster2
  end
end

function M:add_monster3()
  local list_id = 103
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster2 = self:add_npc_by_pos_key(_tunpack(args))
    self.monster_list[#self.monster_list + 1] = monster2
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
      if 0 == #self.monster_list and not self:is_pass_room() then
        if 1 == self.wave then
          self:timer_call_out("Timeline 01", function()
            self:cast_magic(Global.hero, Global.hero, 4010212, 0)
            self:play_timeline("timeline1_0_huitou", 0, 1)
            self:transmit_npc(Global.hero, "bornpoint", "tp1")
            self:add_monster2()
          end, 0.5)
          self.wave = 2
        elseif 2 == self.wave then
          self:timer_call_out("Timeline 01", function()
            self:add_monster3()
          end, 0.5)
          self.wave = 3
        elseif 3 == self.wave then
          self:fight_end(true)
          self:end_perform(self.room_type)
          self:open_all_transmit()
        end
      end
    end
  end
end

function M:on_frame()
end

function M:on_timeline_end(timeline_name)
  self:cast_magic(Global.hero, Global.hero, 4010213, 0)
  if "Timeline 01" == timeline_name and not self.add then
    self:timer_call_out_remove("Timeline 01")
    self:add_monster()
  end
  if "timeline1_0_huitou" == timeline_name then
    self:cast_magic(Global.hero, Global.hero, 4010213, 0)
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
  local data = {
    is_add_npc = self.is_add_npc
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
end

return M
