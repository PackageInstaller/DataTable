local AllWeeklyChallengeData = class("AllWeeklyChallengeData")
local WeeklyChallengeData = require("Game.WeeklyChallenge.WeeklyChallengeData")

function AllWeeklyChallengeData:ctor()
  self.dataDic = {}
  self.isOutOfData = true
  self.rewardDic = {}
  self.doublePickTm = nil
  self.rankTm = 0
  self.lastTm = nil
end

function AllWeeklyChallengeData:UpdateByMsg(msg)
  self.dataDic = {}
  for id, weeklyChallengeElem in pairs(msg.elem) do
    if self.dataDic[id] ~= nil then
      self.dataDic[id]:UpdateByMsg(weeklyChallengeElem, msg.wc)
    else
      local data = WeeklyChallengeData.CreatrWCData(id)
      data:UpdateByMsg(weeklyChallengeElem, msg.wc)
      self.dataDic[id] = data
    end
  end
  if msg.wc ~= nil then
    self.rankTm = msg.wc.current.rankTm or 0
    self.rewardDic = msg.wc.reward or {}
    self.doublePickTm = msg.wc.current.doublePickTm
    self.maxScore = msg.wc.maxScore or {}
    self.maxScore.score1 = self.maxScore.score1 or 0
    self.maxScore.score2 = self.maxScore.score2 or 0
  end
  self.lastTm = msg.lastEndTm
  self.isOutOfData = false
end

function AllWeeklyChallengeData:UpdateScoreInfo(dungeonId, score, rewardDic)
  local isHaveNot = true
  for k, v in pairs(self.dataDic) do
    if k == dungeonId then
      isHaveNot = false
      break
    end
  end
  if isHaveNot then
    return
  end
  if rewardDic ~= nil and table.count(rewardDic) > 0 then
    for k, v in pairs(rewardDic) do
      if self.rewardDic[k] == nil then
        self.rewardDic[k] = v
      else
        self.rewardDic[k] = self.rewardDic[k] + v
      end
    end
  end
  local WCData = self:GetWeeklyChallengeDataByDungeonId(dungeonId)
  if WCData ~= nil and self.rankTm > PlayerDataCenter.timestamp then
    WCData:RefreshCurrentMaxScore(score)
  end
end

function AllWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(dungeonId)
  return self.dataDic[dungeonId]
end

function AllWeeklyChallengeData:GetWeeklyChallengeReward()
  local rewardMax = ConfigData.game_config.weeklyRewardMax
  local counterElem = self:GetCounterElem()
  local isFinish = counterElem == nil or counterElem.nextExpiredTm < PlayerDataCenter.timestamp
  return isFinish, self.rewardDic[1] or 0, rewardMax[1] or 0, self.rewardDic[2] or 0, rewardMax[2] or 0
end

function AllWeeklyChallengeData:GetCounterElem()
  return ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleWeeklyChallengeFresh, 0)
end

function AllWeeklyChallengeData:IsUnlockExtraReward()
  for _, data in pairs(self.dataDic) do
    if #data.cfg.base_reward > 1 and data:IsUnlockWeeklyChallenge() then
      return true
    end
  end
  return false
end

function AllWeeklyChallengeData:SetOutOfData()
  self.isOutOfData = true
end

function AllWeeklyChallengeData:IsOutOfData()
  return self.isOutOfData
end

function AllWeeklyChallengeData:IsExistChallenge()
  return table.count(self.dataDic) > 0
end

function AllWeeklyChallengeData.ConvetTypeReward2RewadDic(weeklyReward)
  local num = 0
  for type, rewardNum in pairs(weeklyReward) do
    num = rewardNum + num
  end
  if 0 < num then
    return {
      [ConfigData.game_config.weeklyRewardItemId] = num
    }
  else
    return nil
  end
end

function AllWeeklyChallengeData:IsTokenReach2Capacity()
  local isFinish, baseNum, baseMax, extrNum, extrMax = self:GetWeeklyChallengeReward()
  if isFinish or baseMax <= baseNum and extrMax <= extrNum then
    return true
  end
  return false
end

function AllWeeklyChallengeData:GetIsUnderDoubleReward()
  if self.doublePickTm == nil then
    return true
  end
  return PlayerDataCenter.timestamp >= self.doublePickTm
end

function AllWeeklyChallengeData:GetWCIsHaveReplaceUIType()
  local curEndTm
  for id, wcData in pairs(self.dataDic) do
    curEndTm = wcData:GetWCEndTime()
    break
  end
  local fakeType = {}
  for key, value in pairs(UIWindowGlobalConfig[UIWindowTypeID.DailyChallenge]) do
    fakeType[key] = value
  end
  local wcAppCfg = ConfigData.challenge_appearance[curEndTm]
  if wcAppCfg == nil or string.IsNullOrEmpty(wcAppCfg.ui_prefab) then
    return nil, fakeType
  end
  fakeType.PrefabName = wcAppCfg.ui_prefab
  return true, fakeType
end

function AllWeeklyChallengeData:GetIsHaveLastActivityWCRank()
  if self:GetWeeklyChallengeDataByDungeonId(1503) ~= nil then
    return false
  end
  local maxActitvityEndTime = 0
  for id, wcCfgs in pairs(ConfigData.weekly_challenge_config) do
    if id == 103 then
      for tiem_end, wcCfg in pairs(wcCfgs) do
        if tiem_end > maxActitvityEndTime then
          maxActitvityEndTime = tiem_end
        end
      end
    end
  end
  if PlayerDataCenter.timestamp < maxActitvityEndTime + 1209600 then
    return true
  end
  return false
end

function AllWeeklyChallengeData:GetWeelyNodeMaxScore()
  self.maxScore = self.maxScore or {}
  self.maxScore.score1 = self.maxScore.score1 or 0
  return self.maxScore.score1
end

function AllWeeklyChallengeData:GetSpecNodeMaxScore()
  self.maxScore = self.maxScore or {}
  self.maxScore.score2 = self.maxScore.score2 or 0
  return self.maxScore.score2
end

return AllWeeklyChallengeData
