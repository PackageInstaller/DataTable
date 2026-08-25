local BattlePassCfgUtils = {}

function BattlePassCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.BattlePass[tid]
end

function BattlePassCfgUtils.GetCfgField(field, cfgTid)
  local cfg = BattlePassCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return BattlePassCfgUtils
