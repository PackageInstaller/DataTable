local TaskController = class("TaskController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local cs_MessageCommon = CS.MessageCommon
local TaskData = require("Game.Task.Data.TaskData")

function TaskController:OnInit()
  self.allTaskData = PlayerDataCenter.allTaskData
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Task)
  self.showingPageType = nil
  self.showingActiveType = nil
  self.isFrist = true
  self.isDailyCompleteToRefresh = false
  self.allDailyTaskList = {}
  self.AllWeeklyTaskList = {}
  self.BrotatoTaskList = {}
  self.TaskOverflowAwardDic = {}
  self.allTimeLimitTask = {}
  self.timeLimitTaskendTime = {}
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  self.isDailyTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
end

function TaskController:AddTimeLimitTask(taskType, taksList, endTime)
  if self.allTimeLimitTask[taskType] == nil then
    self.allTimeLimitTask[taskType] = {}
    self.timeLimitTaskendTime[taskType] = endTime or 0
  end
  for _, taskId in pairs(taksList) do
    table.insert(self.allTimeLimitTask[taskType], taskId)
  end
end

function TaskController:ReomveTimeLimitTask(taskType, taskList)
  if self.allTimeLimitTask[taskType] == nil then
    self.timeLimitTaskendTime[taskType] = nil
    return
  end
  for _, taskId in pairs(taskList) do
    table.removebyvalue(self.allTimeLimitTask[taskType], taskId)
    if #self.allTimeLimitTask[taskType] == 0 then
      self.allTimeLimitTask[taskType] = nil
      self.timeLimitTaskendTime[taskType] = nil
      return
    end
  end
end

function TaskController:SetDailyAndWeeklyLock()
  self.isDailyTaskUnlock = true
  self:PeriodTaskRedDot()
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return
  end
  win:RefreshPages()
end

function TaskController:RecvPeriodTaskDetail(msg)
  if self.isFrist then
    self:RefreshPeriodData(msg)
    self:PeriodTaskRedDot()
    self.isFrist = false
  else
    self:RefreshPeriodData(msg)
    self:PeriodTaskRedDot()
  end
  MsgCenter:Broadcast(eMsgEventId.PeroidUpdate)
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil or self.showingPageType == nil then
    return
  end
  win:OnSelectPage(self.showingPageType)
end

function TaskController:RefreshPeriodData(msg)
  self.allDailyTaskList = msg.daily
  self.AllWeeklyTaskList = msg.weekly
  self.WeeklyChallengeTaskList = msg.weeklyChallenge
  local actPeriodTaskId2ActivityDic = {}
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityDic = activivityCtrl:GetActivityFrameDataDic()
  for activityFrameId, activityFrameData in pairs(activityDic) do
    if activityFrameData:GetCouldShowActivity() then
      local actGneralCfg = ConfigData.activity_general[activityFrameId]
      if actGneralCfg ~= nil and actGneralCfg.period_quest ~= nil then
        for _, taskId in pairs(actGneralCfg.period_quest) do
          if actPeriodTaskId2ActivityDic[taskId] ~= nil then
            error(string.format("duplicated taskId for act added periodTask. taskId:%s act1:%s act2:%s", tostring(taskId), tostring(actPeriodTaskId2ActivityDic[taskId]), tostring(activityFrameId)))
          end
          actPeriodTaskId2ActivityDic[taskId] = activityFrameId
        end
      end
    end
  end
  self.actPeriodTaskId2ActivityDic = actPeriodTaskId2ActivityDic
  for typeId, activeDatas in pairs(ConfigData.active) do
    local pointId = activeDatas[1].activeId
    local currPoint = PlayerDataCenter:GetItemCount(pointId)
    local neetPoint = 0
    local stateType
    for _, stcData in ipairs(activeDatas) do
      local msgDatas
      if typeId == TaskEnum.eTaskPeriodType.DailyTask then
        msgDatas = msg.dailyRewards
      elseif typeId == TaskEnum.eTaskPeriodType.WeeklyTask then
        msgDatas = msg.weeklyRewarsd
      elseif typeId == TaskEnum.eTaskPeriodType.WeeklyChallengeTask then
        msgDatas = msg.weeklyChallengeRewards
      else
        error("eTaskPeriodType is nonexistent,typeId is " .. tostring(typeId))
        return
      end
      local isReceived = msgDatas[stcData.id]
      neetPoint = stcData.activeNum
      if isReceived then
        stateType = TaskEnum.eTaskState.Picked
      elseif currPoint >= neetPoint then
        stateType = TaskEnum.eTaskState.Completed
      else
        stateType = TaskEnum.eTaskState.InProgress
      end
      if stateType == nil then
        error("Can't confirm period task state")
        return
      end
      local periodData = self.allTaskData.taskPeriodDatas[typeId][stcData.id]
      if periodData == nil then
        periodData = {}
        periodData.stcData = stcData
        periodData.stateType = stateType
        self.allTaskData.taskPeriodDatas[typeId][stcData.id] = periodData
      else
        local lastState = periodData.stateType
        periodData.stateType = stateType
        if stateType == TaskEnum.eTaskState.Picked and lastState ~= stateType then
          MsgCenter:Broadcast(eMsgEventId.PeroidCommitComplete, periodData)
        end
      end
    end
  end
