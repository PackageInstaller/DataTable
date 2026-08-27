local base = require("Game.ActivityFrame.ActivityBase")
local ActivityHazeGiftData = class("ActivityHazeGiftData", base)
local ActivityHazeGiftEnum = require("Game.ActivityHazeGift.Data.ActivityHazeGiftEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.HazeGift

function ActivityHazeGiftData:InitHazeGiftData(msg)
  self._actId = msg.actId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_hazegift_main[self._actId]
  self._taskCfg = ConfigData.activity_hazegift_task_group[self._actId]
  self._rewardCfg = ConfigData.activity_hazegift_reward[self._actId]
  self._fixedRewardList = ConfigData.activity_hazegift_reward.fixed_reward[self._actId]
  self._rewardIdList = ConfigData.activity_hazegift_reward.taskIdList[self._actId]
  self:UpdateActFrameDataSingleMsg(msg)
  self:CacheActHazeGiftNextRefreshTimes(msg.startTm)
  self:CalHazeGiftUnlockDayList()
  self:RefreshHazeGiftShow()
end

function ActivityHazeGiftData:CacheActHazeGiftNextRefreshTimes(startTime)
  if startTime == nil then
    return
  end
  local taskCfg = self._taskCfg
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for index, cfg in ipairs(taskCfg) do
    if index == #taskCfg then
      break
    end
    local cacheTime = userData:GetHazeGiftDayRefreshTimes(self._actId, cfg.day)
    if not cacheTime then
      local nextTime = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(startTime)))
      nextTime.hour = 0
      nextTime.min = 0
      nextTime.sec = 0
      local nextRefreshTimestamp = TimeUtil:DateToTimestamp(nextTime) + 86400 * cfg.day + 3600 * TimeUtil:GetDayPassTime()
      userData:SetHazeGiftDayRefreshTimes(self._actId, cfg.day, nextRefreshTimestamp)
    end
  end
end

function ActivityHazeGiftData:CalHazeGiftUnlockDayList()
  self._unlockDayList = {}
  table.insert(self._unlockDayList, true)
  local taskCfg = self._taskCfg
  for index, cfg in ipairs(taskCfg) do
    if index == #taskCfg then
      break
    end
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local cacheTime = userData:GetHazeGiftDayRefreshTimes(self._actId, cfg.day)
    if cacheTime ~= nil and cacheTime <= PlayerDataCenter.timestamp then
      table.insert(self._unlockDayList, true)
    end
  end
end

function ActivityHazeGiftData:RefreshHazeGiftShow()
  self:__RefreshHazeGiftRedDotLooked()
  self:__RefreshHazeGiftRedHasTask()
  self:__RefreshHazeGiftRedHasReward()
end

function ActivityHazeGiftData:__RefreshHazeGiftRedHasTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityHazeGiftEnum.eRedDotType.Task)
  local isCanGet = self:IsCanGetTask()
  local flag = isCanGet
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityHazeGiftData:__RefreshHazeGiftRedHasReward()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityHazeGiftEnum.eRedDotType.Reward)
  local isCanGet = self:IsCanGetReward()
  local flag = isCanGet
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityHazeGiftData:__RefreshHazeGiftRedDotLooked()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityHazeGiftEnum.eRedDotType.Looked)
  local flag = not self:GetActHazeGiftLooked()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityHazeGiftData:GetHazeGiftRuleTitle()
  return self._mainCfg and self._mainCfg.task_rule_title
end

function ActivityHazeGiftData:GetHazeGiftRuleTip()
  return self._mainCfg and self._mainCfg.task_rule_id
end

function ActivityHazeGiftData:GetHazeGiftActivityDes()
  return self._mainCfg and self._mainCfg.activity_des
end

function ActivityHazeGiftData:GetHazeGiftShowHeroId()
  return self._mainCfg and self._mainCfg.hero_id
end

function ActivityHazeGiftData:GetHazeGiftScoreId()
  return self._mainCfg and self._mainCfg.score_id
end

function ActivityHazeGiftData:GetHazeGiftRewardCfg()
  return self._rewardCfg
end

function ActivityHazeGiftData:GetHazeGiftTaskGroupCfg()
  return self._taskCfg
end

function ActivityHazeGiftData:GetHazeGiftFixedRewardList()
  if self._fixedRewardList == nil then
    error("cant get hazeGiftCfg!!")
    return nil
  end
  return self._fixedRewardList
end

function ActivityHazeGiftData:GetHazeGiftRewardIdList()
  if self._rewardIdList == nil then
    error("cant get hazeGiftCfg!!")
    return nil
  end
  return self._rewardIdList
end

function ActivityHazeGiftData:GetActHazeGiftTaskDataListByDayIndex(dayIndex)
  local taskCfg = self._taskCfg[dayIndex]
  if taskCfg == nil or taskCfg.task_group == nil then
    error("cant get hazeGiftCfg!!")
  end
  local taskIdList = taskCfg.task_group
  local taskDataList = {}
  for _, id in ipairs(taskIdList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(id, true)
    table.insert(taskDataList, taskData)
  end
  return taskDataList
end

function ActivityHazeGiftData:IsCanGetTask(dayIndex)
  local isCanGet = false
  for day, isUnlock in ipairs(self._unlockDayList) do
    if dayIndex == nil or day == dayIndex then
      if isUnlock then
        local dayTaskDataList = self:GetActHazeGiftTaskDataListByDayIndex(day)
        for _, taskData in ipairs(dayTaskDataList) do
          isCanGet = isCanGet or taskData:CheckComplete()
          if isCanGet then
            break
          end
        end
      end
      if isCanGet then
        break
      end
    end
  end
  return isCanGet
end

function ActivityHazeGiftData:IsCanGetReward()
  local isCanGet = false
  local rewardIdList = self:GetHazeGiftRewardIdList()
  for _, id in ipairs(rewardIdList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(id, true)
    if not isCanGet and taskData then
      isCanGet = taskData:CheckComplete()
    end
    if isCanGet then
      break
    end
  end
  return isCanGet
end

function ActivityHazeGiftData:SetActHazeGiftLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userData:SetHazeGiftLooked(self._actId)
  self:RefreshHazeGiftShow()
end

function ActivityHazeGiftData:GetActHazeGiftLooked()
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userData:GetHazeGiftLooked(self._actId)
end

function ActivityHazeGiftData:SetActHazeGiftDayLooked(dayIndex)
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userData:SetHazeGiftDayActLooked(self._actId, dayIndex)
end

function ActivityHazeGiftData:GetActHazeGiftDayLooked(dayIndex)
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userData:GetHazeGiftDayActLooked(self._actId, dayIndex)
end

function ActivityHazeGiftData:RefreshHazeGiftFlush()
  self:CalHazeGiftUnlockDayList()
  self:RefreshHazeGiftShow()
end

function ActivityHazeGiftData:CheckHazeGiftDayIsUnlock(dayIndex)
  return self._unlockDayList[dayIndex]
end

function ActivityHazeGiftData:GetBuyShopJumpId()
  return self._mainCfg.shop_id
end

return ActivityHazeGiftData
