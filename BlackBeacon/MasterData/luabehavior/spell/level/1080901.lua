local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_letter = Visualgame_controller:new()
  self.vgc_letter:initialize("10809_Profile_Letter")
  self.vgc_letter:apply_camera(Global.camera:get_camera())
  self.vgc_door = Visualgame_controller:new()
  self.vgc_door:initialize("10809_Profile_Door")
  self.vgc_door:apply_camera(Global.camera:get_camera())
  self.func_npc_pos_list = {
    "Interact1-1",
    "Interact1-2",
    "Interact1-3",
    "Interact1-4",
    "Interact1-5",
    "Interact1-6"
  }
  self.func_npc_letter = 1080901
  self.vgc_letter.on_visibility_change = self.on_visibility_change_letter
  self.vgc_letter.on_obj_move = self.on_obj_move_letter
  self.vgc_letter.func_npc_pos_list = self.func_npc_pos_list
  self.vgc_letter.func_npc_letter = self.func_npc_letter
  self.vgc_door.on_visibility_change = self.on_visibility_change_door
  self.vgc_door.on_obj_move = self.on_obj_move_door
end

function M:on_obj_move_letter(obj_index)
  if get_sync_var("letter") then
    func_npc_try_call_behavior_fun(self.func_npc_letter, "set_npc_pos", self.func_npc_pos_list[self:get_obj_activated_index(obj_index) + 1])
  end
end

function M:on_obj_move_door(obj_index)
  if 1 ~= self:get_obj_activated_index(obj_index) then
    set_sync_var("victory", true)
  else
    set_sync_var("victory", false)
  end
end

function M:on_enter_area(npc, area)
  if npc == get_come_on_hero() and area.Key == "puzzle1" then
    self:timer_call_out("teleport_delay", function()
      self.vgc_letter:change_obj_location(0, 1)
    end, 0.75)
  elseif npc == get_come_on_hero() and area.Key == "puzzle2" then
    self.vgc_door:start_game()
  end
end

function M:on_npc_group_clear(group_id)
  if 10809102 == group_id then
    self:timer_call_out("game_delay", function()
      self.vgc_letter:start_game()
      self:add_functional_npc(4, self.func_npc_pos_list[self.vgc_letter:get_obj_activated_index(0) + 1], "center", {
        npc_id = self.func_npc_letter
      })
      set_sync_var("letter", true)
    end, 0.75)
  end
end

function M:on_remove()
  self.vgc_letter:end_game()
  self.vgc_letter:destroy()
  self.vgc_door:end_game()
  self.vgc_door:destroy()
end

return M
