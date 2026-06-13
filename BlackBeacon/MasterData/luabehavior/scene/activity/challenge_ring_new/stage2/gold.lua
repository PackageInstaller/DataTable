local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local _tunpack = table.unpack
local lMonster = {}
lMonster.RANDOW_VAL_1 = {
  [1] = {
    1,
    201055,
    "M1",
    0,
    0,
    "M1",
    -1,
    -1,
    4,
    "monster1",
    "mm1"
  }
}
lMonster.RANDOW_VAL_2 = {
  [1] = {
    1,
    201055,
    "M2",
    0,
    0,
    "M2",
    -1,
    -1,
    4,
    "monster1",
    "mm2"
  }
}
lMonster.RANDOW_VAL_3 = {
  [1] = {
    1,
    201055,
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
lMonster.RANDOW_VAL_4 = {
  [1] = {
    1,
    201055,
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
lMonster.RANDOW_VAL_5 = {
  [1] = {
    1,
    201055,
    "M5",
    0,
    0,
    "M5",
    -1,
    -1,
    4,
    "monster1",
    "mm4"
  }
}
lMonster.RANDOW_VAL_6 = {
  [1] = {
    1,
    201055,
    "M6",
    0,
    0,
    "M6",
    -1,
    -1,
    4,
    "monster1",
    "mm6"
  }
}
lMonster.RANDOW_VAL_7 = {
  [1] = {
    1,
    201055,
    "M7",
    0,
    0,
    "M7",
    -1,
    -1,
    4,
    "monster1",
    "mm7"
  }
}
lMonster.RANDOW_VAL_8 = {
  [1] = {
    1,
    201055,
    "M8",
    0,
    0,
    "M8",
    -1,
    -1,
    4,
    "monster1",
    "mm8"
  }
}
lMonster.RANDOW_VAL_9 = {
  [1] = {
    1,
    201055,
    "M9",
    0,
    0,
    "M9",
    -1,
    -1,
    4,
    "monster1",
    "mm9"
  }
}
lMonster.RANDOW_VAL_10 = {
  [1] = {
    1,
    201055,
    "M10",
    0,
    0,
    "M10",
    -1,
    -1,
    4,
    "monster1",
    "mm10"
  }
}
lMonster.RANDOW_VAL_11 = {
  [1] = {
    1,
    201055,
    "M11",
    0,
    0,
    "M11",
    -1,
    -1,
    4,
    "monster1",
    "mm11"
  }
}
lMonster.RANDOW_VAL_12 = {
  [1] = {
    1,
    201055,
    "C2",
    0,
    0,
    "C2",
    -1,
    -1,
    4,
    "monster1",
    "mm12"
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
  self:set_sync_var("cancel_born_skill", true)
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.wz_SceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 30
  self.challenge_max_counter = 20
  self.score = 0
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(102)
  self.scoreTime = os.time()
end

function M:add_monster()
  local random_id = math.random(1, 12)
  for _, data in ipairs(lMonster["RANDOW_VAL_" .. random_id]) do
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
end

function M:on_frame()
  if not self.is_success and not self:is_pass_room() and not self.is_add_npc then
    self:remove_functional_npc(50006)
    self:remove_functional_npc(20110 + self.floor_num)
    self:remove_functional_npc(20100 + self.floor_num)
    self:add_functional_npc(4, "center", "center", {npc_id = 50006})
    self.is_add_npc = true
  end
  local remain_mon2 = self:get_npc_count_by_kind(2)
  if 1 == self.challenge_condition and (self.settlementTime and os.time() - self.settlementTime >= 2.5 and remain_mon2 <= 4 or 0 == remain_mon2) then
    local random_num = math.random(2, 3)
    for i = 1, random_num do
      self:add_monster()
    end
    self.settlementTime = os.time()
  end
end

function M:on_npc_show_end(id, type)
  if 50006 ~= id then
    return
  end
  self.wz_SceneCounter:AddNormalCounter(50204, self.challenge_max_counter, 1)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self.challenge_condition = 1
  for i = 1, 5 do
    self:add_monster()
  end
  self.settlementTime = os.time()
  self:set_scene_tips(50205, true)
end

function M:on_npc_dead(npc)
  if npc == Global.hero then
    return
  end
  local normalCounter = self.wz_SceneCounter:GetNormalCounter(50204)
  normalCounter:AddCnt()
  self.score = self.score + 1
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  self.challenge_condition = 0
  self.is_success = true
  self:set_scene_tips(50205, false)
  local count = #self.monster_list
  for i = count, 1, -1 do
    if self.monster_list[i] and self:check_activate(self.monster_list[i]) then
      local monster_pos = self:get_npc_pos(self.monster_list[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster_list[i])
    end
  end
  if self.score and self.score >= 5 and self.score < 10 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20110 + self.floor_num
    })
    self:set_scene_tips(50206, true)
  elseif self.score and self.score >= 10 then
    self:add_functional_npc(2, "NPC", "tp3", {
      npc_id = 20100 + self.floor_num
    })
    self:set_scene_tips(50207, true)
  else
    self:timer_call_out(nil, function()
      self:fight_end(true)
    end, 4)
    self:set_scene_tips(50007, true)
  end
end

function M:on_enter_area(npc, area)
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    chal_card_win = self.is_success,
    texture_guide = self.texture_guide
  }
end

function M:on_load(data)
  self.is_success = data.chal_card_win
  self.texture_guide = data.texture_guide
end

function M:on_guide_finished(guide_id)
end

function M:on_func_npc_interact_end(func_npc_id)
  if (func_npc_id == 20110 + self.floor_num or func_npc_id == 20100 + self.floor_num) and self.is_success then
    self:fight_end(true)
    self:set_scene_tips(50206, false)
    self:set_scene_tips(50207, false)
  end
end

return M
