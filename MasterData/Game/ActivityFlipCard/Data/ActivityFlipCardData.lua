local base = require("Game.ActivityFrame.ActivityBase")
local ActivityFlipCardData = class("ActivityFlipCardData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.FlipCard
local ActivityFlipCardEnum = require("Game.ActivityFlipCard.Data.ActivityFlipCardEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivityFlipCardData:InitFlipCardData(msg)
  self._actId = msg.actId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_flipcards_main[self._actId]
  self._roundCfg = ConfigData.activity_flipcards_round[self._actId]
  self._rewardGets = {}
  local rewardIds = self:GetFlipRewardsByRewardGroupId(self._mainCfg.final_skin)
  self._skinId = rewardIds[1]
  self:SetFlipChooseNewRound(msg.round, true)
  for _, recordMsg in pairs(msg.record) do
    self:SetFlipCardDraw(recordMsg, true)
  end
  self:UpdateFlipCardShow()
  self._isCanRefreshItem = true
end

function ActivityFlipCardData:UpdateFlipCardShow()
  self:__RefreshFlipCardRedHasFlipToken()
  self:__RefreshFlipRedDotLooked()
  self:__RefreshFlipCardRedHasTask()
  MsgCenter:Broadcast(eMsgEventId.ActivityFlipCardChange)
end

function ActivityFlipCardData:TryShowFlipCardReward(rewardGroupId, afterRewardCallback)
  local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
  if flipCardCtrl == nil then
    return
  end
  local rewardIds, rewardNums = self:GetFlipRewardsByRewardGroupId(rewardGroupId)
  
  local function showRewardFunc()
    flipCardCtrl:ShowFlipCardReward(self:GetActId(), rewardIds, rewardNums, afterRewardCallback)
  end
  
  showRewardFunc()
end

function ActivityFlipCardData:__GetIsBlockRedShow()
  return self:GetIsPickedActivityFinal()
end

function ActivityFlipCardData:__RefreshFlipCardRedHasFlipToken()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityFlipCardEnum.EReddotType.HasFlipToken)
  local hasFreeItem = self:GetFlipCardFreeItemRemain() > 0
  local hasPaidItem = 0 < self:GetFlipCardPaidItemRemain()
  local flag = hasFreeItem or hasPaidItem
  flag = flag and not self:__GetIsBlockRedShow()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityFlipCardData:__RefreshFlipRedDotLooked()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityFlipCardEnum.EReddotType.Looked)
  local flag = not self:GetFlipCardLooked() and not self:__GetIsBlockRedShow()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityFlipCardData:__RefreshFlipCardRedHasTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityFlipCardEnum.EReddotType.Task)
  local isCanGet = self:IsCanGetTask()
  local flag = isCanGet
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityFlipCardData:SetFlipCardDraw(recordMsg, isSkipBroadCast)
  if self._rewardGets[recordMsg.idx] == 0 then
    self._rewardGetNum = self._rewardGetNum + 1
  end
  self._rewardGets[recordMsg.idx] = recordMsg.rewardId
  self._isGetAll = self._rewardGetNum == #self._rewardGets
  if recordMsg.rewardId == self._roundCfg[self._round].final_reward then
    self._isGetPoolFinal = true
  end
  if not isSkipBroadCast then
    self:UpdateFlipCardShow()
    local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
    if flipCardWin ~= nil then
      flipCardWin:FlipOpenCard(recordMsg.idx)
      flipCardWin.rewardTimer = self.rewardTimer
    end
    local isfinal, isActivityFinal = self:GetIsIndexFinalReward(recordMsg.idx)
    local delayTime = 0.5
    if isfinal or isActivityFinal then
      delayTime = 1
    end
    self.rewardTimer = TimerManager:StartTimer(delayTime, function()
      self:TryShowFlipCardReward(recordMsg.rewardId, function()
        local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
        if flipCardWin ~= nil and recordMsg.rewardId == self._roundCfg[self._round].final_reward then
          flipCardWin:OnGetFinalReward()
        end
      end)
    end, self, true)
  end
  if self._isGetAll then
    local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
    if flipCardCtrl ~= nil then
      flipCardCtrl:ReqFlipCardNewRound(self:GetActId(), nil, true)
    end
  end
end

