local AllTaskData = class("AllTaskData")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local skipGuide = GR.SkipGameGuide()
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function AllTaskData:ctor()
  self.__sectorTaskTypeCeiling = TaskEnum.eTaskType.SectorTask + 100
  self.__achivTypeCeiling = TaskEnum.eTaskType.Achievement + 100
  self.__timeLimitTypeCeiling = TaskEnum.eTaskType.TimeLimitTask + 100
  self.__activityTypeCeilling = TaskEnum.eTaskType.ActivityTask + 100
  self._taskTypeShowInMain = {}
  for i, list in ipairs(ConfigData.game_config.taskTabSort) do
    for i, taskType in ipairs(list) do
      self._taskTypeShowInMain[taskType] = true
    end
  end
  self.taskDatas = {}
  self.taskTypeDatas = {}
  self.waitExpiredDatas = {}
  self.waitDisappearDatas = {}
  self.__waitExpiredTimer = nil
  self.sectorTaskDatas = {}
  for _, id in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[id]
    self.sectorTaskDatas[sectorCfg.achievement] = {}
  end
  self.normalTaskDatas = {}
  self.timeLimitTaskDataDic = {}
  self.brotatoTaskDatas = {}
  for k, stc in pairs(ConfigData.task) do
    if self:IsNormalType(stc.type) then
      if self.normalTaskDatas[stc.type] == nil then
        self.normalTaskDatas[stc.type] = {}
      end
    elseif self:IsTimeLimitType(stc.type) then
      if self.timeLimitTaskDataDic[stc.type] == nil then
        self.timeLimitTaskDataDic[stc.type] = {}
      end
    elseif self:IsBrotatoTaskType(stc.type) and self.brotatoTaskDatas[stc.type] == nil then
      self.brotatoTaskDatas[stc.type] = {}
    end
  end
  self.weeklyChallengeDatas = {}
  self.completedMainTaskDic = {}
  self.completedMilestoneTaskDic = {}
  self.achievementDatas = {}
  self.achievementTaskNum = 0
  for k, v in pairs(ConfigData.achievement) do
    self.achievementDatas[v.task_type] = {}
  end
  self.taskPeriodDatas = {}
  for typeId, stc in pairs(ConfigData.active) do
    self.taskPeriodDatas[typeId] = {}
  end
  self.specialTaskDatas = {}
  self.guideTaskDatas = {}
  self.avgTaskDatas = {}
end

function AllTaskData:InitAllTaskData(questGroup)
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  if questGroup.received ~= nil then
    if skipGuide and questGroup.received[ConfigData.buildinConfig.FirstGuideTaskId] ~= nil then
      questGroup.received[ConfigData.buildinConfig.FirstGuideTaskId] = nil
    end
    for taskId, questMsg in pairs(questGroup.received) do
      local stcData = ConfigData.task[taskId]
      if stcData == nil then
        error("Cant't find taskCfg,id = " .. taskId)
      else
        local taskData = TaskData.CreateTaskData(questMsg, stcData)
        self:AddTaskData(taskData)
      end
    end
  end
  self:UpdateAllTaskData(true)
end

function AllTaskData:InitCompletedMainTask(mainLineQuest)
  self.completedMainTaskDic = mainLineQuest
end

function AllTaskData:RecordCompletedMainTask(taskId)
  self.completedMainTaskDic[taskId] = true
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteTask)
end

function AllTaskData:InitCompletedMilestoneTask(mileStoneTask)
  self.completedMilestoneTaskDic = mileStoneTask
end

function AllTaskData:RecordCompletedMilestoneTask(taskId)
  self.completedMilestoneTaskDic[taskId] = true
end

