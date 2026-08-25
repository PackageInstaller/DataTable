local AbyssPlayerNameStageTidList = DT.GetOriginalConstant("AbyssPlayerNameStageTidList")
local RailWayRewardItem = DT.GetConstant("RailWayRewardItem")
local StageCfgUtils = {}

function StageCfgUtils.GetCfg(stageTid)
  if not stageTid then
    return nil
  end
  return DT.Stage[stageTid]
end

function StageCfgUtils.GetCfgField(field, cfgTid)
  local cfg = StageCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function StageCfgUtils.GetStageSweepType(stageTid)
  do return StageCfgUtils.GetCfgField, "StageSweep" end
  return StageCfgUtils.GetCfgField, "StageSweep", stageTid
end

function StageCfgUtils.GetExtraCostItemNum(stageTid)
  local cfgCostExtra = StageCfgUtils.GetCfgField("CostExtra", stageTid)
  if not cfgCostExtra then
    return nil
  end
  return cfgCostExtra[2]
end

function StageCfgUtils.GetExtraCostItemTid(stageTid)
  local cfgCostExtra = StageCfgUtils.GetCfgField("CostExtra", stageTid)
  if not cfgCostExtra then
    return nil
  end
  return cfgCostExtra[1]
end

local StageGroupTid2StageTidListMap = {}

function StageCfgUtils.GetStageTidListByStageGroupId(stageGroupId)
  if StageGroupTid2StageTidListMap[stageGroupId] then
    return StageGroupTid2StageTidListMap[stageGroupId]
  end
  StageGroupTid2StageTidListMap[stageGroupId] = {}
  for stageTid, stageCfg in pairs(DT.Stage) do
    if stageCfg.BelongGroup == stageGroupId then
      table.insert(StageGroupTid2StageTidListMap[stageGroupId], stageTid)
    end
  end
  return StageGroupTid2StageTidListMap[stageGroupId]
end

function StageCfgUtils.GetStageGroupType(stageTid)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageTid)
  do return StageGroupCfgUtils.GetCfgField, "Type" end
  return StageGroupCfgUtils.GetCfgField, "Type", stageGroupTid
end

function StageCfgUtils.GetTrailTypeByStageTid(stageId)
  local stageGroupTid = StageCfgUtils.GetCfgField("BelongGroup", stageId)
  if not stageGroupTid then
    return nil
  end
  local normalTrialGroupTidList = CopyDataUtils.GetStageGroupIdList(CommonDefine.StageGroupType.CommonTrial)
  local limitTrialGroupTidList = DT.GetOriginalConstant("StageGroupLimitSummon", {})
  local starTrialGroupTidList = DT.GetOriginalConstant("StarStageGroupLimitSummon", {})
  if table.contains(normalTrialGroupTidList, stageGroupTid) then
    return CommonDefine.TrialType.Normal
  elseif table.contains(limitTrialGroupTidList, stageGroupTid) then
    return CommonDefine.TrialType.Limit
  elseif table.contains(starTrialGroupTidList, stageGroupTid) then
    return CommonDefine.TrialType.Star
  end
  return nil
end

function StageCfgUtils.GetSkipPlot(stageTid)
  local skipPlot = StageCfgUtils.GetCfgField("SkipPlot", stageTid)
  if nil == skipPlot or "" == skipPlot or 0 == skipPlot then
    return false
  end
  return 1 == skipPlot
end

function StageCfgUtils.GetMapBossEliteRailWayExp(stageId)
  local rst = 0
  local cfgMap = StageCfgUtils.GetCfgField("Map", stageId)
  if not cfgMap then
    return rst
  end
  
  local function CollectRailWayExp(rewardList)
    for i = 1, #(rewardList or {}), 2 do
      local itemTid = rewardList[i]
      if itemTid == RailWayRewardItem then
        local exp = rewardList[i + 1]
        rst = rst + exp
      end
    end
  end
  
  for _, mapId in ipairs(cfgMap) do
    local mapNodeGroupCfg = MapNodeGroupCfgUtils.GetCfg(mapId)
    if not mapNodeGroupCfg then
    else
      CollectRailWayExp(mapNodeGroupCfg.BossMonsterBattleReward)
      CollectRailWayExp(mapNodeGroupCfg.EliteMonsterBattleReward)
    end
  end
  return rst
end

function StageCfgUtils.GetStageName(stageTid, textGo)
  if not stageTid then
    return ""
  end
  local rst = LT.Text(StageCfgUtils.GetCfgField("Name", stageTid))
  if table.contains(AbyssPlayerNameStageTidList or {}, stageTid) then
    local isPassed = CopyDataUtils.IsFirstRewardDraw(stageTid)
    if isPassed then
      rst = PlayerDataUtils.GetName() or rst
    else
      rst = StrUtils.GetConfuseText(textGo, rst)
    end
  end
  if not CopyDataUtils.CheckStageIsInOpenTime(stageTid) then
    rst = StrUtils.GetConfuseText(textGo, rst)
  end
  return rst
end

local AvgDialogTid2StageTidDict = {}

function StageCfgUtils.GetStageTidByAvgDialogTid(avgDialogTid)
  if not table.next(AvgDialogTid2StageTidDict) then
    for stageTid, cfg in pairs(DT.Stage) do
      if cfg.StartStory then
        AvgDialogTid2StageTidDict[cfg.StartStory] = stageTid
      end
    end
  end
  return AvgDialogTid2StageTidDict[avgDialogTid]
end

return StageCfgUtils
