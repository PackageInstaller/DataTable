local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.challenge_level = self:get_tower_monster_level("MonLevel4")
  self.room_type = self:get_room_type()
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.challenge_max_time = 30
  self.is_add_npc = nil
  self.challenge_is_false = false
end

function M:on_enter()
  if not self.is_add_npc then
    self:add_functional_npc(4, "center", "center", {npc_id = 40001})
    self.is_add_npc = true
  end
  self:set_scene_camera(9901)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_ui_object_visible("fight", "Main", true)
  if not self:is_pass_room() then
    self:remove_world_model("tppoint1")
  end
  self:open_all_transmit()
  self:fight_end(true)
  self:end_perform(self.room_type)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
end

function M:on_npc_show_end(id, type)
  if 40001 ~= id then
    return
  end
  self:set_scene_camera(9902)
  self:remove_all_transmit()
  self:set_in_challenge(true)
  self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
  self.m_oSceneCounter:GetTimeCounter(40001):Start()
  self:set_functional_npc_visible(40001, false)
  self.challenge_condition = 1
  self.monster1 = self:add_npc_by_pos_key(1, 201021, "center", 0, 0, "center", 0, -4, 4, self.challenge_level)
end

function M:on_npc_dead(npc)
  if self.challenge_max_time - self.m_oSceneCounter:GetTimeCounter(40001):GetTime() > 0 and not self.challenge_is_false then
    self:set_scene_tips(40011, true)
    self:remove_functional_npc(40001)
    self:add_functional_npc(2, "center", "center", {npc_id = 40021})
    self:open_all_transmit()
  end
  self:set_scene_camera(9901)
  self.m_oSceneCounter:GetTimeCounter(40001):Stop()
  self:set_in_challenge(false)
end

function M:on_time_counter_end(id)
  if 40001 ~= id then
    return
  end
  self.challenge_is_false = true
  if self.monster1 then
    local monster_pos = self:get_npc_pos(self.monster1)
    self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
    self:remove_npc(self.monster1)
  end
  self:set_scene_camera(9901)
  self:set_scene_tips(40012, true)
  self:set_in_challenge(false)
  self:open_all_transmit()
  self:remove_functional_npc(40001)
end

function M:on_all_hero_die()
  self.m_oSceneCounter:GetTimeCounter(40001):Stop()
  self.challenge_is_false = true
  if self.monster1 then
    local monster_pos = self:get_npc_pos(self.monster1)
    self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
    self:remove_npc(self.monster1)
  end
  self:set_scene_camera(9901)
  self:set_scene_tips(40012, true)
  self:set_in_challenge(false)
  self:open_all_transmit()
  self:remove_functional_npc(40001)
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
end

function M:on_frame()
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
