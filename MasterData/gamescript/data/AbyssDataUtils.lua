local AbyssDataUtils = {}
local AbyssStageGroupMap

function AbyssDataUtils.ReqAbyssData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenAbyss", function(data)
    Logger.Info("========== 请求融蚀深渊数据成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 请求融蚀深渊数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function AbyssDataUtils.ReqResetAbyssChallenge(stageGroupTid, callback)
  if not stageGroupTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnResetAbyssStageGroup", function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战成功 ==========\n", table.tostring(data or {}))
    if data and data.score and DataCenter.MainCopyData.abyssData then
      DataCenter.MainCopyData.abyssData.score = data.score
    end
    AbyssDataUtils.ResetPassedStageGroup(stageGroupTid)
    if data and data.assistCount and DataCenter.MainCopyData.abyssData then
      DataCenter.MainCopyData.abyssData.assistCount = data.assistCount
    end
    if callback then
      callback(data)
    end
    EventMgr.Instance.OnAbyssUIEvent:Dispatch(AbyssDefine.EventType.OnResetStageGroup, stageGroupTid)
  end, function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战失败 ==========\n", table.tostring(data or {}))
  end, stageGroupTid)
end

function AbyssDataUtils.ReqAbyssTeamDetail(stageGroupTid, callback)
  if not stageGroupTid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenAbyssTeamDetail", function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战成功 ==========\n", table.tostring(data or {}))
    data.hasDetail = true
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("========== 请求重置融蚀深渊挑战失败 ==========\n", table.tostring(data or {}))
  end, stageGroupTid)
end

function AbyssDataUtils.ReqGainAbyssPrize(index, callback)
  if not index then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainAbyssPrize", function(data)
    Logger.Info("========== 请求获取融蚀深渊奖励成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求获取融蚀深渊奖励失败 ==========\n", table.tostring(data or {}))
  end, index)
end

function AbyssDataUtils.ReqGainPrizeAll(indexList, callback)
  if not indexList then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnGainPrizeAll", function(data)
    Logger.Info("========== 请求一键获取融蚀深渊奖励成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 请求一键获取融蚀深渊奖励失败 ==========\n", table.tostring(data or {}))
  end, indexList)
end

function AbyssDataUtils.OpenAbyssPanel(callback)
  local function _OnOpen(serverData)
    AbyssDataUtils.UpdateAbyssDataByServer(serverData)
    
    UIManager.Instance:Reopen(Urls.AbyssPanel)
    if callback then
      callback()
    end
  end
  
  AbyssDataUtils.ReqAbyssData(_OnOpen)
end

function AbyssDataUtils.UpdateAbyssDataByServer(serverData)
  if not serverData then
    return
  end
  if not DataCenter.MainCopyData.abyssData then
    DataCenter.MainCopyData.abyssData = {}
  end
  for k, v in pairs(serverData) do
    DataCenter.MainCopyData.abyssData[k] = v
  end
end

function AbyssDataUtils.ResetPassedStageGroup(stageGroupTid)
  if not (stageGroupTid and DataCenter.MainCopyData.abyssData) or not DataCenter.MainCopyData.abyssData.stageGroups then
    return
  end
  if DataCenter.MainCopyData.abyssData.stageGroups[stageGroupTid] then
    DataCenter.MainCopyData.abyssData.stageGroups[stageGroupTid].stageTid = 0
  end
end

function AbyssDataUtils.ResetAbyssData()
  DataCenter.MainCopyData.abyssData = {}
end

function AbyssDataUtils.UpdatePrizeState(index, state)
  if not DataCenter.MainCopyData.abyssData or not DataCenter.MainCopyData.abyssData.maxScorePrize then
    return
  end
  DataCenter.MainCopyData.abyssData.maxScorePrize[index] = state
end

function AbyssDataUtils.GetStageGroupData(stageGroupTid)
  if not stageGroupTid then
    return {}
  end
  if not DataCenter.MainCopyData.abyssData or not DataCenter.MainCopyData.abyssData.stageGroups then
    return {}
  end
  return DataCenter.MainCopyData.abyssData.stageGroups[stageGroupTid] or {}
end

function AbyssDataUtils.IsUnlock()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.AbyssChallenge)
  if not unlock then
    return false
  end
  do return ActivityManager.Instance.HasOpeningAbyssActivity end
  return ActivityManager.Instance.HasOpeningAbyssActivity, ActivityManager.Instance
end

function AbyssDataUtils.GetStageGroupList(activityTid)
  local config = ActivityDataUtils.GetConfig(activityTid)
  if not config or not config.ActivityPara1 then
    return {}
  end
  return config.ActivityPara1
