local ItemQualityCfgUtils = {}

function ItemQualityCfgUtils.GetCfg(quality)
  if not quality then
    return nil
  end
  return DT.ItemQuality[quality]
end

function ItemQualityCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ItemQualityCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return ItemQualityCfgUtils
