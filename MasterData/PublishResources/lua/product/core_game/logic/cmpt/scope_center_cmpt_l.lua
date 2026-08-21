_class("ScopeCenterComponent", Object)
ScopeCenterComponent = ScopeCenterComponent

function ScopeCenterComponent:Constructor(groupId)
  self._groupId = groupId
end

function ScopeCenterComponent:GetGroupId()
  return self._groupId
end

function Entity:ScopeCenter()
  return self:GetComponent(self.WEComponentsEnum.ScopeCenter)
end

function Entity:AddScopeCenter(groupId)
  local index = self.WEComponentsEnum.ScopeCenter
  local component = ScopeCenterComponent:New(groupId)
  self:AddComponent(index, component)
end

function Entity:HasScopeCenter()
  return self:HasComponent(self.WEComponentsEnum.ScopeCenter)
end

function Entity:RemoveScopeCenter()
  if self:HasScopeCenter() then
    self:RemoveComponent(self.WEComponentsEnum.ScopeCenter)
  end
end