function ActivityFlipCardData:SetFlipChooseNewRound(round, isSkipBroadCast)
  self._round = round
  table.clearmap(self._rewardGets)
  local animTime = self._isGetAll and 1 or 0
  self._isGetPoolFinal = false
  self._isGetAll = false
  self._rewardGetNum = 0
  local rewardCount = self:GetFlipPoolRewardCount(round)
  for iRewardIndex = 1, rewardCount do
    table.insert(self._rewardGets, 0)
  end
  if not isSkipBroadCast then
    self:UpdateFlipCardShow()
    local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
    if flipCardWin ~= nil then
      flipCardWin:FlipBackAllCard(animTime)
    end
  end
end

function ActivityFlipCardData:SetFlipCardLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetFlipCardLooked(self:GetActId())
  self:UpdateFlipCardShow()
end

function ActivityFlipCardData:SetFlipCardDrawMulti(records, isSkip)
  if records ~= nil and 0 < #records or self._drawMultiRecords == nil then
    self._drawMultiRecords = records
  end
  if self.rewardTimer ~= nil then
    TimerManager:StopTimer(self.rewardTimer)
    self.rewardTimer = nil
  end
  if self._drawMultiRecords == nil or #self._drawMultiRecords < 1 then
    self:SetIsCanRefreshItem(true)
    self:UpdateFlipCardShow()
    local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
    if flipCardWin ~= nil then
      flipCardWin:UpdateActivityFlipCardItem()
    end
    self._drawMultiRecords = nil
    return
  end
  if isSkip then
    local rewardGroupIdList = {}
    for _, recordMsg in ipairs(self._drawMultiRecords) do
      self:SetFlipCardDrawed(recordMsg)
      table.insert(rewardGroupIdList, recordMsg.rewardId)
    end
    local rewardIds, rewardNums = self:GetFlipRewardsByRewardGroupIdList(rewardGroupIdList)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRShowOverFunc(BindCallback(self, self.SetFlipCardNewRound))
      window:AddAndTryShowReward(CRData)
    end)
    self:SetIsCanRefreshItem(true)
    self._drawMultiRecords = nil
    return
  else
    local recordMsg = self._drawMultiRecords[1]
    local showMask = #self._drawMultiRecords > 1
    self:SetFlipCardDrawed(recordMsg)
    local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
    if flipCardWin ~= nil then
      flipCardWin:FlipOpenCard(recordMsg.idx, true, showMask)
      flipCardWin.rewardTimer = self.rewardTimer
    end
    local delayTime = 0.8
    local onRewardFunc
    if recordMsg.rewardId == self._roundCfg[self._round].final_reward or self._isGetAll then
      function onRewardFunc()
        local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
        
        if flipCardWin ~= nil then
          self:SetFlipCardNewRound()
          self:UpdateFlipCardShow()
          self:SetIsCanRefreshItem(true)
          flipCardWin:UpdateActivityFlipCardItem()
        end
      end
    else
      self.rewardTimer = TimerManager:StartTimer(delayTime, function()
        local commonReward = UIManager:GetWindow(UIWindowTypeID.CommonReward)
        if commonReward ~= nil then
          UIManager:DeleteWindow(UIWindowTypeID.CommonReward)
        end
        self:SetFlipCardDrawMulti(nil)
      end)
    end
    table.remove(self._drawMultiRecords, 1)
    self:TryShowFlipCardReward(recordMsg.rewardId, onRewardFunc)
  end
end

function ActivityFlipCardData:SetFlipCardDrawed(recordMsg)
  if self._rewardGets[recordMsg.idx] == 0 then
    self._rewardGetNum = self._rewardGetNum + 1
  end
  self._rewardGets[recordMsg.idx] = recordMsg.rewardId
  if recordMsg.rewardId == self._roundCfg[self._round].final_reward then
    self._isGetPoolFinal = true
  end
  self._isGetAll = self._rewardGetNum == #self._rewardGets
end

function ActivityFlipCardData:SetFlipCardNewRound()
  if self._isGetAll then
    local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
    if flipCardCtrl ~= nil then
      flipCardCtrl:ReqFlipCardNewRound(self:GetActId(), nil, true)
    end
  elseif self._isGetPoolFinal then
    local flipCardWin = UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain)
    if flipCardWin ~= nil then
      flipCardWin:OnGetFinalReward()
    end
  end
