local base = require("Game.ActivityFrame.ActivityBase")
local HistoryTinyGameData = class("HistoryTinyGameData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local CommonPoltReviewData = require("Game.CommonUI.PlotReview.CommonPoltReviewData")
local CommonPoltReviewGroupData = require("Game.CommonUI.PlotReview.CommonPoltReviewGroupData")
local ActivityHTGEnum = require("Game.ActivityHistoryTinyGame.ActivityHTGEnum")

function HistoryTinyGameData:ctor(actId)
  self.__actId = actId
  self.__HTGPlayerDic = {}
  base.SetActFrameDataByType(self, ActivityFrameEnum.eActivityType.HistoryTinyGame, actId)
  self:GenAllHTGPlayer()
  self._refreshTime = 0
  self._dailyTaskList = nil
  self._nextExpiredTm = 0
  self._active = 0
  self._pickedDic = {}
  self._cfg = ConfigData.activity_tiny_game_main[actId]
  if self._cfg == nil then
    error("can't read activity_tiny_game_main cfgData by id:" .. tostring(actId))
    return
  end
  self._pointCfg = ConfigData.activity_tiny_game_point[self._cfg.point_reward]
  if self._pointCfg == nil then
    error("can't read activity_tiny_game_point cfgData by id:" .. tostring(self._cfg.point_reward))
    return
  end
  self._allTaskDic = {}
  for i, v in ipairs(self._cfg.activity_daily_task) do
    self._allTaskDic[v] = true
  end
  for i, v in ipairs(self._cfg.task_list) do
    self._allTaskDic[v] = true
  end
  self._avgGroupList = {}
  self._avgPreCondMapping = {}
  self._avgTaskMapping = ConfigData.activity_tiny_game_avg_pre_condition.taskDic[self.__actId]
  local avgPreGroup = ConfigData.activity_tiny_game_avg_pre_condition.groupDic[self.__actId]
  for groupId, avgPreList in ipairs(avgPreGroup) do
    self._avgGroupList[groupId] = {}
    for _, preId in ipairs(avgPreList) do
      local avgId = self._cfg.activity_avg[preId]
      table.insert(self._avgGroupList[groupId], avgId)
      self._avgPreCondMapping[avgId] = ConfigData.activity_tiny_game_avg_pre_condition[self.__actId][preId]
    end
  end
end

function HistoryTinyGameData:UpdateHTGDataByMsg(msg)
  self._refreshTime = msg.refreshTime
  self._dailyTaskList = msg.dailyTask
  self._nextExpiredTm = msg.nextExpiredTm
  for i, pointCfg in ipairs(self._pointCfg) do
    if msg.pickedActiveReward[pointCfg.need_point] ~= nil then
      self._pickedDic[i] = true
    end
  end
  self:UpdateHTGActive(msg.active)
  self:RefreshHTGTaskReddot(nil, true)
  self:RefreshHTGAvgReddot()
end

function HistoryTinyGameData:GenAllHTGPlayer()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameId = self:GetActFrameId()
  local tinyGameDataList = activityFrameCtrl:GetTinyGameDataListByActFrameId(actFrameId)
  if tinyGameDataList == nil or #tinyGameDataList == 0 then
    error("history tiny game activity not has any TinyGames")
    return
  end
  for _, tinyGameData in pairs(tinyGameDataList) do
    self:__GenHTGClass(tinyGameData)
  end
end

function HistoryTinyGameData:__GenHTGClass(tinyGameData)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local tinyGameType = tinyGameData:GetTinyGameCat()
  local tinyGameDataClass = TinyGameEnum.eClassType[tinyGameType]
  if tinyGameDataClass == nil then
    error("History Tiny Game Type not exist type:" .. tostring(tinyGameType))
    return
  end
  tinyGameDataClass = require(tinyGameDataClass)
  local selfHistoryHighScore = activityFrameCtrl:GetTinyGameHistoryHighScore(tinyGameType)
  local playEndTime = self:GetActivityEndTime()
  local HTGPlayer = tinyGameDataClass.New(tinyGameData, selfHistoryHighScore, playEndTime)
  self.__HTGPlayerDic[tinyGameType] = HTGPlayer
end

function HistoryTinyGameData:PlayHTG(tinyGameType)
  local HTGPlayer = self.__HTGPlayerDic[tinyGameType]
  if HTGPlayer ~= nil then
    HTGPlayer:EnterTinyGame()
  end
end

function HistoryTinyGameData:UpdateHTGActive(active)
  self._active = active
  local curLevelActive = active
  local level = 0
  for i, v in ipairs(self._pointCfg) do
    if self._pointCfg[i].need_point <= self._active then
      level = i
    end
  end
  self._level = level
  self:__RefreshHTGACTIVEReddot()
end

function HistoryTinyGameData:UpdateHTGDailyTask(msg)
  self._dailyTaskList = msg.newTaskId
  self._nextExpiredTm = msg.nextExpiredTm
  self._refreshTime = 0
  self:RefreshHTGTaskReddot(nil, true)
end

function HistoryTinyGameData:ReqHTGDailyReplace(taskId, callback)
  if self._refreshTime >= self._cfg.daily_task_refresh_max then
    return
  end
  if not table.indexof(self._dailyTaskList, taskId) then
    return
  end
  local tinyNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityHistoryTinyGame)
  tinyNetCtrl:CS_ACTIVITY_TinyGame_RefreshQuestSingle(self:GetActId(), taskId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    self._refreshTime = self._refreshTime + 1
    local index = table.indexof(self._dailyTaskList, taskId)
    if index then
      self._dailyTaskList[index] = msg.newTaskId
    end
    self:RefreshHTGTaskReddot(nil, true)
    if callback ~= nil then
      callback()
    end
  end)
