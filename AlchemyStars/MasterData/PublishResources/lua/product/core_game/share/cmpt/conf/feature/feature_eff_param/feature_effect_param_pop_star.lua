_class("FeatureEffectParamPopStar", FeatureEffectParamBase)
FeatureEffectParamPopStar = FeatureEffectParamPopStar

function FeatureEffectParamPopStar:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamPopStar:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
  if t.ImageNormalFront then
    self._imageNormalFront = t.ImageNormalFront
  end
  if t.ImageWarningFront then
    self._imageWarningFront = t.ImageWarningFront
  end
  if t.ImageNormalBg then
    self._imageNormalBg = t.ImageNormalBg
  end
  if t.ImageWarningBg then
    self._imageWarningBg = t.ImageWarningBg
  end
  if t.MaxPower then
    self._maxPower = t.MaxPower
  end
  if t.FirstUseInitPower then
    self._firstUseInitPower = t.FirstUseInitPower
  end
end

function FeatureEffectParamPopStar:GetMasterSkillID()
  return self._skillID
end

function FeatureEffectParamPopStar:GetMaxPowerLimit()
  return self._maxPower
end

function FeatureEffectParamPopStar:GetFirstUseInitPower()
  return self._firstUseInitPower
end

function FeatureEffectParamPopStar:GetImageNormalFront()
  return self._imageNormalFront
end

function FeatureEffectParamPopStar:GetImageWarningFront()
  return self._imageWarningFront
end

function FeatureEffectParamPopStar:GetImageNormalBg()
  return self._imageNormalBg
end

function FeatureEffectParamPopStar:GetImageWarningBg()
  return self._imageWarningBg
end