end

function TaskController:PeriodTaskRedDot()
  if not self.isDailyTaskUnlock then
    return
  end
  for actionTypeId, _ in pairs(ConfigData.active) do
    local datas = self:GetDatas4Peroid(actionTypeId)
    local completeNum = 0
    for key, value in pairs(datas) do
      if value.stateType == TaskEnum.eTaskState.Completed then
        completeNum = completeNum + 1
      end
    end
    if actionTypeId == TaskEnum.eTaskPeriodType.WeeklyChallengeTask then
      PlayerDataCenter.allTaskData:UpdateWeeklyChallengeRedDot()
    else
      local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
      if ok then
        local TaskType = self:__ActiveType2TaskType(actionTypeId)
        local taskPageNode = TaskWindowNode:GetChild(TaskType)
        if taskPageNode ~= nil then
          local taskPeriodNode = taskPageNode:AddChildWithPath(actionTypeId, RedDotDynPath.TaskPeriodPath)
          taskPeriodNode:SetRedDotCount(completeNum)
        end
      end
    end
  end
end

function TaskController:__ActiveType2TaskType(activeType)
  local taskType
  for type, typeId in pairs(TaskEnum.eTaskPeriodType) do
    if activeType == typeId then
      taskType = TaskEnum.eTaskType[type]
    end
  end
  return taskType
end

function TaskController:CheckExpiredAndUpdate()
  self.network:SendQuestPeriodDetail()
end

function TaskController:ShowTaskUI(selectPageTypeId, fromType, openCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.Task, function(win)
    if win == nil then
      error("can't open Task winodw")
      return
    end
    win:SetFromWhichUI(fromType)
    if openCallback ~= nil then
      openCallback(win)
    end
    win:RefreshPages()
    if selectPageTypeId ~= nil then
      win:SelectPage(selectPageTypeId)
    else
    end
  end)
end

function TaskController:CloseTaskUI()
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return
  end
  win:Delete()
  self.showingPageType = nil
  self.showingActiveType = nil
  self.beforTypeId = nil
end