function AllTaskData:AddTaskData(taskData)
  self.taskDatas[taskData.id] = taskData
  local stcData = taskData.stcData
  local typeDic = self.taskTypeDatas[stcData.type] or {}
  self.taskTypeDatas[stcData.type] = typeDic
  typeDic[taskData.id] = taskData
  if stcData.isShow then
    if self:IsSectorType(stcData.type) then
      if self.sectorTaskDatas[stcData.type] == nil then
        error(string.format("sectorCfg.achievement(%s) is nil", stcData.type))
        return
      end
      self.sectorTaskDatas[stcData.type][taskData.id] = taskData
    elseif self:IsAchivType(stcData.type) then
      if self.achievementDatas[stcData.type] == nil then
        error(string.format("achievementDatas(%s) is nil", stcData.type))
        return
      end
      self.achievementDatas[stcData.type][taskData.id] = taskData
      self.achievementTaskNum = self.achievementTaskNum + 1
    elseif self:IsNormalType(stcData.type) then
      if self.normalTaskDatas[stcData.type] == nil then
        error(string.format("normalTaskDatas(%s) is nil", stcData.type))
        return
      end
      self.normalTaskDatas[stcData.type][taskData.id] = taskData
    elseif self:IsTimeLimitType(stcData.type) then
      if self.timeLimitTaskDataDic[stcData.type] == nil then
        error(string.format("timeLimitTaskDataDic(%s) is nil", stcData.type))
        return
      end
      self.timeLimitTaskDataDic[stcData.type][taskData.id] = taskData
    elseif self:IsWeeklyChallengeType(stcData.type) then
      self.weeklyChallengeDatas[taskData.id] = taskData
    elseif self:IsBrotatoTaskType(stcData.type) then
      if self.brotatoTaskDatas[stcData.type] == nil then
        error(string.format("brotatoTaskDatas(%s) is nil", stcData.type))
        return
      end
      self.brotatoTaskDatas[stcData.type][taskData.id] = taskData
    end
  end
  if #stcData.guide_id > 0 then
    table.insert(self.guideTaskDatas, taskData)
  end
  if stcData.type == TaskEnum.eTaskType.AvgTask then
    table.insert(self.avgTaskDatas, taskData)
  elseif stcData.type == TaskEnum.eTaskType.SpecialTask then
    table.insert(self.specialTaskDatas, taskData)
  end
end

function AllTaskData:RemoveTaskData(taskData)
  self.taskDatas[taskData.id] = nil
  local stcData = taskData.stcData
  if self.taskTypeDatas[stcData.type] ~= nil then
    self.taskTypeDatas[stcData.type][taskData.id] = nil
  end
  if #stcData.guide_id > 0 then
    table.removebyvalue(self.guideTaskDatas, taskData)
  end
  if stcData.type == TaskEnum.eTaskType.AvgTask then
    table.removebyvalue(self.avgTaskDatas, taskData)
  elseif stcData.type == TaskEnum.eTaskType.SpecialTask then
    table.removebyvalue(self.specialTaskDatas, taskData)
  end
  if stcData.isShow then
    if self:IsSectorType(stcData.type) then
      if self.sectorTaskDatas[stcData.type] == nil then
        error(string.format("sectorCfg.achievement(%s) is nil", stcData.type))
        return
      end
      self.sectorTaskDatas[stcData.type][taskData.id] = nil
    elseif self:IsAchivType(stcData.type) then
      if self.achievementDatas[stcData.type] == nil then
        error(string.format("achievementDatas(%s) is nil", stcData.type))
        return
      end
      self.achievementDatas[stcData.type][taskData.id] = nil
      self.achievementTaskNum = self.achievementTaskNum - 1
    elseif self:IsNormalType(stcData.type) then
      if self.normalTaskDatas[stcData.type] == nil then
        error(string.format("normalTaskDatas(%s) is nil", stcData.type))
        return
      end
      self.normalTaskDatas[stcData.type][taskData.id] = nil
    elseif self:IsTimeLimitType(stcData.type) then
      if self.timeLimitTaskDataDic[stcData.type] == nil then
        error(string.format("timeLimitTaskDataDic(%s) is nil", stcData.type))
        return
      end
      self.timeLimitTaskDataDic[stcData.type][taskData.id] = nil
    elseif self:IsWeeklyChallengeType(stcData.type) then
      self.weeklyChallengeDatas[taskData.id] = nil
    elseif self:IsBrotatoTaskType(stcData.type) then
      self.brotatoTaskDatas[stcData.type][taskData.id] = nil
    end
    MsgCenter:Broadcast(eMsgEventId.TaskDelete, taskData.id)
  end
end

function AllTaskData:TryAutoCompleteHidenTask(taskData)
  if taskData.stcData.isShow == false and taskData:CheckComplete() then
    self.taskNetworkCtrl:SendCommitQuest(taskData)
  end
end

