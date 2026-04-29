_class("BuffViewNotifyComponent", Object)
BuffViewNotifyComponent = BuffViewNotifyComponent

function BuffViewNotifyComponent:Constructor(notifyType, params)
  self._notifyType = notifyType
  self._params = params
end

function BuffViewNotifyComponent:GetNotifyType()
  return self._notifyType
end

function BuffViewNotifyComponent:GetParams()
  return self._params
end

function Entity:BuffViewNotify()
  return self:GetComponent(self.WEComponentsEnum.BuffViewNotify)
end

function Entity:NotifyBuffView(notifyType, params)
  local component = BuffViewNotifyComponent:New(notifyType, params)
  self:ReplaceComponent(self.WEComponentsEnum.BuffViewNotify, component)
end

function Entity:RemoveBuffViewNotify()
  if self:BuffViewNotify() then
    self:RemoveComponent(self.WEComponentsEnum.BuffViewNotify)
  end
end
