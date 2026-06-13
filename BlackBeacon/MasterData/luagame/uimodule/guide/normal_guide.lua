local Base = require("ui.uiobject")
local GuideHelper = require("uimodule.guide.guide_helper")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local ui = Util.create_child_mt(Base)
local UnityDestroy = _ENV.UnityDestroy
local TouchManager = CS.TouchManager
local CTL_TYPE = {
  AREA_ACT = 1,
  AREA_NO_ACT = 2,
  ACT = 3,
  NO_ACT = 4
}

function ui:ui_finish_load(...)
  self.v_input_mask = {}
  self.v_guide_frame = self.v_object
  self.v_frame_rect = self:get_rect_transform(nil, self.v_guide_frame)
end

function ui:ui_on_show(guider, param, ...)
  self.v_guider = guider
  self.v_update_count = 0
  UtilTable.clear_map(self.v_input_mask)
  self:_copy_ui_control(param.ui_name, param.control_path, param.hide_frame, param.ignore_act)
  TouchManager.Instance.ArrowActivated = false
  if UNITY_EDITOR or SDKManager:is_google_play_games() or UNITY_STANDALONE_WIN then
    self:bind_auto_mq(Const.MSG_KEY_DOWN, self._response_key_down, self)
    self:bind_auto_mq(Const.MSG_KEY_UP, self._response_key_up, self)
  end
end

function ui:ui_on_update()
  if self.v_copy_tra and not self.v_copy_tra:IsNull() and self.v_update_count < 3 then
    self.v_copy_tra:SetLocalPositionA(0, 0, 0)
    self.v_update_count = self.v_update_count + 1
    self.v_copy_obj:SetActive(true)
  end
end

function ui:update_cope_obj_location()
  if self.v_copy_obj and self.v_target_obj and self.v_frame_rect and self.v_frame_rect then
    if self.v_guide_area then
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_guide_area, self.v_frame_rect)
    else
      GuideHelper.adjust_frame_rect(self, self.v_copy_obj, self.v_target_obj, self.v_frame_rect)
    end
  end
end

function ui:ui_on_hide()
  if self.v_copy_obj then
    UnityDestroy(self.v_copy_obj)
    self.v_copy_obj = nil
  end
  self:_complete_step()
  self.v_guider = nil
  self.v_is_complete = nil
  self.v_target_obj = nil
  self.v_guide_area = nil
  TouchManager.Instance.ArrowActivated = true
end

function ui:_copy_ui_control(ui_name, ctr_path, hide_frame, ignore_act)
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
    self:set_enable(false)
    self.v_parent_ui:ui_hide()
    return
  end
  GuideHelper._reset_joystick(target_obj)
  GuideHelper._reset_joystick_pos(target_obj)
  self.v_copy_obj = UnityGameObject.Instantiate(target_obj, self.v_guide_frame.transform).gameObject
  local canvas_group = self.v_copy_obj:GetComponent(typeof(UnityEngine.CanvasGroup))
  if canvas_group and canvas_group:IsNull() == false then
    canvas_group.alpha = 1
  end
  GuideHelper.copy_image(target_obj, self.v_copy_obj)
  self.v_copy_obj:SetActive(false)
  local has_tween = GuideHelper._destroy_tween(self.v_copy_obj)
  self.v_copy_obj:SetActive(not has_tween)
  self.v_copy_tra = self.v_copy_obj.transform
  local scale_x = math.abs(self.v_copy_tra.localScale.x)
  local scale_y = math.abs(self.v_copy_tra.localScale.y)
  local scale_z = math.abs(self.v_copy_tra.localScale.z)
  self.v_copy_tra.localRotation = Quat.Euler(0, 0, 0)
  self.v_copy_tra.localScale = Vec3.New(scale_x, scale_y, scale_z)
  if guide_area then
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, guide_area, self.v_frame_rect)
  else
    GuideHelper.adjust_frame_rect(self, self.v_copy_obj, target_obj, self.v_frame_rect)
  end
  self:_get_ctl_event(target_obj, hide_frame, guide_area, ignore_act)
  self.v_guide_frame:SetActive(not hide_frame)
  local input_code_list = GuideHelper.uiwidget_to_inputcode[ctr_path]
  if input_code_list then
    for _, input_code in ipairs(input_code_list) do
      self.v_input_mask[input_code] = true
    end
  end
end

function ui:set_canvas_group_alpha(value)
  local canvas_group = self.v_copy_obj:GetComponent(typeof(UnityEngine.CanvasGroup))
  if not canvas_group or canvas_group:IsNull() ~= false then
    canvas_group = self.v_copy_obj:AddComponent(typeof(UnityEngine.CanvasGroup))
  end
  canvas_group.alpha = value
end

function ui:_get_ctl_event(target_obj, hide_frame, guide_area, ignore_act)
  local btn = self:get_button(nil, self.v_copy_obj)
  local tog = self:get_toggle(nil, self.v_copy_obj)
  local btnex = self:get_button_ex(nil, self.v_copy_obj)
  self.v_target_cb = nil
  self.v_end_click_cb = nil
  
  function self.v_click_cb(...)
    self.v_parent_ui:resume_game()
    if self.v_target_cb then
      self.v_target_cb:Invoke(...)
    end
    if self.v_end_click_cb then
      self.v_end_click_cb()
    else
      self:_complete_step()
    end
  end
  
  if btnex and not hide_frame then
    local component = self:get_button_ex(nil, target_obj)
    self.v_target_cb = component.onTouchBegan
    
    function self.v_end_click_cb()
      component.onTouchEnded:Invoke()
      self.v_guider:complete_step()
    end
    
    self:set_button_ex_listener(btnex, self.v_click_cb, self.v_end_click_cb)
  elseif btn and not hide_frame then
    self.v_target_cb = self:get_button(nil, target_obj).onClick
    self:set_button_listener(btn, self.v_click_cb)
    self.v_copy_obj:SetActive(not guide_area)
  elseif tog and not hide_frame then
    tog.group = nil
    tog.isOn = false
    tog.interactable = true
    self.v_target_cb = self:get_toggle(nil, target_obj).onValueChanged
    self:set_toggle_listener(tog, self.v_click_cb)
    self.v_copy_obj:SetActive(not guide_area)
  end
  if ignore_act then
    self.v_target_cb = nil
  end
  if btn or tog or btnex then
    self.v_ctl_type = guide_area and CTL_TYPE.AREA_ACT or CTL_TYPE.ACT
  else
    self.v_ctl_type = guide_area and CTL_TYPE.AREA_NO_ACT or CTL_TYPE.NO_ACT
    self.v_click_cb = nil
  end
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

function ui:_complete_step()
  if self.v_is_complete then
    return
  end
  if self.v_guider then
    self.v_is_complete = true
    self.v_guider:complete_step()
  end
end

function ui:set_complete()
  self.v_is_complete = true
end

function ui:_response_key_down(msg)
  local input_code = msg.mm_x
  if self.v_input_mask[input_code] and self:get_click_event() then
    self.v_click_cb()
  end
end

function ui:_response_key_up(msg)
  local input_code = msg.mm_x
  if self.v_input_mask[input_code] then
  end
end

return ui
