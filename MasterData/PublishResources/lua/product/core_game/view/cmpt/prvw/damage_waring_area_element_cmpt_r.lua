_class("DamageWarningAreaElementComponent", Object)
DamageWarningAreaElementComponent = DamageWarningAreaElementComponent

function DamageWarningAreaElementComponent:Constructor(areaEntityID, entityConfigID)
  self._ownerEntityID = areaEntityID
  self._entityConfigID = entityConfigID
end

function DamageWarningAreaElementComponent:GetOwnerEntityID()
  return self._ownerEntityID
end

function DamageWarningAreaElementComponent:ClearOwnerEntityID()
  self._ownerEntityID = nil
  self._entityConfigID = nil
end

function DamageWarningAreaElementComponent:GetEntityConfigID()
  return self._entityConfigID
end

function Entity:DamageWarningAreaElement()
  return self:GetComponent(self.WEComponentsEnum.DamageWarningAreaElement)
end

function Entity:HasDamageWarningAreaElement()
  return self:HasComponent(self.WEComponentsEnum.DamageWarningAreaElement)
end

function Entity:AddDamageWarningAreaElement(areaEntityID)
  local index = self.WEComponentsEnum.DamageWarningAreaElement
  local component = DamageWarningAreaElementComponent:New(areaEntityID)
  self:AddComponent(index, component)
end

function Entity:ReplaceDamageWarningAreaElement(areaEntityID, entityConfigID)
  local index = self.WEComponentsEnum.DamageWarningAreaElement
  local component = DamageWarningAreaElementComponent:New(areaEntityID, entityConfigID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveDamageWarningAreaElement()
  if self:HasDamageWarningAreaElement() then
    self:RemoveComponent(self.WEComponentsEnum.DamageWarningAreaElement)
  end
end