end

function HistoryTinyGameData:ReqHTGActiveReward(all, level, callback)
  local point = 0
  local reviewIds = {}
  if not all then
    if not self:IsTinyGameActiveCanReward(level) then
      return
    end
    point = self._pointCfg[level].need_point
    table.insert(reviewIds, level)
  else
    local hasReview = false
    for templevel, v in pairs(self._pointCfg) do
      if self:IsTinyGameActiveCanReward(templevel) then
        table.insert(reviewIds, templevel)
      end
    end
    if #reviewIds == 0 then
      return
    end
  end
  local tinyNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityHistoryTinyGame)
  tinyNetCtrl:CS_ACTIVITY_TinyGame_GetActiveReward(self:GetActId(), all, point, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    for _, templevel in ipairs(reviewIds) do
      self._pickedDic[templevel] = true
    end
    self:__RefreshHTGACTIVEReddot()
    local rewardIds = {}
    local rewardNums = {}
    for itemId, itemCount in pairs(msg.rewards) do
      table.insert(rewardIds, itemId)
      table.insert(rewardNums, itemCount)
    end
    if 0 < #rewardIds then
      self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true):SetCRShowOverFunc(function()
          local achievementSystemWin = UIManager:GetWindow(UIWindowTypeID.AchievementSystem)
          if achievementSystemWin ~= nil then
            achievementSystemWin.achievementLevelNode.__NeedRefreshPlayerLevel()
          end
        end)
        window:AddAndTryShowReward(CRData)
      end)
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function HistoryTinyGameData:RefreshHTGTaskReddot(taskId, forceUpdate)
  if not forceUpdate and (taskId == nil or not self._allTaskDic[taskId]) then
    return
  end
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityHTGEnum.eActivityReddot.Task)
  for i, v in ipairs(self._dailyTaskList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(v)
    if taskData ~= nil and taskData:CheckComplete() then
      childReddot:SetRedDotCount(1)
      return
    end
  end
  for i, v in ipairs(self._cfg.task_list) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(v)
    if taskData ~= nil and taskData:CheckComplete() then
      childReddot:SetRedDotCount(1)
      return
    end
  end
  childReddot:SetRedDotCount(0)
end

function HistoryTinyGameData:__RefreshHTGACTIVEReddot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityHTGEnum.eActivityReddot.Active)
  for i = 1, self._level do
    if self:IsTinyGameActiveCanReward(i) then
      childReddot:SetRedDotCount(1)
      return
    end
  end
  childReddot:SetRedDotCount(0)
end

