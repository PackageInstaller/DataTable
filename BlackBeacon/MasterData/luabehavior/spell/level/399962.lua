local M = Util.create_class()
local tower_skill_id = {
  [1] = 310100301,
  [2] = 310100302,
  [3] = 31010030301
}

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  self.god = get_god_npc()
end

function M:on_frame()
  if 0 == self.magic_set then
    self.magic_set = 1
    set_camera(10000001)
    set_camera_animed_state(true)
    set_aimed_move_state(true)
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_strength_visible(true)
    set_skill_btn_icon(62, "UI_H1001004_atk")
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_ui_object_visible("fight", "Button_prepare", false)
    set_ui_object_visible("fight", "Button_rune", false)
    cast_magic(self.npc, self.npc, 399991, 1)
  end
end

function M:on_input(input_id)
  if 62 == input_id and 1 == self.magic_set then
    clear_input()
    cast_missile(self.npc, nil, nil, nil, tower_skill_id[3], 1)
  end
end

return M
