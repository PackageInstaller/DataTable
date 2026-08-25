local ZoneFeatureUtils = {}
ZoneFeatureUtils.ZoneFeatureMap = {}

function ZoneFeatureUtils.InitZoneFeature()
  for _, cfg in pairs(DT.FeatureSwitch) do
    ZoneFeatureUtils.ZoneFeatureMap[cfg.Feature] = cfg
  end
end

function ZoneFeatureUtils.GetFeatureId(featureName)
  if not table.next(ZoneFeatureUtils.ZoneFeatureMap) then
    ZoneFeatureUtils.InitZoneFeature()
  end
  local cfg = ZoneFeatureUtils.ZoneFeatureMap[featureName]
  return cfg and cfg.ID
end

function ZoneFeatureUtils.IsZoneFeatureOpen(featureName)
  if not table.next(ZoneFeatureUtils.ZoneFeatureMap) then
    ZoneFeatureUtils.InitZoneFeature()
  end
  local featureZone = PlayerDataUtils.GetServerZone()
  local cfg = ZoneFeatureUtils.ZoneFeatureMap[featureName]
  if cfg then
    local svrOpen = PlayerDataUtils.GetFeatureSwitchSvrValue(featureName)
    if nil ~= svrOpen then
      return svrOpen
    end
    if cfg.Invalid then
      return false
    end
    if not cfg.OnlyOpenZone then
      return true
    end
    if table.contains(cfg.OnlyOpenZone, featureZone) then
      return true
    end
  end
  return false
end

function ZoneFeatureUtils.IsJPCBTTest()
  do return ZoneFeatureUtils.IsZoneFeatureOpen end
  return ZoneFeatureUtils.IsZoneFeatureOpen, CommonDefine.ZoneFeature.JPCBTTest
end

function ZoneFeatureUtils.IsJPPriceSymbol()
  do return ZoneFeatureUtils.IsZoneFeatureOpen end
  return ZoneFeatureUtils.IsZoneFeatureOpen, CommonDefine.ZoneFeature.JPPriceSymbol
end

function ZoneFeatureUtils.IsJPCBTTestThenAlert()
  if ZoneFeatureUtils.IsZoneFeatureOpen(CommonDefine.ZoneFeature.JPCBTTest) then
    Alert.Show(10182)
    return true
  end
end

function ZoneFeatureUtils.IsWeaponAutoRefine()
  do return ZoneFeatureUtils.IsZoneFeatureOpen end
  return ZoneFeatureUtils.IsZoneFeatureOpen, CommonDefine.ZoneFeature.WeaponAutoRefine
end

return ZoneFeatureUtils
