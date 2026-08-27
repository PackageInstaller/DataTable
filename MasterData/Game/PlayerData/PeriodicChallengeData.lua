local PeriodicChallengeData = class("PeriodicChallengeData")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")

function PeriodicChallengeData:ctor()
  self.dataHasError = nil
  self.dailyChallengeId = nil
  self.dailyBuffList = nil
  self.dailyChipList = nil
  self.isDailyOutOfData = true
end

function PeriodicChallengeData:UpdateFromDailyChallengeMsg(msg)
  self.isDailyOutOfData = false
  self.dataHasError = nil
  if msg.data == nil then
    print("daily challenge mag data is nil")
    self.dataHasError = true
    return
  end
  self.dailyChallengeId = msg.data.id
  self.dailyBuffList = msg.data.randomData.buffList
  self.dailyChipPoolList = msg.data.randomData.algPoolList
  self:__GenChipList()
  local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
  if periodicRedNote ~= nil then
    local num = self:GetIsDailyChallengeFished() and 0 or 1
    periodicRedNote:SetRedDotCount(num)
  end
end

function PeriodicChallengeData:GetChallengeId(eChallengeType)
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    return self.dailyChallengeId
  end
end

function PeriodicChallengeData:GetChallengeBuffList(eChallengeType)
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    return self.dailyBuffList
  end
  return
end

function PeriodicChallengeData:__GenChipList()
  self.dailyChipList = {}
  for _, chipPoolId in ipairs(self.dailyChipPoolList) do
    local chipPoolCfg = ConfigData.ep_function_pool[chipPoolId]
    for _, chipId in ipairs(chipPoolCfg.function_pool) do
      table.insert(self.dailyChipList, chipId)
    end
  end
end

function PeriodicChallengeData:GetDailyChallengeChipList(eChallengeType)
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    return self.dailyChipList
  end
  return
end

function PeriodicChallengeData:GetChallengeCounterElem(eChallengeType)
  if eChallengeType == PeridicChallengeEnum.eChallengeType.daliy then
    return ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleDailyChallenge, 0)
  end
end

function PeriodicChallengeData:GetIsDailyChallengeFished()
  local counterElem = self:GetChallengeCounterElem(PeridicChallengeEnum.eChallengeType.daliy)
  return counterElem ~= nil and counterElem.times == 2
end

function PeriodicChallengeData:GetDailyChallengeStage()
  local maxReward = ConfigData.game_config.dailyRewardMax
  if self:GetIsDailyChallengeFished() then
    return true, maxReward, maxReward
  end
  local counterElem = self:GetChallengeCounterElem(PeridicChallengeEnum.eChallengeType.daliy)
  if counterElem == nil then
    return 0
  end
  local mask = 1000
  local number = 0
  if mask < counterElem.times then
    number = counterElem.times - mask
  end
  return false, number, maxReward
end

function PeriodicChallengeData:SetIsDailyOutOfData(bool)
  self.isDailyOutOfData = bool
end

function PeriodicChallengeData:GetIsDailyOutOfData()
  return self.isDailyOutOfData
end

return PeriodicChallengeData
