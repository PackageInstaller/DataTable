local M = Util.create_class()

function M:_init()
  self.magic_set = 0
  self.settlementTime = 0
  local tower_skill_id = {
    [1] = 310100301,
    [2] = 310100302,
    [3] = 310100303
  }
  self.god = get_god_npc()
end

function M:on_start()
  self.teammate1 = get_scene_hero_by_poskey(21)
  self.teammate2 = get_scene_hero_by_poskey(22)
end

function M:on_frame()
  if 0 == self.magic_set then
    self.magic_set = 1
    set_aimed_move_state(false)
    set_camera_animed_state(false)
    back_to_scene_camera()
    set_ui_object_visible("fight", "Btn_skill1", true)
    set_ui_object_visible("fight", "Btn_skill7", false)
    if self.teammate1 then
      set_ui_object_visible("fight", "ChangHero1", true)
    end
    if self.teammate2 then
      set_ui_object_visible("fight", "ChangHero2", true)
    end
    set_ui_object_visible("fight", "Button_prepare", true)
    set_ui_object_visible("fight", "Button_rune", true)
    cast_magic(self.npc, self.npc, 399992, 1)
    abort_magic_by_id(self.npc, 399963, 1)
  end
end

return M
