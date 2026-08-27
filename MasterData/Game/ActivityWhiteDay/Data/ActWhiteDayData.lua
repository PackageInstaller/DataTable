local base = require("Game.ActivityFrame.ActivityBase")
local ActWhiteDayData = class("ActWhiteDayData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityWhiteDayEnum = require("Game.ActivityWhiteDay.ActivityWhiteDayEnum")
local ActWhiteDayLineData = require("Game.ActivityWhiteDay.Data.ActWhiteDayLineData")
local ActWhiteDayLineOrderData = require("Game.ActivityWhiteDay.Data.ActWhiteDayLineOrderData")

function ActWhiteDayData:ctor(actId)
  self.__actId = actId
  self.__whiteDayCfg = ConfigData.activity_white_day[actId]
  self.__factoryCfgs = ConfigData.activity_white_day_factory[actId]
  self.__photoCfgs = ConfigData.activity_white_day_photo[actId]
  self.__factoryLevel = nil
  self.__factoryExp = 0
  self.__beforeShowLevelUpLevel = nil
  self.__lineDic = nil
  self.__orderDic = nil
  self.__lineUnlockLevelDic = nil
  self.__levelUnlockListDic = nil
  self.__OrderProducedNumDic = nil
  self.__underAssistHeroDic = nil
  self.__unlockedPhoto = nil
  self.__unlockedPhotoNum = nil
  self.__unlockedPhotoList = nil
  self.__onceQuests = nil
  self.__endlessQuests = nil
  self.__endlessFinished = nil
  self.__endlessRateFlags = nil
  self.__endlessAcceptNum = nil
  base.SetActFrameDataByType(self, ActivityFrameEnum.eActivityType.WhiteDay, actId)
  if self.__whiteDayCfg == nil or self.__factoryCfgs == nil then
    error("can't get white Day Cfg with actId" .. tostring(actId))
  end
  self.wdRedDotRootNode = nil
  self:InitWDReddot()
  self:__GenUnlockLevel()
end

function ActWhiteDayData:__GenUnlockLevel()
  local unlockLevelDic = {}
  local unlockLineList = {}
  for level, levelCfg in ipairs(self.__factoryCfgs) do
    for _, lineId in pairs(levelCfg.line_unlock) do
      if unlockLevelDic[lineId] == nil then
        unlockLevelDic[lineId] = level
        if unlockLineList[level] == nil then
          unlockLineList[level] = {}
        end
        table.insert(unlockLineList[level], lineId)
      end
    end
  end
  self.__lineUnlockLevelDic = unlockLevelDic
  self.__levelUnlockListDic = unlockLineList
end

function ActWhiteDayData:UpdateByAWDByMsg(msg)
  local factory = msg.factory
  if self.__factoryLevel ~= nil and self.__factoryLevel < factory.lv then
    self.__beforeShowLevelUpLevel = self.__factoryLevel
  end
  self.__factoryLevel = factory.lv
  self.__factoryExp = factory.exp
  self.__OrderProducedNumDic = factory.orderTimes
  self:__UpdateAWDLineDatas(factory.orders)
  self:__UpdateAWDOrderDatas()
  self:UpdateUnderAssistHeroDic()
  local polariod = msg.polariod
  self:UpdateUnlockPhotoList(polariod)
  self.__onceQuests = msg.onceQuests
  local endlessQuest = msg.endlessQuest
  self.__endlessQuests = endlessQuest.ids
  self.__endlessRateFlags = endlessQuest.flag
  self.__endlessAcceptNum = endlessQuest.refreshTimes
  self.__endlessFinished = {}
  for taskId, _ in pairs(endlessQuest.compeleteId) do
    table.insert(self.__endlessFinished, taskId)
  end
  self:RefreshWDReddot4Task()
  self:RefreshWDReddot4AlbumAvg()
end

function ActWhiteDayData:__UpdateAWDLineDatas(orders)
  local lineList = self:GetWDFactoryAllLineList()
  if self.__lineDic == nil then
    self.__lineDic = {}
    for _, lineId in pairs(lineList) do
      local lineData = ActWhiteDayLineData.New(self, lineId)
      local orderMsg = orders[lineId]
      lineData:UpdateWDLineData(orderMsg)
      self.__lineDic[lineId] = lineData
    end
  else
    for _, lineId in pairs(lineList) do
      local lineData = self.__lineDic[lineId]
      local orderMsg = orders[lineId]
      lineData:UpdateWDLineData(orderMsg)
    end
  end
end

function ActWhiteDayData:__UpdateAWDOrderDatas()
  if self.__orderDic == nil then
    self.__orderDic = {}
    for lineId, lineData in pairs(self.__lineDic) do
      local orderList = lineData:GetWDLineOrderList()
      for _, orderId in pairs(orderList) do
        if self.__orderDic[orderId] == nil then
          local orderData = ActWhiteDayLineOrderData.New(self, orderId)
          orderData:UpdateWDLineOrderData()
          self.__orderDic[orderId] = orderData
        end
      end
      lineData:GenWDOrderDataList(self.__orderDic)
    end
  else
    for _, orderData in pairs(self.__orderDic) do
      orderData:UpdateWDLineOrderData()
    end
  end
end

function ActWhiteDayData:UpdateUnderAssistHeroDic()
  self.__underAssistHeroDic = {}
  for lineId, lineData in pairs(self.__lineDic) do
    if lineData:GetIsInProduction() then
      local assistHeroId = lineData:GetWDLDAssistHeroID()
      if assistHeroId ~= nil then
        self.__underAssistHeroDic[assistHeroId] = true
      end
    end
  end
end

function ActWhiteDayData:UpdateUnlockPhotoList(polariod)
  if polariod ~= nil then
    self.__unlockedPhoto = polariod.data
    self.__unlockedPhotoNum = table.count(polariod.data)
  else
    self.__unlockedPhoto = {}
    self.__unlockedPhotoNum = 0
  end
  self.__unlockedPhotoList = {}
  for photoId, _ in pairs(self.__unlockedPhoto) do
    table.insert(self.__unlockedPhotoList, photoId)
  end
  table.sort(self.__unlockedPhotoList)
end

function ActWhiteDayData:SetWDHasShowedLevelUp()
  self.__beforeShowLevelUpLevel = nil
end

function ActWhiteDayData:GetWDCfg()
  return self.__whiteDayCfg
end

function ActWhiteDayData:GetAWDFirstEnterAvgId()
  return self.__whiteDayCfg.activity_avg
end

function ActWhiteDayData:GetAWDCollectAllAvgId()
  return self.__whiteDayCfg.finish_avg
end

function ActWhiteDayData:GetAWDSectorId()
  return self.__whiteDayCfg.sector_id
end

function ActWhiteDayData:GetAWDGame2048Id()
  return self.__whiteDayCfg.game_2048
end

function ActWhiteDayData:GetAWDFactoryLevel()
  return self.__factoryLevel
end

function ActWhiteDayData:GetAWDFactoryMaxLevel()
  return #self.__factoryCfgs
end

function ActWhiteDayData:GetWDBeforeLevelUpLevel()
  return self.__beforeShowLevelUpLevel
end

function ActWhiteDayData:GetAWDFactoryCfg()
  return self.__factoryCfgs
end

function ActWhiteDayData:GetAWDFactoryIsFullLevel()
  return self:GetAWDFactoryLevel() >= self:GetAWDFactoryMaxLevel()
end

function ActWhiteDayData:GetAWDFactoryLevelUpReward(level)
  if level >= #self.__factoryCfgs then
    return table.emptytable, table.emptytable
  end
  local levelCfg = self.__factoryCfgs[level + 1]
  return levelCfg.level_reward_ids, levelCfg.level_reward_nums
end

function ActWhiteDayData:GetAWDFactoryLevelUpUnlockLineList(level)
  if level > #self.__factoryCfgs then
    return
  end
  return self.__levelUnlockListDic[level]
end

function ActWhiteDayData:GetAWDFactoryLevelUpUnlockOrderDataList(level)
  if level > #self.__factoryCfgs then
    return
  end
  local list = {}
  for ordetId, orderData in pairs(self.__orderDic) do
    if orderData:GetWDLineOrderUnlockLevel() == level then
      table.insert(list, orderData)
    end
  end
  return list
end

function ActWhiteDayData:GetAWDFactoryExp()
  return self.__factoryExp
end

function ActWhiteDayData:GetAWDFactoryLevelUpExp(level)
  if level > #self.__factoryCfgs then
    return
  end
  return self.__factoryCfgs[level].level_up_exp
end

function ActWhiteDayData:GetWDFactoryAllLineList()
  return self.__factoryCfgs[#self.__factoryCfgs].line_unlock
end

function ActWhiteDayData:GetWDactoryLineUnlockLevel(lineId)
  return self.__lineUnlockLevelDic[lineId]
end

function ActWhiteDayData:GetWDactoryLineIsUnlock(lineId)
  return self:GetWDactoryLineUnlockLevel(lineId) <= self:GetAWDFactoryLevel()
end

function ActWhiteDayData:GetWDFactoryLineData(lineId)
  return self.__lineDic[lineId]
end

function ActWhiteDayData:GetWDFactoryLineDataDic()
  return self.__lineDic
end

function ActWhiteDayData:GetWDOrderUsedTime(orderId)
  if self.__OrderProducedNumDic == nil then
    return 0
  end
  return self.__OrderProducedNumDic[orderId] or 0
end

function ActWhiteDayData:GetWDUnderAssistHeroDic()
  return self.__underAssistHeroDic
end

function ActWhiteDayData:GetWDCouldBuyAccItem()
  return self.__factoryCfgs[self.__factoryLevel].speed_unclock
end

function ActWhiteDayData:GetWDAccItemId()
  return self.__whiteDayCfg.speed_ticket
end

function ActWhiteDayData:GetWDAccItemAcctime()
  if self.accItemAccTime ~= nil then
    return self.accItemAccTime
  end
  local itemCfg = ConfigData.item[self.__whiteDayCfg.speed_ticket]
  if itemCfg ~= nil then
    self.accItemAccTime = itemCfg.arg[2] or 0
    return self.accItemAccTime
  end
  return 0
end

function ActWhiteDayData:GetWDOrderData(orderId)
  if self.__orderDic == nil then
    return
  end
  return self.__orderDic[orderId]
end

function ActWhiteDayData:GetWDPhotoCfgs()
  return self.__photoCfgs
end

function ActWhiteDayData:GetWDUnlockedPhotoDic()
  return self.__unlockedPhoto
end

function ActWhiteDayData:GetWDUnlockedPhotoList()
  return self.__unlockedPhotoList
end

function ActWhiteDayData:GetWDUnlockedPhotoNum()
  return self.__unlockedPhotoNum
end

function ActWhiteDayData:GetWDAllPhotoNum()
  return table.count(self.__photoCfgs)
end

function ActWhiteDayData:GetWDUnlockAllPhoto()
  return self.__unlockedPhotoNum == table.count(self.__photoCfgs)
end

function ActWhiteDayData:GetWDRandomPhotoItemIdAndNum()
  return self.__whiteDayCfg.random_tokenId, self.__whiteDayCfg.random_tokenNum
end

function ActWhiteDayData:GetWDExchangePhotoItemIdAndNum()
  return self.__whiteDayCfg.exchange_tokenId, self.__whiteDayCfg.exchange_tokenNum
end

function ActWhiteDayData:GetWDTaskList()
  return self.__onceQuests
end

function ActWhiteDayData:GetWDEndlessTaskList()
  return self.__endlessQuests or {}
end

function ActWhiteDayData:GetWDEndlessTaskFinishedList()
  return self.__endlessFinished or {}
end

function ActWhiteDayData:GetWDIsEndlessTaskMultReward(taskIndex)
  if 1 << taskIndex - 1 & self.__endlessRateFlags > 0 then
    if self.__whiteDayCfg == nil or self.__whiteDayCfg.endless_limit_des == nil or self.__whiteDayCfg.endless_limit_task == nil then
      error("can't read endless cfg with index:" .. tostring(taskIndex))
      return false
    end
    local multRateText = LanguageUtil.GetLocaleText(self.__whiteDayCfg.endless_limit_des[taskIndex])
    local multRate = self.__whiteDayCfg.endless_limit_task[taskIndex]
    return true, multRateText, multRate
  end
  return false
end

function ActWhiteDayData:GetWDIsAllSkinGet()
  for k, cfg in pairs(self.__photoCfgs) do
    if cfg.skinId ~= nil and PlayerDataCenter.skinData:IsSkinUnlocked(cfg.skinId) and not PlayerDataCenter.skinData:IsHaveSkin(cfg.skinId) then
      return false
    end
  end
  return true
end

function ActWhiteDayData:GetWDIsUnlockPhotoSkinGet()
  for k, _ in pairs(self.__unlockedPhoto) do
    local cfg = self.__photoCfgs[k]
    if cfg.skinId ~= nil and PlayerDataCenter.skinData:IsSkinUnlocked(cfg.skinId) and not PlayerDataCenter.skinData:IsHaveSkin(cfg.skinId) then
      return false
    end
  end
  return true
end

function ActWhiteDayData:GetWDIsPhotoSkinBought()
  for k, _ in pairs(self.__unlockedPhoto) do
    local cfg = self.__photoCfgs[k]
    if cfg.skinId ~= nil and PlayerDataCenter.skinData:IsHaveSkin(cfg.skinId) then
      return true
    end
  end
  return false
end

function ActWhiteDayData:GetWhiteDayPhotoConvertItemIsAboveLimit()
  local photoNum = table.count(self.__photoCfgs)
  local waitUnlockPhotoNum = photoNum - self.__unlockedPhotoNum
  local randomId, randomNum = self:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, exchangeNum = self:GetWDExchangePhotoItemIdAndNum()
  local randomNum = PlayerDataCenter:GetItemCount(randomId) // randomNum
  local exchangeNum = PlayerDataCenter:GetItemCount(exchangeId) // exchangeNum
  local isFull = waitUnlockPhotoNum <= randomNum + exchangeNum
  return isFull
end

function ActWhiteDayData:InitWDReddot()
  local isOk, actSingleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle)
  if isOk then
    local frameActId = self:GetActFrameId()
    self.wdRedDotRootNode = actSingleNode:AddChild(frameActId)
    local taskNode = self.wdRedDotRootNode:AddChild(ActivityWhiteDayEnum.redDotType.task)
    taskNode:AddChild(ActivityWhiteDayEnum.redDotType.commonTask)
    taskNode:AddChild(ActivityWhiteDayEnum.redDotType.endlesstask)
    local photoNode = self.wdRedDotRootNode:AddChild(ActivityWhiteDayEnum.redDotType.photoNode)
    photoNode:AddChild(ActivityWhiteDayEnum.redDotType.couldGetNewPhoto)
    photoNode:AddChild(ActivityWhiteDayEnum.redDotType.getAllPhotoAvg)
    local orderNode = self.wdRedDotRootNode:AddChild(ActivityWhiteDayEnum.redDotType.order)
    self.wdRedDotRootNode:AddChild(ActivityWhiteDayEnum.redDotType.lineEvent)
  else
    error("can't get ActivitySingle node")
  end
end

function ActWhiteDayData:RefreshWDReddot4Task()
  local commonTaskNum = 0
  local endlessTaskNum = 0
  local lineEventNum = 0
  if self:IsActivityRunning() then
    if self.__onceQuests ~= nil then
      for _, taskId in pairs(self.__onceQuests) do
        local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
        if taskData ~= nil and taskData:CheckComplete() then
          commonTaskNum = 1
          break
        end
      end
    end
    if self.__endlessQuests ~= nil then
      for _, taskId in pairs(self.__endlessQuests) do
        local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
        if taskData ~= nil and taskData:CheckComplete() then
          endlessTaskNum = 1
          break
        end
      end
    end
    if self.__orderDic ~= nil then
      for k, lineData in pairs(self.__lineDic) do
        if lineData:GetIsHaveEvent() then
          local taskId = lineData:GetWDLEventTaksId()
          local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
          if taskData ~= nil and taskData:CheckComplete() then
            lineEventNum = 1
            break
          end
        end
      end
    end
  end
  local commonTaskNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.task):GetChild(ActivityWhiteDayEnum.redDotType.commonTask)
  commonTaskNode:SetRedDotCount(commonTaskNum)
  local endlessTaskNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.task):GetChild(ActivityWhiteDayEnum.redDotType.endlesstask)
  endlessTaskNode:SetRedDotCount(endlessTaskNum)
  local lineEventNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.lineEvent)
  lineEventNode:SetRedDotCount(lineEventNum)
