local WeeklyChallengeData = class("WeeklyChallengeData")
local WCEnum = require("Game.WeeklyChallenge.WCEnum")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")

function WeeklyChallengeData.CreatrWCData(id)
  local data = WeeklyChallengeData.New()
  data.id = id
  return data
end

function WeeklyChallengeData:ctor()
  self.id = nil
  self.cfg = nil
  self.heroIdList = {}
  self.isHaveRank = false
  self.currentMaxScore = 0
end

function WeeklyChallengeData:UpdateByMsg(weeklyChallengeElem, wcMsg)
  local heroGroup = weeklyChallengeElem.cfg.heroGroup
  self.heroIdList = {}
  for k, v in pairs(heroGroup) do
    table.insert(self.heroIdList, k)
  end
  self.baseRate = weeklyChallengeElem.cfg.baseRate
  self.cfg = ConfigData.weekly_challenge[self.id]
  local clgId = self.cfg.challenge_id
  local endTime = weeklyChallengeElem.cfg.endTime
  if ConfigData.weekly_challenge_config[clgId] == nil or ConfigData.weekly_challenge_config[clgId][endTime] == nil then
    error(string.format("Cant get weekly_challenge_config, id:%s, endTime:%s", clgId, endTime))
    return
  end
  self.wc_cfg = ConfigData.weekly_challenge_config[clgId][endTime]
  self._fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByWc(self.id, self.wc_cfg, weeklyChallengeElem.cfg)
  self.isHaveRank = self.cfg.have_rank > 0
  self:SetCurrentMaxScore(wcMsg)
end

function WeeklyChallengeData:SetCurrentMaxScore(wcMsg)
  if not self.isHaveRank then
    return
  end
  if wcMsg == nil or wcMsg.current == nil then
    return
  end
  if self.cfg.have_rank == WCEnum.eRankType.normal then
    self.currentMaxScore = wcMsg.current.score or 0
  elseif self.cfg.have_rank == WCEnum.eRankType.activity then
    self.currentMaxScore = wcMsg.current.score2 or 0
  end
end

function WeeklyChallengeData:RefreshCurrentMaxScore(score)
  if not self.isHaveRank then
    return
  end
  if score < (self.currentMaxScore or 0) then
    return
  end
  self.currentMaxScore = score
end

function WeeklyChallengeData:GetCurrentMaxScore()
  return self.currentMaxScore
end

function WeeklyChallengeData:GetWeeklyChanllengeChipDic()
  return self.wc_cfg.const_shop_poolDic
end

function WeeklyChallengeData:GetWCConfig()
  return self.cfg
end

function WeeklyChallengeData:GetIsHaveRankList()
  return self.isHaveRank
end

function WeeklyChallengeData:GetRankType()
  return self.cfg.have_rank
end

function WeeklyChallengeData:GetWeeklyType()
  return self.cfg.weekly_challenge_type
end

function WeeklyChallengeData:GetIsHaveRankReward()
  return ConfigData.weekly_challenge_rank_reward.isHaveReward[self.wc_cfg.rank_id]
end

function WeeklyChallengeData:GetRankRewardId()
  return self.wc_cfg.rank_id
end

function WeeklyChallengeData:IsUnlockWeeklyChallenge()
  return CheckCondition.CheckLua(self.cfg.pre_condition, self.cfg.pre_para1, self.cfg.pre_para2)
end

function WeeklyChallengeData:GetMapLogic()
  if self.wc_cfg ~= nil then
    return self.wc_cfg.map_logic
  end
  return nil
end

function WeeklyChallengeData:GetWCEndTime()
  if self.wc_cfg ~= nil then
    return self.wc_cfg.time_end
  end
end

function WeeklyChallengeData:GetFmtBuffSelectData()
  return self._fmtBuffSelectData
end

return WeeklyChallengeData
