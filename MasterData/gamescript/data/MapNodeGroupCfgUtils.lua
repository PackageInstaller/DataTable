local MapNodeGroupCfgUtils = {}

function MapNodeGroupCfgUtils.GetCfg(cfgTid)
  if not cfgTid then
    return nil
  end
  return DT.MapNodeGroup[cfgTid]
end

function MapNodeGroupCfgUtils.GetCfgField(field, cfgTid)
  local cfg = MapNodeGroupCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return MapNodeGroupCfgUtils
