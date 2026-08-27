local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityRoundData = class("ActivityRoundData", ActivityBase)
local RoundDataLottery = require("Game.ActivityRound.RoundDataLottery")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function ActivityRoundData:InitRoundData(msg)
  self:SetActFrameDataByType(ActivityFrameEnum.eActivityType.Round, msg.actId)
  self._id = msg.actId
  self._curRound = msg.curRoundId
  local frameId = self:GetActFrameId()
  self._roundPoolIds = ConfigData.activity_time_limit_pool_para.poolDic[frameId]
  self._roundPoolDic = {}
  self._fakerPoolDic = {}
  for index, poolId in ipairs(self._roundPoolIds) do
    local poolMsg = msg.rounds[index]
    if poolMsg ~= nil then
      local data = RoundDataLottery.New()
      data:UpdateRewardPoolLotteryData(poolMsg)
      self._roundPoolDic[poolMsg.roundId] = data
    else
      local data = RoundDataLottery.New()
      data:InitFackerPoolLotteryData(poolId)
      self._fakerPoolDic[poolId] = data
    end
  end
  self:UpdateActFrameDataSingleMsg(msg)
end

function ActivityRoundData:UpdateRoundData(msg)
  self._curRound = msg.curRoundId
  for _, roundMsg in ipairs(msg.rounds) do
    local data = self._roundPoolDic[roundMsg.roundId]
    if data ~= nil then
      data:UpdateRewardPoolLotteryData(roundMsg)
    else
      data = self._fakerPoolDic[roundMsg.roundId]
      if data ~= nil then
        data:UpdateRewardPoolLotteryData(roundMsg)
        self._roundPoolDic[roundMsg.roundId] = data
        self._fakerPoolDic[roundMsg.roundId] = nil
      else
        data = RoundDataLottery.New()
        data:UpdateRewardPoolLotteryData(roundMsg)
        self._roundPoolDic[roundMsg.roundId] = data
      end
    end
  end
end

function ActivityRoundData:GetRoundIds()
  return self._roundPoolIds
end

function ActivityRoundData:GetCurRoundId()
  return self._curRound
end

function ActivityRoundData:GetRoundPoolData(roundId)
  if self._roundPoolDic[roundId] ~= nil then
    return self._roundPoolDic[roundId]
  else
    return self._fakerPoolDic[roundId]
  end
end

function ActivityRoundData:GetRoundActId()
  return self._id
end

function ActivityRoundData:IsUnlockPool(id)
  return self._roundPoolDic[id] ~= nil
end

function ActivityRoundData:AllowReqRoundPool(poolId)
  if self._fakerPoolDic[poolId] == nil then
    return false
  end
  local index = table.indexof(self._roundPoolIds, poolId)
  if index then
    index = index - 1
    local prePoolId = self._roundPoolIds[index]
    if prePoolId == nil or self._roundPoolDic[prePoolId] == nil then
      return
    end
    local poolData = self._roundPoolDic[prePoolId]
    return poolData:IsSoldOutRoundBigReward()
  end
  return false
end

return ActivityRoundData
