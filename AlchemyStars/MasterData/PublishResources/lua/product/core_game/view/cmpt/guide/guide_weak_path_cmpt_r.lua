_class("GuideWeakPathComponent", Object)

function GuideWeakPathComponent:Constructor()
  self._guidePath = {}
  self._refreshType = GuideRefreshType.None
end

function GuideWeakPathComponent:GetGuideRefreshType()
  return self._refreshType
end

function GuideWeakPathComponent:SetGuideRefreshType(refreshType)
  self._refreshType = refreshType
end

function GuideWeakPathComponent:SetGuidePath(path)
  self._guidePath = {}
  for k, v in ipairs(path) do
    self._guidePath[#self._guidePath + 1] = v
  end
end

function GuideWeakPathComponent:GetGuidePath()
  return self._guidePath
end

function GuideWeakPathComponent:IsMatchGuidePath(chainPath)
end

function GuideWeakPathComponent:WEC_PostInitialize(owner)
end

function GuideWeakPathComponent:WEC_PostRemoved()
end

function Entity:GuideWeakPath()
  return self:GetComponent(self.WEComponentsEnum.GuideWeakPath)
end

function Entity:HasGuideWeakPath()
  return self:HasComponent(self.WEComponentsEnum.GuideWeakPath)
end

function Entity:AddGuideWeakPath(newPath)
  local index = self.WEComponentsEnum.GuideWeakPath
  local component = GuideWeakPathComponent:New(newPath)
  self:AddComponent(index, component)
end

function Entity:ReplaceGuideWeakPath()
  local index = self.WEComponentsEnum.GuideWeakPath
  local cmpt = self:GuideWeakPath()
  self:ReplaceComponent(index, cmpt)
end

function Entity:RemoveGuideWeakPath()
  if self:HasGuideWeakPath() then
    self:RemoveComponent(self.WEComponentsEnum.GuideWeakPath)
  end
end
