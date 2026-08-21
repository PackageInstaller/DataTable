_class("TrapAreaElementComponent", Object)
TrapAreaElementComponent = TrapAreaElementComponent

function Entity:TrapAreaElement()
  return self:GetComponent(self.WEComponentsEnum.TrapAreaElement)
end

function Entity:HasTrapAreaElement()
  return self:HasComponent(self.WEComponentsEnum.TrapAreaElement)
end

function Entity:AddTrapAreaElement(areaEntityID)
  local index = self.WEComponentsEnum.TrapAreaElement
  local component = TrapAreaElementComponent:New(areaEntityID)
  self:AddComponent(index, component)
end

function Entity:ReplaceTrapAreaElement(areaEntityID)
  local index = self.WEComponentsEnum.TrapAreaElement
  local component = TrapAreaElementComponent:New(areaEntityID)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTrapAreaElement()
  if self:HasTrapAreaElement() then
    self:RemoveComponent(self.WEComponentsEnum.TrapAreaElement)
  end
end
