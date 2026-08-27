local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityDailyChallengeData = class("ActivityDailyChallengeData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")
local CurActType = ActivityFrameEnum.eActivityType.DailyChallenge
local CS_PlayerPrefs = CS.UnityEngine.PlayerPrefs
local PlayerPrefsConsts = require("Game.Login.PlayerPrefsEnum")

function ActivityDailyChallengeData:ctor()
end

function ActivityDailyChallengeData:InitADCData(msg)
  self._isOpened = false
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._cfg = ConfigData.activity_dailychallenge[msg.actId]
  self._dungeonCfg = ConfigData.activity_dailychallenge_dungeon[msg.actId]
  self._awardCfg = ConfigData.activity_dailychallenge_award[msg.actId]
  self._cycleAwardCfg = ConfigData.activity_dailychallenge_award.cyclePhaseDic[msg.actId]
  self._maxFixedPoint = self._awardCfg[#self._awardCfg].need_point
  self:UpdateADCData(msg)
  self._fmtSelectDic = {}
  self.isInfinite = false
end

function ActivityDailyChallengeData:UpdateADCData(msg)
  self._dungeonPointDic = {}
  for k, v in pairs(msg.dungeonPoint) do
    self:SetDungeonPointDic(k, v >> 32)
  end
  self._extraGotPoint = msg.extraGotPoint
  self._nextUnlockRefreshTime = msg.nextUnlockRefreshTime
  self._totalPoint = 0
  for dungeonId, point in pairs(self._dungeonPointDic) do
    self._totalPoint = self._totalPoint + point
  end
  self._rewardGotPointDic = {}
  for i, score in ipairs(msg.rewardGotPoint) do
    self._rewardGotPointDic[score] = true
  end
  self._maxDamage = msg.maxDamage
  self:__RefreshReddot()
end

function ActivityDailyChallengeData:UpdateADCKeyItemMsg(msg)
  self._nextUnlockRefreshTime = msg.nextExpiredTm
end

function ActivityDailyChallengeData:InitBlueDotNeedData()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  self.isUsedDungeonIds = userDataCache:GetADCDungeonIdS(self:GetActId())
  self.isUsedBlueDirty = false
  self.isShowBlueDot = false
end

function ActivityDailyChallengeData:SetDungeonPointDic(dungeonId, score)
  self._dungeonPointDic[dungeonId] = score
  if self.isUsedDungeonIds == nil then
    self:InitBlueDotNeedData()
  end
  if self.isShowBlueDot == false and not table.contain(self.isUsedDungeonIds, dungeonId) then
    local dungeonCfg = self._dungeonCfg[dungeonId]
    if dungeonCfg ~= nil and dungeonCfg.is_infinite then
      self.isShowBlueDot = true
      self.isUsedBlueDirty = true
    end
  end
end

function ActivityDailyChallengeData:SetADCDunegonPoint(dungeonId, score)
  if self:IsADCDungeonUnlock(dungeonId) then
    self._totalPoint = self._totalPoint - self._dungeonPointDic[dungeonId]
    self:SetDungeonPointDic(dungeonId, score)
    self._totalPoint = self._totalPoint + score
    self:__RefreshReddot()
  end
end

function ActivityDailyChallengeData:TryUpdateADCDunegonMaxDmg(dungeonId, dmg)
  if self:IsADCDungeonUnlock(dungeonId) then
    self._maxDamage[dungeonId] = math.max(self._maxDamage[dungeonId] or 0, dmg)
  end
end

function ActivityDailyChallengeData:ReqADCScoreReward(score, isCycle, getAll, callback)
  if not isCycle then
    if not self:IsCanADCFixedReward(score) then
      return
    end
  else
    if not self:IsCanADCExtraReward() then
      return
    end
    score = math.max(self._extraGotPoint, self._maxFixedPoint)
    score = score + math.floor((self._totalPoint - score) / self._cycleAwardCfg.need_point) * self._cycleAwardCfg.need_point
  end
  local adcNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityDailyChallenge)
  adcNet:CS_ACTIVITY_DailyChallenge_GetPointReward(self:GetActId(), score, getAll, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    local total = #msg.rewardGotPoint
    for index, rewardScore in ipairs(msg.rewardGotPoint) do
      if rewardScore <= self._maxFixedPoint then
        self._rewardGotPointDic[rewardScore] = true
      elseif index == total then
        self._extraGotPoint = rewardScore
      end
    end
    if score <= self._maxFixedPoint then
      self._rewardGotPointDic[score] = true
    else
      self._extraGotPoint = score
    end
    local rewardIds = {}
    local rewardNums = {}
    for k, v in pairs(msg.rewards) do
      table.insert(rewardIds, k)
      table.insert(rewardNums, v)
    end
    if 0 < #rewardIds then
      local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(heroIdSnapShoot, false):SetCRNotHandledGreat(true)
        window:AddAndTryShowReward(CRData)
      end)
    end
    self:__RefreshReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityDailyChallengeData:RefreshADCDailyFlush()
  self:__RefreshReddot()
