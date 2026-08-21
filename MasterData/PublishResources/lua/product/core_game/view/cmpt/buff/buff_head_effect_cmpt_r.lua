_class("BuffHeadEffectComponent", Object)
BuffHeadEffectComponent = BuffHeadEffectComponent

function BuffHeadEffectComponent:Constructor(buffViewInstance)
  self._buffViewInstance = buffViewInstance
end

function BuffHeadEffectComponent:GetBuffViewInstance()
  return self._buffViewInstance
end

function BuffHeadEffectComponent:SetBuffViewInstance(buff)
  self._buffViewInstance = buff
end

function Entity:BuffHeadEffect()
  return self:GetComponent(self.WEComponentsEnum.BuffHeadEffect)
end

function Entity:AddBuffHeadEffect(buffv)
  local index = self.WEComponentsEnum.BuffHeadEffect
  local component = BuffHeadEffectComponent:New(buffv)
  self:AddComponent(index, component)
end

function Entity:ReplaceBuffHeadEffect(buffv)
  local index = self.WEComponentsEnum.BuffHeadEffect
  local component = self:GetComponent(index)
  if not component then
    component = BuffHeadEffectComponent:New(buffv)
  else
    component:SetBuffViewInstance(buffv)
  end
  self:ReplaceComponent(index, component)
end

function Entity:RemoveBuffHeadEffect()
  if self:BuffHeadEffect() then
    self:RemoveComponent(self.WEComponentsEnum.BuffHeadEffect)
  end
end
