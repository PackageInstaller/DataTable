_class("GuidePreviewLinkLineComponent", Object)
GuidePreviewLinkLineComponent = GuidePreviewLinkLineComponent

function GuidePreviewLinkLineComponent:Constructor()
  self._guidePLLPath = {}
  self._refreshType = GuideRefreshType.None
  self._invokeType = GuideInvokeType.None
end

function GuidePreviewLinkLineComponent:GetInvokeType()
  return self._invokeType
end

function GuidePreviewLinkLineComponent:SetInvokeType(invokeType)
  self._invokeType = invokeType
end

function GuidePreviewLinkLineComponent:GetGuideRefreshType()
  return self._refreshType
end

function GuidePreviewLinkLineComponent:SetGuideRefreshType(refreshType)
  self._refreshType = refreshType
end

function GuidePreviewLinkLineComponent:SetGuidePLLPath(path)
  self._guidePLLPath = {}
  for k, v in ipairs(path) do
    local vec = Vector2(v[1], v[2])
    self._guidePLLPath[#self._guidePLLPath + 1] = vec
  end
end

function GuidePreviewLinkLineComponent:GetGuidePLLPath()
  return self._guidePLLPath
end

function Entity:GuidePreviewLinkLine()
  return self:GetComponent(self.WEComponentsEnum.GuidePreviewLinkLine)
end

function Entity:HasGuidePreviewLinkLine()
  return self:HasComponent(self.WEComponentsEnum.GuidePreviewLinkLine)
end

function Entity:AddGuidePreviewLinkLine()
  local index = self.WEComponentsEnum.GuidePreviewLinkLine
  local component = GuidePreviewLinkLineComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceGuidePreviewLinkLine()
  local index = self.WEComponentsEnum.GuidePreviewLinkLine
  local component = self:GuidePreviewLinkLine()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveGuidePreviewLinkLine()
  if self:HasGuidePreviewLinkLine() then
    self:RemoveComponent(self.WEComponentsEnum.GuidePreviewLinkLine)
  end
end
