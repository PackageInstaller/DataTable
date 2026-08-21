_class("FeatureEffectParamTrapCount", FeatureEffectParamBase)
FeatureEffectParamTrapCount = FeatureEffectParamTrapCount

function FeatureEffectParamTrapCount:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamTrapCount:_RefreshData(t)
  if not t then
    return
  end
  if t.TargetTrapIDList then
    self._targetTrapIDList = t.TargetTrapIDList
  end
  if t.MaxCount then
    self._maxCount = t.MaxCount
  end
  if t.Icon then
    self._icon = t.Icon
  end
  if t.TitleStr then
    self._titleStr = t.TitleStr
  end
end

function FeatureEffectParamTrapCount:GetFeatureType()
  return FeatureType.TrapCount
end

function FeatureEffectParamTrapCount:GetTargetTrapIDList()
  return self._targetTrapIDList
end

function FeatureEffectParamTrapCount:GetMaxCount()
  return self._maxCount
end

function FeatureEffectParamTrapCount:GetIcon()
  return self._icon
end

function FeatureEffectParamTrapCount:GetTitleStr()
  return self._titleStr
end
