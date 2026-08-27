local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityHallowmasData = class("ActivityHallowmasData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Hallowmas
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActivitySeasonDungeonData = require("Game.ActivityChristmas.ActivitySeasonDungeonData")
local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
local ActInternalUnlockInfo = require("Game.Common.Activity.ActInternalUnlockInfo")
local ActTechTree = require("Game.ActivityFrame.ActTechTree")

function ActivityHallowmasData:InitHallowmasData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_hallowmas_main[msg.actId]
  self._expCfg = ConfigData.activity_hallowmas_exp[msg.actId]
  self._achievementCfg = {}
  local achievementCfg = ConfigData.activity_hallowmas_achievement[msg.actId]
  for k, v in pairs(achievementCfg) do
    local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[v.task_id]
    if envId == nil then
      self._achievementCfg[k] = v
    end
  end
  local count = #self._expCfg
  self._maxLevel = count
  self._cycleExp = self._expCfg[count].need_exp
  self._fixExpMax = self._expCfg[self._maxLevel].total_exp
  self._stageInfoCfg = ConfigData.activity_hallowmas_stage_info[msg.actId]
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ActivityHallowmas)
  self._envDiffDic = {}
  for _, envId in ipairs(self._mainCfg.env_id) do
    if envId ~= 0 then
      self._envDiffDic[envId] = {}
      local envCfg = ConfigData.activity_hallowmas_general_env[envId]
      for i, diffId in ipairs(envCfg.difficulty_id) do
        self._envDiffDic[envId][diffId] = true
      end
    end
  end
  self:__InitTechData()
  self:__GenDungeonData()
  self:__UpdateHallowmas(msg)
  self:__InitUnlockInfo()
end

function ActivityHallowmasData:__InitUnlockInfo()
  self._actUnlockInfo = ActInternalUnlockInfo.New()
  self._actUnlockInfo:InitActAvgUnlockInfo(self._mainCfg.story_stage)
  if self._envDiffDic ~= nil then
    local diffLockDic = {}
    for envId, diffDic in pairs(self._envDiffDic) do
      for diffId, _ in pairs(diffDic) do
        if not self:IsHallowmasDiffUnlock(diffId) then
          diffLockDic[diffId] = envId
        end
      end
    end
    self._actUnlockInfo:InitActEnvDiffUnlockInfo(diffLockDic)
  end
  if self._dungeonDataDic ~= nil then
    local dunLockDic = {}
    for dungeonId, dungeonData in pairs(self._dungeonDataDic) do
      if not dungeonData:GetIsLevelUnlock() then
        dunLockDic[dungeonId] = dungeonData
      end
    end
    self._actUnlockInfo:InitActDunRepeatUnlockInfo(dunLockDic)
  end
end

function ActivityHallowmasData:__InitTechData()
  if self._mainCfg.tech_id == 0 then
    return
  end
  self._actTechTree = ActTechTree.New()
  self._actTechTree:InitTechTree(self._mainCfg.tech_id, self)
  local RefreshHallowmasRedTechCallback = BindCallback(self, self.RefreshHallowmasRedTech)
  self._actTechTree:BindActTechUpdateFunc(RefreshHallowmasRedTechCallback)
  self._actTechTree:BindActTechAllResetFunc(RefreshHallowmasRedTechCallback)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  actFrameCtrl:AddActivityTech(self._actTechTree)
end

function ActivityHallowmasData:UpdateHallowmasData(msg)
  self:__UpdateHallowmas(msg)
  MsgCenter:Broadcast(eMsgEventId.ActivityHallowmas, self:GetActId())
end

