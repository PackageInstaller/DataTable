local base = require("Game.ActivityFrame.ActivityBase")
local ActivityCollectFortuneData = class("ActivityCollectFortuneData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityCollectFortuneEnum = require("Game.ActivityCollectFortune.Data.ActivityCollectFortuneEnum")
local CurActType = ActivityFrameEnum.eActivityType.CollectFortune

function ActivityCollectFortuneData:InitCollectFortuneData(msg)
  self._actId = msg.actId
  self._poolId = msg.poolId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_collectfortune_main[self._actId]
  self._tradCfg = ConfigData.activity_collectfortune_trad_item[self._actId]
  self._awardCfg = ConfigData.activity_collectfortune_award_pool[self._actId]
  self._generalGiftCfg = ConfigData.activity_general_gift_item[self:GetActFrameId()]
  self:UpdateActCollectFortuneRewardGot(msg.rewardGot)
  self:InitCollectFortuneItemRevert()
end

function ActivityCollectFortuneData:UpdateActCollectFortuneRewardGot(rewardGot)
  self._poolRewardGot = {}
  for id, num in pairs(rewardGot) do
    self._poolRewardGot[id] = num
  end
end

function ActivityCollectFortuneData:UpdateActCollectFortunePoolId(poolId)
  self._poolId = poolId
end

function ActivityCollectFortuneData:InitCollectFortuneItemRevert()
  if self._generalGiftCfg == nil then
    return
  end
  self._itemRevertIdDic = {}
  self._itemRevertIndexDic = {}
  self._itemIdListWithIndex = {}
  local itemSendList = self._generalGiftCfg.item_send
  local itemReceiveList = self._generalGiftCfg.item_receive
  for index, sendId in ipairs(itemSendList) do
    local receiveId = itemReceiveList[index]
    if self._itemIdListWithIndex[index] == nil then
      self._itemIdListWithIndex[index] = {}
    end
    table.insert(self._itemIdListWithIndex[index], sendId)
    table.insert(self._itemIdListWithIndex[index], receiveId)
    self._itemRevertIndexDic[sendId] = index
    self._itemRevertIndexDic[receiveId] = index
    self._itemRevertIdDic[sendId] = receiveId
    self._itemRevertIdDic[receiveId] = sendId
  end
end

function ActivityCollectFortuneData:GetActCollectFortuneItemRevertIdDic()
  return self._itemRevertIdDic or {}
end

function ActivityCollectFortuneData:GetActCollectFortuneItemRevertIndexDic()
  return self._itemRevertIndexDic or {}
end

function ActivityCollectFortuneData:GetActCollectFortuneItemIdListWithIndex()
  return self._itemIdListWithIndex or {}
end

function ActivityCollectFortuneData:GetActCollectFortuneActId()
  return self._actId
end

function ActivityCollectFortuneData:GetActCollectFortunePoolId()
  return self._poolId
end

function ActivityCollectFortuneData:GetActCollectFortuneMainCfg()
  return self._mainCfg
end

function ActivityCollectFortuneData:GetActCollectFortuneTradCfg()
  return self._tradCfg
end

function ActivityCollectFortuneData:GetActCollectFortuneAwardCfg()
  return self._awardCfg
end

function ActivityCollectFortuneData:GetActCollectFortuneGeneralGiftCfg()
  return self._generalGiftCfg
end

function ActivityCollectFortuneData:GetActCollectFortuneGiftLimitTimes()
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleActGeneralGiftItem, self:GetActFrameId())
  local giftTimes = counterElem and counterElem.times or 0
  return giftTimes
end

function ActivityCollectFortuneData:RefreshActivityGiftItems(giftItems)
  if giftItems == nil then
    return
  end
  self._toReceiveList = {}
  self._toReceiveDic = {}
  self._receivedList = {}
  for _, data in ipairs(giftItems.toReceive) do
    table.insert(self._toReceiveList, data)
    if self._toReceiveDic[data.sender] == nil then
      self._toReceiveDic[data.sender] = {}
    end
    self._toReceiveDic[data.sender][data.sendTm] = data
  end
  for _, data in ipairs(giftItems.received) do
    table.insert(self._receivedList, data)
  end
end

function ActivityCollectFortuneData:GetActCollectFortuneToReceiveList()
  return self._toReceiveList or {}
end

function ActivityCollectFortuneData:GetActCollectFortuneReceivedList()
  return self._receivedList or {}
end

function ActivityCollectFortuneData:GetActCollectFortunePoolRewardGot(id)
  if self._poolRewardGot == nil then
    self._poolRewardGot = {}
  end
  local gotCount = self._poolRewardGot[id]
  return gotCount ~= nil and gotCount or 0
end

function ActivityCollectFortuneData:GetActCollectFortuneIsCouldDraw()
  local itemIdListWithIndex = self:GetActCollectFortuneItemIdListWithIndex()
  local couldUseTable = {}
  for _, idList in ipairs(itemIdListWithIndex) do
    local itemId = idList[1]
    local giftItemId = idList[2]
    local haveCount = PlayerDataCenter:GetItemCount(itemId)
    local haveGiftCount = PlayerDataCenter:GetItemCount(giftItemId)
    if haveCount <= 0 and haveGiftCount <= 0 then
      return false
    else
      local chooseId = 0 < haveGiftCount and giftItemId or itemId
      table.insert(couldUseTable, chooseId)
    end
  end
  return true, couldUseTable
end

function ActivityCollectFortuneData:GetActCollectFortuneIsLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = userData:GetCollectFortuneLooked(self._actId)
  if isLooked == nil then
    isLooked = false
  end
  return isLooked
end

function ActivityCollectFortuneData:SetActCollectFortuneIsLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userData:SetCollectFortuneLooked(self._actId)
end

function ActivityCollectFortuneData:IsCanGetGift()
  local giftDataList = self:GetActCollectFortuneToReceiveList()
  return 0 < #giftDataList
end

function ActivityCollectFortuneData:RefreshCollectFortuneReddotShow()
  self:__RefreshCollectFortuneRedDotLooked()
  self:__RefreshCollectFortuneRedHasGift()
end

function ActivityCollectFortuneData:__RefreshCollectFortuneRedDotLooked()
  local reddot = self:GetActicityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityCollectFortuneEnum.eReddotType.Looked)
  local flag = not self:GetActCollectFortuneIsLooked()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCollectFortuneData:__RefreshCollectFortuneRedHasGift()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityCollectFortuneEnum.eReddotType.Gift)
  local isCanGet = self:IsCanGetGift()
  local flag = isCanGet
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

return ActivityCollectFortuneData
