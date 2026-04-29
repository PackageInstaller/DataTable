_class("PickUpArrowComponent", Object)

function PickUpArrowComponent:Constructor()
end

function PickUpArrowComponent:WEC_PostInitialize(owner)
end

function PickUpArrowComponent:WEC_PostRemoved()
end

function Entity:PickUpArrow()
  return self:GetComponent(self.WEComponentsEnum.PickUpArrow)
end

function Entity:HasPickUpArrow()
  return self:HasComponent(self.WEComponentsEnum.PickUpArrow)
end

function Entity:AddPickUpArrow()
  local index = self.WEComponentsEnum.PickUpArrow
  local component = PickUpArrowComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePickUpArrow()
  local index = self.WEComponentsEnum.PickUpArrow
  local component = PickUpArrowComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePickUpArrow()
  if self:HasPickUpArrow() then
    self:RemoveComponent(self.WEComponentsEnum.PickUpArrow)
  end
end
