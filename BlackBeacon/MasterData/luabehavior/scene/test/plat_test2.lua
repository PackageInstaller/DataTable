local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local check_magic_id = {
  [1] = 399983,
  [2] = 399984,
  [3] = 399985,
  [4] = 399986,
  [5] = 399987,
  [6] = 399988,
  [7] = 399987,
  [8] = 399988,
  [9] = 4031027,
  [10] = 4031028,
  [11] = 3001017003,
  [12] = 4031024
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
  self:set_sync_var("cancel_born_skill", true)
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 40
  self.challenge_max_counter = 20
  self.plat1_move = 0
  self.plat2_move = 0
  self.plat3_move = 0
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("air", "air", true)
  self:actvie_obstacle("AW_plat2", "wall2", true)
  self:set_scene_camera(9901)
  self:set_sync_var("shot_score", 0)
  self.scoreTime = os.time()
  self:cast_magic(Global.hero, Global.hero, check_magic_id[12], 1)
  self:start_texture_guide(1211001)
  self.settleTime = os.time()
  self.settleTime2 = os.time()
  self.settleTime3 = os.time()
  self:set_plat_active("Plat1", true)
  self:set_plat_active("Plat2", true)
  self:set_plat_active("Plat3", true)
  self.monster1 = self:add_npc_by_pos_key(1, 201062, "M1", 0, 0, "bornpoint", 0, 0, 4, self.normal_level)
  self.monster2 = self:add_npc_by_pos_key(1, 201062, "Plat1_center", 0, 0, "anchor1", 0, 0, 4, self.normal_level)
  self.monster3 = self:add_npc_by_pos_key(1, 201062, "Plat3_center", 0, 0, "anchor3", 0, 0, 4, self.normal_level)
  self:fight_end(true)
  self:open_all_transmit()
end

function M:plat1_wander()
  if 0 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 15 then
    self:move_plat_to_pos("Plat1", "44", 5)
    self.plat1_move = 1
    self.settleTime = os.time()
    self:set_sceneobj_visible("wall1", true)
    self:set_sceneobj_visible("wall2", false)
  elseif 1 == self.plat1_move and self.settleTime and os.time() - self.settleTime >= 15 then
    self:move_plat_to_pos("Plat1", "64", 5)
    self.plat1_move = 0
    self.settleTime = os.time()
    self:set_sceneobj_visible("wall1", false)
    self:set_sceneobj_visible("wall2", true)
  end
end

function M:plat2_wander()
  if 0 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 10 then
    self:move_plat_to_pos("Plat2", "31", 5)
    self.plat2_move = 1
    self.settleTime2 = os.time()
  elseif 1 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("Plat2", "32", 5)
    self.plat2_move = 2
    self.settleTime2 = os.time()
  elseif 2 == self.plat2_move and self.settleTime2 and os.time() - self.settleTime2 >= 5 then
    self:move_plat_to_pos("Plat2", "31", 5)
    self.plat2_move = 1
    self.settleTime2 = os.time()
  end
end

function M:plat3_wander()
  if 0 == self.plat3_move and self.settleTime3 and os.time() - self.settleTime3 >= 15 then
    self:move_plat_to_pos("Plat3", "23", 5)
    self.plat3_move = 1
    self.settleTime3 = os.time()
  elseif 1 == self.plat3_move and self.settleTime3 and os.time() - self.settleTime3 >= 5 then
    self:move_plat_to_pos("Plat3", "24", 5)
    self.plat3_move = 2
    self.settleTime3 = os.time()
  elseif 2 == self.plat3_move and self.settleTime3 and os.time() - self.settleTime3 >= 5 then
    self:move_plat_to_pos("Plat3", "23", 5)
    self.plat3_move = 1
    self.settleTime3 = os.time()
  end
end

function M:on_texture_guide_finish(group_id)
  if 1211001 == group_id then
    self.texture_guide = 1
  end
end

function M:on_frame()
  self:plat1_wander()
  self:plat2_wander()
  self:plat3_wander()
  if 1 == self.texture_guide and not self:check_magic(Global.hero, check_magic_id[13]) and self:get_sync_var("attr100num") and self:get_sync_var("attr100num") > 0 then
    self:set_scene_tips(50120 + tonumber(self:get_sync_var("attr100num")), true)
    if self:get_sync_var("attr100num") <= 3 then
      self.challenge_max_time = self.challenge_max_time + self:get_sync_var("attr100num") * 10
    elseif self:get_sync_var("attr100num") > 3 then
      self.challenge_max_time = self.challenge_max_time + 30
    end
    self.texture_guide = 2
  end
  if not self.is_success and not self.is_add_npc then
    self:remove_functional_npc(50003)
    self:remove_functional_npc(20110 + self.floor_num)
    self:remove_functional_npc(20100 + self.floor_num)
    self:add_functional_npc(4, "npc1", "bornpoint", {npc_id = 50003})
    self:add_functional_npc(2, "npc2", "bornpoint", {npc_id = 22001})
    self.is_add_npc = true
  end
  if 1 == self.challenge_condition and not self:check_magic(Global.hero, check_magic_id[9]) then
    self:cast_magic(Global.hero, Global.hero, check_magic_id[9], 1)
  elseif 0 == self.challenge_condition and self:check_magic(Global.hero, check_magic_id[9]) then
    self:cast_magic(Global.hero, Global.hero, check_magic_id[10], 1)
  end
  if 1 == self.challenge_condition then
    self:set_scene_tips(50000, true, {
      cur_cnt = self:get_sync_var("shot_score"),
      total_cnt = self.challenge_max_counter
    })
  end
end

function M:on_npc_show_start(id, type)
  if 50003 == id then
    self:remove_functional_npc(50002)
    return
  end
  if 50002 == id then
    self:fight_end(true)
    self:remove_functional_npc(40001)
    return
  end
end

function M:on_npc_show_end(id, type)
  if 50003 ~= id then
    return
  end
  self:remove_functional_npc(50002)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self:set_functional_npc_visible(50003, false)
  self.challenge_condition = 1
  self.settlementTime = os.time()
  self:cast_magic(Global.hero, Global.hero, check_magic_id[9], 1)
  self:start_guide(2022)
  self:set_scene_tips(50011, true)
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
  self:set_scene_tips(50011, false)
  if self:get_sync_var("shot_score") >= 80 and self:get_sync_var("shot_score") < 150 then
    self:add_functional_npc(2, "drop", "tp3", {
      npc_id = 20110 + self.floor_num
    })
    self:set_scene_tips(50004, true)
    self:remove_functional_npc(50003)
  elseif self:get_sync_var("shot_score") >= 150 then
    self:add_functional_npc(2, "drop", "tp3", {
      npc_id = 20100 + self.floor_num
    })
    self:set_scene_tips(50005, true)
    self:remove_functional_npc(50003)
  else
    self:timer_call_out(nil, function()
      self:fight_end(true)
    end, 4)
    self:set_scene_tips(50007, true)
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_npc_dead(npc)
  if self:is_pass_room() or self:check_npc_status(self.monster1, 5) then
  end
end

function M:on_leave_area(npc, area)
end

function M:on_save()
  return {
    chal_card_win = self.is_success
  }
end

function M:on_load(data)
  self.is_success = data.chal_card_win
end

function M:on_guide_finished(guide_id)
end

function M:on_func_npc_interact_end(func_npc_id)
  if (func_npc_id == 20110 + self.floor_num or func_npc_id == 20100 + self.floor_num) and self.is_success then
    self:set_scene_tips(50004, false)
    self:set_scene_tips(50005, false)
  end
end

return M
