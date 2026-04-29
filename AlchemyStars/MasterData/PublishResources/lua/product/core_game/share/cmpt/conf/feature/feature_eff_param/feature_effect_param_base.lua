_class("FeatureEffectParamBase", Object)
FeatureEffectParamBase = FeatureEffectParamBase

function FeatureEffectParamBase:Constructor(t)
  self._oriData = t
  self._featureTypeBySet = nil
end

function FeatureEffectParamBase:SetFeatureType(featureType)
  self._featureTypeBySet = featureType
end

function FeatureEffectParamBase:GetFeatureType()
  return self._featureTypeBySet or -1
end

function FeatureEffectParamBase:_RefreshData(t)
end

function FeatureEffectParamBase:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamBase:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamBase:CloneSelf()
  local param = self:New()
  param:CopyFrom(self)
  return param
end
