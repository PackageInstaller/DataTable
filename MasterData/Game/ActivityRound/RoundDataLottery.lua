local RoundlotteryData = class("RoundlotteryData")
local cs_FixRandom = CS.FixRandom

function RoundlotteryData:InitFackerPoolLotteryData(poolId)
  self.roundId = poolId
  self.randomSeed = 0
  self.roundTimes = 0
  self.roundIndex = 0
  self.poolParaCfg = ConfigData.activity_time_limit_pool_para[self.roundId]
end

function RoundlotteryData:UpdateRewardPoolLotteryData(roundMsg)
  local lastIndex = self.roundIndex
  self.roundId = roundMsg.roundId
  self.randomSeed = roundMsg.roundSeed
  self.roundTimes = roundMsg.roundTimes
  self.roundIndex = roundMsg.roundIndex
  self.poolParaCfg = ConfigData.activity_time_limit_pool_para[self.roundId]
  if (lastIndex or 0) ~= self.roundIndex then
    self._history = self:GenRoundRewardExchanged()
  end
end

function RoundlotteryData:GetRoundId()
  return self.roundId
end

function RoundlotteryData:GetRoundTimes()
  return self.roundIndex
end

function RoundlotteryData:GetPoolParaCfg()
  return self.poolParaCfg
end

function RoundlotteryData:GetRoundTotalTimes()
  return self.poolParaCfg.allRewardNum
end

function RoundlotteryData:GetRoundRemainTimes()
  return self.poolParaCfg.allRewardNum - self.roundIndex
end

function RoundlotteryData:GetRoundSingleRewardCount(rewardId)
  local content = self.poolParaCfg.poolContent[rewardId]
  local allNum = content.num
  if self._history == nil then
    return 0, allNum
  end
  local usedNum = self._history[rewardId] or 0
  return usedNum, allNum
end

function RoundlotteryData:IsSoldOutRoundBigReward()
  local bigRewardIds = self.poolParaCfg.reward_id
  for i, rewardId in ipairs(bigRewardIds) do
    local content = self.poolParaCfg.poolContent[rewardId]
    if self._history == nil or content.num > (self._history[rewardId] or 0) then
      return false
    end
  end
  return true
end

function RoundlotteryData.GetUniqRandsWithSourceShuffleQuantity(fixRandom, normalNum, maxNum)
  if normalNum == 0 then
    error("normalNum == 0")
    return table.emptytable
  end
  if maxNum < normalNum then
    normalNum = maxNum
  end
  local list = {}
  for i = 1, maxNum do
    table.insert(list, i)
  end
  maxNum = normalNum
  for i = 1, normalNum do
    local r = fixRandom:RandUInt()
    local j = r % maxNum + i
    list[i], list[j] = list[j], list[i]
    maxNum = maxNum - 1
  end
  return list
end

function RoundlotteryData.ShuffleRandomPool(randomPoolData, fixRandom)
  local maxNum = #randomPoolData.arr
  local size = maxNum - randomPoolData.bigNum
  local bigIdxList = RoundlotteryData.GetBigIdx(fixRandom, randomPoolData)
  local arr = RoundlotteryData.GetUniqRandsWithSourceShuffleQuantity(fixRandom, size, maxNum)
  for i, j in ipairs(bigIdxList) do
    arr[maxNum - i + 1], arr[j] = arr[j], arr[maxNum - i + 1]
  end
  return arr
end

function RoundlotteryData.GetBigIdx(fixRandom, randomPoolData)
  local outList = {}
  local i = 0
  while i < randomPoolData.bigNum do
    local j = fixRandom:RandUInt(0, randomPoolData.bigRewardSecB - randomPoolData.bigRewardSecA) + randomPoolData.bigRewardSecA
    j = j + 1
    for k, v in pairs(outList) do
      if j == v then
        goto lbl_29
      end
    end
    table.insert(outList, j)
    i = i + 1
    ::lbl_29::
  end
  return outList
end

function RoundlotteryData.GenShuffle(randomPoolData, randomSeed, start, count, callback)
  local total = start + count
  if total > #randomPoolData.arr then
    error("Shuffle out of range")
    return
  end
  local fixRandom = cs_FixRandom(randomSeed)
  local arr = RoundlotteryData.ShuffleRandomPool(randomPoolData, fixRandom)
  for i = start + 1, total do
    local id = randomPoolData.arr[arr[i]]
    if callback ~= nil then
      callback(id)
    end
  end
end

function RoundlotteryData:_GenShuffleDataPool()
  local bigNum = 0
  local bigRewardIdDic = {}
  for k, rewardId in ipairs(self.poolParaCfg.reward_id) do
    local bigRewardCfg = self.poolParaCfg.poolContent[rewardId]
    bigNum = bigNum + bigRewardCfg.num
    bigRewardIdDic[rewardId] = true
  end
  local randomPoolData = {
    arr = {},
    bigNum = bigNum,
    bigRewardSecA = self.poolParaCfg.section[1],
    bigRewardSecB = self.poolParaCfg.section[2]
  }
  for k, v in pairs(self.poolParaCfg.poolContent) do
    for i = 1, v.num do
      table.insert(randomPoolData.arr, k)
    end
  end
  table.sort(randomPoolData.arr, function(a, b)
    local aIsBig = bigRewardIdDic[a]
    local bIsBig = bigRewardIdDic[b]
    if aIsBig ~= bIsBig then
      return bIsBig
    end
    return a < b
  end)
  return randomPoolData
end

function RoundlotteryData:GenRoundRewardExchanged()
  local randomPoolData = self:_GenShuffleDataPool()
  local pickedRewardPoolIdDic = table.GetDefaulValueTable(0)
  RoundlotteryData.GenShuffle(randomPoolData, self.randomSeed, 0, self.roundIndex, function(id)
    pickedRewardPoolIdDic[id] = pickedRewardPoolIdDic[id] + 1
  end)
  return pickedRewardPoolIdDic
end

function RoundlotteryData:CheckShuffleResult(startIdx, count, rewardList)
  local pickedRewardList = {}
  local randomPoolData = self:_GenShuffleDataPool()
  RoundlotteryData.GenShuffle(randomPoolData, self.randomSeed, startIdx, count, function(id)
    table.insert(pickedRewardList, id)
  end)
  if #rewardList ~= #pickedRewardList then
    error("Num error")
  end
  for k, rewardId in ipairs(pickedRewardList) do
    if rewardList[k] ~= nil and rewardList[k].elemNumber ~= rewardId then
      warn(string.format("Check shuffle result failed,idx:%s,client:%s,server:%s", k, rewardId, rewardList[k].elemNumber))
    end
  end
end

return RoundlotteryData
