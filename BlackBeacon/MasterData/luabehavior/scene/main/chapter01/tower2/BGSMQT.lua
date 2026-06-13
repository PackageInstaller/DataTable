local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("common.monster_config3", "common")
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_101 = {
  [1] = {
    1,
    20101504,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "normal_level"
  },
  [2] = {
    1,
    20101504,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "normal_level"
  },
  [3] = {
    1,
    20101404,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "normal_level"
  }
}
lMonster.RANDOW_VAL_102 = {
  [1] = {
    1,
    20101504,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "normal_level"
  },
  [2] = {
    1,
    20101504,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "normal_level"
  },
  [3] = {
    1,
    20101404,
    "M3",
    0,
    0,
    "M3",
    -1,
    -1,
    4,
    "normal_level"
  },
  [4] = {
    1,
    20101404,
    "M4",
    0,
    0,
    "M4",
    -1,
    -1,
    4,
    "normal_level"
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
    normal_level = self.normal_level,
    rare_level = self.rare_level,
    boss_level = self.boss_level
  }
  self.monster_list = {}
  self.book = 0
  self.num = 1
  self.skeep = 0
  self.wave = 1
end

function M:add_monster()
  local list_id = 101
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. list_id]) do
    local key = data[10]
    local lv = self.monster_lv[key]
    local args = {
      _tunpack(data, 1, 9)
    }
    args[10] = lv
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
      _tunpack(data, 1, 9)
    }
    args[10] = lv
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
      if 0 == #self.monster_list and not self:is_pass_room() and 1 == self.wave then
        self.wave = 2
        self:add_monster2()
      elseif 0 == #self.monster_list and 2 == self.wave and not self:is_pass_room() then
        self:timer_call_out("dialog2", function()
          self:play_story(201218)
        end, 1)
        self:end_perform(self.room_type)
      end
    end
  end
end

function M:on_enter()
  self:set_sceneobj_visible("scene_fx5", true)
  self:set_sceneobj_visible("/Root/LevelObj/Plat3_/Axis/GameObject(MISSILE_BLOCK)", false)
  self:set_sceneobj_visible("/Root/LevelObj/Plat3_/Axis/GameObject", false)
  if self.in_puzzle then
    self:reset()
  end
  if self.is_open_door then
    self:set_sceneobj_visible("scene_fx2", false)
  else
    self:set_sceneobj_visible("scene_fx2", true)
  end
  self:cast_magic(Global.hero, Global.hero, 4032098, 0)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:set_scene_camera(111)
  if self:is_pass_room() then
    self:room_pass()
  end
  if not self.is_add_npc then
    self:add_functional_npc(4, "NPC1", "NPC1", {npc_id = 101103})
    self:add_functional_npc(4, "NPC2", "NPC2", {npc_id = 101104})
    self.is_add_npc = true
    self:timer_call_out("dialog", function()
    end, 3)
  end
end

function M:room_pass()
  self:fight_end(true)
  self:open_all_transmit()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if area.Key == "dialog2" and not self.had_add_monster then
    self:add_monster()
    self:remove_area("dialog2")
    self.had_add_monster = true
  end
  if area.Key == "camera3" then
    self:set_scene_camera(113)
    self:remove_area("camera3")
  end
  if area.Key == "tips" then
    self:set_scene_tips(100168, true)
  end
  if area.Key == "talk1" then
    self:play_story(201217)
    self:remove_area("talk1")
  end
  self:judge_all_tp(area)
end

function M:on_timeline_end(timeline_name)
end

function M:remove_all_func_npc()
  self:remove_functional_npc(101211)
  self:remove_functional_npc(101212)
  self:remove_functional_npc(101213)
  self:remove_functional_npc(101214)
  self:remove_functional_npc(101215)
  self:remove_functional_npc(101216)
end

