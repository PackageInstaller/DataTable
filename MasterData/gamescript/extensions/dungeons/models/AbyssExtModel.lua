local AbyssExtModel, Super = NewClass("AbyssExtModel", BaseModel)
local CONST_ABYSS_SCORE_OLD = "AbyssChallengeScore"
local CONST_ABYSS_REWARD_OLD = "AbyssChallengeScoreReward"
local CONST_ABYSS_SCORE_NEW = "AbyssChallengeScoreV260"
local CONST_ABYSS_REWARD_NEW = "AbyssChallengeScoreRewardV260"
local CONST_SWITCH_TIME = "AbyssChallengeV260Ts"
AbyssExtModel.TestForceRevivalMark = false

function AbyssExtModel:IsAbyssRevivalFeatureEnabled()
  return true
end

function AbyssExtModel:OnInit()
  self:OnReset()
  self:RegisterNotify(NotifyId.OnFacadeFieldDataChanged, self.OnFacadeFieldChanged, self)
end

function AbyssExtModel:OnReset()
  self:ResetAbyssDatas()
  local awardScoreArr = self:_GetAbyssScoreConfig()
  self.Max_Award_Num = awardScoreArr and #awardScoreArr or 0
  self.Default_Enter_Index = 1
  self.Rank_Req_Interval = 10
end

function AbyssExtModel:_IsUseV260RewardConfig()
  do return self.IsUseV260RewardConfigForActivity, self, self:GetCurrActivityTid() end
  return self.IsUseV260RewardConfigForActivity, self, self:GetCurrActivityTid()
end

function AbyssExtModel:IsUseV260RewardConfigForActivity(activityTid)
  if not activityTid then
    return false
  end
  local currActivityTid = self:GetCurrActivityTid()
  if activityTid == currActivityTid and self.abyssData and self.abyssData.isNewScoreRewardRule ~= nil then
    return self.abyssData.isNewScoreRewardRule
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  local switchTime = DT.GetOriginalConstant(CONST_SWITCH_TIME)
  if switchTime and switchTime > 0 then
    local activityStartTime = activityConfig and activityConfig.ActivityStartTime or 0
    return switchTime <= activityStartTime
  end
  return false
end

function AbyssExtModel:_GetAbyssScoreConfig()
  if self:_IsUseV260RewardConfig() then
    return DT.GetOriginalConstant(CONST_ABYSS_SCORE_NEW) or {}
  end
  return DT.GetOriginalConstant(CONST_ABYSS_SCORE_OLD) or {}
end

function AbyssExtModel:_GetAbyssRewardConfig()
  if self:_IsUseV260RewardConfig() then
    return DT.GetOriginalConstant(CONST_ABYSS_REWARD_NEW) or {}
  end
  return DT.GetOriginalConstant(CONST_ABYSS_REWARD_OLD) or {}
end

function AbyssExtModel:ResetAbyssDatas()
  self.abyssData = {}
  self.rankStartIndexMap = {}
  self.season2ActivityMap = nil
  self.player2AbyssRecordCaches = {}
end

function AbyssExtModel:GetAbyssData()
  return self.abyssData
end

function AbyssExtModel:GetStageGroupDatas()
  return self.abyssData.stageGroups
end

function AbyssExtModel:GetCurrActivityTid()
  return self.abyssData and self.abyssData.activityTid
end

function AbyssExtModel:GetStageGroupData(stageGroupTid)
  if not stageGroupTid then
    return
  end
  return self.abyssData and self.abyssData.stageGroups and self.abyssData.stageGroups[stageGroupTid] or {}
end

function AbyssExtModel:GetScore()
  return self.abyssData and self.abyssData.score or 0
end

function AbyssExtModel:GetMaxScore()
  return self.abyssData and self.abyssData.maxScore or 0
end

function AbyssExtModel:GetMaxValidScore()
  return self.abyssData and self.abyssData.maxValidScore or 0
end

function AbyssExtModel:GetMaxScorePrize()
  return self.abyssData and self.abyssData.maxScorePrize or {}
end

function AbyssExtModel:GetStageGroupTidList()
  local activityTid = self.abyssData.activityTid
  if not activityTid then
    return
  end
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  if not activityConfig or not activityConfig.ActivityPara1 then
    return
  end
  local tidList = {}
  for i = 1, #activityConfig.ActivityPara1 do
    local stageGroupTid = activityConfig.ActivityPara1[i]
    table.insert(tidList, stageGroupTid)
  end
  return tidList
end