end

function ActivityFlipCardData:SetIsCanRefreshItem(flag)
  self._isCanRefreshItem = flag
end

function ActivityFlipCardData:GetIsCanRefreshItem()
  return self._isCanRefreshItem
end

function ActivityFlipCardData:GetFlipCardMainCfg()
  return self._mainCfg
end

function ActivityFlipCardData:GetFlipCardRoundCfg(roundId)
  return self._roundCfg[roundId]
end

function ActivityFlipCardData:GetFlipCardFreeCost()
  for itemId, itemNum in pairs(self._mainCfg.cost_item_free) do
    return itemId, itemNum
  end
end

function ActivityFlipCardData:GetFlipCardFreeItemRemain()
  local freeCostId = self:GetFlipCardFreeCost()
  return PlayerDataCenter:GetItemCount(freeCostId)
end

function ActivityFlipCardData:GetFlipCardPaidCost()
  for itemId, itemNum in pairs(self._mainCfg.cost_item_paid) do
    return itemId, itemNum
  end
end

function ActivityFlipCardData:GetFlipCardPaidItemRemain()
  local paidCostId = self:GetFlipCardPaidCost()
  return PlayerDataCenter:GetItemCount(paidCostId)
end

function ActivityFlipCardData:GetFlipCardRewardGetByIndex(index)
  local rewardGroupId = self._rewardGets[index]
  return self:GetFlipRewardsByRewardGroupId(rewardGroupId)
end

function ActivityFlipCardData:GetIsIndexFinalReward(index)
  local isGetReward = self._rewardGets[index] ~= 0
  local isFinal = isGetReward and self._rewardGets[index] == self._roundCfg[self:GetCurrentFlipRound()].final_reward
  local isActivityFinal = isGetReward and self._rewardGets[index] == self._mainCfg.final_skin
  return isFinal, isActivityFinal
end

function ActivityFlipCardData:GetRoundHasFinalReward(roundId)
  local hasFinal = false
  local hasActivityFinal = false
  if self._roundCfg[roundId] == nil then
    return hasFinal, hasActivityFinal
  end
  local rewardGroupId = self._roundCfg[roundId].final_reward
  hasFinal = rewardGroupId ~= 0
  hasActivityFinal = rewardGroupId == self._mainCfg.final_skin
  return hasFinal, hasActivityFinal
end

function ActivityFlipCardData:GetCurrentFlipRound()
  return self._round
end

function ActivityFlipCardData:GetFlipFinalRewardByRound(roundId)
  if self._roundCfg[roundId] == nil then
    return table.emptytable, table.emptytable
  end
  local rewardGroupId = self._roundCfg[roundId].final_reward
  return self:GetFlipRewardsByRewardGroupId(rewardGroupId)
end

function ActivityFlipCardData:GetFlipRewardsByRound(roundId, isSkipFinalReward)
  local roundCfg = self._roundCfg[roundId]
  if roundCfg == nil then
    return table.emptytable, table.emptytable, 0
  end
  local rewardIds = {}
  local curRewardIds = {}
  local rewardDic = {}
  local rewardNums = {}
  local rewardGroupNums = {}
  for rewardGroupId, rewardGroupNum in pairs(roundCfg.activity_reward) do
    if not isSkipFinalReward or roundCfg.final_reward ~= rewardGroupId then
      local currentRewardIds, currentRewardNums, currentGroupNums = self:GetFlipRewardsByRewardGroupId(rewardGroupId)
      for index, currentRewardId in ipairs(currentRewardIds) do
        local currentRewardNum = currentRewardNums[index]
        if rewardDic[currentRewardId] == nil then
          rewardDic[currentRewardId] = {}
          table.insert(curRewardIds, currentRewardId)
        end
        local groupNum = rewardDic[currentRewardId][currentRewardNum] or 0
        groupNum = groupNum + rewardGroupNum
        rewardDic[currentRewardId][currentRewardNum] = groupNum
      end
    end
  end
  for index, rewardId in ipairs(curRewardIds) do
    local groups = rewardDic[rewardId]
    for rewardNum, groupNum in pairs(groups) do
      table.insert(rewardIds, rewardId)
      table.insert(rewardNums, rewardNum)
      table.insert(rewardGroupNums, groupNum)
    end
  end
  return rewardIds, rewardNums, rewardGroupNums