function M:add_all_func_npc()
  self:add_functional_npc(4, "1", "1", {npc_id = 101211})
  self:add_functional_npc(4, "2", "2", {npc_id = 101212})
  self:add_functional_npc(4, "3", "3", {npc_id = 101213})
  self:add_functional_npc(4, "4", "4", {npc_id = 101214})
  self:add_functional_npc(4, "5", "5", {npc_id = 101215})
  self:add_functional_npc(4, "6", "6", {npc_id = 101216})
end

function M:reset()
  self:remove_all_func_npc()
  self:timer_call_out("reset", function()
    if not self.skeep1 then
      self:add_all_func_npc()
    end
  end, 0.5)
end

function M:pass_puzzle()
  self:remove_functional_npc(101103)
  self:room_pass()
  self.in_puzzle = nil
  self:play_timeline("timeline_pingzhang", 1, 1, nil, false)
  self.is_open_door = true
  self:complete_task(101203)
  self:timer_call_out("pass", function()
    self:set_sceneobj_visible("scene_fx2", false)
    self:play_story(201221)
  end, 1)
end

function M:on_func_npc_interact_end(func_npc_id)
  if 101208 == func_npc_id or 101209 == func_npc_id or 101210 == func_npc_id then
    self.book = self.book + 1
    if 1 == self.book then
      self:add_all_func_npc()
      self:complete_task(101205)
      self:play_story(201224)
      self.in_puzzle = true
    end
  end
  if self.in_puzzle and (101211 == func_npc_id or 101212 == func_npc_id or 101213 == func_npc_id or 101214 == func_npc_id or 101215 == func_npc_id or 101216 == func_npc_id) then
    if func_npc_id == 101210 + self.num then
      self.num = self.num + 1
      if 3 == self.num then
        self:play_story(201220)
      end
      if 101216 == func_npc_id then
        self:pass_puzzle()
      end
    else
      if 6 == self.skeep then
        self:play_story(201226)
        self.skeep1 = true
        self:set_sceneobj_visible("scene_timeline1", true)
        self:timer_call_out("pass3", function()
          self:pass_puzzle()
        end, 2.5)
      end
      self.num = 1
      self:reset()
      if not self.skeep1 then
        self:play_story(201219)
      end
      self.skeep = self.skeep + 1
    end
  end
  if 101103 == func_npc_id then
    if not self.is_play_timeline then
      self:set_scene_tips(100155, true)
      self:timer_call_out("111", function()
        self:play_story(101206)
      end, 1)
    else
      self:set_scene_tips(100155, true)
    end
    self:add_functional_npc(4, "NPC1", "NPC1", {npc_id = 101103})
  end
  if 101104 == func_npc_id then
    self:set_scene_tips(100156, true)
    self:add_functional_npc(4, "NPC2", "NPC2", {npc_id = 101104})
  end
end

function M:on_story_end(story_id)
  if 101206 == story_id then
    self:room_pass()
  end
  if 101203 == story_id then
    self.is_play_timeline = true
    self:play_timeline("timeline1_2jiemi", 1, 1, nil, false)
    self:play_story(101204)
    self:add_functional_npc(4, "book3", "book3", {npc_id = 101210})
    self:set_sceneobj_visible("scene_fx5_(1)", true)
  end
  if 201217 == story_id then
  end
  if 101204 == story_id then
    self:stop_timeline("timeline1_2jiemi")
    self:complete_task(101202)
  end
end

function M:on_chapter_node_continue()
  self:hero_go_out(3, true)
  self:set_sceneobj_visible("scene_fx5_(1)", true)
end

function M:on_leave_area(npc, area)
end

function M:on_frame()
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    is_play_timeline = self.is_play_timeline,
    is_open_door = self.is_open_door,
    book = self.book,
    in_puzzle = self.in_puzzle,
    had_add_monster = self.had_add_monster
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.is_play_timeline = data.is_play_timeline
  self.is_open_door = data.is_open_door
  self.book = data.book
  self.in_puzzle = data.in_puzzle
  self.had_add_monster = data.had_add_monster
end

function M:on_leave()
  self:set_sceneobj_visible("scene_fx2", false)
  self:set_sceneobj_visible("scene_fx5", false)
end

return M
