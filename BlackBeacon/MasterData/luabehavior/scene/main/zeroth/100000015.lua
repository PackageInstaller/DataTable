local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config2", "common")

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.stageshow = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
end

function M:on_enter()
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall1", flase)
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
  elseif not self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall1", true)
    self:actvie_obstacle("AW2", "wall2", true)
    self:set_scene_camera(9902)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self.monster1 = self:add_npc_by_pos_key(1, 201021, "M1", 0, 0, "tp3", 0, 0, 4, self.normal_level)
    self:cast_magic(self.monster1, self.monster1, 4010176, 1)
    self:set_sync_var("rock_skip", true)
    self:cast_magic(self.monster1, self.monster1, 4010189, 1)
    self:cast_magic(self.monster1, self.monster1, 4010188, 1)
    self:cast_magic(self.monster1, self.monster1, 4010191, 1)
    self:cast_magic(self.monster1, self.monster1, 4010190, 1)
    self:cast_magic(Global.hero, Global.hero, 4010192, 1)
  end
end

function M:add_monster(...)
end

function M:on_npc_dead(npc)
  if not self:is_pass_room() and self:check_npc_status(self.monster1, 5) and 0 == self.stageshow then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self.settlementTime = os.time()
    self:open_all_transmit()
    self:start_guide(2005)
    self:abort_magic_by_id(Global.hero, 4010192)
  end
end

function M:on_frame()
  if self.settlementTime and os.time() - self.settlementTime >= 2 then
    self.settlementTime = nil
    self:set_scene_camera(9901)
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

function M:on_leave_area(npc, area)
end

function M:on_save()
  local data = {
    stageshow = self.stageshow
  }
  return data
end

function M:on_load(data)
  self.stageshow = data.stageshow
end

function M:on_guide_finished(guide_id)
  if 2001 == guide_id then
    self:actvie_obstacle("AW2", "wall2", false)
  end
end

return M
