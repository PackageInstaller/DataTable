local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySectorIData = class("ActivitySectorIData", ActivityBase)
local base = ActivityBase
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local cs_FixRandom = CS.FixRandom

function ActivitySectorIData:InitDataByMsg(msg)
  self.actId = msg.actId
  self._cfg = ConfigData.activity_time_limit[self.actId]
  self:SetActFrameDataByType(ActivityFrameEnum.eActivityType.SectorI, self.actId)
  self.__isReadOnLogin = false
  self.__challengeStageId = 0
  local stageList = ConfigData.sector_stage.sectorIdList[self._cfg.rechallenge_stage]
  if stageList ~= nil and 0 < #stageList then
    self.__challengeStageId = stageList[1]
  end
  if self.__challengeStageId > 0 and not PlayerDataCenter.sectorStage:IsStageUnlock(self.__challengeStageId) then
    function self.__onSectorStageStateChange(data)
      if not PlayerDataCenter.sectorStage:IsStageUnlock(self.__challengeStageId) then
        return
      end
      self:RefreshSectorIReddot()
      UserMsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
    end
    
    UserMsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
  end
  self:UpdateDataByMsg(msg)
end

function ActivitySectorIData:UpdateDataByMsg(msg)
  self.battleCount = msg.times
  self.extraTimes = msg.extraTimes
  local expireTm = msg.expireTm
  if expireTm ~= self.expireTm then
    self.expireTm = expireTm
    if 0 < expireTm then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      timePassCtrl:AddEventTimer(expireTm, function()
        self:RefreshSectorIReddot()
        MsgCenter:Broadcast(eMsgEventId.SectorActivityTimePass)
      end)
    end
  end
  self.recordSectorId = msg.recordSectorId
  if msg.roundElem ~= nil then
    self.roundId = msg.roundElem.roundId
    self.randomSeed = msg.roundElem.roundSeed
    self.roundTimes = msg.roundElem.roundTimes
    self.roundIndex = msg.roundElem.roundIndex
    self.poolParaCfg = ConfigData.activity_time_limit_pool_para[self.roundId]
  end
  self:RefreshSectorIReddot()
end

function ActivitySectorIData:GetSectorICfg()
  return self._cfg
end

function ActivitySectorIData:GetSectorIBattleCount()
  if PlayerDataCenter.timestamp >= self.expireTm then
    return true, 0, self._cfg.frequency_day
  end
  local totalCount = self.extraTimes + self._cfg.frequency_day
  return totalCount > self.battleCount, self.battleCount, totalCount
end

function ActivitySectorIData:GetNextExpireTimeInShow()
  local timeCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
  local nextTime = self.expireTm
  if nextTime == 0 then
    nextTime = timeCtrl:GetLogicTodayPassTimeStamp()
  end
  if nextTime > PlayerDataCenter.timestamp then
    return nextTime
  end
  nextTime = timeCtrl:GetLogicTodayPassTimeStamp()
  return nextTime
end

function ActivitySectorIData:GetExtraTimesCount()
  for i, times in ipairs(self._cfg.refresh_times) do
    if times > self.extraTimes then
      return true, self._cfg.refreshCostId, self.self._cfg.refreshCostNum[i]
    end
  end
  return false
end

function ActivitySectorIData:GetLastSectorISector()
  return self.recordSectorId == self._cfg.easy_stage or self.recordSectorId == self._cfg.hard_stage, self.recordSectorId
end

function ActivitySectorIData:RefreshSectorIReddot()
  self:__RefreshChallengeReddot()
end

function ActivitySectorIData:__RefreshChallengeReddot()
  local redDotNode = self:GetActivityReddot()
  if redDotNode == nil then
    return
  end
  if self.__challengeStageId == 0 then
    redDotNode:SetRedDotCount(0)
    return
  end
  local isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(self.__challengeStageId)
  if not isUnlock then
    redDotNode:SetRedDotCount(0)
    return
  end
  if self.actInfo:IsActivityRunningTimeout() then
    redDotNode:SetRedDotCount(0)
  else
    local _, battleCount, allCount = self:GetSectorIBattleCount()
    local remainCount = allCount - battleCount
    redDotNode:SetRedDotCount(remainCount)
  end
end

