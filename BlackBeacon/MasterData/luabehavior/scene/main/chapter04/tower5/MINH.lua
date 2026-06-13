local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)

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
end

function M:on_enter()
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_scene_camera(9902)
  self:set_ui_object_visible("fight", "Btn_skill1", false)
  self:set_ui_object_visible("fight", "Btn_skill3", false)
  self:set_ui_object_visible("fight", "Btn_skill4", false)
  self:set_ui_object_visible("fight", "Btn_skill5", false)
  self:set_ui_object_visible("fight", "Btn_lock7", false)
  self:set_ui_object_visible("fight", "Button_rune", false)
  self:timer_call_out(nil, function()
    self:cast_magic(Global.hero, Global.hero, 1026001, 3)
  end, 1)
end

function M:on_npc_dead(npc)
end

function M:on_frame()
end

function M:add_monster1()
  self.monster1 = self:add_npc_by_pos_key(1, 20106001, "center", 0, 0, "tp3", 0, 0, 4, 99)
  self:cast_magic(self.monster1, self.monster1, 4032901, 1)
  self:set_sync_var("in_daze", 1)
  self:set_sync_var("close_counterattack", 1)
end

function M:add_monster2()
  self.monster2 = self:add_npc_by_pos_key(1, 201021, "center", 0, 0, "tp3", 0, 0, 4, 99)
  self:cast_magic(self.monster2, self.monster2, 4032901, 1)
  self:set_sync_var("in_daze", nil)
  self:set_sync_var("combo_guide", 32)
end

function M:on_teach_scene_create_monster(monster_group)
  if "monster_group1" == monster_group then
    self:add_monster1()
    self:set_sync_var("had_created_" .. monster_group, true)
  elseif "monster_group2" == monster_group then
    self:remove_npc(self.monster1)
    self:add_monster2()
    self:set_sync_var("had_created_" .. monster_group, true)
  end
end

function M:on_end_teach_level(win)
  if self:is_pass_room() then
    return
  end
  self:remove_npc(self.monster2)
  self:fight_end(true)
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
end

function M:on_load(data)
end

return M
