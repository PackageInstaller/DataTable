local this = class("cellPhotoParamSlider", G_UIModuleBase)

function this.bind()
  return {txt_title = "", txt_value = ""}
end

function this.methods()
  return {
    onValueChange = function(self, value)
      if not self.isInit then
        return
      end
      self.mediator:setLightParam(self.paramType, value)
      self:refreshSliderUI()
    end,
    onDown = function(self)
      self.bindComponents.animator_slider:Play("Pressed")
    end,
    onUp = function(self)
      self.bindComponents.animator_slider:Play("return")
      Timer.once(0.27, function()
        self.bindComponents.animator_slider:Play("Normal")
      end, self)
    end
  }
end

function this:init()
  self.configData = self.bind.data
  self.isInit = true
  self.paramType = self.configData.id
  self.bind.txt_title = self.configData.name
  self.bindComponents.slider.minValue = self.configData.min
  self.bindComponents.slider.maxValue = self.configData.max
end

function this:refreshSliderUI()
  local min = self.configData.min
  local max = self.configData.max
  local value = self.bindComponents.slider.value
  local percent = (value - min) / (max - min) * 100
  self.bind.txt_value = tostring(math.floor(percent))
end

function this:open()
  self:init()
end

function this:show()
  if not self.isBind then
    return
  end
  local mediator = L_PhotoManager.mediator
  self.mediator = mediator
  self.mediator = mediator
  local paramController = mediator:getLightParam()
  local val = paramController.params[self.paramType] or 0
  self.bindComponents.slider:SetValueWithoutNotify(val)
  self:refreshSliderUI()
end

function this:refresh()
  local mediator = L_PhotoManager.mediator
  local paramController = mediator:getLightParam()
  local val = paramController.params[self.paramType] or 0
  self.bindComponents.slider:SetValueWithoutNotify(val)
  self:refreshSliderUI()
end

function this:close()
end

return this
