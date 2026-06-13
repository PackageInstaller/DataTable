local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
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
    1
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
    1
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    201060,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    1
  },
  [2] = {
    1,
    201060,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    1
  },
  [3] = {
    1,
    201061,
    "M5",
    0,
    0,
    "M5",
    -1,
    -1,
    4,
    1
  },
  [4] = {
    1,
    201061,
    "M6",
    0,
    0,
    "M6",
    -1,
    -1,
    4,
    1
  }
}

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
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
  self.monster_list2 = {}
  self.random_id = math.random(1, 4)
  self.wave = 1
  self.add_monster_tag = 1
  self.first_enter = 0
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if 0 == self.first_enter then
    self:play_timeline("test3", 0, 0)
  end
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(104)
    self:open_all_transmit()
    self:set_scene_camera(103)
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(104)
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
    self.monster_list2[#self.monster_list2 + 1] = monster2
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster_list2
  for i = count, 1, -1 do
    local monster = self.monster_list2[i]
    if monster == npc then
      table.remove(self.monster_list2, i)
      if 0 == #self.monster_list2 and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:open_all_transmit()
        self:set_scene_camera(103)
      end
    end
  end
end

function M:on_frame()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
  if area.Key == "M1" and 1 == self.add_monster_tag then
    self:add_monster()
    self.add_monster_tag = 2
  else
  end
  if area.Key == "M2" and 2 == self.add_monster_tag then
    self:add_monster2()
    self.add_monster_tag = 3
  end
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    first_enter = 1,
    add_monster_tag = self.add_monster_tag
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.first_enter = data.first_enter
  self.add_monster_tag = data.add_monster_tag
end

return M
