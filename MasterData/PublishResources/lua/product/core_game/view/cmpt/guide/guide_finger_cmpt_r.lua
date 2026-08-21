_class("GuideFingerComponent", Object)

function GuideFingerComponent:Constructor()
end

function GuideFingerComponent:WEC_PostInitialize(owner)
end

function GuideFingerComponent:WEC_PostRemoved()
end

function Entity:GuideFinger()
  return self:GetComponent(self.WEComponentsEnum.GuideFinger)
end

function Entity:HasGuideFinger()
  return self:HasComponent(self.WEComponentsEnum.GuideFinger)
end

function Entity:AddGuideFinger()
  local index = self.WEComponentsEnum.GuideFinger
  local component = GuideFingerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceGuideFinger()
  local index = self.WEComponentsEnum.GuideFinger
  local component = GuideFingerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGuideFinger()
  if self:HasGuideFinger() then
    self:RemoveComponent(self.WEComponentsEnum.GuideFinger)
  end
end
