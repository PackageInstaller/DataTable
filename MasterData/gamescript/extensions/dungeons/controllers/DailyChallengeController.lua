local DailyChallengeController, Super = NewClass("DailyChallengeController", BaseController)

function DailyChallengeController.OnReset()
  DailyChallengeModel.Instance:OnReset()
end

function DailyChallengeController:ReqOnCutClass(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnCutClass", function(svrData)
    Logger.Info("GameRequest.OnCutClass svrData:", table.tostring(svrData))
    if callback then
      callback()
    end
  end, function(errData)
    Logger.Error("GameRequest.OnCutClass failed:", table.tostring(errData))
  end)
end

function DailyChallengeController:ReqOnOpenDailyChallenge(callback, failCb)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenDailyChallenge", function(svrData)
    Logger.Info("GameRequest.OnOpenDailyChallenge svrData:", table.tostring(svrData))
    self:SetSvrData(svrData)
    if callback then
      callback(svrData)
    end
  end, function(errData)
    Logger.Info("GameRequest.OnOpenDailyChallenge failed:", table.tostring(errData))
    if failCb then
      failCb()
    end
  end)
end

function DailyChallengeController:ReqEnterStage()
  ProtoManager.Instance:ReqServer("StageRequest", "Enter", function()
  end, function()
  end, 1, self.teamIdx or 1, self.assistAwakerTid, self.playerUid, extraParam)
end

function DailyChallengeController:GetSvrData()
  do return DailyChallengeModel.Instance.GetSvrData end
  return DailyChallengeModel.Instance.GetSvrData, DailyChallengeModel.Instance
end

function DailyChallengeController:SetSvrData(data)
  DailyChallengeModel.Instance:SetSvrData(data)
end

function DailyChallengeController:GetInfo()
  return DailyChallengeModel.Instance.info
end

function DailyChallengeController:GetMaxDifficultyStageID()
  return DailyChallengeModel.Instance.maxDifficultyStageID
end

function DailyChallengeController:GetRelicGroupList()
  return DailyChallengeModel.Instance.relicGroupList
end

function DailyChallengeController:GetWeekRelicInfo()
  local weekRelicID = DailyChallengeModel.Instance.weekRelicID
  if weekRelicID and 0 ~= weekRelicID then
    local superscript = LT.Text("ThisWeek")
    do return self._GetRelicInfo, self, weekRelicID end
    return self._GetRelicInfo, self, weekRelicID, superscript
  end
end

function DailyChallengeController:_GetRelicInfo(id, superscript)
  local cfg = DT.RelicConfig[id]
  return {
    id = id,
    name = LT.Text(cfg.Name),
    icon = cfg.Icon,
    Quality = cfg.Quality,
    superscript = superscript
  }
end

function DailyChallengeController:GetDayRelicInfo()
  local dayRelicID = DailyChallengeModel.Instance.dayRelicID
  if dayRelicID and 0 ~= dayRelicID then
    local superscript = LT.Text("Today")
    do return self._GetRelicInfo, self, dayRelicID end
    return self._GetRelicInfo, self, dayRelicID, superscript
  end
end

function DailyChallengeController:GetSelectedLevelMonsterIDs()
  do return CopyDataUtils.GetStageMonsterWithAffixList, DT.Constant.DailyChallengeExampleStage.Data end
  return CopyDataUtils.GetStageMonsterWithAffixList, DT.Constant.DailyChallengeExampleStage.Data, true
end

function DailyChallengeController:GetRecommendedSchoolInfo()
  local recommendedSchoolID = DailyChallengeModel.Instance.recommendedSchoolID
  if recommendedSchoolID and recommendedSchoolID > 0 then
    local cfg = DT.SchoolConfig[recommendedSchoolID]
    return {
      name = LT.Text(cfg.Name),
      icon = cfg.Icon
    }
  end
end

