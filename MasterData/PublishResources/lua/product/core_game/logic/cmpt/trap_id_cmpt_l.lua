_class("TrapIDComponent", Object)
TrapIDComponent = TrapIDComponent

function TrapIDComponent:Constructor(trapID)
  self._trapID = trapID
end

function TrapIDComponent:GetTrapID()
  return self._trapID
end

function Entity:TrapID()
  return self:GetComponent(self.WEComponentsEnum.TrapID)
end

function Entity:HasTrapID()
  return self:HasComponent(self.WEComponentsEnum.TrapID)
end

function Entity:AddTrapID()
  local index = self.WEComponentsEnum.TrapID
  local component = TrapIDComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTrapID(trapID)
  local index = self.WEComponentsEnum.TrapID
  local component = TrapIDComponent:New(trapID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrapID()
  if self:HasTrapID() then
    self:RemoveComponent(self.WEComponentsEnum.TrapID)
  end
end
