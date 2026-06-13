local M = Util.create_class()
local tower_skill_id = {
  [1] = 310100301,
  [2] = 310100302,
  [3] = 31010030301
}

function M:_init()
  self.magic_set = nil
  self.settlementTime = 0
  self.strengthTime = 0
  self.god = get_god_npc()
  self.strength = nil
  self.strengthMax = nil
  self.levle = nil
  self.levlemax = nil
  self.levelD = nil
  self.shotatk = nil
  self.shotatkTime = 0
end

function M:on_frame()
  self:search_target()
  if self.god then
    self.strength = get_npc_attr(self.god, 105)
    self.strengthMax = get_npc_attr(self.god, 107)
  end
  if self.magic_set == nil then
    self.magic_set = 0
    set_ui_object_visible("fight", "Btn_skill1", false)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "ChangHero1", false)
    set_ui_object_visible("fight", "ChangHero2", false)
    set_ui_object_visible("fight", "Button_prepare", false)
    set_ui_object_visible("fight", "Button_rune", false)
    set_ui_object_visible("fight", "Btn_skill7", true)
    set_skill_btn_icon(62, "UI_H1001004_atk")
    self.fire = add_npc_by_pos_key(1, 3001027, "center", 0, 0, "center", 0, 0, 2, 1)
    cast_magic(self.fire, self.fire, 399984, 1)
  end
end

function M:set_charging()
end

function M:cast_shotatk()
  set_ui_object_visible("fight", "Btn_skill7", false)
  set_ui_object_visible("fight", "Btn_skill6", true)
  focus_npc(self.fire)
end

function M:cast_skill1()
  if 0 == self.magic_set then
    self.magic_set = 1
  end
  cast_magic(self.npc, self.npc, 399991, 1)
  self.settlementTime = get_npc_time(self.npc)
  self:set_charging()
  clear_input(self, 60)
  set_strength_visible(true)
end

function M:cast_skill2()
  if 1 == self.magic_set then
    self.magic_set = 0
  end
  cast_magic(self.npc, self.npc, 399992, 1)
  set_strength_visible(false)
  self.settlementTime = get_npc_time(self.npc)
  clear_input(self, 60)
end

function M:on_input(input_id)
  if 62 == input_id then
    self:cast_shotatk()
  end
  if 61 == input_id and 0 == self.magic_set and get_npc_time(self.npc) > self.settlementTime + 1.1 and self.strength > 30 then
    self:cast_skill1()
  elseif 61 == input_id and 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime + 1.1 then
    self:cast_skill2()
  elseif 61 == input_id and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 399997, 1)
  end
end

function M:on_touch_up(output_id, iscancel)
  if 62 == output_id and false == iscancel then
    self.shotatk = 0
  end
end

function M:search_target()
  self.target = search_npc(self.npc, 2, 30, nil, 1)
end

function M:on_room_change(npc)
  if check_magic(npc, 4031015) then
    cast_magic(self.npc, self.npc, 399982, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if check_magic(npc, 4031015) then
    cast_magic(self.npc, self.npc, 399982, 1)
  end
end

return M
