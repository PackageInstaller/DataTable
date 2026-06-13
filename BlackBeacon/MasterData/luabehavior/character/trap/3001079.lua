local Base = require("manager.scene.custom_scene_logic_runner")
local M = Util.create_child_mt(Base)

function M:_init(npc)
  set_npc_floating_text_hud_visible(npc, false)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  self.vgc_1 = self:create_visualgame_controller()
  self.vgc_1:initialize("Test_Profile")
  self.vgc_1:apply_camera(Global.camera:get_camera())
end

function M:on_enter_area(npc, area)
  if area.Key == "game_start" and npc == get_come_on_hero() then
    print("111111111111111111111111")
    self.vgc_1:start_game()
  end
end

function M:on_leave_area(npc, area)
  if area.Key == "game_start" and npc == get_come_on_hero() then
    print("222222222222222")
    self.vgc_1:end_game()
  end
end

return M
