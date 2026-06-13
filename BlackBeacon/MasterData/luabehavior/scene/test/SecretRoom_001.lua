local SceneCounter = import("common.scene_counter", "common")
local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.steal_his = nil
  self.challenge_max_time = 20
  self.is_add_npc = false
  self.m_oSceneCounter = SceneCounter.NewObj(self)
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
  self.tp_control2 = 0
end

function M:on_enter()
  self:set_scene_camera(9901)
  if self.is_add_npc == false then
    self:add_functional_npc(4, "center", "center", {npc_id = 82001})
    self.is_add_npc = true
  end
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:set_ui_object_visible("fight", "Main", true)
  self:open_all_transmit()
  self:fight_end(true)
end

function M:on_npc_show_end(id, type)
  if 82001 == id then
    self:set_scene_camera(9902)
    self:remove_all_transmit()
    self.m_oSceneCounter:AddTimeCounter(40001, self.challenge_max_time, 2)
    self.m_oSceneCounter:GetTimeCounter(40001):Start()
    self:set_functional_npc_visible(82001, false)
    self:set_in_challenge(true)
    Log.Info(Global.hero, "Scene_is_in_chall", self:is_in_challenge())
    self.challenge_condition = 1
    self.monster1 = self:add_npc_by_pos_key(1, 201025, "M1", 0, 0, "M2", 0, 0, 4, self.boss_level)
    self.monster2 = self:add_npc_by_pos_key(1, 3001022, "J1", 0, 0, "J1", 0, 0, 4, self.normal_level)
    self.monster3 = self:add_npc_by_pos_key(1, 3001022, "J2", 0, 0, "J2", 0, 0, 4, self.normal_level)
    self.monster4 = self:add_npc_by_pos_key(1, 3001005, "M11", 0, 0, "M13", 0, 0, 4, self.normal_level)
    self.monster5 = self:add_npc_by_pos_key(1, 3001005, "M12", 0, 0, "M14", 0, 0, 4, self.normal_level)
    self.monster6 = self:add_npc_by_pos_key(1, 3001005, "M13", 0, 0, "M11", 0, 0, 4, self.normal_level)
    self.monster7 = self:add_npc_by_pos_key(1, 3001005, "M14", 0, 0, "M12", 0, 0, 4, self.normal_level)
  end
  if 82002 == id then
    self:remove_functional_npc(82001)
    self:remove_functional_npc(82002)
  end
end

function M:on_npc_dead(npc)
  if 0 == self:get_npc_count_by_kind(2) then
    self:remove_npc(self.monster2)
    self:remove_npc(self.monster3)
    self:remove_npc(self.monster4)
    self:remove_npc(self.monster5)
    self:remove_npc(self.monster6)
    self:remove_npc(self.monster7)
    self:set_scene_tips(40011, true)
    self:remove_functional_npc(82001)
    self.m_oSceneCounter:GetTimeCounter(40001):Stop()
    self:add_functional_npc(2, "center", "center", {npc_id = 82002})
    self:set_in_challenge(false)
    self:open_all_transmit()
    self.settlementTime = os.time()
    self:end_perform(self.room_type)
  end
  if npc == self.monster8 then
    if not self:check_magic(npc, 201051002) and self.steal_his then
      self:restore_change_item_count(self.steal_his)
      self:set_scene_tips(999999998, true)
    else
      Log.Info(Global.hero, "222222222")
    end
  end
end

function M:on_time_counter_end(id)
  Log.Info(Global.hero, "id", id)
  if 40001 ~= id then
    return
  end
  if 0 ~= self:get_npc_count_by_kind(2) then
    Log.Info(Global.hero, "333333333333")
    local monster_pos = self:get_npc_pos(self.monster1)
    self:create_scene_effect("Fx_Common_Death", monster_pos, 10)
    self:remove_npc(self.monster1)
    self:remove_npc(self.monster2)
    self:remove_npc(self.monster3)
    self:remove_npc(self.monster4)
    self:remove_npc(self.monster5)
    self:remove_npc(self.monster6)
    self:remove_npc(self.monster7)
  end
  self:set_scene_camera(9901)
  self:set_scene_tips(40012, true)
  self:set_in_challenge(false)
  self:open_all_transmit()
  self:remove_functional_npc(82001)
end

function M:on_frame()
  if self:check_magic(Global.hero, 201051001) then
    Log.Info(Global.hero, "money_check")
    self.steal_his = self:change_prop_count(501002, 2, 1, 2)
    self:abort_magic_by_id(Global.hero, 201051001)
    self:set_scene_tips(999999999, true)
  end
end

function M:on_hero_dead()
end

function M:on_enter_area(npc, area)
  if not npc:is_hero() then
    return
  end
  self:judge_all_tp(area)
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

function M:on_leave_area(npc, area)
end

return M