function TaskController:GetPageGroupList()
  local groupList = table.deepCopy(ConfigData.game_config.taskTabSort)
  for index, group in ipairs(groupList) do
    group.realIndex = index
  end
  
  local function tryRemoveGroupFunc(functionUnlock, typeId, group, typeIndex, groupIndex)
    if not functionUnlock or self.allTimeLimitTask[typeId] == nil or #self.allTimeLimitTask[typeId] == 0 then
      table.remove(group, typeIndex)
      if #group == 0 then
        table.remove(groupList, groupIndex)
      end
    end
  end
  
  for groupIndex = #groupList, 1, -1 do
    local group = groupList[groupIndex]
    for typeIndex = #group, 1, -1 do
      local typeId = group[typeIndex]
      if typeId == TaskEnum.eTaskType.LargeActivityTask then
        local isLargeActivityUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
        tryRemoveGroupFunc(isLargeActivityUnlock, typeId, group, typeIndex, groupIndex)
      elseif typeId == TaskEnum.eTaskType.HeroActivityTask then
        local isHeroActivityUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity)
        tryRemoveGroupFunc(isHeroActivityUnlock, typeId, group, typeIndex, groupIndex)
      end
    end
  end
  return groupList
end

function TaskController:GetPageName(index, subIndex)
  local taskNames = ConfigData.game_config.taskNames
  if taskNames == nil then
    error("can't read taskNames")
    return "", ""
  end
  local name, name_en
  if subIndex == nil then
    local str = string.split(ConfigData:GetTipContent(taskNames[index][1]), "|")
    name = str[1]
    name_en = str[2]
  else
    local str = string.split(ConfigData:GetTipContent(taskNames[index][subIndex]), "|")
    name = str[1]
    name_en = str[2]
  end
  return name, name_en
end

function TaskController:GetIndexOfTaskType(taskTypeId)
  for index, subTagIds in ipairs(self:GetPageGroupList()) do
    if table.contain(subTagIds, taskTypeId) then
      return subTagIds.realIndex
    end
  end
  return nil
end

function TaskController:GetTaskTypeName(taskTypeId)
  local index = self:GetIndexOfTaskType(taskTypeId)
  if index == nil then
    return "", ""
  end
  return self:GetPageName(index)
end

function TaskController:GetDatas4Task(typeId)
  local function CreateDataContainFinished(taskList, taskDatas)
    local newTaskDatas = {}
    
    for id, value in pairs(taskDatas) do
      newTaskDatas[id] = value
    end
    for _, id in ipairs(taskList) do
      if newTaskDatas[id] == nil then
        local stcData = ConfigData.task[id]
        if stcData == nil then
          error("Cant get task cfg, id = " .. tostring(id))
        elseif stcData.isShow then
          local taskData = TaskData.CreatePickedTaskData(stcData)
          taskData.isPicked = true
          newTaskDatas[id] = taskData
        end
      end
    end
    return newTaskDatas
  end
  
  local taskDatas
  if typeId == TaskEnum.eTaskType.DailyTask then
    local taskDatas = self.allTaskData.normalTaskDatas[typeId]
    local newTaskDatas = CreateDataContainFinished(self.allDailyTaskList, taskDatas)
    for taskId, taskData in pairs(newTaskDatas) do
      local actFrameId = self.actPeriodTaskId2ActivityDic ~= nil and self.actPeriodTaskId2ActivityDic[taskId]
      if actFrameId ~= nil then
        taskData:SetBindActFramId(actFrameId)
      end
    end
    return newTaskDatas, self:GetDatas4Peroid(TaskEnum.eTaskPeriodType.DailyTask)
  elseif typeId == TaskEnum.eTaskType.WeeklyTask then
    local taskDatas = self.allTaskData.normalTaskDatas[typeId]
    local newTaskDatas = CreateDataContainFinished(self.AllWeeklyTaskList, taskDatas)
    for taskId, taskData in pairs(newTaskDatas) do
      local actFrameId = self.actPeriodTaskId2ActivityDic ~= nil and self.actPeriodTaskId2ActivityDic[taskId]
      if actFrameId ~= nil then
        taskData:SetBindActFramId(actFrameId)
      end
    end
    return newTaskDatas, self:GetDatas4Peroid(TaskEnum.eTaskPeriodType.WeeklyTask)
  elseif typeId == TaskEnum.eTaskType.WeeklyChallengeTask then
    local taskDatas = self.allTaskData.weeklyChallengeDatas
    local newTaskDatas = CreateDataContainFinished(self.WeeklyChallengeTaskList, taskDatas)
    return newTaskDatas, self:GetDatas4Peroid(TaskEnum.eTaskPeriodType.WeeklyChallengeTask)
  elseif TaskEnum.IsActivityTask(typeId) then
    local taskDatas = self.allTaskData.timeLimitTaskDataDic[typeId]
    if self.allTimeLimitTask[typeId] ~= nil then
      local newTaskDatas = CreateDataContainFinished(self.allTimeLimitTask[typeId], taskDatas)
      return newTaskDatas
    end
  elseif self.allTaskData:IsBrotatoTaskType(typeId) then
    local taskDatas = self.allTaskData.brotatoTaskDatas[typeId]
    local newTaskDatas = CreateDataContainFinished(self.BrotatoTaskList, taskDatas)
    return newTaskDatas
  else
    taskDatas = self.allTaskData.normalTaskDatas[typeId]
  end
  return taskDatas or {}
