_class("AlignmentComponent", Object)
AlignmentComponent = AlignmentComponent

function AlignmentComponent:Constructor(type)
  self._alignmentType = type
end

function AlignmentComponent:GetAlignmentType()
  return self._alignmentType
end

function Entity:Alignment()
  return self:GetComponent(self.WEComponentsEnum.Alignment)
end

function Entity:HasAlignment()
  return self:HasComponent(self.WEComponentsEnum.Alignment)
end

function Entity:AddAlignment(alignmentType)
  local index = self.WEComponentsEnum.Alignment
  local component = AlignmentComponent:New(alignmentType)
  self:AddComponent(index, component)
end

function Entity:ReplaceAlignment(alignmentType)
  local index = self.WEComponentsEnum.Alignment
  local component = AlignmentComponent:New(alignmentType)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveAlignment()
  if self:HasAlignment() then
    self:RemoveComponent(self.WEComponentsEnum.Alignment)
  end
end
