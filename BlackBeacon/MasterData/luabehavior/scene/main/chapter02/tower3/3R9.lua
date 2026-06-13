local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20104402,
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
    20104402,
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
    20104402,
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
    20104402,
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
Monster_plus.RANDOW_VAL_1 = {
  [1] = {
    1,
    20104402,
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
    20104402,
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
  self:set_route_status(4, 1, true)
  self:set_route_status(4, 7, false)
  self.car = self:add_npc_by_pos_key(2, 300103801, "C1", 0, 0, "C2", 0, 0, 4, 1)
  self:cast_magic(self.car, self.car, 3001038008, 0)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:open_all_transmit()
    self:cast_magic(Global.hero, Global.hero, 4032098, 99)
  else
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(102)
    self:add_monster()
  end
end

function M:add_monster()
  local list_id = self.random_id
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
  local list_id = self.random_id
  for _, data in ipairs(Monster_plus["RANDOW_VAL_" .. list_id]) do
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
      if 2 == #self.monster_list and not self:is_pass_room() and 1 == self.wave then
        self.wave = 2
        self:add_monster2()
        self.wave = 1
      end
      if 0 == #self.monster_list and not self:is_pass_room() then
        self:fight_end(true)
        self:end_perform(self.room_type)
        self:open_all_transmit()
      end
    end
  end
end

function M:on_frame()
end

function M:on_story_end()
end

function M:on_enter_area(npc, area)
  if area.Key == "C2" and npc == self.car then
    self:fight_end(true)
    Log.Info(Global.hero, "22222222222")
    self:open_all_transmit()
    self.wave = 0
    self:set_scene_tips(1021041, true, 3)
    self:cast_magic(self.car, self.car, 3001038005, 0)
    self:timer_call_out(nil, function()
      self:remove_npc(self.car)
    end, 0.7)
  end
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    is_accept_task = self.is_accept_task
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.is_accept_task = data.is_accept_task
end

return M
