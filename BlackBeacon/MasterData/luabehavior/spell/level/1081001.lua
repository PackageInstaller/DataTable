local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_door = Visualgame_controller:new()
  self.vgc_door:initialize("10810_Profile_Door1")
  self.vgc_door:apply_camera(Global.camera:get_camera())
  self.scene_timeline_door = "/Root/Level/10810/Door/scene_timeline_1081001_door"
  self.vgc_door.on_visibility_change = self.on_visibility_change_door
  self.vgc_door.on_obj_move = self.on_obj_move_door
  self.vgc_door.scene_timeline_door = self.scene_timeline_door
  self.vgc_door.parent = self
  self.vgc_door.door_status = false
  self.sculpture_hint_effect = "/Root/Change_/Change_Night/Zone_11/Prop_07/sc08_prop_73_02_pre1/Fx_SculptureHint1"
  set_sceneobj_visible(self.sculpture_hint_effect, true)
end

function M:on_visibility_change_door(obj_index, is_visible)
  if true == is_visible and self.door_ready and not self.door_status then
    set_sceneobj_visible(self.parent.sculpture_hint_effect, true)
    set_scene_timeline_speed(self.scene_timeline_door, 1)
    self.door_status = true
  end
end

function M:on_obj_move_door(obj_index)
  if 0 == self:get_obj_activated_index(obj_index) then
    self.door_ready = true
  else
    self.door_ready = false
    if self.door_status then
      set_sceneobj_visible(self.parent.sculpture_hint_effect, false)
      set_scene_timeline_speed(self.scene_timeline_door, -1.5)
      self.door_status = false
    end
  end
end

function M:on_enter_area(npc, area)
  if npc == get_come_on_hero() and area.Key == "puzzle" then
    self:timer_call_out("teleport_delay", function()
      self.vgc_door:change_obj_location(0, 1)
      set_sceneobj_visible(self.sculpture_hint_effect, false)
    end, 0.75)
    self.vgc_door:start_game()
  end
end

function M:on_remove()
  self.vgc_door:end_game()
  self.vgc_door:destroy()
end

return M
