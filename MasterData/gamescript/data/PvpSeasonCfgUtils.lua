local PvpSeasonCfgUtils = {}

function PvpSeasonCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.PVPSeason[tid]
end

function PvpSeasonCfgUtils.GetCfgField(field, cfgTid)
  local cfg = PvpSeasonCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return PvpSeasonCfgUtils
