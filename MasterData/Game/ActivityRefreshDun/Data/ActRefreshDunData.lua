local base = require("Game.ActivityFrame.ActivityBase")
local ActRefreshDunData = class("ActRefreshDunData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActRefreshDunEnum = require("Game.ActivityRefreshDun.ActRefreshDunEnum")
local ARDDungeonData = require("Game.ActivityRefreshDun.Data.ARDDungeonData")
local CommonPoltReviewData = require("Game.CommonUI.PlotReview.CommonPoltReviewData")
local CommonPoltReviewGroupData = require("Game.CommonUI.PlotReview.CommonPoltReviewGroupData")

function ActRefreshDunData:ctor(actId)
  self.__ARDDCfg = ConfigData.activity_refresh_dungeon[actId]
  self.__actId = actId
  self.__expiredTm = nil
  self.__exchangeTimes = nil
  self.__purchaseRefreshTimes = nil
  self.__ARDDdataDic = nil
  self.__DunOrderList = nil
  self.__miniGameData = nil
  self:SetActFrameDataByType(ActivityFrameEnum.eActivityType.RefreshDun, actId)
  self:InitARDReddot()
end

function ActRefreshDunData:UpdateARDByMsg(msg)
  self.__expiredTm = msg.expiredTm
  self.__exchangeTimes = msg.exchangeTimes
  self.__purchaseRefreshTimes = msg.purchaseRefreshTimes
  self.__miniGameData = msg.activityGameDamie
  self.__ARDDdataDic = {}
  self.__DunOrderList = {}
  for index, dungoenInfo in ipairs(msg.dungeons) do
    table.insert(self.__DunOrderList, dungoenInfo.dungoenId)
    local ARDDunData = ARDDungeonData.New(dungoenInfo.dungoenId, dungoenInfo.completed, self)
    self.__ARDDdataDic[dungoenInfo.dungoenId] = ARDDunData
  end
  self:ARDRefreshAvgReddot()
  self:ARDRefreshTaskReddot()
end

function ActRefreshDunData:GetARDExpiredTm()
  return self.__expiredTm
end

function ActRefreshDunData:GetARDDataList()
  return self.__DunOrderList
end

function ActRefreshDunData:GetARDDataByDunId(dungeonId)
  if self.__ARDDdataDic == nil then
    return nil
  end
  return self.__ARDDdataDic[dungeonId]
end

function ActRefreshDunData:GetARDDataByDunIndex(index)
  local dungeonId = self.__DunOrderList[index]
  return self:GetARDDataByDunId(dungeonId)
end

function ActRefreshDunData:GetARDDCfg()
  return self.__ARDDCfg
end

function ActRefreshDunData:GetARDDTaskList()
  return self.__ARDDCfg.task_list
end

function ActRefreshDunData:GetARDAvgId()
  return self.__ARDDCfg.activity_avg
end

function ActRefreshDunData:GetARDDResetMsg()
  return self.__ARDDCfg.refresh_txt
end

function ActRefreshDunData:GetARDDExchangeMsg()
  return self.__ARDDCfg.exchange_txt
end

function ActRefreshDunData:GetARDResetMAXTime()
  local times = self.__ARDDCfg.refresh_times
  return times[#times]
end

function ActRefreshDunData:GetARDResetTime()
  return self.__purchaseRefreshTimes or 0
end

function ActRefreshDunData:IsARDResetRunOut()
  return self:GetARDResetTime() >= self:GetARDResetMAXTime()
end

function ActRefreshDunData:GetARDMAXExchangeTime()
  return self.__ARDDCfg.exchange
end

function ActRefreshDunData:GetARDExchangeTime()
  return self.__exchangeTimes or 0
end

function ActRefreshDunData:GetARDResetCostItemId()
  return self.__ARDDCfg.refreshCostId
end

function ActRefreshDunData:GetARDResetCost()
  local resetTime = self:GetARDResetTime() + 1
  for index, time in ipairs(self.__ARDDCfg.refresh_times) do
    if time >= resetTime then
      return self.__ARDDCfg.costList[index]
    end
  end
  return 0
end

function ActRefreshDunData:GetARDLevelNum()
  local totalNum = table.count(self.__ARDDdataDic)
  local palyedNum = 0
  for dunId, dunData in pairs(self.__ARDDdataDic) do
    if dunData:GetARDDunIsCompleted() then
      palyedNum = palyedNum + 1
    end
  end
  return totalNum, totalNum - palyedNum
end

function ActRefreshDunData:GetARDMiniGameId()
  return self.__ARDDCfg.tiny_game
end

function ActRefreshDunData:GetARDMiniGameMaxScore()
  if self.__miniGameData == nil then
    return 0
  end
  return self.__miniGameData.highestScore or 0
end

function ActRefreshDunData:GetARDPlotReviewData()
  local bgName
  local enterAvgId = self:GetARDAvgId()
  local collect17StoryAvgId = self.__ARDDCfg.finish_avg
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local CPRData = CommonPoltReviewData.New()
  CPRData:SetCPRBgResName(self.__ARDDCfg.pic, false)
  CPRData:SetCPRTitleName(LanguageUtil.GetLocaleText(self.__ARDDCfg.avg_name))
  local avgCfg = ConfigData.story_avg[enterAvgId]
  local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
  local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupName, groupName, groupDes, {enterAvgId})
  CPRData:AddAvgGroup(CPRGroupData)
  local totalCount = 0
  local totalUnlockCount = 0
  for heroId, dunHeroCfg in pairs(ConfigData.activity_refresh_dungeon_hero) do
    totalCount = totalCount + 1
    local avgId = dunHeroCfg.avg_id
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    local avgCfg = ConfigData.story_avg[avgId]
    if avgCfg ~= nil then
      local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
      local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
      local CPRGroupData = CommonPoltReviewGroupData.New(groupName, groupName, groupDes, {avgId})
      local unlockDes
      if not played then
        local heroName
        local heroCfg = ConfigData.hero_data[heroId]
        if heroCfg ~= nil then
          heroName = LanguageUtil.GetLocaleText(heroCfg.name)
          unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7303)), heroName)
        end
      end
      CPRGroupData:SetAvgGroupDataIsUnlock(played, unlockDes)
      CPRData:AddAvgGroup(CPRGroupData)
    end
    if played then
      totalUnlockCount = totalUnlockCount + 1
    end
  end
  local isUnlock = totalUnlockCount >= self.__ARDDCfg.finish_condition
  local unlockDes
  if not isUnlock then
    unlockDes = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7308))
  else
    totalUnlockCount = totalUnlockCount + 1
  end
  local avgCfg = ConfigData.story_avg[collect17StoryAvgId]
  local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
  local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupName, groupName, groupDes, {collect17StoryAvgId})
  CPRGroupData:SetAvgGroupDataOperateData(nil, function()
    self:ARDRefreshAvgReddot()
  end)
  CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
    return self:__IsFinishAvgBlueDot()
  end)
  CPRGroupData:SetAvgGroupDataIsUnlock(isUnlock, unlockDes)
  CPRData:AddAvgGroup(CPRGroupData)
  CPRData:SetCPRUnlockNum(totalCount + 2, totalUnlockCount + 1)
  return CPRData