end

function ActWhiteDayData:RefreshWDReddot4AlbumAvg()
  local isWatchedFinalAvg = false
  if self:IsActivityRunning() and self:GetWDUnlockAllPhoto() then
    local avgId = self:GetAWDCollectAllAvgId()
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    if avgPlayCtrl ~= nil and not avgPlayCtrl:IsAvgPlayed(avgId) then
      isWatchedFinalAvg = true
    end
  end
  local avgNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.photoNode):GetChild(ActivityWhiteDayEnum.redDotType.getAllPhotoAvg)
  avgNode:SetRedDotCount(isWatchedFinalAvg and 1 or 0)
end

function ActWhiteDayData:SetWDReddot4Album(bool)
  local isHaveNewGetPhotoItem = false
  if self:IsActivityRunning() then
    isHaveNewGetPhotoItem = bool
  end
  local newPhotoNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.photoNode):GetChild(ActivityWhiteDayEnum.redDotType.couldGetNewPhoto)
  newPhotoNode:SetRedDotCount(isHaveNewGetPhotoItem and 1 or 0)
end

function ActWhiteDayData:RefreshWDReddot4Order()
  local isHaveCompletedOrder = false
  if self.__lineDic ~= nil and self:IsActivityRunning() then
    for lineId, lineData in pairs(self.__lineDic) do
      if lineData:GetIsInProduction() and lineData:GetIsProductionOver() then
        isHaveCompletedOrder = true
        break
      end
    end
  end
  local orderNode = self.wdRedDotRootNode:GetChild(ActivityWhiteDayEnum.redDotType.order)
  orderNode:SetRedDotCount(isHaveCompletedOrder and 1 or 0)
end

function ActWhiteDayData:__IsHaveReadDot()
  local num = 0
  local frameActId = self:GetActFrameId()
  local isOk, reddotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, frameActId, ActivityWhiteDayEnum.redDotType.task)
  if isOk then
    num = num + reddotNode:GetRedDotCount()
  end
  local isOrderOk, orderNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, frameActId, ActivityWhiteDayEnum.redDotType.order)
  if isOrderOk then
    num = num + orderNode:GetRedDotCount()
  end
  if 0 < num then
    return true
  end
end

function ActWhiteDayData:GetActivityReddotNum()
  local isBlue, num
  isBlue = not self:__IsHaveReadDot()
  num = self.wdRedDotRootNode:GetRedDotCount()
  return isBlue, num
end

return ActWhiteDayData