function AllTaskData:UpdateAllTaskData(forceRefresh, changedTaskTypeDic)
  self:__ExpireData()
  local isNormalHasChange, isSectorHasChange, isAchivLevelHasChange, isWCHasChange, isTimeLimitHasChange, isMilestoneChange
  if not forceRefresh then
    for taskType, _ in pairs(changedTaskTypeDic) do
      if self:IsNormalType(taskType) then
        isNormalHasChange = true
      elseif self:IsAchivType(taskType) then
        isAchivLevelHasChange = true
      elseif self:IsWeeklyChallengeType(taskType) then
        isWCHasChange = true
      elseif self:IsTimeLimitType(taskType) then
        isTimeLimitHasChange = true
      elseif self:IsSectorType(taskType) then
        isSectorHasChange = true
      elseif self:IsMilestoneType(taskType) then
        isMilestoneChange = true
      end
    end
  end
  if forceRefresh or isNormalHasChange then
    self:InitNormalTaskRedDot(changedTaskTypeDic)
  end
  if forceRefresh or isSectorHasChange then
    self:InitSectorTaskRedDot()
  end
  if forceRefresh or isAchivLevelHasChange then
    self:InitAchivLevelRedDot(changedTaskTypeDic)
  end
  if forceRefresh or isWCHasChange then
    self:InitWeeklyChallengeTaskRedDot()
  end
  if forceRefresh or isTimeLimitHasChange then
    self:InitTimeLimitTaskRedDot(changedTaskTypeDic)
  end
  if forceRefresh or isMilestoneChange then
    self:_UpdMilestoneRedDot()
  end
  self:InitGuideTaksData()
end

function AllTaskData:InitGuideTaksData()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if saveUserData ~= nil and saveUserData.guideData ~= nil and table.count(saveUserData.guideData.skipGuideTask) > 0 then
    local skipGuideTask = {}
    for taskId, _ in pairs(saveUserData.guideData.skipGuideTask) do
      if self.taskDatas[taskId] ~= nil then
        skipGuideTask[taskId] = true
      end
    end
    saveUserData.guideData.skipGuideTask = skipGuideTask
  end
end

function AllTaskData:InitNormalTaskRedDot(changedTaskTypeDic)
  local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if not ok then
    return
  end
  for TaskType, arr in pairs(self.normalTaskDatas) do
    if changedTaskTypeDic == nil or changedTaskTypeDic[TaskType] then
      if TaskEnum.eTaskType.DailyTask == TaskType or TaskEnum.eTaskType.WeeklyTask == TaskType then
        local isDailyTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
        if not isDailyTaskUnlock then
          goto lbl_61
        end
      end
      local taskPageNode = TaskWindowNode:AddChildWithPath(TaskType, RedDotDynPath.TaskPagePath)
      local taskUnitNode = taskPageNode:AddChild(RedDotStaticTypeId.TaskUnit)
      local completeCount = self:RefreshTaskDataArr(arr)
      if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi) then
        taskUnitNode:SetRedDotCount(completeCount)
      else
        taskUnitNode:SetRedDotCount(0)
      end
    end
    ::lbl_61::
  end
end

function AllTaskData:InitTimeLimitTaskRedDot(changedTaskTypeDic)
  local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if not ok then
    return
  end
  local isLargeActivityunlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
  for TaskType, arr in pairs(self.timeLimitTaskDataDic) do
    if changedTaskTypeDic == nil or changedTaskTypeDic[TaskType] then
      local taskPageNode = TaskWindowNode:AddChildWithPath(TaskType, RedDotDynPath.TaskPagePath)
      local taskUnitNode = taskPageNode:AddChild(RedDotStaticTypeId.TaskUnit)
      local taskFirstOpenNode = taskPageNode:AddChild(RedDotStaticTypeId.TaskFirstOpen)
      if table.count(arr) > 0 then
        local completeCount = self:RefreshTaskDataArr(arr)
        if isLargeActivityunlock then
          taskUnitNode:SetRedDotCount(completeCount)
        else
          taskUnitNode:SetRedDotCount(0)
        end
        if isLargeActivityunlock then
          local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
          local isTaskOpened = saveUserData:GetFirstOpenTaskReddotDic()
          local isHaveNotReadTask = false
          for _, taskData in pairs(arr) do
            if taskData.open_condition ~= nil and not isTaskOpened[taskData.open_condition] then
              isHaveNotReadTask = true
              break
            end
          end
          if isHaveNotReadTask then
            taskFirstOpenNode:SetRedDotCount(1)
          else
            taskFirstOpenNode:SetRedDotCount(0)
          end
        end
      else
        taskUnitNode:SetRedDotCount(0)
        taskFirstOpenNode:SetRedDotCount(0)
      end
    end
  end
