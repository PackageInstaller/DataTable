local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local cast_magic_id = {
  [1] = 4033001,
  [2] = 4033002
}
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    201060,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    38,
    "mm1"
  },
  [2] = {
    1,
    201060,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    38,
    "mm2"
  },
  [3] = {
    1,
    201019,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    38,
    "mm3"
  },
  [4] = {
    1,
    201019,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    38,
    "mm4"
  }
}
lMonster.RANDOW_VAL_2 = {
  [1] = {
    1,
    201061,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    38,
    "mm5"
  },
  [2] = {
    1,
    201061,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    38,
    "mm6"
  },
  [3] = {
    1,
    201061,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    38,
    "mm7"
  },
  [4] = {
    1,
    201019,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    38,
    "mm8"
  }
}
lMonster.RANDOW_VAL_3 = {
  [1] = {
    1,
    201054,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    38,
    "mm9"
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.random_id = math.random(1, 4)
  self.wave = 1
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:add_monster()
  end
end

function M:add_monster()
  local list_id = 1
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
  end
  for index = 1, 2 do
    self:cast_magic(self.mm1, self.mm1, cast_magic_id[index], 1)
    self:cast_magic(self.mm2, self.mm2, cast_magic_id[index], 1)
    self:cast_magic(self.mm3, self.mm3, cast_magic_id[index], 1)
    self:cast_magic(self.mm4, self.mm4, cast_magic_id[index], 1)
  end
end

function M:add_monster2()
  local list_id = 2
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
  end
  for index = 1, 2 do
    self:cast_magic(self.mm7, self.mm7, cast_magic_id[index], 1)
    self:cast_magic(self.mm5, self.mm5, cast_magic_id[index], 1)
    self:cast_magic(self.mm6, self.mm6, cast_magic_id[index], 1)
    self:cast_magic(self.mm8, self.mm8, cast_magic_id[index], 1)
  end
end

function M:add_monster3()
  local list_id = 3
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local args = {
      _tunpack(data, 1, 10)
    }
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
  end
  for index = 1, 2 do
    self:cast_magic(self.mm9, self.mm9, cast_magic_id[index], 1)
  end
end

function M:on_npc_dead(npc)
  local remain_mon2 = self:get_npc_count_by_kind(2)
  local remain_mon3 = self:get_npc_count_by_kind(3)
  if 0 == remain_mon2 and 0 == remain_mon3 and not self:is_pass_room() and 1 == self.wave then
    self.wave = 2
    self:add_monster2()
  elseif 0 == remain_mon2 and 0 == remain_mon3 and not self:is_pass_room() and 2 == self.wave then
    self.wave = 3
    self:add_monster3()
  elseif 0 == remain_mon2 and 0 == remain_mon3 and not self:is_pass_room() and 3 == self.wave then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self:open_all_transmit()
  end
end

function M:on_frame()
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
