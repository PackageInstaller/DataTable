local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local SceneCounter = import("common.scene_counter", "common")

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.room_type = self:get_room_type()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.challenge_level = self:get_tower_monster_level("MonLevel4")
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.control = 0
  self.hit_count = 0
  self.hit_max = 4
  self.fz_SceneCounter = SceneCounter.NewObj(self)
end

function M:on_enter()
  if not self.is_add_npc then
    self:add_functional_npc(5, "start", "start", {npc_id = 40022})
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(9901)
  self:fight_end(true)
  self:open_all_transmit()
end

function M:on_nofight_game_start(func_npc_id)
  if 40022 ~= func_npc_id then
    return
  end
  if self.control > 0 then
    return
  end
  local power = self:get_formation_attr_sum(99, true)
  if power > 2 then
    self:cast_magic(Global.hero, Global.hero, 4010180)
  end
  local IQ = self:get_formation_attr_sum(100, true)
  if IQ > 2 then
    self:cast_magic(Global.hero, Global.hero, 4010179)
  end
  self.control = 1
  self.star_count = nil
  self.fz_SceneCounter:AddNormalCounter(91006, self.hit_max, 1)
  self:set_scene_camera(9902)
  self:create_world_model_on_position("Fx_linshi", "jiaohu", "win", 0)
  self:remove_all_transmit()
  self:remove_functional_npc(40022)
  self:set_in_challenge(true)
  self.monster = {}
  self.monster[1] = self:add_npc_by_pos_key(1, 201033, "T1", 0, 0, "T1", 0, 0, 4, self.normal_level)
  self.monster[2] = self:add_npc_by_pos_key(1, 201033, "T2", 0, 0, "T2", 0, 0, 4, self.normal_level)
  self.monster[3] = self:add_npc_by_pos_key(1, 201029, "T3", 0, 0, "T3", 0, 0, 4, self.normal_level)
  self.monster[4] = self:add_npc_by_pos_key(1, 201012, "T4", 0, 0, "T4", 0, 0, 4, self.normal_level)
  self.monster[5] = self:add_npc_by_pos_key(1, 201033, "T5", 0, 0, "T5", 0, 0, 4, self.normal_level)
  self.monster[6] = self:add_npc_by_pos_key(1, 201033, "T6", 0, 0, "T6", 0, 0, 4, self.normal_level)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if not hit_target == Global.hero then
    return
  elseif not self.star_count then
    self.hit_count = self.hit_count + 1
    local normalCounter = self.fz_SceneCounter:GetNormalCounter(91006)
    normalCounter:AddCnt()
  end
  if self.hit_count > self.hit_max and 1 == self.control then
    local count = #self.monster
    for i = count, 1, -1 do
      if self.monster[i] then
        local monster_pos = self:get_npc_pos(self.monster[i])
        self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
        self:remove_npc(self.monster[i])
      end
    end
    if not self.star_count then
      self:set_scene_tips(91006, false)
      self.star_count = true
    end
    self:set_scene_tips(40012, true)
    self:set_in_challenge(false)
    self:remove_world_model("jiaohu")
    self:open_all_transmit()
    self:add_functional_npc(5, "start", "start", {npc_id = 40022})
    self:abort_magic_by_id(Global.hero, 4010179)
    self:abort_magic_by_id(Global.hero, 4010180)
    self.control = 0
    self.hit_count = 0
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster
  for i = count, 1, -1 do
    local monster = self.monster[i]
    if monster == npc then
      table.remove(self.monster, i)
    end
  end
  for i = count, 1, -1 do
    if self.monster[i] then
      return
    end
  end
end

function M:on_frame()
end

function M:on_all_hero_die()
  if not self.star_count then
    self:set_scene_tips(91006, false)
    self.star_count = true
  end
  local count = #self.monster
  for i = count, 1, -1 do
    if self.monster[i] then
      local monster_pos = self:get_npc_pos(self.monster[i])
      self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
      self:remove_npc(self.monster[i])
    end
  end
  self:set_scene_camera(9901)
  self:set_scene_tips(40012, true)
  self:set_in_challenge(false)
  self:open_all_transmit()
  self:abort_magic_by_id(Global.hero, 4010179)
  self:abort_magic_by_id(Global.hero, 4010180)
  self:remove_world_model("jiaohu")
  self.control = 0
  if not self.is_add_npc then
    self:add_functional_npc(5, "start", "start", {npc_id = 40022})
    self:reset_functional_npc(40022)
  end
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
  if area.Key == "win" and 1 == self.control then
    if not self.star_count then
      self:set_scene_tips(91006, false)
      self.star_count = true
    end
    self:set_scene_tips(40011, true)
    self:set_in_challenge(false)
    local count = #self.monster
    for i = count, 1, -1 do
      if self.monster[i] then
        local monster_pos = self:get_npc_pos(self.monster[i])
        self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
        self:remove_npc(self.monster[i])
      end
    end
    self:remove_world_model("jiaohu")
    if not self.is_add_npc then
      self:add_functional_npc(2, "win", "win", {npc_id = 40021})
      self.is_add_npc = true
    end
    self:open_all_transmit()
    self:set_scene_camera(9901)
    self:abort_magic_by_id(Global.hero, 4010179)
    self:abort_magic_by_id(Global.hero, 4010180)
  end
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
