_class("FettersComponent", Object)
FettersComponent = FettersComponent

function FettersComponent:Constructor()
  self._fettersPetEntityID = -1
  self._fettersPrimaryType = PieceType.None
  self._isActive = false
end

function FettersComponent:SetFettersData(entityID, type)
  self._fettersPetEntityID = entityID
  self._fettersPrimaryType = type
end

function FettersComponent:SetActive(isActive)
  self._isActive = isActive
end

function FettersComponent:GetFettersPetEntityID()
  return self._fettersPetEntityID
end

function FettersComponent:GetFettersPrimaryType()
  return self._fettersPrimaryType
end

function FettersComponent:IsActive()
  return self._isActive
end

function Entity:Fetters()
  return self:GetComponent(self.WEComponentsEnum.Fetters)
end

function Entity:HasFetters()
  return self:HasComponent(self.WEComponentsEnum.Fetters)
end

function Entity:AddFetters()
  local index = self.WEComponentsEnum.Fetters
  local component = FettersComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceFetters()
  local index = self.WEComponentsEnum.Fetters
  local component = FettersComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveFetters()
  if self:HasFetters() then
    self:RemoveComponent(self.WEComponentsEnum.Fetters)
  end
end
