local DailyChallengeModel, Super = NewClass("DailyChallengeModel", BaseModel)
local DailyChallengeData = DataCenter.dailyChallengeData

function DailyChallengeModel:OnReset()
  DailyChallengeData.svrData = nil
end

function DailyChallengeModel:OnInit()
  self:OnReset()
end

function DailyChallengeModel:GetSvrData()
  return DailyChallengeData.svrData
end

function DailyChallengeModel:SetSvrData(data)
  DailyChallengeData.svrData = data
  self:UpdateDailyChallengeInfo(data)
  self:Notify(NotifyId.OnDailyChallengeDataChanged)
end

function DailyChallengeModel:UpdateDailyChallengeInfo(serverData)
  if not serverData then
    return
  end
  local stageGroupCfg = DT.StageGroup[DT.Constant.DailyChallengedSelecStageLevel.Data]
  if not stageGroupCfg then
    return
  end
  local divingGameplayType = CommonDefine.SeasonGameplayType.ConsciousnessDiving
  local rankRow = SeasonRotationCfgUtils.GetSeasonRankRewardRowByRankId(serverData.seasonId, divingGameplayType, serverData.rankID)
  local seasonRoEndTime = SeasonRotationCfgUtils.GetEndTime(serverData.seasonId, divingGameplayType)
  self.difficulty = 0
  local levelCfgs = CopyDataUtils.GetCfgStageList(stageGroupCfg.ID)
  self.levelIDs = {}
  for _, cfg in ipairs(levelCfgs) do
    if cfg.DailyChallengeDifficulty < 9 then
      table.insert(self.levelIDs, cfg.ID)
    end
  end
  local stageList = serverData.stageList or {}
  local levelHighestScores = {}
  for _, id in ipairs(self.levelIDs) do
    local score = stageList[id]
    table.insert(levelHighestScores, score)
  end
  local scores = DT.Constant.DailyChallengeWeeklyScore.Data
  local weekScoreLimit = scores[#scores]
  local winNums = DT.Constant.WeeklyTotalWins.Data
  local weekWinNumLimit = winNums[#winNums]
  local weekRewardCount = 0
  for _, _ in pairs(serverData.weekPrize or {}) do
    weekRewardCount = weekRewardCount + 1
  end
  local rewards = DT.Constant.DailyChallengeWeeklyReward.Data
  local totalWeekRewardCount = #rewards
  self.stageGroupCfg = stageGroupCfg
  self.selectedLevelIdx = 1
  local lastSelectStageId = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.DailyChallengeLastId)
  if lastSelectStageId then
    for idx, id in ipairs(self.levelIDs) do
      if id == lastSelectStageId then
        self.selectedLevelIdx = idx
        break
      end
    end
  end
  self.weekRelicID = serverData.weekRelicID
  self.dayRelicID = serverData.dayRelicID
  self.seasonId = serverData.seasonId
  self.nextSeasonId = serverData.nextSeasonId
  self.recommendedSchoolID = serverData.recommendedSchoolID
  DataCenter.dbgTeamData.recommendedSchoolID = self.recommendedSchoolID
  self.relicGroupList = serverData.relicGroupList
  self.levelHighestScores = levelHighestScores
  self.rankID = self:GetShowRankId(serverData.rankID)
  self.dayHighestScoreLevelID = serverData.dayHighestScoreFormStage
  self.maxDifficultyStageID = serverData.maxDifficultyStageID or 0
  local passRewards = {}
  self:_InsertFirstPassRewards(passRewards, stageGroupCfg.StageGroupDrop, serverData.passed)
  self:_InsertPassRewards(passRewards, stageGroupCfg.StageGroupDropPreview)
  self.info = {
    name = LT.Text(stageGroupCfg.Name),
    desc = LT.Text(stageGroupCfg.Desc),
    background = stageGroupCfg.Backgrand,
    rankTitle = rankRow and LT.Text(rankRow.Name) or "-",
    dayHighestScore = serverData.dayHighestScore,
    weekMaxScore = serverData.seasonRoData and serverData.seasonRoData.maxScore or serverData.weekMaxScore,
    weekScore = serverData.weekScore,
    weekScoreLimit = weekScoreLimit,
    weekRewardCount = weekRewardCount,
    totalWeekRewardCount = totalWeekRewardCount,
    weekRewardResetTime = seasonRoEndTime > 0 and seasonRoEndTime or serverData.weekRewardResetTime or 0,
    passRewards = passRewards,
    weekWinNum = serverData.weekWinNum or 0,
    weekWinNumLimit = weekWinNumLimit,
    stageList = stageList,
    illuTid = serverData.illuTid,
    recAwakerList = serverData.recAwakerList
  }
  self.lifeMaxScore = serverData.lifeMaxScore
  self:_CreateWeekRewardInfos(serverData.weekWinPrize or {})
  self:_CreateWeekAchieveRewardInfos(serverData.expPrize)
end

function DailyChallengeModel:GetSeasonId()
  do return SeasonRotationModel.Instance.GetSeasonId, SeasonRotationModel.Instance end
  return SeasonRotationModel.Instance.GetSeasonId, SeasonRotationModel.Instance, CommonDefine.SeasonGameplayType.ConsciousnessDiving
end

function DailyChallengeModel:GetSeasonEndTime()
  return PvpSeasonCfgUtils.GetCfgField("StartTime", self.nextSeasonId) or 0
end

function DailyChallengeModel:IsHaveWeekReward()
  local infos = self.weekRewardInfos or {}
  for _, info in ipairs(infos) do
    if info.state == CommonDefine.RewardState.Available then
      return true
    end
  end
  return false
end

function DailyChallengeModel:_InsertFirstPassRewards(passRewards, dropIDs, obtained)
  if not dropIDs then
    return
  end
  for _, dropID in ipairs(dropIDs) do
    local dropCfg = DT.Drop[dropID]
    for _, drop in ipairs(dropCfg.data_list) do
      table.insert(passRewards, {
        tid = drop.DropItem,
        count = drop.DropNum,
        dailyFirstPass = true,
        obtained = obtained
      })
    end
  end
end

function DailyChallengeModel:_InsertPassRewards(passRewards, itemTids)
  if not itemTids then
    return
  end
  for _, tid in ipairs(itemTids) do
    table.insert(passRewards, {
      tid = tid,
      dailyFirstPass = false,
      obtained = false
    })
  end
end

function DailyChallengeModel:_CreateWeekRewardInfos(weekWinPrize)
  local infos = self.weekRewardInfos
  if nil == infos then
    infos = {}
    self.weekRewardInfos = infos
  end
  table.clear(infos)
  local winNums = DT.Constant.WeeklyTotalWins.Data
  local rewardsList = DT.Constant.WeeklyTotalWinsReward.Data
  for idx, winNum in ipairs(winNums) do
    local info = {}
    info.idx = idx
    info.score = winNum
    info.desc = LT.Textf("WeeklyTotalWinTaskDesc", winNum, math.min(winNum, self.info.weekWinNum or 0))
    info.rewards = {}
    local rewards = rewardsList[idx] or {}
    for i = 1, #rewards, 2 do
      table.insert(info.rewards, {
        tid = rewards[i],
        count = rewards[i + 1]
      })
    end
    local state = weekWinPrize[winNum]
    if not state then
      info.state = CommonDefine.RewardState.Unavailable
    elseif state == CommonDefine.CommonState.GainPrize then
      info.state = CommonDefine.RewardState.Available
    elseif state == CommonDefine.CommonState.Finish then
      info.state = CommonDefine.RewardState.Received
    end
    table.insert(infos, info)
  end
  self:SortRewardInfos(self.weekRewardInfos)
end

function DailyChallengeModel:_CreateWeekAchieveRewardInfos(weekPrize)
  local infos = self.weekAchieveRewardInfos
  if nil == infos then
    infos = {}
    self.weekAchieveRewardInfos = infos
  end
  table.clear(infos)
  local scores = DT.GetOriginalConstant("DailyChallengeAccumulatedExperience")
  local rewardsList = DT.GetOriginalConstant("DailyChallengeAccumulatedExperienceReward")
  if scores then
    for idx, score in ipairs(scores) do
      local info = {}
      info.idx = idx
      info.score = score
      info.rewards = {}
      local rewards = rewardsList[idx] or {}
      for i = 1, #rewards, 2 do
        table.insert(info.rewards, {
          tid = rewards[i],
          count = rewards[i + 1]
        })
      end
      local state = weekPrize and weekPrize[idx]
      if not state then
        info.state = CommonDefine.RewardState.Unavailable
      elseif state == CommonDefine.CommonState.GainPrize then
        info.state = CommonDefine.RewardState.Available
      elseif state == CommonDefine.CommonState.Finish then
        info.state = CommonDefine.RewardState.Received
      end
      table.insert(infos, info)
    end
  end
  self:SortRewardInfos(self.weekAchieveRewardInfos)
end

function DailyChallengeModel:CutClassStateFinish()
  local data = DailyChallengeData.svrData
  return data and 1 == data.cutClassFinish
end

function DailyChallengeModel:GetShowRankId(curRankId)
  do return DailyChallengeDataUtils.GetShowRankId end
  return DailyChallengeDataUtils.GetShowRankId, curRankId
end

function DailyChallengeModel:GetLastRewardRankId()
  local data = DailyChallengeData.svrData
  return data and data.lastRewardRankId or 0
end

function DailyChallengeModel:Get_selectedLevelIdx()
  return self.selectedLevelIdx
end

function DailyChallengeModel:UpdateAfterCutClass(svrData)
  local data = DailyChallengeData.svrData
  if data then
    data.weekWinNum = svrData.weekWinNum
    data.cutClassFinish = svrData.cutClassFinish
    data.dailyMaxDiffStage = svrData.dailyMaxDiffStage
    data.maxDifficultyStageID = svrData.maxDifficultyStageID
  end
end

function DailyChallengeModel:SortRewardInfos(rewardInfos)
  if rewardInfos then
    table.sort(rewardInfos, function(a, b)
      if a.state == CommonDefine.RewardState.Available and b.state ~= CommonDefine.RewardState.Available then
        return true
      end
      if a.state ~= CommonDefine.RewardState.Available and b.state == CommonDefine.RewardState.Available then
        return false
      end
      if a.state == CommonDefine.RewardState.Available and b.state == CommonDefine.RewardState.Available then
        return a.score < b.score
      end
      if a.state == CommonDefine.RewardState.Unavailable and b.state ~= CommonDefine.RewardState.Unavailable then
        return true
      end
      if a.state ~= CommonDefine.RewardState.Unavailable and b.state == CommonDefine.RewardState.Unavailable then
        return false
      end
      if a.state == CommonDefine.RewardState.Unavailable and b.state == CommonDefine.RewardState.Unavailable then
        return a.score < b.score
      end
      return a.score < b.score
    end)
  end
end

function DailyChallengeModel:GetStageScoreBase(stageTid)
  local cfg = DT.Stage[stageTid]
  local difficulty = cfg and cfg.DailyChallengeDifficulty or 1
  return (difficulty - 1) * DT.GetConstant("DailyChallengeBasicScore")
end

function DailyChallengeModel:GetDifficulty()
  return self.difficulty
end

function DailyChallengeModel:SetDifficulty(stageTid)
  if not stageTid or 0 == stageTid then
    self.difficulty = 0
    return
  end
  local cfg = DT.Stage[stageTid]
  self.difficulty = cfg and cfg.DailyChallengeDifficulty or 0
end

return DailyChallengeModel