end

function ActivityDailyChallengeData:ReqADCUnlockDungeon(dungeonId, callback)
  if self._dungeonPointDic[dungeonId] ~= nil then
    return
  end
  local dungeonCfg = self._dungeonCfg[dungeonId]
  if dungeonCfg == nil then
    return
  end
  if dungeonCfg.unlock_item > self:GetADCKeyItemCount() then
    return
  end
  local adcNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityDailyChallenge)
  adcNet:CS_ACTIVITY_DailyChallenge_UnlockDungeon(self:GetActId(), dungeonId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    for i, dungeonId in ipairs(msg.dungeon) do
      if self._dungeonPointDic[dungeonId] == nil then
        self:SetDungeonPointDic(dungeonId, 0)
      end
    end
    if callback ~= nil then
      callback()
    end
    MsgCenter:Broadcast(eMsgEventId.ActivityDailyChallengeDungeonUpdate, dungeonId)
  end)
end

function ActivityDailyChallengeData:SetIsInfinite(isInfinite)
  self.isInfinite = isInfinite
  if self.isInfinite and self.isUsedBlueDirty then
    self.isUsedDungeonIds = {}
    for k, v in pairs(self._dungeonPointDic) do
      table.insert(self.isUsedDungeonIds, k)
    end
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userDataCache:RecordADCDungeonIds(self:GetActId(), self.isUsedDungeonIds)
    self.isUsedBlueDirty = false
    self.isShowBlueDot = false
  end
end

function ActivityDailyChallengeData:SetAdcOpend()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  self._lastOpenMainUITime = math.floor(PlayerDataCenter.timestamp)
  userDataCache:RecordADCEnterTime(self:GetActId(), self._lastOpenMainUITime)
  self:__RefreshReddot()
end

function ActivityDailyChallengeData:__RefreshReddot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if not self:GetActivityIsUnlock() then
    reddot:SetRedDotCount(0)
    return
  end
  if self._lastOpenMainUITime == nil then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    self._lastOpenMainUITime = userDataCache:GetADCEnterTime(self:GetActId())
  end
  if TimeUtil:CompareIsCorssDay(self._lastOpenMainUITime, math.floor(PlayerDataCenter.timestamp)) then
    reddot:SetRedDotCount(1)
    return
  end
  if self:IsCanADCExtraReward() then
    reddot:SetRedDotCount(1)
    return
  end
  for k, cfg in ipairs(self._awardCfg) do
    if self:IsCanADCFixedReward(cfg.need_point) then
      reddot:SetRedDotCount(1)
      return
    end
  end
  reddot:SetRedDotCount(0)
end

function ActivityDailyChallengeData:GetIsShowBlueDot()
  return self.isShowBlueDot
end

function ActivityDailyChallengeData:IsCanADCFixedReward(score)
  return not self._rewardGotPointDic[score] and score <= self._totalPoint and score <= self._maxFixedPoint
end

