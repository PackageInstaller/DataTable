local NewbieGuideModel = NewClass("NewbieGuideModel", BaseModel)

function NewbieGuideModel:OnInit()
  self:OnReset()
end

function NewbieGuideModel:OnReset()
  self._guideTid = nil
  self._guideIndex = nil
  self._guideCfg = nil
end

function NewbieGuideModel:SetGuideData(guideTid, guideIndex, guideCfg)
  self._guideTid = guideTid
  self._guideIndex = guideIndex
  self._guideCfg = guideCfg
end

function NewbieGuideModel:GetGuideTid()
  return self._guideTid
end

function NewbieGuideModel:GetGuideIndex()
  return self._guideIndex
end

function NewbieGuideModel:GetGuideCfg()
  return self._guideCfg
end

function NewbieGuideModel:IsForceGuide()
  return self._guideCfg and self._guideCfg.IsForcible == cd.NumberTrue or false
end

function NewbieGuideModel:IsClickAnywhereGuide()
  return self._guideCfg and -1 == self._guideCfg.IsForcible or false
end

function NewbieGuideModel:GetNodeName()
  return self._guideCfg and self._guideCfg.NodeName or nil
end

function NewbieGuideModel:GetGuideDirection()
  return self._guideCfg and self._guideCfg.GuideDirection or nil
end

function NewbieGuideModel:GetContent()
  return self._guideCfg and self._guideCfg.Content or nil
end

function NewbieGuideModel:GetContentOffset()
  return self._guideCfg and self._guideCfg.ContentOffset or {}
end

return NewbieGuideModel
