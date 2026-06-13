local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local atk_counting, x, y
local TEMP_POS = {}
local indicator_set = 0
local press_set = 0
local tower_skill_id = {
  [1] = 310100301,
  [2] = 310100302
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
  self.target = search_npc(self.npc, 2, 3, nil, 1)
  if self.target ~= nil then
    cast_magic(self.npc, self.target, 100175, 1)
  end
end

function M:cast_counter()
end

function M:cast_skill1()
  if 0 == self.control then
    self.control = 1
    replace_tower_skill(2)
    set_ui_object_visible("fight", "Btn_skill3", false)
    set_ui_object_visible("fight", "Btn_skill4", false)
    set_ui_object_visible("fight", "Btn_skill5", false)
    set_ui_object_visible("fight", "Btn_lock7", false)
    set_ui_object_visible("fight", "JoystickContent", false)
  end
  abort_skill(self.npc)
  if check_magic(self.target, 399963) then
    abort_magic_by_id(self.target, 399963, 1)
  end
  cast_magic(self.npc, self.target, 399962, 1)
  cast_magic(self.npc, self.target, 100173, 1)
  CommonRole.clear_input(self, 60)
end

function M:cast_skill2()
  if 1 == self.control then
    self.control = 0
    replace_tower_skill(1)
    set_ui_object_visible("fight", "Btn_skill3", true)
    set_ui_object_visible("fight", "Btn_skill4", true)
    set_ui_object_visible("fight", "Btn_skill5", true)
    set_ui_object_visible("fight", "Btn_lock7", true)
    set_ui_object_visible("fight", "JoystickContent", true)
  end
  abort_skill(self.npc)
  cast_magic(self.npc, self.target, 399963, 1)
  CommonRole.clear_input(self, 60)
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
  self.indicator_input_timer[input_id] = 0
  if 60 == input_id and 0 == self.control then
    self:cast_skill1()
  elseif 60 == input_id and 1 == self.control then
    self:cast_skill2()
  end
end

function M:on_touch_up(input_id, iscancle)
end

function M:on_frame()
end

function M:on_skill_begin(npc, skill_id)
  if npc ~= self.npc then
    return
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
