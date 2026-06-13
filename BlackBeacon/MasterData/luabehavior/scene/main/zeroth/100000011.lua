local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local monster_cfg = import("luaBehavior.common.monster_config", "common")

function M:_init(...)
  Base._init(self, ...)
  self.room_num, self.floor_num = self:get_tower_floor_info()
  self.normal_level = self:get_tower_monster_level("MonLevel1")
  self.rare_level = self:get_tower_monster_level("MonLevel2")
  self.boss_level = self:get_tower_monster_level("MonLevel3")
  self.room_type = self:get_room_type()
  self.monster_list = {}
  self.is_hide_skill = 0
  self.guide1 = 0
  self.monster_lv = {
    monster1 = self.normal_level,
    monster2 = self.rare_level,
    monster3 = self.boss_level
  }
  self.tp_control1 = 0
end

function M:on_enter()
  self:set_scene_camera(9901)
  self:actvie_obstacle("AW1", "wall", true)
  self:set_ui_object_visible("fight", "Button_prepare", false)
  self:set_ui_object_visible("fight", "Collection", false)
  self:set_ui_object_visible("fight", "Talent", false)
  if not self:is_pass_room() then
    self:remove_world_model("tppoint1")
  end
  if 0 == self.is_hide_skill then
    self:set_ui_object_visible("fight", "Btn_skill1", false)
    self:set_ui_object_visible("fight", "Btn_skill3", false)
    self:set_ui_object_visible("fight", "Btn_skill4", false)
    self:set_ui_object_visible("fight", "Btn_skill5", false)
    self:set_ui_object_visible("fight", "Btn_lock7", false)
    self:set_ui_object_visible("fight", "JoystickContent", false)
    self:cast_magic(Global.hero, Global.hero, 4010159, 1)
    self:cast_magic(Global.hero, Global.hero, 4010177, 1)
    self:cast_magic(Global.hero, Global.hero, 4010171, 1)
    self.is_hide_skill = 1
  end
  self:open_all_transmit(2)
  self:fight_end(true)
  self:end_perform(self.room_type)
  local x, y = self:get_scene_map_pos_postion("center")
  self:lookat_position(Global.hero, x, y, true)
end

function M:add_monster(...)
end

function M:on_npc_dead(npc)
end

function M:on_frame()
  if 3 == self.guide1 then
    self:start_guide(2005)
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
  if 2004 == guide_id then
    self.guide1 = 3
  end
end

function M:on_save()
  local data = {
    is_hide_skill = self.is_hide_skill,
    guide1 = self.guide1
  }
  return data
end

function M:on_load(data)
  self.is_hide_skill = data.is_hide_skill
  self.guide1 = data.guide1
end

return M
