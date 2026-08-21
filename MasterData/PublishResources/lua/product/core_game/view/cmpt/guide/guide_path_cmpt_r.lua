_class("GuidePathComponent", Object)

function GuidePathComponent:Constructor()
  self._guidePath = {}
  self._refreshType = GuideRefreshType.None
  self._invokeType = GuideInvokeType.None
end

function GuidePathComponent:GetInvokeType()
  return self._invokeType
end

function GuidePathComponent:SetInvokeType(invokeType)
  self._invokeType = invokeType
end

function GuidePathComponent:GetGuideRefreshType()
  return self._refreshType
end

function GuidePathComponent:SetGuideRefreshType(refreshType)
  self._refreshType = refreshType
end

function GuidePathComponent:SetGuidePath(path)
  self._guidePath = {}
  for k, v in ipairs(path) do
    local vec = Vector2(v[1], v[2])
    self._guidePath[#self._guidePath + 1] = vec
  end
end

function GuidePathComponent:GetGuidePath()
  return self._guidePath
end

function GuidePathComponent:IsMatchGuidePath(chainPath)
end

function GuidePathComponent:WEC_PostInitialize(owner)
end

function GuidePathComponent:WEC_PostRemoved()
end

function Entity:GuidePath()
  return self:GetComponent(self.WEComponentsEnum.GuidePath)
end

function Entity:HasGuidePath()
  return self:HasComponent(self.WEComponentsEnum.GuidePath)
end

function Entity:AddGuidePath(newPath)
  local index = self.WEComponentsEnum.GuidePath
  local component = GuidePathComponent:New(newPath)
  self:AddComponent(index, component)
end

function Entity:ReplaceGuidePath()
  local index = self.WEComponentsEnum.GuidePath
  local cmpt = self:GuidePath()
  self:ReplaceComponent(index, cmpt)
end

function Entity:RemoveGuidePath()
  if self:HasGuidePath() then
    self:RemoveComponent(self.WEComponentsEnum.GuidePath)
  end
end
