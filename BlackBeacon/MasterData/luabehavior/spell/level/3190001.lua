local M = Util.create_class()

function M:_init()
  self.god = get_god_npc()
end

function M:on_start()
  if check_magic(self.god, 3190002) == true then
    abort_magic_by_id(self.god, 3190002, 1)
  end
  set_ui_object_visible("fight", "Btn_skill1", false)
  set_ui_object_visible("fight", "Btn_skill7", false)
  set_ui_object_visible("fight", "Btn_skill3", false)
  set_ui_object_visible("fight", "Btn_skill4", false)
  set_ui_object_visible("fight", "Btn_skill5", false)
  set_ui_object_visible("fight", "JoystickContent", false)
  set_ui_object_visible("fight", "Btn_skillTower", true)
  clear_focal()
  set_camera_animed_state(true)
end

function M:on_frame()
  char_visible(true)
end

return M
