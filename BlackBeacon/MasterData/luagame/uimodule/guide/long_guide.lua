local Base = require("ui.uiobject")
local GuideHelper = require("uimodule.guide.guide_helper")
local JoystickType = typeof(CS.Game.SkillJoyStick)
local SkillIndicator = require("uimodule.fight.skill_indicator")
local TouchManager = CS.TouchManager
local ui = Util.create_child_mt(Base)
local UnityDestroy = _ENV.UnityDestroy
local CTL_TYPE = {
  AREA_ACT = 1,
  AREA_NO_ACT = 2,
  ACT = 3,
  NO_ACT = 4
}
local INPUT_CODE = Config.INPUT_CODE
local SKILL_INPUT_COUDE = {
  [1] = INPUT_CODE.INPUT_COMMON,
  [2] = INPUT_CODE.INPUT_SPECAIL_SKILL,
  [3] = INPUT_CODE.INPUT_SKILL1,
  [4] = INPUT_CODE.INPUT_SKILL2,
  [5] = INPUT_CODE.INPUT_SKILL3,
  [6] = INPUT_CODE.TPS_SKILL,
  [7] = INPUT_CODE.TPS_ATK_SKILL,
  [8] = INPUT_CODE.TOWER_SKILL
}
local LONG_GUIDE_CLICK_MODE = {DEFAULT_CLICK = 0, SPEC_CLICK1 = 1}

function ui:ui_finish_load(...)
  self.v_guide_frame = self.v_object
  self.v_bg1 = self:get_child_gameobj("Bg", self.v_object)
  self.v_bg2 = self:get_child_gameobj("Bg1", self.v_object)
  self.v_bg3 = self:get_rect_transform("Bg2", self.v_object)
  self.v_frame_rect = self:get_rect_transform(nil, self.v_guide_frame)
  self.v_input_mask = {}
end

function ui:ui_on_show(guider, param, ...)
  self.v_guider = guider
  self.v_joystick_btn = self.v_parent_ui:get_joystick_btn()
  self.v_joystick_btn:SetActiveEx(false)
  self.v_cancle_time = param.cancle_time
  self.v_click_mode = param.click_mode
  self.v_cur_guideid = param.guide_id
  UtilTable.clear_map(self.v_input_mask)
  self:_copy_ui_control(param.ui_name, param.control_path, param.hide_frame)
  TouchManager.Instance.ArrowActivated = false
  if SDKManager:is_support_key_mouse() then
    self:bind_auto_mq(Const.MSG_KEY_DOWN, self._response_key_down, self)
    self:bind_auto_mq(Const.MSG_KEY_UP, self._response_key_up, self)
  end
end

function ui:ui_on_hide()
  if self.v_copy_obj then
    UnityDestroy(self.v_copy_obj)
    self.v_copy_obj = nil
  end
  self:_complete_step()
  self.v_is_complete = nil
  self.v_guider = nil
  self.v_click_count = 0
  self.v_hold_time = nil
  self.v_normal_finish = nil
  self.v_bg1:SetActive(true)
  self.v_bg2:SetActive(true)
  self.v_target_obj = nil
  self.v_guide_area = nil
  TouchManager.Instance.ArrowActivated = true
end

function ui:ui_on_update(delta_time)
  if self.v_hold_time then
    self.v_hold_time = self.v_hold_time + delta_time
    if self.v_hold_time > self.v_cancle_time then
      self.v_parent_ui:resume_game()
      self.v_parent_ui:hide_mask()
      self:_hide_frame_bg()
      self.v_joystick_btn:SetActiveEx(false)
    end
  end
end

function ui:update_cope_obj_location()
  if self.v_copy_obj and self.v_target_obj and self.v_frame_rect then
    if self.v_guide_area then
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_guide_area, self.v_frame_rect)
    else
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_target_obj, self.v_frame_rect)
    end
  end
end

function ui:_copy_ui_control(ui_name, ctr_path, hide_frame)
  local uiobj = UIMgr:try_get_visible_ui(ui_name)
  if not uiobj then
    Log.Error("get ui failure !!, ui_name=", ui_name)
    self.v_parent_ui:ui_hide()
    return
  end
  if not ctr_path then
    return
  end
  local target_obj = GuideHelper.get_obj_by_path(self, ctr_path, uiobj)
  local guide_area = self:get_child_gameobj("Guide_Area", target_obj)
  self.v_target_obj = target_obj
  self.v_guide_area = guide_area
  if not target_obj then
    Log.Error("get ui control by path failure !!, path=", ctr_path, " ui name=", uiobj:ui_get_name())
    self.v_parent_ui:ui_hide()
    return
  end
  GuideHelper._reset_joystick(target_obj)
  GuideHelper._reset_joystick_pos(target_obj)
  self.v_copy_obj = UnityGameObject.Instantiate(target_obj, self.v_guide_frame.transform).gameObject
  GuideHelper.copy_image(target_obj, self.v_copy_obj)
  if guide_area then
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, guide_area, self.v_frame_rect)
  else
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, target_obj, self.v_frame_rect)
  end
  self.v_is_joystick = false
  if self:_get_joystick_event(target_obj) then
    self.v_is_joystick = true
    self:_get_ctl_event(target_obj, hide_frame, guide_area, true)
  else
    self:_get_ctl_event(target_obj, hide_frame, guide_area)
  end
  self.v_guide_frame:SetActive(not hide_frame)
  local input_code_list = GuideHelper.uiwidget_to_inputcode[ctr_path]
  if input_code_list then
    for _, input_code in ipairs(input_code_list) do
      self.v_input_mask[input_code] = true
    end
  end