end

function TaskController:GetDatas4Peroid(activeTypeId)
  return self.allTaskData.taskPeriodDatas[activeTypeId]
end

function TaskController:GetTaskIds(typeId, ids, perodicDic)
  local taskDatas, peroidDatas = self:GetDatas4Task(typeId)
  for k, v in pairs(taskDatas) do
    if v:CheckComplete() then
      ids[k] = true
    end
  end
  if peroidDatas ~= nil then
    perodicDic[self:TaskType2PeriodType(typeId)] = {}
    for taskId, data in pairs(peroidDatas) do
      if data.stateType == TaskEnum.eTaskState.Completed then
        perodicDic[self:TaskType2PeriodType(typeId)][taskId] = true
      end
    end
  end
  return ids, perodicDic
end

function TaskController:SelectTask(typeId)
  self.showingPageType = typeId
  if typeId == TaskEnum.eTaskType.DailyTask then
    self.showingActiveType = TaskEnum.eTaskPeriodType.DailyTask
  elseif typeId == TaskEnum.eTaskType.WeeklyTask then
    self.showingActiveType = TaskEnum.eTaskPeriodType.WeeklyTask
  elseif typeId == TaskEnum.eTaskType.WeeklyChallengeTask then
    self.showingActiveType = TaskEnum.eTaskPeriodType.WeeklyChallengeTask
  else
    self.showingActiveType = nil
  end
end

function TaskController:IsChangeTaskType(typeId)
  if typeId == TaskEnum.eTaskType.DailyTask or typeId == TaskEnum.eTaskType.WeeklyTask then
    typeId = TaskEnum.eTaskType.DailyTask
  end
  if self.beforTypeId ~= typeId then
    self.beforTypeId = typeId
    return true
  end
  return false
end

function TaskController:IsPeriodTaskType(typeId)
  return typeId == TaskEnum.eTaskType.SideTask
end

function TaskController:TaskType2PeriodType(taskTypeId)
  if taskTypeId == TaskEnum.eTaskType.DailyTask then
    return TaskEnum.eTaskPeriodType.DailyTask
  elseif taskTypeId == TaskEnum.eTaskType.WeeklyTask then
    return TaskEnum.eTaskPeriodType.WeeklyTask
  elseif taskTypeId == TaskEnum.eTaskType.WeeklyChallengeTask then
    return TaskEnum.eTaskPeriodType.WeeklyChallengeTask
  end
end

function TaskController:CalTaskRewardsOverflow(stcTask)
  local itemTransDic = {}
  for i, v in ipairs(stcTask.rewardIds) do
    local itemCfg = ConfigData.item[v]
    local num = 0
    if itemCfg.overflow_type == eItemTransType.actMoneyX then
      num = PlayerDataCenter:GetItemOverflowNum(v, stcTask.rewardNums[i])
    end
    if num ~= 0 then
      itemTransDic[v] = num
    end
  end
  self.TaskOverflowAwardDic[stcTask.id] = itemTransDic