function AbyssExtModel:GetTeamData(stageGroupTid)
  if not stageGroupTid then
    return
  end
  local stageGroupData = self:GetStageGroupData(stageGroupTid)
  return stageGroupData and stageGroupData.team
end

function AbyssExtModel:GetCurReachAwardNum()
  local maxScore = self:GetMaxScore()
  local awardScoreArr = self:_GetAbyssScoreConfig()
  local reachCount = 0
  local configCount = awardScoreArr and #awardScoreArr or 0
  for i = 1, configCount do
    local needScore = awardScoreArr[i] or 0
    if maxScore >= needScore then
      reachCount = reachCount + 1
    end
  end
  return reachCount
end

function AbyssExtModel:GetGotAwardNum()
  local gotCount = 0
  local maxScorePrize = self:GetMaxScorePrize()
  if not maxScorePrize then
    return 0
  end
  for _, state in pairs(maxScorePrize) do
    if state == CommonDefine.TaskCommonState.Finish then
      gotCount = gotCount + 1
    end
  end
  local awardScoreArr = self:_GetAbyssScoreConfig()
  local configCount = awardScoreArr and #awardScoreArr or 0
  if configCount > 0 and gotCount > configCount then
    gotCount = configCount
  end
  return gotCount
end

function AbyssExtModel:GetPassText(stageGroupTid)
  local diffText = ""
  local stageGroupData = self:GetStageGroupData(stageGroupTid)
  if not stageGroupData or stageGroupData.stageTid <= 0 then
    return diffText
  end
  local stageConfig = CopyDataUtils.GetStageConfig(stageGroupData.stageTid)
  diffText = LT.Textf("AbyssChallengeStageClearance", LT.Text(stageConfig.Name))
  return diffText
end

function AbyssExtModel:GetMaxAwardNum()
  return self.Max_Award_Num
end

function AbyssExtModel:GetEndTime()
  return self.abyssData and self.abyssData.activityEndTs or 0
end

function AbyssExtModel:HasGotAward(awardIndex)
  local maxScorePrize = self:GetMaxScorePrize()
  if not maxScorePrize or not awardIndex then
    return false
  end
  local state = maxScorePrize[awardIndex]
  return state == CommonDefine.TaskCommonState.Finish
end

function AbyssExtModel:UpdateScorePrize(index, state)
  if not self.abyssData or not self.abyssData.maxScorePrize then
    return
  end
  self.abyssData.maxScorePrize[index] = state
  self:LocalNotify(NotifyId.OnAbyssScorePrizeStateChanged, index, state)
end

function AbyssExtModel:UpdateAbyssDataByServer(svrData)
  if not svrData then
    return
  end
  for k, v in pairs(svrData) do
    self.abyssData[k] = v
  end
  self:_InitStageGroups()
  local awardScoreArr = self:_GetAbyssScoreConfig()
  self.Max_Award_Num = awardScoreArr and #awardScoreArr or 0
  self:Notify(NotifyId.OnAbyssDataChanged)
end

function AbyssExtModel:_InitStageGroups()
  local activityTid = self.abyssData.activityTid
  if not activityTid then
    return
  end
  local stageGroups = self.abyssData and self.abyssData.stageGroups
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  if not activityConfig or not activityConfig.ActivityPara1 then
    return
  end
  for i = 1, #activityConfig.ActivityPara1 do
    local stageGroupTid = activityConfig.ActivityPara1[i]
    local stageGroupData = stageGroups and stageGroups[stageGroupTid]
    stageGroupData = stageGroupData or {
      stageGroupTid = stageGroupTid,
      stageTid = 0,
      score = 0,
      team = {}
    }
    local maxStageLevel = AbyssDataUtils.GetMaxStageLevel(stageGroupTid)
    stageGroupData.stageGroupTid = stageGroupTid
    stageGroupData.maxStageLevel = maxStageLevel
    self.abyssData.stageGroups[stageGroupTid] = stageGroupData
  end
end

function AbyssExtModel:UpdateTeamDataByServer(stageGroupTid, svrData, isExtra)
  if not stageGroupTid or not svrData then
    return
  end
  local abyssStageGroupData = self:GetStageGroupData(stageGroupTid)
  if not abyssStageGroupData then
    return
  end
  if isExtra then
    abyssStageGroupData.teamExtra = svrData
  else
    abyssStageGroupData.team = svrData
  end
  self:Notify(NotifyId.OnAbyssTeamDataChanged, stageGroupTid, isExtra, abyssStageGroupData)