end

function ui:_get_ctl_event(target_obj, hide_frame, guide_area, is_joystick)
  local btnex = self:get_button_ex(nil, self.v_copy_obj)
  if not btnex then
    Log.Error("按钮类型不对，请检查！")
    return
  end
  self.v_target_cb = nil
  self.v_end_click_cb = nil
  
  function self.v_click_cb(...)
    self.v_parent_ui:resume_game()
    if self.v_target_cb then
      self.v_target_cb:Invoke(...)
    end
    self.v_hold_time = 0
  end
  
  if btnex and not hide_frame then
    local component = self:get_button_ex(nil, target_obj)
    self.v_target_cb = component.onTouchBegan
    
    function self.v_end_click_cb()
      if self.v_hold_time and self.v_hold_time < self.v_cancle_time then
        self.v_hold_time = nil
      end
      component.onTouchEnded:Invoke()
      self.v_normal_finish = true
    end
    
    self:set_button_ex_listener(btnex, self.v_click_cb, self.v_end_click_cb, nil, self.v_end_click_cb)
  end
  if self.v_click_mode == LONG_GUIDE_CLICK_MODE.SPEC_CLICK1 then
    function self.v_click_cb(...)
      self.v_hold_time = 0
      
      if self.v_target_cb then
        self.v_target_cb:Invoke(...)
      end
    end
    
    if btnex and not hide_frame then
      local component = self:get_button_ex(nil, target_obj)
      self.v_target_cb = component.onTouchBegan
      
      function self.v_end_click_cb()
        if self.v_hold_time and self.v_hold_time < self.v_cancle_time then
          self.v_hold_time = nil
          return
        end
        self.v_can_break_guide = true
        component.onTouchEnded:Invoke()
        self.v_normal_finish = true
      end
      
      self:set_button_ex_listener(btnex, self.v_click_cb, self.v_end_click_cb, nil, self.v_end_click_cb)
    end
  end
  if btnex then
    self.v_ctl_type = guide_area and CTL_TYPE.AREA_ACT or CTL_TYPE.ACT
  end
end

function ui:_get_joystick_event(target_obj)
  local joy_stick = self.v_copy_obj:GetComponent(JoystickType)
  if not joy_stick then
    return
  end
  local idx = 0
  for k in string.gmatch(target_obj.name, "%d+") do
    idx = tonumber(k)
  end
  if not idx or 0 == idx then
    return
  end
  local keycode = SKILL_INPUT_COUDE[idx]
  local indicator = SkillIndicator.get_key(keycode)
  if not indicator then
    Log.Info("get indicator failure, keycode=", keycode)
    return
  end
  joy_stick.BaseRectTrans = self.v_bg3.component
  
  function joy_stick.UpdateAction(x, y)
    SkillIndicator.joy_stick_update(indicator, x, y)
  end
  
  self.v_has_joystick = true
  return true
end

function ui:check_joystick_guid()
  return self.v_is_joystick
end

function ui:_hide_frame_bg()
  self.v_bg1:SetActive(false)
  self.v_bg2:SetActive(false)
end

function ui:get_copy_obj()
  return self.v_copy_obj
end

function ui:get_pivot(idx)
  return self:get_rect_transform("Pivot_" .. idx, self.v_guide_frame)
end

function ui:get_frame_rect()
  return self.v_frame_rect
end

function ui:get_click_event()
  return self.v_click_cb
end

function ui:get_ctl_type()
  return self.v_ctl_type
end

function ui:set_complete()
  self.v_is_complete = true
end

function ui:_complete_step()
  if self.v_is_complete then
    return
  end
  if self.v_guider then
    self.v_is_complete = true
    self.v_guider:complete_step()
  end
end

function ui:can_break_guide()
  return self.v_click_mode ~= LONG_GUIDE_CLICK_MODE.SPEC_CLICK1 or self.v_can_break_guide
end

function ui:_response_key_down(msg)
  local input_code = msg.mm_x
  if self.v_input_mask[input_code] and self.v_click_cb then
    self.v_click_cb()
  end
end

function ui:_response_key_up(msg)
  local input_code = msg.mm_x
  if self.v_input_mask[input_code] and self.v_end_click_cb then
    self.v_end_click_cb()
  end
end

return ui