end

function TaskController:SendCommitQuestReward(taskData, showCommonReward, callbak, afterRewardFunc)
  local containAth = false
  for k, itemId in ipairs(taskData.stcData.rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self._afterRewardFunc = afterRewardFunc
  self.isDailyCompleteToRefresh = false
  self:CalTaskRewardsOverflow(taskData.stcData)
  self.network:SendCommitQuest(taskData, callbak)
  if showCommonReward then
    self._showCommonRewardTaskData = taskData
  else
    self._showCommonRewardTaskData = nil
  end
end

function TaskController:OnTaskCommit(stcTask, addInfo)
  local afterRewardFunc = self._afterRewardFunc
  self._afterRewardFunc = nil
  local taskWindow = UIManager:GetWindow(UIWindowTypeID.Task)
  local isSector = self.allTaskData:IsSectorType(stcTask.type)
  if isSector == true then
    return
  end
  local isWeeklyChallenge = self.allTaskData:IsWeeklyChallengeType(stcTask.type)
  if isWeeklyChallenge then
    self.network:SendQuestPeriodDetail()
    return
  end
  if self.showingPageType == stcTask.type and taskWindow ~= nil then
    taskWindow:OnSelectPage(self.showingPageType)
    if stcTask.type == TaskEnum.eTaskType.DailyTask or stcTask.type == TaskEnum.eTaskType.WeeklyTask then
      taskWindow:OnDailyWeeklyTaskComplete()
    end
  end
  if stcTask.type == TaskEnum.eTaskType.MainTask or stcTask.type == TaskEnum.eTaskType.SideTask or TaskEnum.IsActivityTask(stcTask.type) then
  elseif stcTask.type == TaskEnum.eTaskType.DailyTask or stcTask.type == TaskEnum.eTaskType.WeeklyTask then
    self.isDailyCompleteToRefresh = true
    self.network:SendQuestPeriodDetail()
    if taskWindow ~= nil then
      return
    end
  elseif self._showCommonRewardTaskData == nil or self._showCommonRewardTaskData.stcData ~= stcTask then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local taskStepCfg = ConfigData.taskStep[stcTask.id]
    if taskStepCfg ~= nil then
      for stepIndex, stepCfg in ipairs(taskStepCfg) do
        local rewardTips = string.format(ConfigData:GetTipContent(360), self:GetTaskTypeName(stcTask.type), LanguageUtil.GetLocaleText(stcTask.task_intro), stepCfg.finish_value, stepCfg.finish_value)
        local overflowInfo
        local rewardDic = {}
        for index, id in pairs(stcTask.rewardIds) do
          rewardDic[id] = stcTask.rewardNums[index]
        end
        if addInfo ~= nil then
          overflowInfo = addInfo.task_overflowInfo
          local randomPackage = addInfo.task_randomPackage or table.emptytable
          for parentItemId, data in pairs(randomPackage) do
            rewardDic[parentItemId] = (rewardDic[parentItemId] or 0) - data.itemNum
            if rewardDic[parentItemId] <= 0 then
              rewardDic[parentItemId] = nil
            end
            local resultDic = data.product
            for itemId, num in pairs(resultDic) do
              rewardDic[itemId] = (rewardDic[itemId] or 0) + num
            end
          end
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRItemCustomTransDic(overflowInfo):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRRewardTips(rewardTips):SetCRShowOverFunc(afterRewardFunc)
        CRData:SetCRItemTransDic(self.TaskOverflowAwardDic[stcTask.id])
        window:AddAndTryShowReward(CRData)
        return
      end
    end
  end)
end

