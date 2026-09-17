local this = class("modulePhotoGroup_wind", require("ui.pages.photo.group.modulePhotoGroup_base"))

function this.bind()
  return {txtForce = ""}
end

function this.methods()
  return {
    onValueChanged_force = function(self, val)
      self:setVal(L_Const.photoParam.windForce, val)
      if self.bindComponents.slider.value <= 0.9 then
        if self.ooo then
          self.bindComponents.imgDirAnimation:Stop()
          self.ooo = false
        end
      elseif not self.ooo then
        self.ooo = true
        self.bindComponents.imgDirAnimation:Play("anim_pagephoto_pointer")
      end
    end,
    onDown_slider = function(self)
      self.bindComponents.animator_slider:Play("Pressed")
    end,
    onUp_slider = function(self)
      self.bindComponents.animator_slider:Play("return")
      Timer.once(0.27, function()
        self.bindComponents.animator_slider:Play("Normal")
      end, self)
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end,
    onClickReset = function(self)
      self:resetParam()
    end
  }
end

function this:open()
  L_PhotoManager:addListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
  self:bindScreenTouch("+")
  local tpl = self.paramTpl:getTplById(L_Const.photoParam.windForce)
  local name = self.paramTpl:getName(tpl)
  self.bind.txtForce = name
  self:refreshSliderArea(L_Const.photoParam.windForce)
  self:initWindParam()
  self:refreshUI()
end

function this:show()
  L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Wind")
  if self.bindComponents.slider.value <= 0.9 then
    self.bindComponents.imgDirAnimation:Rewind()
    self.bindComponents.imgDirAnimation:Stop()
    self.ooo = false
  elseif not self.ooo then
    self.ooo = true
    self.bindComponents.imgDirAnimation:Play("anim_pagephoto_pointer")
  end
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
  self:bindScreenTouch("-")
end

function this:onEvent_photoTemplateChange()
  self:initWindParam()
  self:refreshUI()
end

function this:initWindParam()
  self.windSou = {}
  local wind = C_RealWeather.GetWeatherWind()
  if wind then
    local dir = wind:GetDirection()
    local power = wind:GetPower()
    self.oriDir = dir
    self.oriPower = power
    self.windSou[L_Const.photoParam.windDirection] = dir
    self.windSou[L_Const.photoParam.windForce] = power
  end
end

function this:resetParam()
  local wind = C_RealWeather.GetWeatherWind()
  if wind and self.oriDir and self.oriPower then
    local dir = self.oriDir
    local power = self.oriPower
    self.windSou[L_Const.photoParam.windDirection] = dir
    self.windSou[L_Const.photoParam.windForce] = power
    self:setVal(L_Const.photoParam.windForce, power * 50)
    self:setVal(L_Const.photoParam.windDirection, dir)
  end
  self:refreshUI()
end

function this:refreshUI()
  local dir = self.windSou[L_Const.photoParam.windDirection]
  if dir then
    local camera = C_CameraManager.mainCamera
    local camRot = L_Vector3.getRot(camera.transform)
    self.bindComponents.rTransDir:SetLocalEulerAngles(0, 0, -dir.y + camRot.y + 90)
  end
  local power = self.windSou[L_Const.photoParam.windForce]
  if power then
    self.bindComponents.slider.value = power * 50
  end
end

function this:setVal(id, val)
  local wind = C_RealWeather.GetWeatherWind()
  if wind == nil then
    return
  end
  if id == L_Const.photoParam.windDirection then
    wind:SetDirection(val)
  elseif id == L_Const.photoParam.windForce then
    C_RealWeather.SetPower(val / 50)
    local percent = math.clamp(val / 50)
    local material = self.bindComponents.material_wind:GetComponent(typeof(C_MeshRenderer)).materials[0]
    material:SetFloat("_Intensity", math.lerp(0.02, 0.1, percent))
  end
end

function this:bindScreenTouch(sign)
  self.onDragStartHandle = self.onDragStartHandle or L_CommonUtil.handle(self.onTouch_dragStart, self)
  self.onDragHandle = self.onDragHandle or L_CommonUtil.handle(self.onTouch_drag, self)
  self.onDragEndHandle = self.onDragEndHandle or L_CommonUtil.handle(self.onTouch_dragEnd, self)
  C_ScreenTouch.OnUI_DragStart(sign, self.onDragStartHandle)
  C_ScreenTouch.OnUI_Drag(sign, self.onDragHandle)
  C_ScreenTouch.OnUI_DragEnd(sign, self.onDragEndHandle)
end

function this:onTouch_dragStart(gesture)
  self.inDir = gesture.go == self.bindComponents.rTransDrag.gameObject
  if self.inDir then
    L_PhotoManager:sendEvent(L_PhotoManager.event.changeStartAlpha)
  end
end

function this:onTouch_dragEnd()
  if self.timer1 then
    Timer.remove(self.timer1)
    self.timer1 = nil
  end
  self.audioChangePlaying = false
  L_PhotoManager:sendEvent(L_PhotoManager.event.changeEndAlpha)
end

function this:onTouch_drag()
  if not self.inDir then
    return
  end
  local dir = self.bindComponents.rTransDir
  local currentMousePos = C_CameraManager.uiCamera:ScreenToViewportPoint(CS.UnityEngine.Input.mousePosition)
  local screenPos = C_CameraManager.uiCamera:WorldToViewportPoint(dir.position)
  local v3 = (currentMousePos - screenPos).normalized
  local angle = Mathf.Atan2(v3.y, v3.x) * Mathf.Rad2Deg
  local moveDistance = self.lastMousePos == nil and 1 or L_Vector3.distance(self.lastMousePos, currentMousePos)
  if 0.1 < moveDistance then
    local strAudioName = "Play_SFX_System_UI_Photograph_Choose_Wind_Change"
    if not self.audioChangePlaying then
      L_AudioUtil.playSound(strAudioName)
      self.audioChangePlaying = true
      self.timer1 = Timer.once(0.06, function()
        self.audioChangePlaying = false
      end, self)
    end
    self.lastMousePos = currentMousePos
  end
  dir:SetLocalEulerAngles(0, 0, angle)
  local camera = C_CameraManager.mainCamera
  local camRot = L_Vector3.getRot(camera.transform)
  self:setVal(L_Const.photoParam.windDirection, L_Vector3.getTemp(0, -angle + camRot.y + 90, 0))
end

return this
