_class("FeatureConfigHelper", Object)
FeatureConfigHelper = FeatureConfigHelper

function FeatureConfigHelper:Constructor()
  self._featureConfigDic = {}
  self._featureEffectParamParser = FeatureEffectParamParser:New()
end

function FeatureConfigHelper:ClearFeatureData()
  self._featureConfigDic = {}
end

function FeatureConfigHelper:GetFeatureData(featureType)
  if featureType == nil then
    Log.error("FeatureConfigHelper:GetFeatureData() featureType is nil")
    return
  end
  if self._featureConfigDic[featureType] ~= nil then
    return self._featureConfigDic[featureType]
  end
  local featureConfigData = FeatureConfigData:New(self._featureEffectParamParser)
  featureConfigData:ParseFeatureConfig(featureType)
  self._featureConfigDic[featureType] = featureConfigData
  return featureConfigData
end

function FeatureConfigHelper:ParseCustomFeatureList(feature_list)
  local effectParamList = {}
  if not feature_list then
    return effectParamList
  end
  local effectIndexList = {}
  for k, v in pairs(feature_list) do
    effectIndexList[#effectIndexList + 1] = k
  end
  table.sort(effectIndexList)
  for _, featureType in ipairs(effectIndexList) do
    local baseData = self:GetFeatureData(featureType)
    if baseData then
      local baseParam = baseData:GetFeatureEffectParam()
      local effectParamObj
      if baseParam and baseParam.CloneSelf then
        effectParamObj = baseParam:CloneSelf()
        if effectParamObj then
          local effectParamCfg = feature_list[featureType]
          effectParamObj:ReplaceByCustomCfg(effectParamCfg)
          effectParamList[#effectParamList + 1] = effectParamObj
        end
      end
    end
  end
  return effectParamList
end
