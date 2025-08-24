local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local UnityRawImage = UnityEngine.UI.RawImage
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local MODEL_PARAM = MODEL_CONFIG.UI_TESTSHOW_MODEL_PARAM
local Math = require("base.mathx")
local TypeCamera = typeof(UnityEngine.Camera)
local CAMERA_STATE = {
  NORMAL = 1,
  FAR = 2,
  NEAR = 3
}
local MIN_CONTENT_Y = 0
local MAX_CONTENT_Y = 0.7
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnCharRet", function()
    self:ui_hide()
  end)
  self:set_button("BtnSure", function()
    self:click_sure_btn()
  end)
  local slider = self.v_uicompents.CharPos_sld
  self:set_scrollrect_listener(slider, function()
    if not self.v_uicompents.CharPos_sld.gameObject.activeSelf then
      return
    end
    if self.v_model_view then
      local y = Math.lerp_number(MIN_CONTENT_Y, MAX_CONTENT_Y, slider.value)
      self.v_model_view:change_content_pos_y(y)
    end
  end)
  self:set_button("CharScaleBtn", function()
    self:click_scale_btn()
  end)
end

function ui:ui_on_show()
  self:register_drag()
  self.v_uiobjects.CharPos:SetActive(false)
  local slider = self.v_uicompents.CharPos_sld
  slider.value = 0
  self.v_camera_state = CAMERA_STATE.FAR
  Util.custom_enable_keyword("_LockWidthInViewByCode", true)
end

function ui:register_drag()
  local drag_obj = self.v_uiobjects.ShowChar
  Util.set_drag(drag_obj, self.v_ui_root, function(x, _)
    if not self.v_model_view then
      return
    end
    self.v_model_view:change_content_angle_y(x)
  end)
end

function ui:ui_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:ui_on_hide()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
  Util.custom_enable_keyword("_LockWidthInViewByCode", false)
end

function ui:click_sure_btn()
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME, nil, nil, nil, nil, "UITestModelRtView")
  end
  local input_obj = self.v_uicompents.ModText_rect
  local input = Util.get_component(nil, input_obj, UnityEngine.UI.InputField)
  local model_id = input.text
  if not model_id or "" == model_id then
    return
  end
  local camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
  self.v_model_view:set_camera_param(camera_param)
  self.v_model_view:load_test_model(model_id)
  self:update_scene_model()
end

function ui:click_scale_btn()
  if not self.v_model_view then
    return
  end
  if self.v_camera_state == CAMERA_STATE.FAR then
    self.v_camera_state = CAMERA_STATE.NEAR
  elseif self.v_camera_state == CAMERA_STATE.NEAR then
    self.v_camera_state = CAMERA_STATE.FAR
  end
  self:refresh_scale_btn()
  self:update_scene_model()
end

function ui:update_scene_model()
  local camera_param = {
    pos_x = 0,
    pos_y = 0.86,
    pos_z = -2.6,
    rot_x = 0,
    rot_y = 0,
    rot_z = 0
  }
  local camera_size = 0.9
  if self.v_camera_state == CAMERA_STATE.FAR then
  elseif self.v_camera_state == CAMERA_STATE.NEAR then
    camera_param = {
      pos_x = 0,
      pos_y = 1.16,
      pos_z = -1.5,
      rot_x = 0,
      rot_y = 0,
      rot_z = 0
    }
    camera_size = 0.5
  end
  self.v_model_view:update_camera_param(camera_param, true)
  self.v_model_view:change_content_pos_y(0)
  local camera = self.v_model_view:get_camera()
  local camera_component = camera:GetComponent(TypeCamera)
  camera_component.orthographicSize = camera_size
end

function ui:refresh_scale_btn()
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local slider = ucom.CharPos_sld
  slider.gameObject:SetActive(self.v_camera_state == CAMERA_STATE.NEAR)
  uobj.IconNear:SetActive(self.v_camera_state == CAMERA_STATE.FAR)
  uobj.IconFar:SetActive(self.v_camera_state == CAMERA_STATE.NEAR)
  local scale_txt = self.v_camera_state == CAMERA_STATE.NEAR and Util.format_str("远景") or Util.format_str("近景")
  ucom.ScaleText_txt.text = scale_txt
  slider.value = 0
end

return ui