function ActivityHallowmasData:__UpdateHallowmas(msg)
  local lastLevel = self._level
  self._level = msg.level
  self._exp = msg.totalScore
  self._dailyExp = msg.dailyScore
  self._taskRefTimes = msg.quest.refreshCnt
  self._expiredTm = msg.quest.expireTm
  self._highestScore = msg.highestScore
  local lastRecord = self._warChessRecord
  self._warChessRecord = msg.warChessRecord
  if lastLevel ~= nil and self._level ~= lastLevel then
    self._actUnlockInfo:UpdateActAvgUnlockInfo()
  end
  if lastRecord ~= nil and self._warChessRecord ~= nil then
    local hasChanged = false
    for k, value in pairs(self._warChessRecord.difficultyRecord) do
      if lastRecord.difficultyRecord[k] ~= value then
        hasChanged = true
        break
      end
    end
    if hasChanged then
      local diffLockDic = self._actUnlockInfo:GetActEnvDiffUnlockInfo()
      if diffLockDic ~= nil then
        for diff, value in pairs(diffLockDic) do
          if self:IsHallowmasDiffUnlock(diff) then
            self._actUnlockInfo:AddActEnvDiffUnlockInfo(diff)
          end
        end
      end
      self._actUnlockInfo:UpdateActDunRepeatUnlockInfo()
    end
  end
  if self._taskIdDic == nil then
    self._taskIdDic = {}
  else
    table.clearmap(self._taskIdDic)
  end
  self._taskIds = msg.quest.received
  for i, v in ipairs(msg.quest.received) do
    self._taskIdDic[v] = true
  end
  self._expPickedDic = msg.obtainHistory
  self._cycleRewardPickedCount = msg.extraPickLevel
  self._curExp = self._exp - self._expCfg[self._level].total_exp
  if self._level == self._maxLevel then
    self._curExp = self._curExp - self._cycleExp * self._cycleRewardPickedCount
  end
  if msg.tech ~= nil and self._actTechTree ~= nil then
    self._actTechTree:UpdateActTechTree(msg.tech)
  end
  self:__TryUpdateAddtionData()
  self:RefreshHallowmasRedDailyTask()
  self:RefreshHallowmasRedExp()
  self:RefreshHallowmasRedAchievement()
  self:RefreshHallowmasRedSectorAvg()
  self:RefreshHallowmasRedTech()
  self:RefreshHallowmasRedRedEnvTask()
end

function ActivityHallowmasData:__GenSectorAvgDic()
  self._avgIdDic = {}
  local avgIds = ConfigData.story_avg.sectorAvgDic[self._mainCfg.story_stage]
  if avgIds == nil then
    return
  end
  for i, v in ipairs(avgIds) do
    self._avgIdDic[v] = true
  end
end

function ActivityHallowmasData:__GenDungeonData()
  self._dungeonDataDic = {}
  local actId = self:GetActId()
  self._dungeonIdList = ConfigData.season_battle_ex.level_list_dic[actId]
  if self._dungeonIdList == nil then
    return
  end
  for index, dunStageId in pairs(self._dungeonIdList) do
    local extraCfg = ConfigData.season_battle_ex[actId][dunStageId]
    local dungeonData = ActivitySeasonDungeonData.New(dunStageId, extraCfg, actId, index)
    self._dungeonDataDic[dunStageId] = dungeonData
  end
end

function ActivityHallowmasData:__TryUpdateAddtionData()
  if self._seasonAddtionData == nil then
    return
  end
  self._seasonAddtionData:SetSeasonScoreData(self._dailyExp, self._mainCfg.score_daily_limit)
end

function ActivityHallowmasData:RefreshHallowmasRedDailyTask(taskData)
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local taskRed = actRed:AddChild(ActivityHallowmasEnum.reddotType.DailyTask)
  if not self:IsActivityRunning() then
    taskRed:SetRedDotCount(0)
    return
  end
  if taskData ~= nil then
    if taskData:CheckComplete() and taskRed:GetRedDotCount() ~= 1 then
      taskRed:SetRedDotCount(1)
    end
    return
  end
  if self:IsActivityRunning() then
    for taskId, _ in pairs(self._taskIdDic) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        taskRed:SetRedDotCount(1)
        return
      end
    end
  end
  taskRed:SetRedDotCount(0)