function DailyChallengeController:GetSelectedLevelPassRewards(curSelectIndex)
  local cfg = self:_GetSelectedLevelCfg(curSelectIndex)
  if cfg and cfg.NormalReward then
    local rewards = {}
    for tid, count in table.iteraDouble(cfg.NormalReward) do
      table.insert(rewards, {
        tid = tid,
        count = count,
        itemAwardType = CommonDefine.ItemAwardType.Normal
      })
    end
    if cfg.FirstTimeReward then
      for tid, count in table.iteraDouble(cfg.FirstTimeReward) do
        table.insert(rewards, {
          tid = tid,
          count = count,
          itemAwardType = CommonDefine.ItemAwardType.First
        })
      end
    end
    table.sort(rewards, function(a, b)
      local aFirst = a.itemAwardType == CommonDefine.ItemAwardType.First
      local bFirst = b.itemAwardType == CommonDefine.ItemAwardType.First
      local aCfg = DT.Item[a.tid]
      local bCfg = DT.Item[b.tid]
      if aFirst ~= bFirst then
        return bFirst
      end
      return aCfg.BaseSortID < bCfg.BaseSortID
    end)
    do return ItemDataUtils.KickoutAwakerFavorItem end
    return ItemDataUtils.KickoutAwakerFavorItem, rewards, function(a, b)
      local aFirst = a.itemAwardType == CommonDefine.ItemAwardType.First
      local bFirst = b.itemAwardType == CommonDefine.ItemAwardType.First
      local aCfg = DT.Item[a.tid]
      local bCfg = DT.Item[b.tid]
      if aFirst ~= bFirst then
        return bFirst
      end
      return aCfg.BaseSortID < bCfg.BaseSortID
    end, table.iteraDouble(cfg.FirstTimeReward)
  end
  return {}
end

function DailyChallengeController:GetLevelPassIndex()
  local levelIDs = DailyChallengeModel.Instance.levelIDs
  local stageList = self.GetInfo().stageList or {}
  local maxIndex = 0
  for idx, id in ipairs(levelIDs) do
    if stageList[id] and stageList[id] > 1 then
      maxIndex = math.max(idx, maxIndex)
    end
  end
  return maxIndex
end

function DailyChallengeController:GetLastRewardRankId()
  do return DailyChallengeModel.Instance.GetLastRewardRankId end
  return DailyChallengeModel.Instance.GetLastRewardRankId, DailyChallengeModel.Instance
end

function DailyChallengeController:CutClassStateFinish()
  do return DailyChallengeModel.Instance.CutClassStateFinish end
  return DailyChallengeModel.Instance.CutClassStateFinish, DailyChallengeModel.Instance
end

function DailyChallengeController:UpdateAfterCutClass(svrData)
  do return DailyChallengeModel.Instance.UpdateAfterCutClass, DailyChallengeModel.Instance end
  return DailyChallengeModel.Instance.UpdateAfterCutClass, DailyChallengeModel.Instance, svrData
end

function DailyChallengeController:GetRankID()
  return DailyChallengeModel.Instance.rankID or 0
end

function DailyChallengeController:GetStageGroupId()
  if DailyChallengeModel.Instance.stageGroupCfg then
    return DailyChallengeModel.Instance.stageGroupCfg.ID
  else
    return 0
  end
end

function DailyChallengeController:RequestGainPrize(index, score, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnDailyChallengeGainPrize", function()
    self:UpdateWeekRewardInfoState(index, CommonDefine.RewardState.Received)
    callback()
  end, nil, score)
end

function DailyChallengeController:UpdateWeekRewardInfoState(idx, state)
  local weekRewardInfos = DailyChallengeModel.Instance.weekRewardInfos
  for _, info in ipairs(weekRewardInfos) do
    if info.idx == idx then
      info.state = state
      break
    end
  end
  DailyChallengeModel.Instance:SortRewardInfos(weekRewardInfos)
  self:Notify(NotifyId.OnDailyChallengeDataChanged)
end

function DailyChallengeController:RequestGainAchievePrize(index, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnDailyChallengeGainAchievePrize", function()
    self:UpdateWeekAchieveRewardInfoState(index, CommonDefine.RewardState.Received)
    if callback then
      callback()
    end
  end, nil, index)
end

function DailyChallengeController:RequestGainAllAchievementPrize(callback)
  TaskController.Instance:ReqOnTaskGainAllPrize(CommonDefine.TaskServerIndex.DailyChallengeChildTask, callback)
end