function ActivitySectorIData:GetActSectorIDataPoolIdList()
  local list = ConfigData.activity_time_limit_pool_para.poolDic[self:GetActFrameId()]
  if list == nil then
    error(" activity_time_limit_pool_para NIL ID:" .. tostring(self:GetActFrameId()))
    return table.emptytable
  end
  return list
end

function ActivitySectorIData:GetActSectorIDataCoinId()
  local coinId = ConfigData.activity_time_limit_pool_para.activityCoinDic[self:GetActFrameId()]
  if coinId == nil then
    error(" activity_time_limit_pool_para NIL Coin ID:" .. tostring(self:GetActFrameId()))
  end
  return coinId
end

function ActivitySectorIData:GetRelationStage(stageId)
  if not self:IsActivityRunning() then
    return nil
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil or stageCfg.sector ~= self._cfg.hard_stage then
    return nil
  end
  local sectorDiffDic = ConfigData.sector_stage.sectorDiffDic[self._cfg.easy_stage]
  if sectorDiffDic == nil then
    return nil
  end
  sectorDiffDic = sectorDiffDic[stageCfg.difficulty]
  if sectorDiffDic == nil then
    return nil
  end
  local relationId = sectorDiffDic[stageCfg.num]
  if relationId == nil then
    return nil
  end
  return ConfigData.sector_stage[relationId]
end

function ActivitySectorIData.GetUniqRandsWithSourceShuffleQuantity(fixRandom, normalNum, maxNum)
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

function ActivitySectorIData.ShuffleRandomPool(randomPoolData, fixRandom)
  local maxNum = #randomPoolData.arr
  local size = maxNum - randomPoolData.bigNum
  local bigIdxList = ActivitySectorIData.GetBigIdx(fixRandom, randomPoolData)
  local arr = ActivitySectorIData.GetUniqRandsWithSourceShuffleQuantity(fixRandom, size, maxNum)
  for i, j in ipairs(bigIdxList) do
    arr[maxNum - i + 1], arr[j] = arr[j], arr[maxNum - i + 1]
  end
  return arr
end

function ActivitySectorIData.GetBigIdx(fixRandom, randomPoolData)
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

function ActivitySectorIData.GenShuffle(randomPoolData, randomSeed, start, count, callback)
  local total = start + count
  if total > #randomPoolData.arr then
    error("Shuffle out of range")
    return
  end
  local fixRandom = cs_FixRandom(randomSeed)
  local arr = ActivitySectorIData.ShuffleRandomPool(randomPoolData, fixRandom)
  for i = start + 1, total do
    local id = randomPoolData.arr[arr[i]]
    if callback ~= nil then
      callback(id)
    end
  end
end

function ActivitySectorIData:_GenShuffleDataPool()
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

function ActivitySectorIData:GenActSectorIRewardExchanged()
  local randomPoolData = self:_GenShuffleDataPool()
  local pickedRewardPoolIdDic = table.GetDefaulValueTable(0)
  ActivitySectorIData.GenShuffle(randomPoolData, self.randomSeed, 0, self.roundIndex, function(id)
    pickedRewardPoolIdDic[id] = pickedRewardPoolIdDic[id] + 1
  end)
  return pickedRewardPoolIdDic
end

function ActivitySectorIData:CheckShuffleResult(startIdx, count, rewardList)
  local pickedRewardList = {}
  local randomPoolData = self:_GenShuffleDataPool()
  ActivitySectorIData.GenShuffle(randomPoolData, self.randomSeed, startIdx, count, function(id)
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

function ActivitySectorIData:GetMainWindowIsFirstInit()
  if self._mainWinIsFirst == nil then
    self._mainWinIsFirst = true
  end
  return self._mainWinIsFirst
end

function ActivitySectorIData:SetMainWindowIsFirstInit(bool)
  self._mainWinIsFirst = bool
end

function ActivitySectorIData:GetChapterPosList()
  return self._cfg.chapterPosList
end

function ActivitySectorIData:GetChapterHasUnlock()
  local unlock = true
  if self._cfg.down_time ~= nil and PlayerDataCenter.timestamp < self._cfg.down_time then
    unlock = false
  end
  return unlock, self._cfg.down_time
end

return ActivitySectorIData
