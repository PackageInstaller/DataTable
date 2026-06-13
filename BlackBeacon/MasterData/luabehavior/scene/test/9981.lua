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
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
  self.tp_control2 = 0
end

function M:on_enter()
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(9902)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  if self:is_pass_room() then
    self:open_all_transmit()
  elseif not self:is_pass_room() then
    self.monster1 = self:add_npc_by_pos_key(1, 201043, "M1", 0, 0, "M1", -1, -1, 4, self.boss_level)
  end
end

function M:on_npc_dead(npc)
  local count = #self.monster_list
  for i = count, 1, -1 do
    local monster = self.monster_list[i]
    if monster == npc then
      table.remove(self.monster_list, i)
    end
  end
  if 0 == #self.monster_list and not self:is_pass_room() and 0 == self.monsternum and not self:check_activate(self.monster1) then
    self:fight_end(true)
    self:end_perform(self.room_type)
    self.settlementTime = os.time()
    self:open_all_transmit()
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

return M
