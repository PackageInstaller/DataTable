local this = class("modulePhotoGroup_base", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.paramTpl = L_GameTpl:getPhotographParamTpl()
end

function this:toBind(uiBinding)
  if self.isShow == nil then
    this.super.toBind(self, uiBinding)
  else
    self:toShow()
  end
end

function this:unBind(uiBinding)
  if self.isShow == nil then
    this.super.unBind(self, uiBinding)
  else
    self:toHide()
  end
end

function this:open()
end

function this:close()
end

function this:resetVal(id)
  local tpl = self.paramTpl:getTplById(id)
  local default = self.paramTpl:getParam(tpl)
  self.bindComponents.slider.value = default
end

function this:initGroupList(groupId)
  local list = self.paramTpl:getListByGroupId(groupId)
  local content = {}
  for index, tpl in ipairs(list) do
    local data = {}
    if not C_PhotoPlayUtil:IsMainControlInPLatform() or tpl.id ~= L_Const.photoParam.player then
      self:packList(data, tpl, index)
      table.insert(content, data)
    end
  end
  self.bind.list:clear()
  self.bind.list:insert_array(content)
  return content
end

function this:packList(data, tpl, index)
  data.id = self.paramTpl:getId(tpl)
  data.txtName = self.paramTpl:getName(tpl)
  data.tabGroup = self.bindComponents.tabGroup
  data.imgIcon = self.paramTpl:getIcon(tpl)
end

function this:refreshSliderArea(id)
  local tpl = self.paramTpl:getTplById(id)
  local slider = self.bindComponents.slider
  local val = self:getDefaultVal(id)
  slider.minValue = self.paramTpl:getParamMin(tpl)
  slider.maxValue = self.paramTpl:getParamMax(tpl)
  slider.minViewValue = slider.minValue
  slider.value = val
end

function this:refreshDefaultSignPos(id)
  if self.sliderWidth == nil then
    local parent = self.bindComponents.defaultSign.parent
    self.sliderWidth = parent.sizeDelta.x
  end
  local defaultPos = self:getDefaultPos(id, self.sliderWidth)
  L_Vector3.setAnchored(self.bindComponents.defaultSign, L_Vector3.getTemp(defaultPos, 0, 0))
end

function this:getDefaultVal(id)
  local tpl = self.paramTpl:getTplById(id)
  local default = self.paramTpl:getParam(tpl)
  return default
end

function this:getDefaultMinAndMax(id)
  local tpl = self.paramTpl:getTplById(id)
  local min = self.paramTpl:getParamMin(tpl)
  local max = self.paramTpl:getParamMax(tpl)
  return min, max
end

function this:getDefaultPos(id, width)
  local tpl = self.paramTpl:getTplById(id)
  local default = self.paramTpl:getParam(tpl)
  local min = self.paramTpl:getParamMin(tpl)
  local max = self.paramTpl:getParamMax(tpl)
  local v = (default - min) / (max - min)
  v = math.clamp(v, 0, 1)
  return v * width
end

function this:getUseArgs(paramStr)
  local args = L_PhotoManager:getArgsByCurUseData(paramStr)
  return args
end

function this:hideGroup()
  L_PhotoManager:sendEvent(L_PhotoManager.event.hideGroup)
end

return this
