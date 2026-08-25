local StateCfgUtils = {}

function StateCfgUtils.GetCfg(cfgTid)
  if not cfgTid then
    return nil
  end
  return DT.State[cfgTid]
end

function StateCfgUtils.GetCfgField(field, cfgTid)
  local cfg = StateCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return StateCfgUtils
