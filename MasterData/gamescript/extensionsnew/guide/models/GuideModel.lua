local GuideModel = NewClass("GuideModel", BaseModel)

function GuideModel:OnInit()
  self:OnReset()
end

function GuideModel:OnReset()
  self._guideId = nil
  self._subGuideId = nil
end

function GuideModel:SyncFromDataCenter()
  self._guideId = DataCenter.guideData.guideId
  self._subGuideId = DataCenter.guideData.subGuideId
end

function GuideModel:GetGuideCfg()
  do return end
  return GuideUtils.GetCurGuideCfg
end

function GuideModel:GetGuideContent()
  local cfg = self:GetGuideCfg()
  return cfg and cfg.Content or nil
end

function GuideModel:GetHeadIcon()
  local cfg = self:GetGuideCfg()
  if not cfg then
    return nil
  end
  local awaker = cfg.AwakerHead
  if tonumber(awaker) then
    do return AwakerDataUtils.GetLittleIcon, tonumber(awaker) end
    return AwakerDataUtils.GetLittleIcon, tonumber(awaker)
  end
  if type(awaker) == "string" then
    return awaker
  end
end

function GuideModel:GetGuideName()
  local cfg = self:GetGuideCfg()
  if not cfg then
    return nil
  end
  local awaker = cfg.AwakerHead
  if tonumber(awaker) then
    local awakerCfg = DT.AwakerConfig[awaker]
    return awakerCfg and awakerCfg.Name or nil
  end
end

function GuideModel:HasAwakerHead()
  local cfg = self:GetGuideCfg()
  return nil ~= cfg and nil ~= cfg.AwakerHead
end

return GuideModel