end

function AbyssDataUtils.GetChildStageTids(stageGroupTid)
  if not stageGroupTid then
    return {}
  end
  if AbyssStageGroupMap then
    return AbyssStageGroupMap[stageGroupTid] or {}
  end
  AbyssStageGroupMap = {}
  local abyssStageGroups = {}
  for tid, cfg in pairs(DT.StageGroup) do
    if cfg.Type == CommonDefine.StageGroupType.AbyssChallenge then
      abyssStageGroups[tid] = true
    end
  end
  for stageTid, cfg in pairs(DT.Stage) do
    if cfg and cfg.BelongGroup and abyssStageGroups[cfg.BelongGroup] then
      if not AbyssStageGroupMap[cfg.BelongGroup] then
        AbyssStageGroupMap[cfg.BelongGroup] = {}
      end
      if not table.contains(AbyssStageGroupMap[cfg.BelongGroup], stageTid) then
        table.insert(AbyssStageGroupMap[cfg.BelongGroup], stageTid)
      end
    end
  end
  
  local function StageSorter(a, b)
    local cfgA = CopyDataUtils.GetStageConfig(a)
    local cfgB = CopyDataUtils.GetStageConfig(b)
    return cfgA.StageLevel < cfgB.StageLevel
  end
  
  for _stageGroupTid, _ in pairs(AbyssStageGroupMap) do
    table.sort(AbyssStageGroupMap[_stageGroupTid], StageSorter)
  end
  return AbyssStageGroupMap[stageGroupTid] or {}
end

function AbyssDataUtils.GetMaxStageLevel(stageGroupTid)
  if not stageGroupTid then
    return 0
  end
  local childStages = AbyssDataUtils.GetChildStageTids(stageGroupTid)
  local maxStageLevel = 0
  for _, stageTid in ipairs(childStages) do
    local config = CopyDataUtils.GetStageConfig(stageTid)
    if config and config.StageLevel and maxStageLevel < config.StageLevel then
      maxStageLevel = config.StageLevel
    end
  end
  return maxStageLevel
end

function AbyssDataUtils.GetStageScore(stageTid)
  if not stageTid then
    return 0
  end
  local config = CopyDataUtils.GetStageConfig(stageTid)
  return config and config.AbyssChallengeScore or 0
end

function AbyssDataUtils.GetHaveJoinAbyss()
  local maxScore = AbyssExtModel.Instance:GetMaxScore()
  if maxScore > 0 then
    return true
  end
  local stageGroups = AbyssExtModel.Instance:GetStageGroupDatas()
  if not stageGroups then
    return false
  end
  for _, stageGroup in pairs(stageGroups) do
    if stageGroup.extraPass then
      return true
    end
    if stageGroup.team then
      if stageGroup.team.keeperSkill and stageGroup.team.keeperSkill > 0 then
        return true
      end
    elseif stageGroup.teamExtra and stageGroup.teamExtra.keeperSkill and stageGroup.teamExtra.keeperSkill > 0 then
      return true
    end
  end
  return false
end

function AbyssDataUtils.GetStageGroupTypeRespawnCost(stageGroupType)
  if not stageGroupType then
    return 1
  end
  local cfg = DT.Constant.StageGroupTypeRespawnCost
  local data = cfg and cfg.Data or {}
  for i = 1, #data, 2 do
    if data[i] == stageGroupType then
      return data[i + 1] or 1
    end
  end
  return 1
end

function AbyssDataUtils.IsAbyssStageTid(stageTid)
  if not stageTid or stageTid <= 0 then
    return false
  end
  local stageCfg = DT.Stage[stageTid]
  if not stageCfg or not stageCfg.BelongGroup then
    return false
  end
  local stageGroupCfg = DT.StageGroup[stageCfg.BelongGroup]
  return stageGroupCfg and stageGroupCfg.Type == CommonDefine.StageGroupType.AbyssChallenge
end

function AbyssDataUtils.GetStageRespawnCostByStageTid(stageTid)
  if not stageTid or stageTid <= 0 then
    return 1
  end
  local stageCfg = DT.Stage[stageTid]
  local stageGroupTid = stageCfg and stageCfg.BelongGroup
  local stageGroupCfg = stageGroupTid and DT.StageGroup[stageGroupTid]
  local stageGroupType = stageGroupCfg and stageGroupCfg.Type
  do return AbyssDataUtils.GetStageGroupTypeRespawnCost end
  return AbyssDataUtils.GetStageGroupTypeRespawnCost, stageGroupType
end

return AbyssDataUtils
