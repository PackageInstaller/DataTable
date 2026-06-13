local M = Util.create_class()

function M:_init()
  self.god = get_god_npc()
end

function M:on_start()
  if check_magic(self.god, 3190012) == true then
    abort_magic_by_id(self.god, 3190012, 1)
  end
  set_ui_object_visible("fight", "Btn_skill1", false)
  set_ui_object_visible("fight", "Btn_skill7", false)
  set_ui_object_visible("fight", "Btn_skill3", false)
  set_ui_object_visible("fight", "Btn_skill4", false)
  set_ui_object_visible("fight", "Btn_skill5", false)
  set_ui_object_visible("fight", "Btn_skillTower", true)
  set_ui_object_visible("fight", "JoystickContent", false)
end

return M
