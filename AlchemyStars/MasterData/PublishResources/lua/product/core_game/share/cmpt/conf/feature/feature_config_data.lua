_class("FeatureConfigData", Object)
FeatureConfigData = FeatureConfigData

function FeatureConfigData:Constructor(effectParamParser)
  self._effectParamParser = effectParamParser
end

function FeatureConfigData:ParseFeatureConfig(featureType)
  local featureConfigGroup = Cfg.cfg_feature({FeatureType = featureType})
  if featureConfigGroup and 0 < #featureConfigGroup then
  else
    Log.fatal("ParseFeatureConfig feature not exist FeatureType=", featureType, " ", Log.traceback())
    return
  end
  local featureConfig = featureConfigGroup[1]
  self._featureType = featureType
  self._featureIndex = featureConfig.ID
  self._previewType = featureConfig.PreviewType
  self._previewParam = featureConfig.PreviewParam
  self._layoutOrder = featureConfig.LayoutOrder or -1
  self._icon = featureConfig.Icon
  self._desc = featureConfig.Desc
  self._effectParam = self._effectParamParser:ParseFeatureEffectParam(featureType, featureConfig.EffectParam)
end

function FeatureConfigData:GetFeatureType()
  return self._featureType
end

function FeatureConfigData:GetFeatureIcon()
  return self._icon
end

function FeatureConfigData:GetFeatureDesc()
  return self._desc
end

function FeatureConfigData:GetFeatureEffectParam()
  return self._effectParam
end

function FeatureConfigData:GetFeaturePreviewType()
  return self._previewType
end

function FeatureConfigData:GetFeaturePreviewParam()
  return self._previewParam
end

function FeatureConfigData:GetFeaturePreviewParam()
  return self._layoutOrder
end
