_class("PhantomComponent", Object)
PhantomComponent = PhantomComponent

function PhantomComponent:Constructor(ownerID)
  self._ownerID = ownerID
end

function PhantomComponent:GetOwnerEntityID()
  return self._ownerID
end

function Entity:PhantomComponent()
  return self:GetComponent(self.WEComponentsEnum.Phantom)
end

function Entity:AddPhantomComponent(ownerID)
  local index = self.WEComponentsEnum.Phantom
  local component = PhantomComponent:New(ownerID)
  self:AddComponent(index, component)
end

function Entity:HasPhantomComponent()
  return self:HasComponent(self.WEComponentsEnum.Phantom)
end

function Entity:RemovePhantomComponent()
  if self:HasPhantomComponent() then
    self:RemoveComponent(self.WEComponentsEnum.Phantom)
  end
end