function HistoryTinyGameData:RefreshHTGAvgReddot(avgid, taskId)
  if avgid ~= nil and self._avgPreCondMapping[avgid] == nil then
    return
  end
  if taskId ~= nil and not self._avgTaskMapping[taskId] then
    return
  end
  local actReddot = self:GetActivityReddot()
  if actReddot == nil then
    return
  end
  local childReddot = actReddot:AddChild(ActivityHTGEnum.eActivityReddot.Review)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local reddotCount = 0
  for groupId, avgIds in ipairs(self._avgGroupList) do
    if 1 < groupId then
      local lastAvgList = self._avgGroupList[groupId - 1]
      if not avgPlayCtrl:IsAvgPlayed(lastAvgList[#lastAvgList]) then
        break
      end
      for _, avgId in ipairs(avgIds) do
        if avgPlayCtrl:IsAvgUnlock(avgId) then
          local unlockCfg = self._avgPreCondMapping[avgId]
          if unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
            local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
            if (taskData == nil or taskData:CheckComplete()) and not avgPlayCtrl:IsAvgPlayed(avgId) then
              reddotCount = 1
              break
            end
          end
        end
      end
    end
    if reddotCount == 1 then
      break
    end
  end
  childReddot:SetRedDotCount(reddotCount)
end

function HistoryTinyGameData:GetHTGData(tinyGameType)
  return self.__HTGPlayerDic[tinyGameType]
end

function HistoryTinyGameData:GetTinyGameDailyTaskIds()
  return self._dailyTaskList
end

function HistoryTinyGameData:IsTinyGameActiveHasReward(level)
  return self._pickedDic[level]
end

function HistoryTinyGameData:GetTinyGameActive()
  return self._active
end

function HistoryTinyGameData:GetTinyGameRefrehTimes()
  return self._refreshTime
end

function HistoryTinyGameData:GetTinyGameNextTm()
  return self._nextExpiredTm
end

function HistoryTinyGameData:IsTinyGameActiveCanReward(level)
  if self._pickedDic[level] then
    return false
  end
  local pointCfg = self._pointCfg[level]
  if pointCfg == nil then
    error("point level miss id:" .. tostring(level))
    return false
  end
  return self._active >= pointCfg.need_point
end

function HistoryTinyGameData:GetTGCfgData()
  return self._cfg
end

function HistoryTinyGameData:GetTGActiveCfg()
  return self._pointCfg
end

function HistoryTinyGameData:GetTGMaxActive()
  local maxActiveCfg = self._pointCfg[#self._pointCfg]
  return maxActiveCfg.need_point
end

function HistoryTinyGameData:GetActiveLevel()
  return self._level or 0
end

function HistoryTinyGameData:GetAfterFirstAvgGuideId()
  return self._cfg.avg_guide
end

function HistoryTinyGameData:GetFirstAvgId()
  return self._cfg.activity_avg_start1
end

function HistoryTinyGameData:GetSecondAvgId()
  return self._cfg.activity_avg_start2
end

function HistoryTinyGameData:GetUnlockAllAvgId()
  return self._cfg.activity_avg_finish
end

function HistoryTinyGameData:GetHTGAVGReviewData()
  local unlockAllAvgId = self:GetUnlockAllAvgId()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local CPRData = CommonPoltReviewData.New()
  CPRData:SetCPRBgResName(nil)
  CPRData:SetCPRTitleName(nil)
  local totalCount = 0
  local totalUnlockCount = 0
  for index, avgids in ipairs(self._avgGroupList) do
    if avgids[1] ~= unlockAllAvgId then
      totalCount = totalCount + 1
      local avgid = avgids[1]
      local avgCfg = ConfigData.story_avg[avgid]
      local unlockCfg = self._avgPreCondMapping[avgid]
      local isUnlock = avgPlayCtrl:IsAvgUnlock(avgCfg.id)
      if isUnlock and 1 < index then
        local lastAvgids = self._avgGroupList[index - 1]
        local preAvgId = lastAvgids[#lastAvgids]
        isUnlock = ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(preAvgId)
      end
      if isUnlock and unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
        if taskData ~= nil and isUnlock then
          isUnlock = taskData:CheckComplete()
        end
      end
      if avgCfg ~= nil then
        local groupEnName = "Stage " .. tostring(totalCount)
        local groupName = LanguageUtil.GetLocaleText(avgCfg.describe)
        local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
        local CPRGroupData = CommonPoltReviewGroupData.New(groupEnName, groupName, groupDes, avgids)
        local unlockDes
        if not isUnlock then
          unlockDes = LanguageUtil.GetLocaleText(unlockCfg.describe_condition)
        end
        CPRGroupData:SetAvgGroupDataIsUnlock(isUnlock, unlockDes)
        CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
          if index == 1 then
            return false
          end
          if not CPRGroupData:GetAvgGroupIsUnlock() then
            return false
          end
          local tempavgPlay = ControllerManager:GetController(ControllerTypeId.AvgPlay)
          for i, avgId in ipairs(avgids) do
            local unlockCfg = self._avgPreCondMapping[avgId]
            if unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
              local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
              if (taskData == nil or taskData:CheckComplete()) and not tempavgPlay:IsAvgPlayed(avgId) then
                return true
              end
            end
          end
          return false
        end)
        CPRGroupData:SetAvgSingleDotFunc(function(avgId)
          if index == 1 then
            return false
          end
          local unlockCfg = self._avgPreCondMapping[avgId]
          if unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
            local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
            if taskData ~= nil and not taskData:CheckComplete() then
              return false
            end
          end
          local active = not ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(avgId)
          return active
        end)
        CPRData:AddAvgGroup(CPRGroupData)
      end
      if isUnlock then
        totalUnlockCount = totalUnlockCount + 1
      end
    end
  end
  local avgids = self._avgGroupList[#self._avgGroupList]
  local isUnlock = totalCount <= totalUnlockCount
  isUnlock = isUnlock and avgPlayCtrl:IsAvgUnlock(unlockAllAvgId)
  if isUnlock then
    local lastAvgids = self._avgGroupList[totalCount]
    local preAvgId = lastAvgids[#lastAvgids]
    local isplayed = ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(preAvgId)
    isUnlock = isplayed
  end
  if isUnlock and unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
    if taskData ~= nil and isUnlock then
      isUnlock = taskData:CheckComplete()
    end
  end
  totalCount = totalCount + 1
  local unlockDes
  if not isUnlock then
    local unlockCfg = self._avgPreCondMapping[unlockAllAvgId]
    unlockDes = LanguageUtil.GetLocaleText(unlockCfg.describe_condition)
  else
    totalUnlockCount = totalUnlockCount + 1
  end
  local avgCfg = ConfigData.story_avg[unlockAllAvgId]
  local groupEnName = "Stage " .. tostring(totalCount)
  local groupName = LanguageUtil.GetLocaleText(avgCfg.describe)
  local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupName, groupName, groupDes, {unlockAllAvgId})
  CPRGroupData:SetAvgGroupDataIsUnlock(isUnlock, unlockDes)
  CPRGroupData:SetAvgGroupDataBlueDotFunc(function()
    if not CPRGroupData:GetAvgGroupIsUnlock() then
      return false
    end
    local tempavgPlay = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    for i, avgId in ipairs(avgids) do
      local unlockCfg = self._avgPreCondMapping[avgId]
      if unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
        if (taskData == nil or taskData:CheckComplete()) and not tempavgPlay:IsAvgPlayed(avgId) then
          return true
        end
      end
    end
    return false
  end)
  CPRGroupData:SetAvgSingleDotFunc(function(avgId)
    local unlockCfg = self._avgPreCondMapping[avgId]
    if unlockCfg ~= nil and unlockCfg.task_condition ~= nil then
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(unlockCfg.task_condition, false)
      if taskData ~= nil and not taskData:CheckComplete() then
        return false
      end
    end
    local active = not ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(avgId)
    return active
  end)
  CPRData:AddAvgGroup(CPRGroupData)
  CPRData:SetCPRUnlockNum(totalCount, totalUnlockCount)
  return CPRData
end

function HistoryTinyGameData:GetActivityReddotNum()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return true, 0
  end
  if reddot:GetRedDotCount() == 0 then
    return true, 0
  end
  local isBlue = true
  for i, v in pairs(ActivityHTGEnum.eActivityReddot) do
    if not self:IsHTGBlueReddotType(v) then
      local childReddot = reddot:GetChild(v)
      if childReddot ~= nil and 0 < childReddot:GetRedDotCount() then
        isBlue = false
        break
      end
    end
  end
  return isBlue, reddot:GetRedDotCount()
end

function HistoryTinyGameData:IsHTGBlueReddotType(type)
  if type == ActivityHTGEnum.eActivityReddot.Review then
    return true
  end
  return false
end

return HistoryTinyGameData
