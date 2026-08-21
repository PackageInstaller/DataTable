_class("FeatureEffectParamStepPoint", FeatureEffectParamBase)
FeatureEffectParamStepPoint = FeatureEffectParamStepPoint

function FeatureEffectParamStepPoint:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamStepPoint:_RefreshData(t)
  if not t then
    return
  end
  if t.InitStepPoint then
    self._initStepPoint = t.InitStepPoint
  end
  if t.MaxStepPoint then
    self._maxStepPoint = t.MaxStepPoint
  end
  if t.RecoverStepPoint then
    self._recoverStepPoint = t.RecoverStepPoint
  end
end

function FeatureEffectParamStepPoint:GetFeatureType()
  return FeatureType.StepPoint
end

function FeatureEffectParamStepPoint:GetInitStepPoint()
  return self._initStepPoint
end

function FeatureEffectParamStepPoint:GetMaxStepPoint()
  return self._maxStepPoint
end

function FeatureEffectParamStepPoint:GetRecoverStepPoint()
  return self._recoverStepPoint
end