function DailyChallengeController:RequestGainAllLevelPrize(callback)
  PvpController.Instance:ReqOnGainAllLevelReward(DailyChallengeDataUtils.careerLevelType, callback)
end

function DailyChallengeController:UpdateWeekAchieveRewardInfoState(idx, state)
  local weekAchieveRewardInfos = DailyChallengeModel.Instance.weekAchieveRewardInfos
  for _, info in ipairs(weekAchieveRewardInfos) do
    if info.idx == idx then
      info.state = state
      return
    end
  end
end

function DailyChallengeController:GetlifeMaxScore()
  return DailyChallengeModel.Instance.lifeMaxScore
end

function DailyChallengeController:GetWeekRewardInfos()
  return DailyChallengeModel.Instance.weekRewardInfos
end

function DailyChallengeController:GetWeekWinNum()
  return DailyChallengeModel.Instance.info.weekWinNum or 0
end

function DailyChallengeController:GetWeekAchieveRewardInfos()
  return DailyChallengeModel.Instance.weekAchieveRewardInfos
end

function DailyChallengeController:GetDayHighestScoreLevelName()
  local dayHighestScoreLevelID = DailyChallengeModel.Instance.dayHighestScoreLevelID
  if dayHighestScoreLevelID and dayHighestScoreLevelID > 0 then
    local cfg = DT.Stage[dayHighestScoreLevelID]
    do return LT.Text end
    return LT.Text, cfg.Name
  end
  return ""
end

function DailyChallengeController:_GetSelectedLevelCfg(selectedLevelIdx)
  local levelIDs = DailyChallengeModel.Instance.levelIDs
  if levelIDs then
    local id = levelIDs[selectedLevelIdx]
    return DT.Stage[id]
  end
end

function DailyChallengeController:GetSelectedLevelDesc(selectedLevelIdx)
  local cfg = self:_GetSelectedLevelCfg(selectedLevelIdx)
  if cfg and cfg.Desc then
    do return LT.Text end
    return LT.Text, cfg.Desc
  end
  return ""
end

function DailyChallengeController:GetSelectedLevelBackground(selectedLevelIdx)
  local cfg = self:_GetSelectedLevelCfg(selectedLevelIdx)
  if cfg then
    return cfg.Backgrand or ""
  end
  return ""
end

function DailyChallengeController:GetSelectedLevelName(selectedLevelIdx)
  local cfg = self:_GetSelectedLevelCfg(selectedLevelIdx)
  if cfg then
    do return LT.Text end
    return LT.Text, cfg.Name
  end
  return ""
end

function DailyChallengeController:GetSelectedLevelID(selectedLevelIdx)
  local cfg = self:_GetSelectedLevelCfg(selectedLevelIdx)
  if cfg then
    return cfg.ID
  end
  return 0
end

function DailyChallengeController:GetWeekHighestScore()
  local info = self:GetInfo()
  if info then
    return info.weekMaxScore or 0
  end
  return 0
end

function DailyChallengeController:GetStageGroupName()
  if DailyChallengeModel.Instance.stageGroupCfg then
    do return LT.Text end
    return LT.Text, DailyChallengeModel.Instance.stageGroupCfg.Name
  end
  return ""
end

function DailyChallengeController:BoxLevelInfoItemData(selectIdx)
  local levelIDs = DailyChallengeModel.Instance.levelIDs
  local levelInfoList = {}
  if levelIDs then
    local firstLevelCfg = DT.Stage[levelIDs[1]]
    local firstLevelName = LT.Text(firstLevelCfg.Name)
    local levelUnlockDesc = LT.Textf("LevelUnlockDesc", firstLevelName)
    for idx, id in ipairs(levelIDs) do
      local cfg = DT.Stage[id]
      table.insert(levelInfoList, {
        name = LT.Text(cfg.Name),
        lvDesc = LT.Text("Copy_Recommend_Level") .. cfg.StageLevel,
        unlocked = 1 == idx and true,
        unlockDesc = 1 == idx and "" or levelUnlockDesc,
        curSelectIdx = selectIdx,
        isCarzy = cfg.DailyChallengeMadnessDifficulty and 1 == cfg.DailyChallengeMadnessDifficulty or false
      })
    end
  end
  return levelInfoList
end

return DailyChallengeController