end

function AllTaskData:InitSectorTaskRedDot()
  for _, id in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[id]
    local sectorId = sectorCfg.id
    RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId)
    local taskNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemTasksPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTasks)
    local count = 0
    for k, v in pairs(self.sectorTaskDatas[sectorCfg.achievement]) do
      if v:CheckComplete() then
        count = count + 1
      end
    end
    taskNode:SetRedDotCount(count)
  end
end

function AllTaskData:InitAchivLevelRedDot(changedTaskTypeDic)
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi
    for taskType, v in pairs(self.achievementDatas) do
      if changedTaskTypeDic == nil or changedTaskTypeDic[taskType] then
        local pageNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.AchivTaskPagePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
        local count = 0
        for k, v in pairs(v) do
          if v:CheckComplete() then
            count = count + 1
            if latestFinishAchi == nil then
              latestFinishAchi = v
            end
          end
        end
        pageNode:SetRedDotCount(count)
      end
    end
  end
end

function AllTaskData:InitWeeklyChallengeTaskRedDot()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  if not isUnlock then
    return
  end
  local reddot = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  self:UpdateWeeklyChallengeRedDot()
end

function AllTaskData:RefreshTaskDataArr(taskDataArr)
  local count = 0
  if taskDataArr == nil then
    return
  end
  for _, taskData in pairs(taskDataArr) do
    if taskData:CheckComplete() then
      count = count + 1
    end
  end
  return count
end

function AllTaskData:__ExpireData()
  self.__waitExpiredTimer = nil
  self.waitExpiredDatas = {}
  self.waitDisappearDatas = {}
  for k, v in pairs(self.taskDatas) do
    local stcData = v.stcData
    if stcData.isShow then
      if v.expiredTm ~= 0 then
        table.insert(self.waitExpiredDatas, v)
      elseif v.disappearTm ~= 0 then
        table.insert(self.waitDisappearDatas, v)
      end
    end
  end
  local timeStamp = PlayerDataCenter.timestamp
  table.sort(self.waitExpiredDatas, function(a, b)
    return a.expiredTm < b.expiredTm
  end)
  while #self.waitExpiredDatas > 0 do
    local taskData = self.waitExpiredDatas[1]
    if timeStamp >= taskData.expiredTm then
      table.remove(self.waitExpiredDatas, 1)
      if taskData.stcData.end_handle ~= nil and 0 < taskData.stcData.end_handle then
        taskData.disappearTm = taskData.expiredTm + taskData.stcData.end_handle
        taskData.expiredTm = 0
        table.insert(self.waitDisappearDatas, taskData)
      else
        self:RemoveTaskData(taskData)
      end
    else
      break
    end
  end
  local waitDuration
  if #self.waitExpiredDatas > 0 then
    local duration = self.waitExpiredDatas[1].expiredTm - timeStamp
    if waitDuration == nil or waitDuration > duration then
      waitDuration = duration
    end
  end
  table.sort(self.waitDisappearDatas, function(a, b)
    return a.disappearTm < b.disappearTm
  end)
  while #self.waitDisappearDatas > 0 do
    local taskData = self.waitDisappearDatas[1]
    if timeStamp >= taskData.disappearTm then
      table.remove(self.waitDisappearDatas, 1)
      self:RemoveTaskData(taskData)
    else
      break
    end
  end
  if #self.waitDisappearDatas > 0 then
    local duration = self.waitDisappearDatas[1].disappearTm - timeStamp
    if waitDuration == nil or waitDuration > duration then
      waitDuration = duration
    end
  end
  if self.__waitExpiredTimerId ~= nil then
    TimerManager:StopTimer(self.__waitExpiredTimerId)
    self.__waitExpiredTimerId = nil
  end
  if waitDuration ~= nil then
    local delay = math.ceil(waitDuration)
    self.__waitExpiredTimerId = TimerManager:StartTimer(delay, self.__ExpireData, self, true, false, true)
  end
end

