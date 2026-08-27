local base = require("Game.ActivityFrame.ActivityBase")
local SigninLiveStreamData = class("ActivityHeroGrow", base)
local redDotType = {Looked = 1}

function SigninLiveStreamData:ctor(actFrameData)
  self.actId = actFrameData:GetActId()
  self.__mainCfg = ConfigData.activity_kurolive[self.actId]
  self:SetActFrameData(actFrameData)
  self:RefreshRedDotLooked()
end

function SigninLiveStreamData:RefreshSILSData(msg)
  self.nextRefreshTime = msg.nextRefreshTime or 0
  self.curOrderId = msg.orderId or 0
  self.completedOrders = msg.orders or table.emptytable
end

function SigninLiveStreamData:RefreshRedDotLooked()
  local redDot = self:GetActChildRedDot(redDotType.Looked)
  if redDot == nil then
    return
  end
  local isLooked = self:GetActIsLooked()
  local redDotNum = isLooked and 0 or 1
  redDot:SetRedDotCount(redDotNum)
end

function SigninLiveStreamData:SetActIsLooked()
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSignInLiveLooked(self:GetActId())
  self:RefreshRedDotLooked()
end

function SigninLiveStreamData:GetActIsLooked()
  local isLooked = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetSignInLiveLooked(self:GetActId())
  return isLooked
end

function SigninLiveStreamData:GetSILSDataIsCompleteTodayReward()
  return self.nextRefreshTime ~= 0
end

function SigninLiveStreamData:GetSILSDataIsCompleteAllReward()
  return self:GetSILSDataCollectedRewardNum() >= self:GetSILSDataTotalewardNum()
end

function SigninLiveStreamData:GetSILSDataNextRefreshTm()
  return self.nextRefreshTime
end

function SigninLiveStreamData:GetSILSDataCurRewardId()
  if self:GetSILSDataIsCompleteTodayReward() or self.curOrderId == 0 then
    return self.completedOrders[#self.completedOrders]
  end
  return self.curOrderId
end

function SigninLiveStreamData:GetSILSDataRewardMaterial(rewardId)
  local rewardCfg = ConfigData.activity_kurolive_reward[rewardId]
  return rewardCfg.rewardIds, rewardCfg.rewardNums
end

function SigninLiveStreamData:GetSILSDataRewardItemIdAndName(rewardId)
  local rewardCfg = ConfigData.activity_kurolive_reward[rewardId]
  local itemId = rewardCfg.item_id
  local name = LanguageUtil.GetLocaleText(rewardCfg.name)
  return itemId, name, rewardCfg.icon
end

function SigninLiveStreamData:GetSILSDataRewardItemInfo(rewardId)
  local rewardCfg = ConfigData.activity_kurolive_reward[rewardId]
  local itemId = rewardCfg.item_id
  local itemCfg = ConfigData.item[itemId]
  local mixedList = {}
  if itemCfg.action_type == eItemActionType.FixedGiftPackage then
    for itemId, itemNum in pairs(itemCfg.giftOptainDic) do
      table.insert(mixedList, {itemId = itemId, itemNum = itemNum})
    end
  end
  table.sort(mixedList, function(a, b)
    return a.itemId < b.itemId
  end)
  local itemIdList, itemNumList = {}, {}
  for index, v in ipairs(mixedList) do
    table.insert(itemIdList, v.itemId)
    table.insert(itemNumList, v.itemNum)
  end
  return itemIdList, itemNumList
end

function SigninLiveStreamData:GetSILSDataCollectedRewardIds()
  return self.completedOrders
end

function SigninLiveStreamData:GetSILSDataCollectedRewardIdDic()
  local dic = {}
  for _, id in ipairs(self.completedOrders) do
    dic[id] = true
  end
  return dic
end

function SigninLiveStreamData:GetSILSDataAllRewardIds()
  local list = {}
  for id, cfg in ipairs(ConfigData.activity_kurolive_reward) do
    table.insert(list, id)
  end
  return list
end

function SigninLiveStreamData:GetSILSDataCollectedRewardNum()
  return #self.completedOrders
end

function SigninLiveStreamData:GetSILSDataTotalewardNum()
  return #ConfigData.activity_kurolive_reward
end

function SigninLiveStreamData:GetSILSDataTip()
  return self.__mainCfg.task_rule_title, self.__mainCfg.task_rule_id
end

function SigninLiveStreamData:GetSecretRewardInfo()
  return self.__mainCfg.mystery_gift, self.__mainCfg.icon, self.__mainCfg.gift_name
end

function SigninLiveStreamData:GetSILSDataAvgId()
  return self.__mainCfg.story_id
end

function SigninLiveStreamData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  return isBlue, num
end

return SigninLiveStreamData