end

function AbyssExtModel:IsHaveRecordStageData(teamData)
  return self:GetRecordStageData(teamData) ~= nil
end

function AbyssExtModel:GetRecordStageData(teamData)
  return teamData and teamData.recordStageData
end

function AbyssExtModel:GetProgressRewardDatas()
  local stars = self:_GetAbyssScoreConfig()
  local rewards = self:_GetAbyssRewardConfig()
  local size = math.min(#stars, #rewards)
  local maxScore = self:GetMaxScore()
  local progressRewardDatas = {}
  for i = 1, size do
    local star = stars[i] or 0
    local rewardArrCfg = rewards[i]
    local rewardArr = {}
    for idx = 1, #rewardArrCfg, 2 do
      local tid = rewardArrCfg[idx]
      local num = rewardArrCfg[idx + 1]
      if tid and num then
        table.insert(rewardArr, {tid = tid, num = num})
      end
    end
    local isAttach = maxScore >= star
    local isGet = self:HasGotAward(i)
    
    local function _ReqGetRewardFunc()
      AbyssController.Instance:ReqGainAbyssPrize(i)
    end
    
    local rewardData = {
      awardIndex = i,
      star = star,
      needStar = star,
      awardTitle = LT.Text("AbyssChallengeScore"),
      rewards = rewardArr,
      hideStar = true,
      isAttach = isAttach,
      isGet = isGet,
      gainRewardFunc = _ReqGetRewardFunc
    }
    if rewardData.reqGetAwardFunc then
      setmetatable(rewardData, ReactiveFlags.SKIP)
    end
    table.insert(progressRewardDatas, rewardData)
  end
  return progressRewardDatas
end

function AbyssExtModel:GetFirstNotPassedStageGroupIndex(stageGroupTidList)
  local result = self.Default_Enter_Index
  if not stageGroupTidList then
    return result
  end
  for idx, stageGroupTid in ipairs(stageGroupTidList) do
    local stageGroupData = self:GetStageGroupData(stageGroupTid)
    if stageGroupData and (not stageGroupData.stageTid or stageGroupData.stageTid <= 0) then
      result = idx - 1
      break
    end
  end
  if result <= 0 then
    result = self.Default_Enter_Index
  end
  return result
end

function AbyssExtModel:HasStageGroupPassed(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local stageGroupData = self:GetStageGroupData(stageGroupTid)
  return stageGroupData and stageGroupData.stageTid and stageGroupData.stageTid > 0
end

function AbyssExtModel:GetPassedStageTid(stageGroupTid)
  if not stageGroupTid then
    return
  end
  local stageGroupData = self:GetStageGroupData(stageGroupTid)
  return stageGroupData and stageGroupData.stageTid
end

function AbyssExtModel:CalcRecordDataListByServer(activityTid, stageGroupDatas)
  local recordList = {}
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  if not activityConfig or not activityConfig.ActivityPara1 then
    return recordList
  end
  for _, stageGroupTid in ipairs(activityConfig.ActivityPara1) do
    local stageGroupData = {score = 0}
    if stageGroupDatas and stageGroupDatas[stageGroupTid] then
      if type(stageGroupDatas[stageGroupTid]) == "table" then
        stageGroupData = stageGroupDatas[stageGroupTid]
      else
        stageGroupData.score = stageGroupDatas[stageGroupTid]
      end
    end
    local stageName = LT.Text(CopyDataUtils.GetStageGroupName(stageGroupTid) or "")
    stageGroupData.stageGroupTid = stageGroupTid
    stageGroupData.isExtra = false
    stageGroupData.showName = stageName
    table.insert(recordList, stageGroupData)
    if stageGroupData.extraPass or stageGroupData.widExtra and "" ~= stageGroupData.widExtra then
      local extraStageGroupData = table.clone(stageGroupData)
      extraStageGroupData.isExtra = true
      extraStageGroupData.wid = stageGroupData.widExtra
      extraStageGroupData.battleUuid = stageGroupData.battleUuidExtra
      local textExtra = LT.Text("AbyssChallengeHistoricalRecord")
      extraStageGroupData.showName = stageName .. textExtra
      table.insert(recordList, extraStageGroupData)
    end
  end
  return recordList
end

function AbyssExtModel:GetRankReqInterval()
  return self.Rank_Req_Interval
end

function AbyssExtModel:GetStartIndex(rankKey)
  return self.rankStartIndexMap[rankKey] or 1
end

function AbyssExtModel:GetRankList(activityTid)
  do return RankModel.Instance.GetRankListData, RankModel.Instance, RankDefine.RankType.AbyssChallenge end
  return RankModel.Instance.GetRankListData, RankModel.Instance, RankDefine.RankType.AbyssChallenge, activityTid
end

function AbyssExtModel:GetSeasonOptionList(activityTid)
  local activityConfig = ActivityDataUtils.GetConfig(activityTid)
  if not activityConfig or not activityConfig.ActivityPara2 then
    return {}
  end
  local optionDataList = {}
  local currSeason = activityConfig.ActivityPara2
  local lastSeason = math.max(1, currSeason - 1)
  local curSeasonOptionData = {
    key = self:GetActivityTidBySeason(currSeason),
    text = LT.Text("AbyssChallengeRankThisPeriod")
  }
  local lastSeasonOptionData
  if lastSeason ~= currSeason then
    lastSeasonOptionData = {
      key = self:GetActivityTidBySeason(lastSeason),
      text = LT.Text("AbyssChallengeRankPreviousPeriod")
    }
    table.insert(optionDataList, lastSeasonOptionData)
  end
  table.insert(optionDataList, curSeasonOptionData)
  return optionDataList
end

function AbyssExtModel:GetActivityTidBySeason(season)
  if not season then
    return
  end
  if self.season2ActivityMap then
    return self.season2ActivityMap[season]
  end
  self.season2ActivityMap = {}
  for activityTid, config in pairs(DT.Activity) do
    if config.ActivityType == ActivityDefine.ActivityType.Abyss and config.ActivityPara2 then
      self.season2ActivityMap[config.ActivityPara2] = activityTid
    end
  end
  return self.season2ActivityMap[season]
end

function AbyssExtModel:OnFacadeFieldChanged(playerUid, facadeField, data)
  if "abyssChallenge" ~= facadeField or not data then
    return
  end
  local abyssChallengeData = data.abyssChallenge
  if abyssChallengeData and abyssChallengeData.activityId2Data then
    local updateStageGroupTid
    for activityTid, seasonData in pairs(abyssChallengeData.activityId2Data) do
      if seasonData.stageGroups then
        for stageGroupTid, stageGroupData in pairs(seasonData.stageGroups) do
          stageGroupData.stageGroupTid = stageGroupTid
          self:SetRecordCacheData(playerUid, activityTid, stageGroupData)
          updateStageGroupTid = stageGroupData.stageGroupTid
          self:Notify(NotifyId.OnStageRecordDataChanged, updateStageGroupTid)
        end
      end
    end
  end
end

function AbyssExtModel:GetRecordKey(activityTid, stageGroupTid)
  return activityTid .. "_" .. stageGroupTid
end

function AbyssExtModel:GetRecordCacheData(playerUid, activityTid, stageGroupTid)
  if not self.player2AbyssRecordCaches[playerUid] then
    return
  end
  local cacheKey = self:GetRecordKey(activityTid, stageGroupTid)
  return self.player2AbyssRecordCaches[playerUid][cacheKey]
end

function AbyssExtModel:SetRecordCacheData(playerUid, activityTid, stageGroupData)
  if not self.player2AbyssRecordCaches[playerUid] then
    self.player2AbyssRecordCaches[playerUid] = {}
  end
  local cacheKey = self:GetRecordKey(activityTid, stageGroupData.stageGroupTid)
  self.player2AbyssRecordCaches[playerUid][cacheKey] = stageGroupData
end

function AbyssExtModel:ClearRecordCacheData()
  table.clear(self.player2AbyssRecordCaches)
end

function AbyssExtModel:CheckUpdateRankRecordCache(playerUid, activityTid, stageGroupTid, score)
  local cacheData = self:GetRecordCacheData(playerUid, activityTid, stageGroupTid)
  local cacheScore = cacheData and cacheData.score or 0
  if score > cacheScore then
    AbyssController.Instance:ReqAbyssRankRecordData(playerUid, activityTid, stageGroupTid)
    return true
  end
  return false
end

function AbyssExtModel:GetCacheSeasonMaxScore(playerUid, activityTid)
  local playerCaches = self.player2AbyssRecordCaches[playerUid]
  local activityTidStr = tostring(activityTid)
  local maxScore = 0
  for cacheKey, stageGroupData in pairs(playerCaches) do
    if string.contains(cacheKey, activityTidStr) then
      maxScore = maxScore + (stageGroupData and stageGroupData.score or 0)
    end
  end
  return maxScore
end

return AbyssExtModel
