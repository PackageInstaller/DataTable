local FeatureUnlockCfgUtils = {}

function FeatureUnlockCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.FeatureUnlock[tid]
end

function FeatureUnlockCfgUtils.GetCfgField(field, cfgTid)
  local cfg = FeatureUnlockCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

local FeatureTidMappingDict = {}

function FeatureUnlockCfgUtils.GetFeatureConfigByFeatureId(featureId, subFeatureId)
  if not featureId then
    return nil
  end
  subFeatureId = subFeatureId or 0
  if not table.next(FeatureTidMappingDict) then
    for _, cfg in pairs(DT.FeatureUnlock) do
      if not FeatureTidMappingDict[cfg.Feature] then
        FeatureTidMappingDict[cfg.Feature] = {}
      end
      FeatureTidMappingDict[cfg.Feature][cfg.Key or 0] = cfg.ID
    end
  end
  local targetFeatureTid = FeatureTidMappingDict[featureId] and FeatureTidMappingDict[featureId][subFeatureId]
  return DT.FeatureUnlock[targetFeatureTid]
end

return FeatureUnlockCfgUtils
