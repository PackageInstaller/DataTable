_class("TrapAurasOutlineComponent", Object)
TrapAurasOutlineComponent = TrapAurasOutlineComponent

function TrapAurasOutlineComponent:Constructor()
end

function Entity:TrapAurasOutlineComponent()
  return self:GetComponent(self.WEComponentsEnum.TrapAurasOutline)
end

function Entity:HasTrapAurasOutline()
  return self:HasComponent(self.WEComponentsEnum.TrapAurasOutline)
end

function Entity:AddTrapAurasOutline()
  local index = self.WEComponentsEnum.TrapAurasOutline
  local component = TrapAurasOutlineComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceTrapAurasOutline()
  local index = self.WEComponentsEnum.TrapAurasOutline
  local component = TrapAurasOutlineComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrapAurasOutline()
  if self:HasTrapAurasOutline() then
    self:RemoveComponent(self.WEComponentsEnum.TrapAurasOutline)
  end
end
