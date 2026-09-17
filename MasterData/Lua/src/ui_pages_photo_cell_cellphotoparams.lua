local this = class("cellPhotoParams", G_UIModuleBase)
local paramTpl = L_GameTpl:getPhotographParamTpl()

function this.bind()
  return {txt_value = "", txtName = ""}
end

function this.methods()
  return {
    onValueChange = function(self, value)
      if not self.isInit then
        return
      end
      self:setVal(self.bind.id, value)
      self:refreshSliderUI()
      self.isDragging = true
    end,
    onDown = function(self)
      self.bindComponents.animator_slider:Play("Pressed")
    end,
    onUp = function(self)
      self.bindComponents.animator_slider:Play("Normal")
    end
  }
end

function this:init()
  self.mediator = L_PhotoManager:getMediator()
  self.paramDic = self.mediator.paramDic
  local defaultMin, defaultMax = self:getDefaultMinAndMax(self.bind.id)
  self.min = defaultMin
  self.max = defaultMax
  self.bindComponents.slider.minValue = defaultMin
  self.bindComponents.slider.maxValue = defaultMax
  self.bindComponents.slider.minViewValue = defaultMin
  local val = self:getDefaultVal(self.bind.id)
  self.bindComponents.slider:SetValueWithoutNotify(val)
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
  self.timer = Timer.repeated(0, self.update, self)
end

function this:show()
  local mediator = L_PhotoManager.mediator
  self.mediator = mediator
  local val = self:getDefaultVal(self.bind.id)
  self.bindComponents.slider:SetValueWithoutNotify(val)
  self:refreshSliderUI()
end

function this:refresh()
  local val = self:getDefaultVal(self.bind.id)
  self.bindComponents.slider:SetValueWithoutNotify(val)
  self:refreshSliderUI()
end

function this:setVal(id, val)
  L_PhotoManager:getMediator():setPhotoParmVal(id, val)
  local defaultMin, defaultMax = self:getDefaultMinAndMax(id)
  if tonumber(defaultMin) ~= 0 or tonumber(defaultMax) ~= 1 then
    self.bind.txt_value = string.format("%.0f", val)
  else
    self.bind.txt_value = string.format("%.0f", val * 100)
  end
end

function this:getDefaultMinAndMax(id)
  local tpl = paramTpl:getTplById(id)
  local min = paramTpl:getParamMin(tpl)
  local max = paramTpl:getParamMax(tpl)
  return min, max
end

function this:getDefaultVal(id)
  if self.bind.id == L_Const.photoParam.rotation then
    return self.mediator:getPhotoParmVal(self.bind.id)
  end
  local val = self.paramDic[id]
  if val == nil then
    local tpl = paramTpl:getTplById(id)
    local default = paramTpl:getParam(tpl)
    val = default
  end
  return val
end

function this:close()
  Timer.remove(self.timer)
  L_PhotoManager:removeListener(L_PhotoManager.event.photoTemplateChange, self.onEvent_photoTemplateChange, self)
end

function this:onEvent_photoTemplateChange()
  self:refresh()
end

function this:update()
  if self.isDragging then
    self.isDragging = false
    return
  end
  if self.bind.id == L_Const.photoParam.rotation and L_CommonUtil.isValid(self.bindComponents.slider) and self.bindComponents.slider.gameObject.activeInHierarchy then
    self.bindComponents.slider:SetValueWithoutNotify(self.mediator:getPhotoParmVal(self.bind.id))
    self:refreshSliderUI()
  end
  if self.bind.id == L_Const.photoParam.wideIntensity then
    self.bindComponents.slider:SetValueWithoutNotify(self.mediator:getPhotoParmVal(self.bind.id))
    self:refreshSliderUI()
  end
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