function TaskController:OnTaskUpdate(taskData)
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return
  end
  local isSector = self.allTaskData:IsSectorType(taskData.stcData.type)
  if isSector == true then
    return
  end
  self.isDailyCompleteToRefresh = false
  if self.showingPageType == taskData.stcData.type then
    win:OnSelectPage(self.showingPageType)
  end
end

function TaskController:OnTaskDelete(id)
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  local stcTask = ConfigData.task[id]
  if win == nil or stcTask == nil then
    return
  end
  local isSector = self.allTaskData:IsSectorType(stcTask.type)
  if isSector == true then
    return
  end
  self.isDailyCompleteToRefresh = false
  if self.showingPageType == stcTask.type then
    win:OnSelectPage(self.showingPageType)
  end
end

function TaskController:SendCommitTaskPeriod(index, showingActiveType)
  if showingActiveType == nil then
    return
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self.network:SendQuestPeriodRewardPicked(index, showingActiveType, function()
    self.network:SendQuestPeriodDetail()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local activeCfg = ConfigData.active[showingActiveType][index]
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(activeCfg.rewardIds, activeCfg.rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function TaskController:SendCommitTaskPeriodArray(indexDic, showingActiveType)
  if showingActiveType == nil then
    return
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  
  local function next()
    table.remove(self.__waitPickPreodic, 1)
    if #self.__waitPickPreodic > 0 then
      self.__waitPickPreodic[1]()
    end
  end
  
  local function netFunc()
    self.network:CS_QUESTPERIOD_RewardOnePicked(indexDic, showingActiveType, function(dataList)
      self.network:SendQuestPeriodDetail()
      if dataList.Count <= 0 then
        next()
        return
      end
      local reward = dataList[0]
      if reward ~= nil and 0 < table.count(reward) then
        local rewardIds = {}
        local rewardCounts = {}
        for id, count in pairs(reward) do
          table.insert(rewardIds, id)
          table.insert(rewardCounts, count)
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardCounts)
          window:AddAndTryShowReward(CRData)
        end)
      end
      next()
    end)
  end
  
  if self.__waitPickPreodic == nil then
    self.__waitPickPreodic = {}
  end
  table.insert(self.__waitPickPreodic, netFunc)
  if #self.__waitPickPreodic == 1 then
    netFunc()
  end
end

function TaskController:IsDailyCompleteToRefresh()
  return self.isDailyCompleteToRefresh and not self.isFrist
end

function TaskController:IsCompleteAllDailyTaskOrFinshPeroid()
  local trueComplete = table.count(self.allTaskData.normalTaskDatas[TaskEnum.eTaskType.DailyTask]) <= 0
  if trueComplete then
    return true
  end
  local PeriodComplete = true
  local periodDataList = self:GetDatas4Peroid(TaskEnum.eTaskPeriodType.DailyTask)
  for _, data in pairs(periodDataList) do
    if data.stateType ~= TaskEnum.eTaskState.Picked then
      PeriodComplete = false
      break
    end
  end
  if PeriodComplete then
    return true
  end
  local taskDatas = self.allTaskData.normalTaskDatas[TaskEnum.eTaskType.DailyTask]
  if taskDatas == nil then
    return true
  end
  for _, taskData in pairs(taskDatas) do
    local unlock = true
    if taskData.stcData.open_condition ~= nil and 0 < taskData.stcData.open_condition then
      unlock = FunctionUnlockMgr:ValidateUnlock(taskData.stcData.open_condition)
    end
    if unlock and not taskData.isPicked then
      return false
    end
  end
  return true
end

function TaskController:SendOneKeyPick(ids, backAction, afterRewardFunc)
  self.network:CS_QUEST_OneKeyPick(ids, backAction, afterRewardFunc)
end

function TaskController:GetAllRewards(taskIds)
  local ids = {}
  local perodicDic = {}
  for idx, taskId in ipairs(taskIds) do
    ids = self:GetTaskIds(taskId, ids, perodicDic)
  end
  return ids, perodicDic
end

function TaskController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
end

return TaskController