function ActivityDailyChallengeData:IsCanADCExtraReward()
  if 0 < (self._extraGotPoint or 0) then
    return self._totalPoint - self._extraGotPoint >= self._cycleAwardCfg.need_point
  end
  return self._totalPoint - self._maxFixedPoint >= self._cycleAwardCfg.need_point
end

function ActivityDailyChallengeData:IsReceiveADCFixedReward(score)
  return self._rewardGotPointDic[score]
end

function ActivityDailyChallengeData:GetADCTotalPoint()
  return self._totalPoint
end

function ActivityDailyChallengeData:GetADCDungeonPoint(dungeonId)
  return self._dungeonPointDic[dungeonId] or 0
end

function ActivityDailyChallengeData:IsADCDungeonUnlock(dungeonId)
  return self._dungeonPointDic[dungeonId] ~= nil
end

function ActivityDailyChallengeData:GetADCHeightestDamage(dungeonId)
  return self._maxDamage[dungeonId] or 0
end

function ActivityDailyChallengeData:GetADCKeyItemRecure()
  return self._nextUnlockRefreshTime
end

function ActivityDailyChallengeData:GetADCKeyItemCount()
  return PlayerDataCenter:GetItemCount(self._cfg.unlock_item)
end

function ActivityDailyChallengeData:GetADCKeyItemId()
  return self._cfg.unlock_item
end

function ActivityDailyChallengeData:GetADCMaxFixedPoint()
  return self._maxFixedPoint
end

function ActivityDailyChallengeData:GetADCCycleGotPoint()
  return self._extraGotPoint
end

function ActivityDailyChallengeData:GetADCMainCfg()
  return self._cfg
end

function ActivityDailyChallengeData:GetADCDungeonCfg()
  return self._dungeonCfg
end

function ActivityDailyChallengeData:GetADCAwardCfg()
  return self._awardCfg
end

function ActivityDailyChallengeData:GetADCCycleAward()
  return self._cycleAwardCfg
end

function ActivityDailyChallengeData:GetIsInfinite()
  return self.isInfinite
end

function ActivityDailyChallengeData:GetADCDungeonCfgList(isInfinite)
  local dungeonList = {}
  for i, cfg in pairs(self._dungeonCfg) do
    if isInfinite and cfg.is_infinite then
      table.insert(dungeonList, cfg)
    elseif not isInfinite and not cfg.is_infinite then
      table.insert(dungeonList, cfg)
    end
  end
  return dungeonList
end

function ActivityDailyChallengeData:IsADCAllPass()
  for dungeonid, _ in pairs(self._dungeonCfg) do
    if self:GetADCDungeonPoint(dungeonid) == 0 then
      return false
    end
  end
  return true
end

function ActivityDailyChallengeData:IsEnoughADCItemKey()
  local needKeyNum = 0
  for dungeonid, cfg in pairs(self._dungeonCfg) do
    if not self:IsADCDungeonUnlock(dungeonid) then
      needKeyNum = needKeyNum + cfg.unlock_item
    end
  end
  return needKeyNum <= self:GetADCKeyItemCount()
end

function ActivityDailyChallengeData:GetADCBuffSelectData(dungeonId)
  if self._fmtSelectDic[dungeonId] ~= nil then
    return self._fmtSelectDic[dungeonId]
  end
  local dungeonCfg = self._dungeonCfg[dungeonId]
  if dungeonCfg == nil then
    error("id id nil " .. tostring(dungeonId))
    return nil
  end
  local fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByADC(self, dungeonId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local dungenOrder = dungeonCfg.dungeon_order
  local selectbuffDic = userDataCache:GetADCBuffSelect(self:GetActId(), dungenOrder)
  fmtBuffSelectData:SetDefaultSelect(selectbuffDic)
  fmtBuffSelectData:SetSelectCallback(function(buffDic)
    userDataCache:RecordADCBuffSelect(self:GetActId(), dungenOrder, buffDic)
  end)
  self._fmtSelectDic[dungeonId] = fmtBuffSelectData
  return fmtBuffSelectData
end

return ActivityDailyChallengeData