end

function ActRefreshDunData:InitARDReddot()
  local isOk, actSingleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle)
  if isOk then
    local frameActId = self:GetActFrameId()
    self.ARDRedDotRootNode = actSingleNode:AddChild(frameActId)
    self.ARDRedDotRootNode:AddChild(ActRefreshDunEnum.redDotType.task)
    self.ARDRedDotRootNode:AddChild(ActRefreshDunEnum.redDotType.avg)
  else
    error("can't get ActivitySingle node")
  end
end

function ActRefreshDunData:__IsFinishAvgBlueDot()
  local isNotWatchFinalAvg = false
  if self:IsActivityRunning() then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local avgId = self.__ARDDCfg.finish_avg
    if not avgPlayCtrl:IsAvgPlayed(avgId) then
      local totalUnlockCount = 0
      for heroId, dunHeroCfg in pairs(ConfigData.activity_refresh_dungeon_hero) do
        local avgId = dunHeroCfg.avg_id
        if avgPlayCtrl:IsAvgPlayed(avgId) then
          totalUnlockCount = totalUnlockCount + 1
        end
      end
      if totalUnlockCount >= self.__ARDDCfg.finish_condition then
        isNotWatchFinalAvg = true
      end
    end
  end
  return isNotWatchFinalAvg
end

function ActRefreshDunData:ARDRefreshAvgReddot()
  local isNotWatchFinalAvg = self:__IsFinishAvgBlueDot()
  local avgNode = self.ARDRedDotRootNode:GetChild(ActRefreshDunEnum.redDotType.avg)
  avgNode:SetRedDotCount(isNotWatchFinalAvg and 1 or 0)
end

function ActRefreshDunData:ARDRefreshTaskReddot()
  local taskNum = 0
  if self:IsActivityOpen() then
    for _, taskId in pairs(self:GetARDDTaskList()) do
      local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
      if taskData ~= nil and taskData:CheckComplete() then
        taskNum = 1
        break
      end
    end
  end
  local taskNode = self.ARDRedDotRootNode:GetChild(ActRefreshDunEnum.redDotType.task)
  taskNode:SetRedDotCount(taskNum)
end

function ActRefreshDunData:__IsHaveReadDot()
  local num = 0
  local frameActId = self:GetActFrameId()
  local isOk, reddotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, frameActId, ActRefreshDunEnum.redDotType.task)
  if isOk then
    num = num + reddotNode:GetRedDotCount()
  end
  if 0 < num then
    return true
  end
end

function ActRefreshDunData:GetActivityReddotNum()
  local isBlue, num
  isBlue = not self:__IsHaveReadDot()
  num = self.ARDRedDotRootNode:GetRedDotCount()
  return isBlue, num
end

return ActRefreshDunData
