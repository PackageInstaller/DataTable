local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local atk_counting, x, y
local TEMP_POS = {}
local indicator_set = 0
local press_set = 0
local death_set = 0
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 12
}
local arrow_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 3
}
local waycast_id = {
  [60] = 310100101
}
local tower_skill_id = {
  [1] = 310100101
}
local skill_abort_level = 5

function M:init_data()
end

function M:_init(npc)
  Base._init(self)
  self:init_data()
  CommonRole.role_common_init(self)
  self.indicator_input_timer = self.indicator_input_timer or {}
  self.now_input_id = nil
  self.now_skill_id = nil
  self.control = 0
end

function M:on_born_behavior()
  waycast_id = {
    [60] = 310100101
  }
end

function M:cast_counter()
end

function M:cast_skill2()
  if 0 == self.control then
    return
  end
  if get_npc_cd_charge(self.npc, tower_skill_id[1]) < get_skill_cfg(tower_skill_id[1]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  if 0 == indicator_set then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return
  end
  abort_skill(self.npc)
  cast_skill(self.npc, self.target, tower_skill_id[1], nil, nil)
  skill_abort_level = 4
  CommonRole.clear_input(self, 60)
  self.control = 0
end

function M:cast_skill3()
end

function M:cast_atk()
end

function M:clear_focal_condition()
  if self.target == nil then
    clear_focal()
  elseif not check_npc_distance(self.npc, self.target, 12, 1) then
    clear_focal()
  end
end

function M:on_frame()
  for id, value in pairs(self.indicator_input_timer) do
    self.indicator_input_timer[id] = self.indicator_input_timer[id] + 1
    if self.indicator_input_timer[id] > 7 then
      self:on_press(id)
      press_set = 1
      self.indicator_input_timer[id] = nil
    end
  end
  self:clear_focal_condition()
  CommonRole.role_common_on_frame(self)
end

function M:on_press(input_id)
  if not waycast_id[input_id] then
    return
  end
  local now_npc_time = get_npc_time(self.npc)
  local now_cd_charge = get_npc_cd_charge(self.npc, waycast_id[input_id])
  if input_id ~= self.now_input_id then
    return
  end
  if 60 == input_id then
    if now_cd_charge < get_skill_cfg(waycast_id[input_id]).CdChargePerCost then
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, 6, 0) then
      update_skill_indicator(input_id, skill_area, arrow_indi_cfg, 0.5)
      set_indicator_active(input_id, true, true)
    else
      update_skill_indicator(input_id, skill_area, arrow_indi_cfg, 0.5)
      set_indicator_active(input_id, true, false)
    end
  end
end

function M:on_skill_begin(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == tower_skill_id[1] then
  end
end

function M:on_skill_hit(npc, skill_id, hit_target)
  if hit_target == self.npc then
    CommonRole.hit_screen_effect(self)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == tower_skill_id[1] then
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc ~= self.npc then
    return
  end
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
  self.indicator_input_timer[input_id] = 0
  if 60 == input_id and self.now_input_id == nil then
    self.now_input_id = input_id
  end
end

function M:on_touch_up(input_id, iscancle)
  self.indicator_input_timer[input_id] = nil
  if true == iscancle then
    press_set = 0
  end
  if 60 == input_id then
    set_indicator_active(input_id, false)
    x, y = get_indicator_pos(input_id)
  end
  if input_id ~= self.now_input_id then
    return
  end
  if 60 == input_id and false == iscancle then
    indicator_set = 1
    self:cast_skill2()
    self.now_input_id = nil
    self.control = 1
  elseif true == iscancle then
    self.now_input_id = nil
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    clear_input()
  end
end

function M:on_scene_change()
end

function M:on_npc_removed(npc)
  CommonRole.role_common_on_npc_removed(self, npc)
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
end

return M
