local AcountLevelCfgUtils = {}

function AcountLevelCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.AcountLevelConfig[tid]
end

function AcountLevelCfgUtils.GetCfgField(field, cfgTid)
  local cfg = AcountLevelCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return AcountLevelCfgUtils