end

function ActivityHallowmasData:RefreshHallowmasRedExp()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local expRed = actRed:AddChild(ActivityHallowmasEnum.reddotType.Exp)
  expRed:SetRedDotCount(self:IsHallowmasExpAllReceive() and 1 or 0)
end

function ActivityHallowmasData:RefreshHallowmasRedAchievement(taskData)
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local achienementRed = actRed:AddChild(ActivityHallowmasEnum.reddotType.Achievement)
  if taskData ~= nil then
    if taskData:CheckComplete() and achienementRed:GetRedDotCount() ~= 1 then
      achienementRed:SetRedDotCount(1)
    end
    return
  end
  for taskId, _ in pairs(self._achievementCfg) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() then
      achienementRed:SetRedDotCount(1)
      return
    end
  end
  achienementRed:SetRedDotCount(0)
end

function ActivityHallowmasData:RefreshHallowmasRedRedEnvTask(taskData, envId)
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local envTaskRed = actRed:AddChild(ActivityHallowmasEnum.reddotType.EnvTask)
  if not self:IsActivityRunning() then
    envTaskRed:ClearChild()
    return
  end
  if taskData ~= nil then
    local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[taskData.id]
    if envId ~= nil and taskData:CheckComplete() and self:IsHallowmasEnvUnlock(envId) then
      local envIdRed = envTaskRed:AddChild(envId)
      if envIdRed:GetRedDotCount() ~= 1 then
        envIdRed:SetRedDotCount(1)
      end
    end
    return
  end
  if envId ~= nil then
    local envIdRed = envTaskRed:AddChild(envId)
    local envCfg = ConfigData.activity_hallowmas_general_env[envId]
    for _, taskId in ipairs(envCfg.env_task) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        envIdRed:SetRedDotCount(1)
        return
      end
    end
    envIdRed:SetRedDotCount(0)
    return
  end
  for _, singEnvId in ipairs(self._mainCfg.env_id) do
    if self:IsHallowmasEnvUnlock(singEnvId) then
      local envIdRed = envTaskRed:AddChild(singEnvId)
      local envCfg = ConfigData.activity_hallowmas_general_env[singEnvId]
      local redCount = 0
      for _, taskId in ipairs(envCfg.env_task) do
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
        if taskData ~= nil and taskData:CheckComplete() then
          redCount = 1
          break
        end
      end
      envIdRed:SetRedDotCount(redCount)
    end
  end
end

function ActivityHallowmasData:RefreshHallowmasRedSectorAvg()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local sectorAvgRed = actRed:AddChild(ActivityHallowmasEnum.reddotType.SectorAvg)
  if self._avgIdDic == nil then
    self:__GenSectorAvgDic()
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k, v in pairs(self._avgIdDic) do
    local played = avgPlayCtrl:IsAvgPlayed(k)
    local unlock = avgPlayCtrl:IsAvgUnlock(k)
    if not played and unlock then
      sectorAvgRed:SetRedDotCount(1)
      return
    end
  end
  sectorAvgRed:SetRedDotCount(0)
end

function ActivityHallowmasData:RefreshHallowmasRedTech()
  if self._actTechTree == nil then
    return
  end
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local reddotChild = reddot:AddChild(ActivityHallowmasEnum.reddotType.Tech)
  local itemReddot = reddot:AddChild(ActivityHallowmasEnum.reddotType.TechItemLimit)
  if not self:IsActivityRunning() then
    reddotChild:ClearChild()
    itemReddot:SetRedDotCount(0)
    return
  end
  local branchDic = self._actTechTree:GetTechDataDic()[self._mainCfg.tech_special_branch]
  local hasLeveUpTech = false
  for k, techData in pairs(branchDic) do
    if techData:IsCouldLevelUp() then
      hasLeveUpTech = true
      break
    end
  end
  local reddotChildPage = reddotChild:AddChild(self._mainCfg.tech_special_branch)
  reddotChildPage:SetRedDotCount(hasLeveUpTech and 1 or 0)
  local flag, itemId = self._actTechTree:GetTreeResetReturnItemId()
  if flag then
    itemReddot:SetRedDotCount(PlayerDataCenter:GetItemCount(itemId) >= 20000 and 1 or 0)
  end
