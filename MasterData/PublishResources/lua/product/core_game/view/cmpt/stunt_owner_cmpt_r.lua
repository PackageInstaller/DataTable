_class("StuntOwnerComponent", Object)
StuntOwnerComponent = StuntOwnerComponent

function StuntOwnerComponent:Constructor()
  self._stunts = {}
end

function StuntOwnerComponent:AddStunt(tag, e)
  self._stunts[tag] = e
end

function StuntOwnerComponent:RemoveStunt(tag)
  local e = self._stunts[tag]
  e:GetOwnerWorld():DestroyEntity(e)
  self._stunts[tag] = nil
end

function StuntOwnerComponent:GetStuntByTag(tag)
  return self._stunts[tag]
end

function Entity:StuntOwnerComponent()
  return self:GetComponent(self.WEComponentsEnum.StuntOwner)
end

function Entity:HasStuntOwnerComponent()
  return self:HasComponent(self.WEComponentsEnum.StuntOwner)
end

function Entity:AddStuntOwnerComponent()
  local index = self.WEComponentsEnum.StuntOwner
  local component = StuntOwnerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceStuntOwnerComponent()
  local index = self.WEComponentsEnum.StuntOwner
  local component = StuntOwnerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveStuntOwnerComponent()
  if self:HasStuntOwnerComponent() then
    self:RemoveComponent(self.WEComponentsEnum.StuntOwner)
  end
end
