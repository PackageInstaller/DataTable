local this = class("modulePhotoLightSetting", G_UIModuleBase)

function this.bind()
  return {
    moduleColorPick = {
      moduleName = "pages/photo/submodule/moduleColorPick"
    },
    isActive_range = true,
    isActive_intensity = true,
    isActive_reset = true,
    isOn = false,
    value_intensity = 1,
    value_range = 10,
    isActive_block = false,
    isActive_togOn = false
  }
end

function this.methods()
  return {
    onValueChange_range = function(self, value)
      if not self.lightData then
        return
      end
      self:refreshRangeSlider(value)
      self.lightData:setRange(value)
      self:emit("setLightRange", value)
    end,
    onUp_range = function(self)
      self.bindComponents.anim_slider_range:Play("return")
      Timer.once(0.27, function()
        self.bindComponents.anim_slider_range:Play("Normal")
      end, self)
    end,
    onDown_range = function(self)
      self.bindComponents.anim_slider_range:Play("Pressed")
    end,
    onValueChange_intensity = function(self, value)
      if not self.lightData then
        return
      end
      self:refreshIntensitySlider(value)
      self.lightData:setIntensity(value)
      self:emit("setLightIntensity", value)
    end,
    onUp_intensity = function(self)
      self.bindComponents.anim_slider_intensity:Play("return")
      Timer.once(0.27, function()
        self.bindComponents.anim_slider_intensity:Play("Normal")
      end, self)
    end,
    onDown_intensity = function(self)
      self.bindComponents.anim_slider_intensity:Play("Pressed")
    end,
    onClick_reset = function(self)
      local data = self.lightData
      data:reset()
      self:initWithData(self.lightData)
      self:emit("setLightColor", self.lightData)
    end,
    onValueChange_isOn = function(self, isOn)
      if not self.lightData then
        return
      end
      self.lightData:setIsOn(isOn)
      self:emit("setLightOn", self.lightData.lightId, isOn)
    end,
    moduleColorPick = {
      onColorChange = function(self, color)
        if not self.lightData then
          return
        end
        self.lightData:setColor(color)
        self:emit("setLightColor", self.lightData)
      end
    }
  }
end

function this:initWithData(data)
  self.lightData = data
  self.bind.isOn = data.isOn
  self.modules.moduleColorPick:initColor(data.color)
  self:initLimit()
  self.bind.value_intensity = data.intensity
  self.bind.value_range = data.range
  self:refreshIntensitySlider(data.intensity)
  self:refreshRangeSlider(data.range)
end

function this:refreshIntensitySlider(value)
  local min = self.bindComponents.slider_intensity.minValue
  local max = self.bindComponents.slider_intensity.maxValue
  value = math.clamp(value, min, max)
  local percent = value / (max - min) * 100
  local v = math.round(percent)
  self.bindComponents.txt_intensity.text = tostring(v)
end

function this:refreshRangeSlider(value)
  local min = self.bindComponents.slider_range.minValue
  local max = self.bindComponents.slider_range.maxValue
  value = math.clamp(value, min, max)
  local percent = value / (max - min) * 100
  local v = math.round(percent)
  self.bindComponents.txt_range.text = tostring(v)
end

function this:initLimit()
  local min, max = self.lightData:getIntensityLimit()
  self.bindComponents.slider_intensity.minValue = min
  self.bindComponents.slider_intensity.maxValue = max
  self.lightData.intensity = math.clamp(self.lightData.intensity, min, max)
  min, max = self.lightData:getRangeLimit()
  self.bindComponents.slider_range.minValue = min
  self.bindComponents.slider_range.maxValue = max
  self.lightData.range = math.clamp(self.lightData.range, min, max)
end

function this:onDrag_light(screenPos)
  local cam = C_CameraManager.mainCamera
  local plane = Unity.Plane(cam.transform.forward, self.lightData.position)
  local ray = cam:ScreenPointToRay(C_Vector3(screenPos.x, screenPos.y, 0))
  local s, distance = plane:Raycast(ray)
  if s then
    local hitPoint = ray:GetPoint(distance)
    self.lightData:setPosition(hitPoint)
  end
end

function this:open()
  self.modules.moduleColorPick:onColorCircleChange(142, 158)
end

function this:refresh()
end

function this:close()
end

return this
