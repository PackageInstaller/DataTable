local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    20106005,
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
    20106005,
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
    20106103,
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
    20106103,
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
lMonster.RANDOW_VAL_2 = {
  [1] = {
    1,
    20106005,
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
    20106005,
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
    20101905,
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
    20101905,
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
lMonster.RANDOW_VAL_3 = {
  [1] = {
    1,
    20106103,
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
    20106103,
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
    20106005,
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
    20106005,
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
lMonster.RANDOW_VAL_4 = {
  [1] = {
    1,
    20106005,
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
    20106005,
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
    20106005,
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
    20106005,
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

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self:set_sync_var("cancel_born_skill", true)
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.monster_lv = {
    normal_level = self.normal_level,
    rare_level = self.rare_level,
    boss_level = self.boss_level
  }
  self.monster_list = {}
  self.random_id = math.random(1, 4)
  self.wave = 1
end

function M:on_enter()
  self:set_mapview_transmit(false)
  self:skip_finish_anim(true)
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:fight_end(true)
  self:set_scene_camera(110)
  if self:is_pass_room() and self.is_play_timeline then
    self:actvie_obstacle("AW1", "wall", true)
    self:open_all_transmit()
  end
  if not self.is_play_timeline then
    self:play_timeline("timeline1_2_office", 0, 3, nil, false)
    self:timer_call_out(nil, function()
      self:play_story(1012004)
    end, 0.5)
    self.is_play_timeline = true
  end
  if self.is_open_door then
    self:set_sceneobj_visible("scene_timeline_anmen", true)
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

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
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

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_timeline_end(timeline_name)
  if "timeline1_2_office" == timeline_name then
    self:complete_task(100202)
    if not self.is_add_npc then
      self:add_functional_npc(4, "NPC1", "NPC1", {npc_id = 100104})
      self:add_functional_npc(4, "NPC2", "NPC1", {npc_id = 100105})
      self:add_functional_npc(4, "NPC3", "NPC1", {npc_id = 100106})
      self.is_add_npc = true
    end
  end
end

function M:on_func_npc_interact_end(func_npc_id)
  if 100104 == func_npc_id then
    self:remove_functional_npc(100104)
    self:play_story(1012008)
  end
  if 100105 == func_npc_id then
    self:remove_functional_npc(100105)
    self:play_story(1012009)
  end
  if 100106 == func_npc_id then
    self:remove_functional_npc(100106)
    self:play_story(1012010)
  end
end

function M:on_story_end(story_id)
  if 1012004 == story_id then
    self:stop_timeline("timeline1_2_office")
    if not self.is_accept_task then
      self:accept_task_group(9023)
      self.is_accept_task = true
    end
  end
  if 1012010 == story_id then
    self.is_open_door = true
    self:open_all_transmit()
    self:play_timeline("timeline1_2_anmen", 0, 1.5, nil, false)
    self:set_sceneobj_visible("scene_timeline_anmen", true)
  end
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    is_play_timeline = self.is_play_timeline,
    is_open_door = self.is_open_door,
    is_accept_task = self.is_accept_task
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.is_play_timeline = data.is_play_timeline
  self.is_open_door = data.is_open_door
  self.is_accept_task = data.is_accept_task
end

return M
