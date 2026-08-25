local RelicCfgUtils = {}

function RelicCfgUtils.GetCfg(relicTid)
  if not relicTid then
    return nil
  end
  return DT.RelicConfig[relicTid]
end

function RelicCfgUtils.GetCfgField(field, cfgTid)
  local cfg = RelicCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function RelicCfgUtils.GetRelicBgImage(relicTid)
  local quality = RelicCfgUtils.GetCfgField("Quality", relicTid)
  do return ItemQualityCfgUtils.GetCfgField, "RelicEdgeFrame" end
  return ItemQualityCfgUtils.GetCfgField, "RelicEdgeFrame", quality
end

return RelicCfgUtils