function AllTaskData:IsSectorType(type)
  local isSectorType = type >= TaskEnum.eTaskType.SectorTask and type < self.__sectorTaskTypeCeiling
  local sectorId
  if isSectorType then
    for _, id in ipairs(ConfigData.sector.id_sort_list) do
      local sectorCfg = ConfigData.sector[id]
      if type == sectorCfg.achievement then
        sectorId = sectorCfg.id
        break
      end
    end
  end
  return isSectorType, sectorId
end

function AllTaskData:IsNormalType(type)
  return type >= TaskEnum.eTaskType.MainTask and type <= TaskEnum.eTaskType.WeeklyTask
end

function AllTaskData:IsAchivType(type)
  local isAchivType = type >= TaskEnum.eTaskType.Achievement and type < self.__achivTypeCeiling
  return isAchivType
end

function AllTaskData:IsMilestoneType(type)
  local isType = type >= TaskEnum.eTaskType.MilestoneTask and type < TaskEnum.eTaskType.MilestoneTask + 100
  return isType
end

function AllTaskData:IsWeeklyChallengeType(type)
  return type == TaskEnum.eTaskType.WeeklyChallengeTask
end

function AllTaskData:IsBrotatoTaskType(type)
  return type >= TaskEnum.eTaskType.BrotatoTask and type < TaskEnum.eTaskType.BrotatoTaskMax
end

function AllTaskData:IsTimeLimitType(type)
  if not self._taskTypeShowInMain[type] then
    return false
  end
  return type >= TaskEnum.eTaskType.TimeLimitTask and type <= self.__timeLimitTypeCeiling or type >= TaskEnum.eTaskType.ActivityTask and type < self.__activityTypeCeilling
end

function AllTaskData:AllTaskOnTaskUpdate(taskData)
  local taskType = taskData.stcData.type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
    if taskData:CheckComplete() and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask) then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.SectorTask, nil, {
        LanguageUtil.GetLocaleText(taskData.stcData.name)
      }, nil))
    end
  elseif self:IsAchivType(taskType) then
    self:__UpdateAchivTaskRedDotCount(taskType)
    if taskData:CheckComplete() then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.AchievementAchieved, {
        jumpType = JumpManager.eJumpTarget.Achieve4System,
        argList = nil
      }, {
        taskData:GetTaskFirstStepIntro()
      }, nil))
    end
  elseif taskType == TaskEnum.eTaskType.heroTrainTask then
    self:__UpdateHeroTaskRedDotCount(taskType)
  elseif self:IsWeeklyChallengeType(type) then
    self:UpdateWeeklyChallengeRedDot()
  elseif self:IsMilestoneType(taskType) then
    local isMileStoneUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MileStones)
    if not isMileStoneUnlock then
      return
    end
    self:_UpdMilestoneRedDot()
    if taskData:CheckComplete() then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.MilestoneTips, nil, {
        taskData:GetTaskFirstStepIntro()
      }, nil))
    end
  end
end

function AllTaskData:AllTaskOnTaskCommit(stcTask)
  local taskType = stcTask.type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
  elseif self:IsAchivType(taskType) then
    self:__UpdateAchivTaskRedDotCount(taskType)
  elseif taskType == TaskEnum.eTaskType.heroTrainTask then
    self:__UpdateHeroTaskRedDotCount(taskType)
  elseif self:IsWeeklyChallengeType(taskType) then
    self:UpdateWeeklyChallengeRedDot()
  end
end

function AllTaskData:__UpdateSectorTaskRedDotCount(taskType, sectorId)
  if sectorId == nil then
    return
  end
  local OK, taskNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTasks)
  if OK then
    local count = 0
    for k, v in pairs(self.sectorTaskDatas[taskType]) do
      if v:CheckComplete() then
        count = count + 1
      end
    end
    taskNode:SetRedDotCount(count)
  end
end

function AllTaskData:_UpdMilestoneRedDot()
  local unlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MileStones)
  if not unlock then
    return
  end
  for moduleId = 1, ConfigData.milestone_module.maxModuleId do
    local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.MlstModulePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Milestone, moduleId):AddChild(RedDotStaticTypeId.MlstModuleTask)
    local reddotNum = 0
    local typeNum = #ConfigData.milestones_mile_task[moduleId]
    for i = 1, typeNum do
      local taskType = TaskEnum.eTaskType.MilestoneTask + moduleId * 10 + i
      local taskDic = self:GetTaskDataDicByType(taskType)
      for k, v in pairs(taskDic) do
        if not v:IsPickedTaskReward() and v:CheckComplete() then
          reddotNum = reddotNum + 1
          goto lbl_63
        end
      end
    end
    ::lbl_63::
    node:SetRedDotCount(reddotNum)
  end
