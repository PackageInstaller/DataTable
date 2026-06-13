local SceneCounter = import("common.scene_counter", "common")
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
  self:set_sync_var("cancel_born_skill", true)
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.wz_SceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 40
  self.challenge_max_counter = 20
  self.challenge_is_false = false
end

function M:on_enter()
  if not self.is_add_npc then
    self:add_functional_npc(4, "center", "center", {npc_id = 50003})
    self.is_add_npc = true
  end
  self:open_all_transmit()
  self:fight_end(true)
  self:end_perform(self.room_type)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(9901)
  self:set_sync_var("shot_score", 0)
  self.before_score = self:get_sync_var("shot_score")
  self.now_score = nil
  self.scoreTime = os.time()
end

function M:on_npc_show_end(id, type)
  if 50003 ~= id then
    return
  end
  self:remove_all_transmit()
  self:set_in_challenge(true)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.wz_SceneCounter:AddNormalCounter(50000, self.challenge_max_counter, 1)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self:set_functional_npc_visible(50003, false)
  self.challenge_condition = 1
  self:add_monster()
  self.settlementTime = os.time()
  self:cast_magic(Global.hero, Global.hero, 4010178, 1)
  self:start_guide(2101)
  self:set_scene_tips(50008, true)
end

function M:add_monster()
  self.random_id = math.random(1, 4)
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
  end
  if 2 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[2], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[3], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[4], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[1], 1)
  end
  if 3 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[6], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[8], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[5], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[7], 1)
  end
  if 4 == self.random_id then
    self:cast_magic(self.mm1, self.mm1, check_magic_id[8], 1)
    self:cast_magic(self.mm2, self.mm2, check_magic_id[5], 1)
    self:cast_magic(self.mm3, self.mm3, check_magic_id[7], 1)
    self:cast_magic(self.mm4, self.mm4, check_magic_id[6], 1)
  end
end

function M:on_frame()
  if 1 == self.challenge_condition and not self:check_magic(Global.hero, 4010178) then
    self:cast_magic(Global.hero, Global.hero, 4010178, 1)
  elseif 0 == self.challenge_condition and self:check_magic(Global.hero, 4010178) then
    self:cast_magic(Global.hero, Global.hero, 399982, 1)
  end
  if 1 == self.challenge_condition and (self.settlementTime and os.time() - self.settlementTime >= 14 or self:check_magic(self.mm1, 399980) and self:check_magic(self.mm2, 399980) and self:check_magic(self.mm3, 399980) and self:check_magic(self.mm4, 399980)) then
    local count = #self.monster_list
    for i = count, 1, -1 do
      if self.monster_list[i] and self:check_activate(self.monster_list[i]) then
        local monster_pos = self:get_npc_pos(self.monster_list[i])
        self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
        self:remove_npc(self.monster_list[i])
      end
    end
    self:add_monster()
    self.settlementTime = os.time()
  end
  if 1 == self.challenge_condition and self.scoreTime and os.time() - self.scoreTime >= 0.5 then
    self.now_score = self:get_sync_var("shot_score")
    if self.now_score > self.before_score then
      local Dvalue = self.now_score - self.before_score
      for i = Dvalue, 1, -1 do
        local normalCounter = self.wz_SceneCounter:GetNormalCounter(50000)
        normalCounter:AddCnt()
      end
      self.before_score = self.now_score
    end
    self.scoreTime = os.time()
  end
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  self.challenge_condition = 0
  self.is_success = true
  self:force_finish_cur_guide()
  self:set_scene_tips(50000, false)
  self:set_in_challenge(false)
  self:open_all_transmit()
  local count = #self.monster_list
  for i = count, 1, -1 do
    if self.monster_list[i] and self:check_activate(self.monster_list[i]) then
      local monster_pos = self:get_npc_pos(self.monster_list[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster_list[i])
    end
  end
  if self:get_sync_var("shot_score") < 40 then
    self:add_functional_npc(4, "tp1", "center", {npc_id = 50002})
    self:create_world_model_on_position("npc01", "jiaohu", "tp1", 0, "center")
    self:set_scene_tips(50007, true)
  elseif self:get_sync_var("shot_score") >= 40 and self:get_sync_var("shot_score") < 80 then
    self:add_functional_npc(2, "NPC", "tp3", {npc_id = 20005})
    self:set_scene_tips(50004, true)
    self:remove_functional_npc(50003)
  elseif self:get_sync_var("shot_score") >= 80 and self:get_sync_var("shot_score") < 120 then
    self:add_functional_npc(2, "NPC", "tp3", {npc_id = 20006})
    self:set_scene_tips(50005, true)
    self:remove_functional_npc(50003)
  elseif self:get_sync_var("shot_score") >= 120 then
    self:add_functional_npc(2, "NPC", "tp3", {npc_id = 20007})
    self:set_scene_tips(50006, true)
    self:remove_functional_npc(50003)
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  if area.Key == "tp1" or area.Key == "tp2" or area.Key == "tp3" or area.Key == "tp4" then
    self:cast_magic(Global.hero, Global.hero, 399982, 1)
    self:set_scene_tips(101024, false)
  end
  self:judge_all_tp(area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    is_add_npc = self.is_add_npc,
    challenge_condition = self.challenge_condition
  }
  return data
end

function M:on_load(data)
  self.is_add_npc = data.is_add_npc
  self.challenge_condition = data.challenge_condition
end

function M:on_guide_finished(guide_id)
  if 2101 == guide_id then
  end
end

return M