end

function ActivityBase:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityHallowmasEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityHallowmasData:ReqHallowmasBuyScore(count, callback)
  if self._mainCfg.score_buy_time > PlayerDataCenter.timestamp then
    return
  end
  if self._level + count > self._maxLevel then
    return
  end
  self._temp_buy_costDic = self._temp_buy_costDic or {}
  table.clearmap(self._temp_buy_costDic)
  for i = 0, count - 1 do
    local cfg = self._expCfg[self._level + i]
    local num = self._temp_buy_costDic[cfg.level_cost_id] or 0
    self._temp_buy_costDic[cfg.level_cost_id] = num + cfg.level_cost_num
  end
  for k, v in pairs(self._temp_buy_costDic) do
    if k == ConstGlobalItem.PaidSubItem then
      if v > PlayerDataCenter:GetItemCount(k) + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem) then
        return false
      end
    elseif v > PlayerDataCenter:GetItemCount(k) then
      return false
    end
  end
  self._net:CS_ACTIVITY_Halloween2022_BuyScore(self:GetActId(), count, callback)
end

function ActivityHallowmasData:ReqHallowmasExpReceive(level, callback)
  if not self:IsHallowmasLevelCanPick(level) then
    return
  end
  self._net:CS_ACTIVITY_Halloween2022_PickLevelReward(self:GetActId(), level, callback)
end

function ActivityHallowmasData:ReqHallowmasExpCycle(callback)
  if not self:IsHallowmasCycleCanPick() then
    return
  end
  self._net:CS_ACTIVITY_Halloween2022_PickCycleReward(self:GetActId(), callback)
end

function ActivityHallowmasData:ReqHallowmasAllExp(callback)
  if not self:IsHallowmasExpAllReceive() then
    return
  end
  self._net:CS_ACTIVITY_Halloween2022_PickAllLevelReward(self:GetActId(), callback)
end

function ActivityHallowmasData:ReqHallowmasRefreshTask(taskId, callback)
  if not self:IsActivityRunning() then
    return
  end
  if self._taskRefTimes >= self._mainCfg.daily_task_refresh_max then
    return
  end
  if self._taskIdDic[taskId] == nil then
    return
  end
  local index = table.indexof(self._taskIds, taskId)
  self._net:CS_ACTIVITY_Halloween2022_RefreshSingleQuest(self:GetActId(), taskId, function()
    if callback ~= nil then
      callback(self._taskIds[index])
    end
  end)
end

