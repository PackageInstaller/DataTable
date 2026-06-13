local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    3001017,
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
    3001018,
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
    3001019,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3001020,
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
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    3001020,
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
    3001019,
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
    3001018,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3001017,
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
    3001019,
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
    3001020,
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
    3001019,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3001020,
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
lMonster.RANDOW_VAL_104 = {
  [1] = {
    1,
    3001018,
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
    3001019,
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
    3001020,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "monster1",
    "mm3"
  },
  [4] = {
    1,
    3001021,
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
local check_magic_id = {
  [1] = 399983,
  [2] = 399984,
  [3] = 399985,
  [4] = 399986,
  [5] = 399987,
  [6] = 399988,
  [7] = 399987,
  [8] = 399988
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
  self.random_id = math.random(1, 4)
  if not self.is_add_npc then
    self:set_sync_var("cancel_born_skill", true)
  end
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(102)
  if not self.monster_condition then
    self:add_monster()
    self:cast_magic(Global.hero, Global.hero, 4010178, 1)
    self:start_guide(2101)
    self:add_functional_npc(4, "tp1", "center", {npc_id = 50002})
    self:create_world_model_on_position("npc01", "jiaohu", "tp1", 0, "center")
  end
end

function M:add_monster()
  local list_id = 100 + self.random_id
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 9)
    }
    args[10] = lv
    local monster = self:add_npc_by_pos_key(_tunpack(args))
    local monsterName = data[11]
    self[monsterName] = monster
    self.monster_list[#self.monster_list + 1] = monster
  end
  if 1 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[1], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[2], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[3], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[4], 1)
  elseif 2 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[2], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[3], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[4], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[1], 1)
  elseif 3 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[6], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[8], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[5], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[7], 1)
  elseif 4 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[8], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[5], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[7], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[6], 1)
  end
end

function M:on_frame()
  if not self.monster_condition and self:check_magic(self.mm1, 399980) and self:check_magic(self.mm2, 399980) and self:check_magic(self.mm3, 399980) and self:check_magic(self.mm4, 399980) then
    self:remove_npc(self.mm1)
    self:remove_npc(self.mm2)
    self:remove_npc(self.mm3)
    self:remove_npc(self.mm4)
    self.monster_condition = true
    if not self.is_add_npc then
      self:add_functional_npc(2, "NPC", "tp3", {npc_id = 20005})
      self:end_perform(self.room_type)
      self.is_add_npc = true
      self:remove_functional_npc(50002)
      self:remove_world_model("jiaohu")
    end
  end
  if not self.monster_condition and not self:check_magic(Global.hero, 4010178) then
    self:cast_magic(Global.hero, Global.hero, 4010178, 1)
  end
  if self.monster_condition and self:check_magic(Global.hero, 4010178) then
    self:cast_magic(Global.hero, Global.hero, 399982, 1)
  end
end

function M:on_npc_show_end(id, type)
  if 50002 == id then
    self:fight_end(true)
    return
  end
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    random_id = self.random_id,
    monster_condition = self.monster_condition
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.random_id = data.random_id
  self.monster_condition = data.monster_condition
end

function M:on_guide_finished(guide_id)
  if 2101 == guide_id then
    self:set_scene_tips(101024, true)
  end
end

function M:on_click_operation(operation_type)
  if 1 == operation_type and self.is_add_npc == true then
    self:fight_end(true)
  end
end

return M
