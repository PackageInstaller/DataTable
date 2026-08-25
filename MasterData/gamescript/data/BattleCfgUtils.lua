local BattleCfgUtils = {}

function BattleCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.BattleConfig[tid]
end

function BattleCfgUtils.GetCfgField(field, cfgTid)
  local cfg = BattleCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function BattleCfgUtils.GetSkipPlot(battleTid)
  local skipPlot = BattleCfgUtils.GetCfgField("SkipPlot", battleTid)
  if nil == skipPlot then
    return nil
  end
  if "" == skipPlot or 0 == skipPlot then
    return false
  end
  return 1 == skipPlot
end

function BattleCfgUtils.GetIsMustPlayPlot(battleTid)
  local SkipPlot = BattleCfgUtils.GetCfgField("SkipPlot", battleTid)
  return 0 == SkipPlot
end

return BattleCfgUtils
