local M = Util.create_class()
local tower_skill_id = {
  [1] = 310100301,
  [2] = 310100302,
  [3] = 31010030401
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

function M:on_start()
  if get_sync_var("attr99num") then
    self.attr99num = get_sync_var("attr99num")
    if self.attr99num <= 2 then
      self.shotatkIdelTime = 0.7 - self.attr99num * 0.25
    elseif self.attr99num > 2 then
      self.shotatkIdelTime = 0.1
    end
    if get_sync_var("attr99num") > 0 then
      set_scene_tips(50110 + tonumber(get_sync_var("attr99num")), true, {})
    end
  end
end

function M:on_frame()
  if self.god then
    self.strength = get_npc_attr(self.god, 105)
    self.strengthMax = get_npc_attr(self.god, 107)
  end
  if self.magic_set == nil then
    self.magic_set = 0
    set_ui_object_visible("fight", "Btn_skill6", true)
    set_skill_btn_icon(61, "UI_H1001008_skill3")
    self:set_charging()
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
    set_camera(12110003)
    set_ui_object_visible("fight", "JoystickContent", false)
    stop_skill_joystick_move(self.npc)
    stop_move(self.npc)
    abort_skill(self.npc, 1)
    set_camera_animed_state(true)
    set_camera_click_swip_state(true)
  end
  if self.god and 0 == self.magic_set and self.strength < 30 then
    set_skill_btn_icon(61, "TPS_gray")
  elseif self.god and 0 == self.magic_set and self.strength > 30 then
    set_skill_btn_icon(61, "UI_H1001005_exskill")
  elseif self.god and 1 == self.magic_set then
    set_skill_btn_icon(61, "UI_H1001005_exskill")
  end
  if self.god and 0 == self.magic_set and self.strength < self.strengthMax and get_npc_time(self.npc) > self.strengthTime + 0.3 then
    cast_magic(self.npc, self.god, 4031018, 1)
    self.strengthTime = get_npc_time(self.npc)
    self:set_charging()
  end
  if self.god and 1 == self.magic_set and self.strength > 0 and get_npc_time(self.npc) > self.strengthTime + 0.3 then
    cast_magic(self.npc, self.god, 4031017, 1)
    self.strengthTime = get_npc_time(self.npc)
  end
  if self.god and 1 == self.magic_set and 0 == self.strength then
    self:cast_skill2()
  end
  if 1 == self.magic_set and check_magic(self.npc, 3001017003) then
    cast_magic(self.npc, self.npc, 3001017002, 1)
    abort_magic_by_id(self.npc, 3001017003)
  end
  if 1 == self.shotatk then
    self:cast_shotatk()
  end
end

function M:set_charging()
  if 0 == self.magic_set and self.god and self.strength > 0 then
    self.level = math.ceil(self.strength / 5)
    self.levlemax = math.ceil(self.strengthMax / 5)
    self.levelD = self.levlemax - self.level
    cast_magic(self.npc, self.npc, 399999, self.levlemax)
    cast_magic(self.npc, self.npc, 399998, self.level)
    set_skill_btn_charging(61, 1, {
      param_type = 1,
      param1 = 105,
      param2 = 107
    })
  else
    clear_skill_btn_charging(61)
  end
end

function M:cast_skill1()
  if 0 == self.magic_set then
    self.magic_set = 1
  end
  cast_magic(self.npc, self.npc, 399991, 1)
  self.settlementTime = get_npc_time(self.npc)
  self:set_charging()
  set_strength_visible(true)
end

function M:cast_skill2()
  if 1 == self.magic_set then
    self.magic_set = 0
  end
  cast_magic(self.npc, self.npc, 399992, 1)
  set_strength_visible(false)
  self.settlementTime = get_npc_time(self.npc)
end

function M:cast_shotatk()
  if 0 == self.magic_set and get_npc_time(self.npc) > self.shotatkTime + self.shotatkIdelTime then
    cast_missile(self.npc, nil, nil, nil, tower_skill_id[3], 1)
    self.shotatkTime = get_npc_time(self.npc)
  elseif 1 == self.magic_set and get_npc_time(self.npc) > self.shotatkTime + 0.2 then
    cast_missile(self.npc, nil, nil, nil, tower_skill_id[3], 1)
    self.shotatkTime = get_npc_time(self.npc)
  end
end

function M:on_input(input_id)
  if 61 == input_id and 0 == self.magic_set and get_npc_time(self.npc) > self.settlementTime + 1.1 and self.strength > 30 then
    self:cast_skill1()
    if not self.attr101tips and get_sync_var("attr101num") and get_sync_var("attr101num") > 0 then
      set_scene_tips(50130 + tonumber(get_sync_var("attr101num")), true, {})
      self.attr101tips = true
    end
  elseif 61 == input_id and 1 == self.magic_set and get_npc_time(self.npc) > self.settlementTime + 1.1 then
    self:cast_skill2()
  elseif 61 == input_id and 0 == self.magic_set then
    cast_magic(self.npc, self.npc, 399997, 1)
  end
  if 62 == input_id then
    self.shotatk = 1
  end
end

function M:on_touch_up(output_id, iscancel)
  if 62 == output_id and false == iscancel then
    self.shotatk = 0
  end
end

function M:on_room_change(npc)
  if check_magic(npc, 4031021) then
    cast_magic(self.npc, self.npc, 4031022, 1)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc and check_magic(npc, 4031021) then
    cast_magic(self.npc, self.npc, 4031022, 1)
  end
end

return M