end

function ActivityFlipCardData:GetFlipRewardsByRewardGroupId(rewardGroupId)
  local rewardCfg = ConfigData.activity_flipcards_award[rewardGroupId]
  if rewardCfg == nil or table.IsEmptyTable(rewardCfg.reward) then
    return table.emptytable, table.emptytable, 0
  end
  local rewardIds = {}
  local rewardNums = {}
  local rewardGroupNums = {}
  for rewardId, rewardNum in pairs(rewardCfg.reward) do
    table.insert(rewardIds, rewardId)
    table.insert(rewardNums, rewardNum)
  end
  table.insert(rewardGroupNums, 1)
  return rewardIds, rewardNums, rewardGroupNums
end

function ActivityFlipCardData:GetFlipRewardsByRewardGroupIdList(rewardGroupIdList)
  local rewardIds = {}
  local rewardNums = {}
  local rewardGroupNums = {}
  for _, rewardId in ipairs(rewardGroupIdList) do
    local rewardCfg = ConfigData.activity_flipcards_award[rewardId]
    if rewardCfg ~= nil and not table.IsEmptyTable(rewardCfg.reward) then
      for rewardId, rewardNum in pairs(rewardCfg.reward) do
        table.insert(rewardIds, rewardId)
        table.insert(rewardNums, rewardNum)
      end
      table.insert(rewardGroupNums, 1)
    end
  end
  return rewardIds, rewardNums, rewardGroupNums
end

function ActivityFlipCardData:GetFlipFinalRewardAvg()
  return self._mainCfg.avg_id
end

function ActivityFlipCardData:GetFlipActivityFinalReward()
  return self:GetFlipRewardsByRewardGroupId(self._mainCfg.final_skin)
end

function ActivityFlipCardData:GetIsPickedRoundFinal()
  return self._isGetPoolFinal
end

function ActivityFlipCardData:GetIsPickedActivityFinal()
  return PlayerDataCenter.skinData:IsHaveSkin(self._skinId)
end

function ActivityFlipCardData:GetIsPickedRoundAll()
  return self._isGetAll
end

function ActivityFlipCardData:GetRoundPickNum()
  return self._rewardGetNum
end

function ActivityFlipCardData:GetFlipPoolRewardCount(roundId)
  local roundCfg = self._roundCfg[roundId]
  if roundCfg == nil then
    return 0
  end
  local rewardCount = 0
  for _, rewardGroupNum in pairs(roundCfg.activity_reward) do
    rewardCount = rewardCount + rewardGroupNum
  end
  return rewardCount
end

function ActivityFlipCardData:GetFlipCardItemIsGetByIndex(index)
  return self._rewardGets[index] ~= 0
end

function ActivityFlipCardData:GetFlipCardNotGetRewardIdx(count)
  local idx = {}
  for index, isGet in ipairs(self._rewardGets) do
    if isGet == 0 then
      table.insert(idx, index)
    end
    if count ~= nil and #idx == count then
      break
    end
  end
  return idx
end

function ActivityFlipCardData:GetFlipCardSkinBgPosData(skinType)
  local allBgPosList = ConfigData.activity_flipcards_main.bgPosList
  if allBgPosList == nil then
    error("cant get flipcard BG_pos config")
    return nil
  end
  local bgPosList = allBgPosList[self._actId]
  if bgPosList == nil then
    return nil
  end
  return bgPosList[skinType]
end

function ActivityFlipCardData:GetFlipCardSkinBgScaleData()
  local allBgScaleList = ConfigData.activity_flipcards_main.bgScaleList
  if allBgScaleList == nil then
    error("cant get flipcard BG_scale config")
    return nil
  end
  local scaleList = allBgScaleList[self._actId]
  return scaleList[1]
end

function ActivityFlipCardData:GetFlipCardLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetFlipCardLooked(self:GetActId())
end

function ActivityFlipCardData:IsCanGetTask()
  local isCanGet = false
  local taskIds = ConfigData.activity_general[self:GetActFrameId()].once_quest
  for _, taskId in pairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    isCanGet = isCanGet or taskData:CheckComplete()
    if isCanGet then
      break
    end
  end
  return isCanGet
end

return ActivityFlipCardData
