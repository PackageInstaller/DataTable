_class("BodyAreaComponent", Object)
BodyAreaComponent = BodyAreaComponent

function BodyAreaComponent:Constructor(area)
  self._area = area
end

function BodyAreaComponent:SetArea(area)
  self._area = area
end

function BodyAreaComponent:GetArea()
  return self._area
end

function BodyAreaComponent:GetAreaCount()
  return #self._area
end

function BodyAreaComponent:SetPreviewArea(previewArea)
  self._previewArea = previewArea
end

function BodyAreaComponent:GetPreviewArea()
  return self._previewArea
end

function Entity:BodyArea()
  return self:GetComponent(self.WEComponentsEnum.BodyArea)
end

function Entity:HasBodyArea()
  return self:HasComponent(self.WEComponentsEnum.BodyArea)
end

function Entity:AddBodyArea(area)
  local index = self.WEComponentsEnum.BodyArea
  local component = BodyAreaComponent:New(area)
  self:AddComponent(index, component)
end

function Entity:ReplaceBodyArea(area)
  local index = self.WEComponentsEnum.BodyArea
  local component = BodyAreaComponent:New(area)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveBodyArea()
  if self:HasBodyArea() then
    self:RemoveComponent(self.WEComponentsEnum.BodyArea)
  end
end
