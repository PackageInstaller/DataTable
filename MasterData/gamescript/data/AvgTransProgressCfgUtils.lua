local AvgTransProgressCfgUtils = {}

function AvgTransProgressCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.AvgTransProgress[tid]
end

function AvgTransProgressCfgUtils.GetCfgField(field, cfgTid)
  local cfg = AvgTransProgressCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

local StageTid2CfgDict = {}
local StageGroupTid2CfgDict = {}

function AvgTransProgressCfgUtils._InitCacheDict()
  for _, cfg in pairs(DT.AvgTransProgress) do
    if cfg.StageGroupTid then
      StageGroupTid2CfgDict[cfg.StageGroupTid] = cfg
    end
    if cfg.StageTid then
      StageTid2CfgDict[cfg.StageTid] = cfg
    end
  end
end

function AvgTransProgressCfgUtils.IsStageGroupLocalized(stageGroupTid, curLanguage)
  if not table.next(StageGroupTid2CfgDict) or not table.next(StageTid2CfgDict) then
    AvgTransProgressCfgUtils._InitCacheDict()
  end
  curLanguage = curLanguage or DataCenter.gameData.CurrTextLanguage
  local targetCfg = StageGroupTid2CfgDict[stageGroupTid]
  return targetCfg and targetCfg[curLanguage]
end

function AvgTransProgressCfgUtils.IsStageLocalized(stageTid, curLanguage)
  if not table.next(StageGroupTid2CfgDict) or not table.next(StageTid2CfgDict) then
    AvgTransProgressCfgUtils._InitCacheDict()
  end
  curLanguage = curLanguage or DataCenter.gameData.CurrTextLanguage
  local targetCfg = StageTid2CfgDict[stageTid]
  return targetCfg and targetCfg[curLanguage]
end

return AvgTransProgressCfgUtils
