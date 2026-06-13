local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_sculpture1 = Visualgame_controller:new()
  self.vgc_sculpture1:initialize("10810_Profile_Door2-1")
  self.vgc_sculpture1:apply_camera(Global.camera:get_camera())
  self.vgc_sculpture2 = Visualgame_controller:new()
  self.vgc_sculpture2:initialize("10810_Profile_Door2-2")
  self.vgc_sculpture2:apply_camera(Global.camera:get_camera())
end

function M:on_story_finish(story_id)
  if 904080116 == story_id then
  end
  if 904080118 == story_id then
  end
end

function M:on_remove()
  self.vgc_sculpture1:end_game()
  self.vgc_sculpture1:destroy()
  self.vgc_sculpture2:end_game()
  self.vgc_sculpture2:destroy()
end

function M:on_activate_pov_camera(pov_index)
  self:set_functional_npc_visible(108010201, false)
  self:set_functional_npc_visible(108010202, false)
  self:set_functional_npc_visible(1089999, false)
  char_visible(true)
end

function M:on_deactivate_pov_camera()
  self:set_functional_npc_visible(108010201, true)
  self:set_functional_npc_visible(108010202, true)
  self:set_functional_npc_visible(1089999, true)
  char_visible(false)
end

return M
