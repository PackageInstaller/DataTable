local PVPPositionCfgUtils = {}

function PVPPositionCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.PVPPosition[tid]
end

function PVPPositionCfgUtils.GetCfgField(field, cfgTid)
  local cfg = PVPPositionCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return PVPPositionCfgUtils
