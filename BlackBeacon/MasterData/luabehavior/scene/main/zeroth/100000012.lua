local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config3", "common")

function M:_init(...)
  Base._init(self, ...)
  self.monsternum = 0
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.guide1 = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
end

function M:on_enter()
  self:actvie_obstacle("AW1", "wall", true)
  if self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(9901)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self:open_all_transmit()
  elseif not self:is_pass_room() then
    self:actvie_obstacle("AW1", "wall", true)
    self:set_scene_camera(9902)
    local x, y = self:get_scene_map_pos_postion("center")
    self:lookat_position(Global.hero, x, y, true)
    self.monster1 = self:add_npc_by_pos_key(1, 201009, "M1", 0, 0, "M1", 0, 0, 4, self.normal_level)
    self:set_ui_object_visible("fight", "Btn_skill1", true)
    self:set_ui_object_visible("fight", "Btn_lock7", true)
    self:start_guide(2010)
  end
end

function M:add_monster(...)
  local monster = self:add_npc_by_pos_key(...)
  table.insert(self.monster_list, monster)
end

function M:on_npc_dead(npc)
  if not self:is_pass_room() and 0 == self.monsternum and self:check_npc_status(self.monster1, 5) then
    self.monsternum = 1
    self.monster2 = self:add_npc_by_pos_key(1, 201009, "M2", 0, 0, "M2", 0, 0, 4, self.normal_level)
    self.monster3 = self:add_npc_by_pos_key(1, 201009, "M3", 0, 0, "M3", 0, 0, 4, self.normal_level)
    self.monster4 = self:add_npc_by_pos_key(1, 201009, "M4", 0, 0, "M4", 0, 0, 4, self.normal_level)
    self:cast_magic(self.monster2, self.monster2, 4010008, 1)
    self:cast_magic(self.monster3, self.monster3, 4010008, 1)
    self:cast_magic(self.monster4, self.monster4, 4010008, 1)
    self.guide1 = 1
  end
  if not self:is_pass_room() and 1 == self.monsternum and self:check_npc_status(self.monster2, 5) and self:check_npc_status(self.monster3, 5) and self:check_npc_status(self.monster4, 5) then
    self.monsternum = 2
    self:fight_end(true)
    self:end_perform(self.room_type)
    self.settlementTime = os.time()
    self:open_all_transmit()
    self:start_guide(2005)
  end
end

function M:on_frame()
  if self.settlementTime and os.time() - self.settlementTime >= 2 then
    self.settlementTime = nil
    self:set_scene_camera(9901)
  end
  if 1 == self.guide1 then
    self:set_ui_object_visible("fight", "Btn_skill4", true)
    self:cast_magic(Global.hero, Global.hero, 4010158, 1)
    self:start_guide(2002)
    self.guide1 = 2
  end
  if 3 == self.guide1 then
    self:cast_magic(Global.hero, Global.hero, 4010173, 1)
    self.guide1 = 4
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

function M:on_guide_finished(guide_id)
  if 2002 == guide_id then
    self.guide1 = 3
  end
  if 2003 == guide_id then
    self.guide1 = 5
    if not self:check_npc_status(self.monster2, 5) then
      self:abort_magic_by_id(self.monster2, 4010008)
    end
    if not self:check_npc_status(self.monster3, 5) then
      self:abort_magic_by_id(self.monster3, 4010008)
    end
    if not self:check_npc_status(self.monster4, 5) then
      self:abort_magic_by_id(self.monster4, 4010008)
    end
  end
end

return M
