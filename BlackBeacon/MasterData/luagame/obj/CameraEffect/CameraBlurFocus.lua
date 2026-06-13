local TypeCameraFocusBlur = typeof(CS.Game.CameraFocusBlur)
local Layer = require("utils.layer")
local Math = require("base.mathx")
local _clamp = Math.Clamp
local _lerp = Math.lerp_number
local _abs = math.abs
local M = Util.create_class()

function M:_init(camera_lua)
  self.v_camera = camera_lua
  self.v_camera_obj = camera_lua.v_camera_obj
end

function M:on_release()
end

function M:late_update()
end

function M:set_blur_focus(radius, iteration, downScaling, time)
  if not self.v_camera_blur_focus then
    self.v_camera_blur_focus = self.v_camera_obj:GetComponent(TypeCameraFocusBlur)
  end
  
  local function callback()
    if Global.hero and radius < 0 then
      Global.hero:set_layer(Layer.Layer.Character)
    end
  end
  
  if Global.hero and radius >= 0 then
    Global.hero:set_layer(Layer.Layer.BlurFocus)
  end
  self.v_camera_blur_focus:SetBlurFocus(radius, iteration, downScaling, time, callback)
end

return M
