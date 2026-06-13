local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")

function M:_init(...)
  Base._init(self, ...)
  self.vgc_0 = Visualgame_controller:new()
  self.vgc_0:initialize("Test_Profile")
  self.vgc_0:apply_camera(Global.camera:get_camera())
  self.func_npc_pos_list = {
    "P1-1",
    "P1-2",
    "P1-3",
    "P2-1",
    "P2-2",
    "P2-3"
  }
  self.test_func_npc = 1081000
  self.vgc_0.on_visibility_change = self.on_visibility_change
  self.vgc_0.func_npc_pos_list = self.func_npc_pos_list
  self.vgc_0.test_func_npc = self.test_func_npc
  self.vgc_0:start_game()
  VisualGameManager:open_capture_system(108100001)
end

function M:on_remove()
  self.vgc_0:end_game()
  self.vgc_0:destroy()
  VisualGameManager:close_capture_system()
end

return M
