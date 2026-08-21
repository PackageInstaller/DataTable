_class("DeadFlagComponent", Object)

function DeadFlagComponent:Constructor()
end

function DeadFlagComponent:SetDeadDrop(deadDrop)
  self._deadDrop = deadDrop
end

function DeadFlagComponent:GetDeadDrop()
  return self._deadDrop
end

function Entity:DeadFlag()
  return self:GetComponent(self.WEComponentsEnum.DeadFlag)
end

function Entity:HasDeadFlag()
  return self:HasComponent(self.WEComponentsEnum.DeadFlag)
end

function Entity:AddDeadFlag()
  local index = self.WEComponentsEnum.DeadFlag
  local component = DeadFlagComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceDeadFlag()
  local index = self.WEComponentsEnum.DeadFlag
  local component = DeadFlagComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveDeadFlag()
  if self:HasDeadFlag() then
    self:RemoveComponent(self.WEComponentsEnum.DeadFlag)
  end
end
