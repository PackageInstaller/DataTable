local TipsTypeCfgUtils = {}

function TipsTypeCfgUtils.GetCfg(cfgTid)
  if not cfgTid then
    return nil
  end
  if type(cfgTid) == "number" then
    cfgTid = tostring(cfgTid)
  end
  return DT.TipsType[cfgTid]
end

function TipsTypeCfgUtils.GetCfgField(field, cfgTid)
  local cfg = TipsTypeCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return TipsTypeCfgUtils
