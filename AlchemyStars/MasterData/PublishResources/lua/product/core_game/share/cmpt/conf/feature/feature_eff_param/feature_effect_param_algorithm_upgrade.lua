require("feature_effect_param_base")
_class("FeatureEffectParamAlgorithmUpgrade", FeatureEffectParamBase)
FeatureEffectParamAlgorithmUpgrade = FeatureEffectParamAlgorithmUpgrade

function FeatureEffectParamAlgorithmUpgrade:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamAlgorithmUpgrade:_RefreshData(t)
  if not t then
    return
  end
  if t.EnterValue then
    self._enterValue = t.EnterValue
  end
  if t.MaxValue then
    self._maxValue = t.MaxValue
  end
  if t.MinValue then
    self._minValue = t.MinValue
  end
  if t.RelicIDList then
    self._relicIDList = t.RelicIDList
  end
  if t.RelicDescList then
    self._relicDescList = t.RelicDescList
  end
end

function FeatureEffectParamAlgorithmUpgrade:GetFeatureType()
  return FeatureType.AlgorithmUpgrade
end

function FeatureEffectParamAlgorithmUpgrade:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamAlgorithmUpgrade:CloneSelf()
  local param = FeatureEffectParamAlgorithmUpgrade:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamAlgorithmUpgrade:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamAlgorithmUpgrade:GetEnterValue()
  return self._enterValue or 0
end

function FeatureEffectParamAlgorithmUpgrade:GetMaxValue()
  return self._maxValue or 100
end

function FeatureEffectParamAlgorithmUpgrade:GetMinValue()
  return self._minValue or 0
end

function FeatureEffectParamAlgorithmUpgrade:GetRelicIDList()
  return self._relicIDList or {}
end

function FeatureEffectParamAlgorithmUpgrade:GetRelicDescList()
  return self._relicDescList or {}
end