end

function AllTaskData:__UpdateAchivTaskRedDotCount(taskType)
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi
    local ok, pageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
    if ok then
      local count = 0
      for k, v in pairs(self.achievementDatas[taskType]) do
        if v:CheckComplete() then
          count = count + 1
          if latestFinishAchi == nil then
            latestFinishAchi = v
          end
        end
      end
      pageNode:SetRedDotCount(count)
    end
  end
end

function AllTaskData:__UpdateHeroTaskRedDotCount(taskType)
  local isTrainTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  if isTrainTaskUnlock then
    local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
    if not ok then
      return
    end
    for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
      local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
      local heroTaskNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroTask, RedDotDynPath.HeroCardHeroTaskPath)
      if heroData:IsHaveCompletedHeroTask() then
        heroTaskNode:SetRedDotCount(1)
      else
        heroTaskNode:SetRedDotCount(0)
      end
    end
  end
end

function AllTaskData:UpdateWeeklyChallengeRedDot()
  local ok, reddot = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  if not ok then
    return
  end
  local num = 0
  for _, data in pairs(self.weeklyChallengeDatas) do
    if data:CheckComplete() then
      num = num + 1
    end
  end
  for _, periodData in ipairs(self.taskPeriodDatas[TaskEnum.eTaskPeriodType.WeeklyChallengeTask]) do
    if periodData.stateType == TaskEnum.eTaskState.Completed then
      num = num + 1
    end
  end
  reddot:SetRedDotCount(num)
end

function AllTaskData:IsMainTaskComplete(taskId)
  local taskCfg = ConfigData.task[taskId]
  if taskCfg == nil then
    error("Can't find task，taskId = " .. taskId)
    return true
  end
  if taskCfg.type ~= TaskEnum.eTaskType.MainTask then
    error("The task is not mainTask，taskId = " .. taskId)
    return true
  end
  return self.completedMainTaskDic[taskId] ~= nil
end

function AllTaskData:GetTaskData4Home()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if node:GetRedDotCount() > 0 then
    local taskData, isComplete = self:__GetMainTask4Home()
    if isComplete then
      return taskData, true, false
    end
    for _, taskType in pairs(TaskEnum.HomeTaskRewardOthers) do
      local tasks
      if self:IsNormalType(taskType) then
        tasks = self.normalTaskDatas[taskType]
      elseif self:IsTimeLimitType(taskType) then
        tasks = self.timeLimitTaskDataDic[taskType]
      end
      if tasks ~= nil then
        for _, tmpTaskData in pairs(tasks) do
          local tmpComplete = tmpTaskData:CheckComplete()
          if tmpComplete then
            return tmpTaskData, true, false
          end
        end
      end
    end
    for typeId, datas in pairs(self.taskPeriodDatas) do
      for _, peroidData in pairs(datas) do
        if peroidData.stateType == TaskEnum.eTaskState.Completed and peroidData.stcData.type ~= TaskEnum.eTaskPeriodType.WeeklyChallengeTask then
          return peroidData, true, true
        end
      end
    end
  end
  return self:__GetMainTask4Home(), false
end

function AllTaskData:__GetMainTask4Home()
  local taskData
  local isComplete = false
  for _, tmpTaskData in pairs(self.normalTaskDatas[TaskEnum.eTaskType.MainTask]) do
    local tmpComplete = tmpTaskData:CheckComplete()
    if tmpComplete and not isComplete then
      taskData = tmpTaskData
      isComplete = true
    elseif isComplete == tmpComplete and (taskData == nil or tmpTaskData.id < taskData.id) then
      taskData = tmpTaskData
      isComplete = tmpComplete
    end
  end
  return taskData, isComplete
end

function AllTaskData:GetTaskDataById(taskId, containCompleted)
  local taskData = self.taskDatas[taskId]
  if taskData == nil and containCompleted then
    local stcData = ConfigData.task[taskId]
    taskData = TaskData.CreatePickedTaskData(stcData)
  end
  return taskData
end

function AllTaskData:GetTaskDataDicByType(taskType)
  return self.taskTypeDatas[taskType] or table.emptytable
end

return AllTaskData