function ActivityHallowmasData:ReqHallowmasCommitTask(taskId, callback)
  if not self:IsActivityRunning() then
    return
  end
  local tasKType
  if self._taskIdDic[taskId] then
    tasKType = 1
  elseif self._achievementCfg[taskId] then
    tasKType = 2
  else
    local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[taskId]
    if envId ~= nil and self:IsHallowmasEnvUnlock(envId) then
      tasKType = 3
    end
  end
  if tasKType == nil then
    return
  end
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(self:GetActFrameId(), taskId, function()
    if tasKType == 1 then
      self._taskIdDic[taskId] = nil
      self:RefreshHallowmasRedDailyTask()
    elseif tasKType == 2 then
      self:RefreshHallowmasRedAchievement()
    elseif tasKType == 3 then
      local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[taskId]
      self:RefreshHallowmasRedRedEnvTask(nil, envId)
    end
    local rewards, nums = taskData:GetTaskCfgRewards()
    local CRData = CommonRewardData.CreateCRDataUseList(rewards, nums)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHallowmasData:ReqHallowmasCommitEnvTaskList(taskIds, callback)
  if not self:IsActivityRunning() then
    return
  end
  local envId = ConfigData.activity_hallowmas_general_env.taskEnvDic[taskIds[1]]
  if envId == nil or not self:IsHallowmasEnvUnlock(envId) then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Select_Commit(self:GetActFrameId(), taskIds, function()
    self:RefreshHallowmasRedRedEnvTask(nil, envId)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHallowmasData:ReqHallowmasAllChievement(callback)
  local taskIds = {}
  for taskId, _ in pairs(self._achievementCfg) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() then
      table.insert(taskIds, taskId)
    end
  end
  if taskIds[1] == nil then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Select_Commit(self:GetActFrameId(), taskIds, function()
    self:RefreshHallowmasRedAchievement()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHallowmasData:IsHallowmasLevelCanPick(level)
  if self._expPickedDic[level] then
    return false
  end
  return level <= self._level
end

function ActivityHallowmasData:IsHallowmasLevelReceived(level)
  return self._expPickedDic[level]
end

function ActivityHallowmasData:IsHallowmasCycleCanPick()
  if self._level < self._maxLevel then
    return false
  end
  return self._curExp >= self._cycleExp
end

function ActivityHallowmasData:IsHallowmasCycleCanPick()
  if self._level < self._maxLevel then
    return false
  end
  return self._curExp >= self._cycleExp
end

function ActivityHallowmasData:IsHallowmasExpAllReceive()
  if self._level ~= #self._expPickedDic then
    return true
  end
  if self._level == self._maxLevel then
    return self._curExp >= self._cycleExp
  end
  return false
end

function ActivityHallowmasData:IsHallowmasSectorAvg(avgId)
  if self._avgIdDic ~= nil then
    self:__GenSectorAvgDic()
  end
  return self._avgIdDic[avgId]
end

function ActivityHallowmasData:IsHallowmasDiffUnlock(difficult)
  local cfg = self._stageInfoCfg[difficult]
  if cfg == nil then
    return false
  end
  if cfg.preConditionsNum == 0 then
    return true
  end
  for i, v in ipairs(cfg.preConditions) do
    if CheckCondition.CheckLua(v[1], v[2], v[3]) then
      return true
    end
  end
  return false
end

function ActivityHallowmasData:IsHallowmasEnvUnlock(envId)
  if self._tempUnlockEncDic ~= nil and self._tempUnlockEncDic[envId] then
    return true
  end
  local cfg = ConfigData.activity_hallowmas_general_env[envId]
  if cfg == nil then
    return false
  end
  if cfg.preConditionsNum == 0 then
    if self._tempUnlockEncDic == nil then
      self._tempUnlockEncDic = {}
    end
    self._tempUnlockEncDic[envId] = true
    return true
  end
  for i, v in ipairs(cfg.preConditions) do
    if CheckCondition.CheckLua(v[1], v[2], v[3]) then
      if self._tempUnlockEncDic == nil then
        self._tempUnlockEncDic = {}
      end
      self._tempUnlockEncDic[envId] = true
      return true
    end
  end
  return false
end

function ActivityHallowmasData:IsHallowmasEnvDiffcultyExist(envId, diffcultyId)
  if self._envDiffDic[envId] == nil then
    return false
  end
  return self._envDiffDic[envId][diffcultyId]
end

function ActivityHallowmasData:GetHallowmasMainCfg()
  return self._mainCfg
end

function ActivityHallowmasData:GetHallowmasExpCfg()
  return self._expCfg
end

function ActivityHallowmasData:GetHallowmasStageInfoCfg()
  return self._stageInfoCfg
end

function ActivityHallowmasData:GetHallowmasAchievementCfg()
  return self._achievementCfg
end

function ActivityHallowmasData:GetTaskInitTaskTime()
  return self._mainCfg.task_time
end

function ActivityHallowmasData:GetHallowmasScoreDailyLimit()
  return self._dailyExp, self._mainCfg.score_daily_limit
end

function ActivityHallowmasData:GetHallowmasScoreItemId()
  return self._mainCfg.score_token
end

function ActivityHallowmasData:GetHallowmasWarChessRecord()
  return self._warChessRecord
end

function ActivityHallowmasData:GetCompleteDiffDic()
  return self._warChessRecord.difficultyRecord
end

function ActivityHallowmasData:GetHallowmasEnvScore(envId)
  return self._warChessRecord.envRecord[envId] or 0
end

function ActivityHallowmasData:GetHallowmasLv()
  return self._level
end

function ActivityHallowmasData:GetHallowmasLvLimit()
  return self._maxLevel
end

function ActivityHallowmasData:GetHallowmasAllExp()
  return self._exp
end

function ActivityHallowmasData:GetHallowmasCurExp()
  return self._curExp
end

function ActivityHallowmasData:GetHallowmasCurExpLimit()
  local cfg = self._expCfg[self._level]
  if cfg == nil then
    return 0
  end
  return cfg.need_exp
end

function ActivityHallowmasData:GetHallowmasCycleExpLimit()
  return self._cycleExp
end

function ActivityHallowmasData:GetHallowmasDailyTaskIdDic()
  return self._taskIdDic
end

function ActivityHallowmasData:GetHallowmasDailyTaskIds()
  return self._taskIds
end

function ActivityHallowmasData:GetSeasonDungeonInfo()
  return self._dungeonDataDic, self._dungeonIdList
end

function ActivityHallowmasData:GetHallowmasExpiredTm()
  return self._expiredTm
end

function ActivityHallowmasData:GetHallowmasExpPicked()
  return self._expPickedDic
end

function ActivityHallowmasData:GetHallowmasTaskRefreshTimes()
  return self._taskRefTimes
end

function ActivityHallowmasData:GetHallowmasHighestScore()
  return self._highestScore
end

function ActivityHallowmasData:GetHallowmasSeasonAddtion()
  if self._seasonAddtionData == nil then
    self._seasonAddtionData = WarChessSeasonAddtionData.New()
    local tip = ConfigData:GetTipContent(self._mainCfg.clear_tip)
    self._seasonAddtionData:SetSeasonCompleteFloorTip(tip)
    self._seasonAddtionData:SetSeasonScoreToken(self:GetHallowmasScoreItemId())
    self._seasonAddtionData:SetSelectLevelTokenCallback(function()
      UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
        if win == nil then
          return
        end
        win:InitCarnivalInfoWindow(self._mainCfg.score_limit_tip)
      end)
    end)
    self:__TryUpdateAddtionData()
  end
  return self._seasonAddtionData
end

function ActivityHallowmasData:GetHallowmasTechTree()
  return self._actTechTree
end

function ActivityHallowmasData:GetHallowmasEnvIdByDifficultyId(diffId)
  for envId, diffDic in pairs(self._envDiffDic) do
    if diffDic[diffId] == true then
      return envId
    end
  end
  return -1
end

function ActivityHallowmasData:GetHallowmasDiffIdByTowerId(towerId)
  if self._tempTowerDiffMap ~= nil and self._tempTowerDiffMap[towerId] ~= nil then
    return self._tempTowerDiffMap[towerId]
  end
  for diffId, v in pairs(self._stageInfoCfg) do
    if v.season_id == towerId then
      if self._tempTowerDiffMap == nil then
        self._tempTowerDiffMap = {}
      end
      self._tempTowerDiffMap[towerId] = diffId
      return diffId
    end
  end
  return -1
end

function ActivityHallowmasData:GetActHallowmasUnlockInfo()
  return self._actUnlockInfo
end

function ActivityHallowmasData:DealHallowmasWhenEnd()
  self._actUnlockInfo:ResetAllUnlockData()
end

return ActivityHallowmasData
