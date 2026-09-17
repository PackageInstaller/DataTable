local this = class("cellPhotoColorSlider", G_UIModuleBase)
local IDTOFIELD = L_PhotoManager.IDTOFIELD
local paramTpl = L_GameTpl:getPhotographParamTpl()

function this.bind()
  return {
    txt_value = "",
    txtName = "",
    goSaturation = false,
    goTemperature = false,
    goHue = false
  }
end

function this.methods()
  return {
    onValueChange = function(self, value)
      if not self.isInit then
        return
      end
      self:setVal(self.bind.id, value)
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
  self.mediator = L_PhotoManager:getMediator()
  local defaultMin, defaultMax = self:getDefaultMinAndMax(self.bind.id)
  self.min = defaultMin
  self.max = defaultMax
  self.bindComponents.slider.minValue = defaultMin
  self.bindComponents.slider.maxValue = defaultMax
  local val = self:getDefaultVal(self.bind.id)
  self.bindComponents.slider.value = val
  self.isInit = true
end

function this:refreshSliderUI()
  local min = self.min
  local max = self.max
  local value = self.bindComponents.slider.value
  local percent = (value - min) / (max - min) * 100
  self.bind.txt_value = tostring(math.floor(percent))
end

function this:open()
  self:init()
  L_PhotoManager:addListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
end

function this:show()
  local mediator = L_PhotoManager.mediator
  self.mediator = mediator
  self.bindComponents.slider:SetValueWithoutNotify(self:getDefaultVal(self.bind.id))
  self:refreshSliderUI()
end

function this:refresh()
  self.bindComponents.slider:SetValueWithoutNotify(self:getDefaultVal(self.bind.id))
  self:refreshSliderUI()
  self.bind.goSaturation = self.bind.id == L_Const.photoParam.saturation
  self.bind.goTemperature = self.bind.id == L_Const.photoParam.temperature
  self.bind.goHue = self.bind.id == L_Const.photoParam.whitebalancetint
end

function this:setVal(id, val)
  local filter = L_PhotoManager:getMediator().photoFilter
  self.bind.txt_value = string.format("%.0f", val * 50)
  filter[IDTOFIELD[id]] = val
end

function this:getDefaultMinAndMax(id)
  local tpl = paramTpl:getTplById(id)
  local min = paramTpl:getParamMin(tpl)
  local max = paramTpl:getParamMax(tpl)
  return min, max
end

function this:getDefaultVal(id)
  local filter = L_PhotoManager:getMediator().photoFilter
  local val = filter[IDTOFIELD[id]]
  return val
end

function this:close()
  L_PhotoManager:removeListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
end

function this:onEvent_photoTemplateChange()
  self:refresh()
end

function this:resetVal()
  local tpl = paramTpl:getTplById(self.bind.id)
  if not tpl then
    return
  end
  local default = paramTpl:getParam(tpl)
  if self.isBind and self.bindComponents then
    self.bindComponents.slider.value = default
  end
end

return this
