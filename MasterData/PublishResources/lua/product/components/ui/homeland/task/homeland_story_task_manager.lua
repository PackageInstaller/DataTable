_class("HomelandStoryTaskManager", Object)
HomelandStoryTaskManager = HomelandStoryTaskManager

function HomelandStoryTaskManager:Constructor()
  self._storyTasks = {}
  self._runingStoryTask = nil
  self._runingTaskGroup = nil
  self._runingTask = nil
  self._mode = HomelandMode.Normal
end

function HomelandStoryTaskManager:Init(homelandClient, taskManager)
  self._homelandClient = homelandClient
  self._taskManager = taskManager
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._homelandTaskManagerHelper = self._taskManager:GetHomelandTaskManagerHelper()
  self._homelandTraceManager = self._homelandClient:GetHomelandTraceManager()
  self:ReceiveStoryTaskInfos()
  self:CreateServerData()
  self:CreateStoryTasks()
  self._taskCore = TaskManager:GetInstance():StartTask(self.ReceiveLastStoryTaskRewards, self)
  self._onHomeLandStoryTaskUpdate = GameHelper:GetInstance():CreateCallback(self.HandleStoryTaskUpdate, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HandleStoryTaskUpdate, self._onHomeLandStoryTaskUpdate)
  self._storyTaskLocalData = UIHomelandStoryTaskLocalData:New()
  self:CheckRun()
  self._lastStoryTaskLen = 0
end

function HomelandStoryTaskManager:Dispose()
  if self._onHomeLandStoryTaskUpdate then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HandleStoryTaskUpdate, self._onHomeLandStoryTaskUpdate)
    self._onHomeLandStoryTaskUpdate = nil
  end
  if self._taskCore then
    GameGlobal.TaskManager():KillTask(self._taskCore)
    self._taskCore = nil
  end
  if #self._storyTasks > 0 then
    for i = 1, #self._storyTasks do
      self._storyTasks[i]:Dispose()
    end
  end
  self._storyTasks = nil
  self._runingStoryTask = nil
  self._runingTaskGroup = nil
  self._runingTask = nil
end

function HomelandStoryTaskManager:CheckRun()
  self._storyTaskInfos = self._homelandModule.m_homeland_info.story_task_info
  if self._storyTaskInfos and self._storyTaskInfos.cfg_id > 0 then
    self:StartRun(self._storyTaskInfos.cfg_id)
  end
end

function HomelandStoryTaskManager:StartRun(taskId)
  self:StartStoryTaskManager(taskId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryTaskChangeState, true)
end

function HomelandStoryTaskManager:StopRun(taskId)
  if taskId then
    for i = 1, #self._storyTasks do
      if self._storyTasks[i]:GetStoryTaskID() == taskId then
        self._storyTasks[i]:EndRun()
        self._runingStoryTask = nil
        self._runingTask = nil
        break
      end
    end
  elseif self._runingStoryTask then
    self._runingStoryTask:EndRun()
    if self._runingTask then
      self._homelandTraceManager:DisposeTrace(self._runingTask:GetGuidId(), TraceEnum.Task)
    end
    self._runingStoryTask = nil
    self._runingTask = nil
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.StoryTaskChangeState, false)
  Log.fatal("HomelandStoryTaskManager:StopRun")
end

function HomelandStoryTaskManager:Update(deltaTimeMS)
  if self._runingStoryTask then
    self._runingStoryTask:Update(deltaTimeMS)
  end
end

function HomelandStoryTaskManager:ReceiveStoryTaskInfos()
  self._storyTaskServerData = self._homelandModule:GetHomelandGroupTaskInfo(QuestType.QT_Homeland_Story_Task)
  self:PrintStoryTaskInfos(self._storyTaskServerData)
end

function HomelandStoryTaskManager:GetStoryTaskCount()
  local len = 0
  for key, value in pairs(self._storyTaskServerData) do
    len = len + 1
  end
  return len
end

function HomelandStoryTaskManager:CreateServerData()
  self._serverData = {}
  local allCfg = self._homelandTaskManagerHelper:GetStoryTaskAllCfg()
  for key, value in pairs(allCfg) do
    local tb = value.StoryTaskGroupTb
    self._serverData[value.ID] = {}
    local res = self:GetTaskGroupData(tb)
    self._serverData[value.ID] = res
  end
  Log.fatal("CreateServerData")
end

function HomelandStoryTaskManager:GetTaskGroupData(tb)
  local data = {}
  for key, value in ipairs(tb) do
    for i, v in pairs(self._storyTaskServerData) do
      if value == i then
        data[value] = v
      end
    end
  end
  return data
end

function HomelandStoryTaskManager:CreateStoryTasks()
  if #self._storyTasks > 0 then
    for i = 1, #self._storyTasks do
      self._storyTasks[i]:Dispose()
    end
    self._storyTasks = {}
  end
  local allCfg = self._homelandTaskManagerHelper:GetStoryTaskAllCfg()
  for storytaskId, cfg in pairs(allCfg) do
    if self._serverData[storytaskId] then
      local storyTask = HomeStoryTask:New(storytaskId, cfg, self, self._serverData[storytaskId])
      table.insert(self._storyTasks, storyTask)
    end
  end
  Log.fatal("CreateStoryTasks")
end

function HomelandStoryTaskManager:StartStoryTaskManager(taskId)
  if taskId then
    if self._runingStoryTask then
      self._runingStoryTask:EndRun()
    end
    if #self._storyTasks > 0 then
      local runningTask
      for i = 1, #self._storyTasks do
        if self._storyTasks[i]:GetStoryTaskID() == taskId and not self._storyTasks[i]:CheckFinished() then
          runningTask = self._storyTasks[i]
          break
        end
      end
      self:SetRunningStoryTask(runningTask)
    end
  elseif #self._storyTasks > 0 then
    local runningTask
    for i = 1, #self._storyTasks do
      if not self._storyTasks[i]:CheckFinished() then
        runningTask = self._storyTasks[i]
        break
      end
    end
    self:SetRunningStoryTask(runningTask)
  end
end

function HomelandStoryTaskManager:SwitchStoryTask(taskId)
  if #self._storyTasks > 0 then
    local runningTask
    for i = 1, #self._storyTasks do
      if self._storyTasks[i]:GetStoryTaskID() == taskId then
        runningTask = self._storyTasks[i]
        break
      end
    end
    self:SetRunningStoryTask(runningTask)
  end
end

function HomelandStoryTaskManager:SetRunningStoryTask(storyTask)
  if #self._storyTasks == 0 then
    Log.fatal("当前无剧情任务！！！！！！！！！！！！！")
    return
  end
  if not storyTask then
    Log.fatal("当前无任务！！！！！！！！！！！！！:")
    return
  end
  if self._runingStoryTask ~= nil then
    self._runingStoryTask:EndRun()
  end
  self._runingStoryTask = storyTask
  self._runingStoryTask:StartRun()
  self._runingTaskGroup = self._runingStoryTask:GetRuningTaskGroup()
  if self._runingTaskGroup then
    self._runingTask = self._runingTaskGroup:GetRuningTask()
  end
  Log.fatal("")
end

function HomelandStoryTaskManager:GetNextSrotyTask()
  self:ReceiveStoryTaskInfos()
  self:CreateServerData()
  self:CreateStoryTasks()
end

function HomelandStoryTaskManager:RefreshTaskInfo()
  if self:GetClientMode() ~= HomelandMode.Normal then
    return
  end
  self:ReceiveStoryTaskInfos()
  self:CreateServerData()
  if not self._runingStoryTask then
    self:CreateStoryTasks()
    self:CheckRun()
  end
  for storyTaskId, groups in pairs(self._serverData) do
    if self._runingStoryTask and self._runingStoryTask:GetStoryTaskID() == storyTaskId then
      self._runingStoryTask:SetServerData(groups)
    end
  end
  self:CheckGroupFinishedCount()
end

function HomelandStoryTaskManager:GetRuningStoryTask()
  return self._runingStoryTask
end

function HomelandStoryTaskManager:GetRuningTaskroup()
  return self._runingTaskGroup
end

function HomelandStoryTaskManager:GetRuningTaskItem()
  return self._runingTask
end

function HomelandStoryTaskManager:GetHomelandTaskManagerHelper()
  return self._homelandTaskManagerHelper
end

function HomelandStoryTaskManager:GetHomelandClient()
  return self._homelandClient
end

function HomelandStoryTaskManager:GetHomelandModule()
  return self._homelandModule
end

function HomelandStoryTaskManager:GetTaskManager()
  return self._taskManager
end

function HomelandStoryTaskManager:OnStoryTaskFinish(storyTaskId)
  if not self._runingStoryTask then
    return
  end
  self._lastTaskStoryTaskId = storyTaskId
  if self._runingStoryTask and storyTaskId == self._runingStoryTask:GetStoryTaskID() then
    self._runingStoryTask:EndRun()
    self._runingStoryTask = nil
  end
end

function HomelandStoryTaskManager:OnTaskGroupFinish(groupId)
  if not self._runingStoryTask then
    return
  end
  if not self._runingTaskGroup or groupId ~= self._runingTaskGroup:GetGroupID() then
    return
  end
  if self._runingStoryTask:CheckFinished() then
    self._runingStoryTask:EndRun()
    self._runingStoryTask = nil
    self._runingTaskGroup = nil
    self._runingTask = nil
  else
    self._runingStoryTask:MoveNextTaskGroup()
    self._runingTaskGroup = self._runingStoryTask:GetRuningTaskGroup()
    if not self._runingTaskGroup then
      self._runingStoryTask:EndRun()
      self._runingStoryTask = nil
      return
    end
    self._runingTaskGroup:StartRun()
    self._runingTask = self._runingTaskGroup:GetRuningTask()
  end
end

function HomelandStoryTaskManager:OnTaskGroupFinishAfterReward(groupId)
  for k, storyV in pairs(self._storyTasks) do
    local storyTaskCfg = storyV:GetStoryTaskCfg()
    local theLastGroupId = false
    if storyTaskCfg.StoryTaskGroupTb ~= nil then
      local groupTabCount = #storyTaskCfg.StoryTaskGroupTb
      theLastGroupId = storyTaskCfg.StoryTaskGroupTb[groupTabCount] == groupId
    end
    if theLastGroupId then
      local taskName = StringTable.Get(storyTaskCfg.GroupsListTitle)
      ToastManager.ShowToast(StringTable.Get("str_homeland_storytask_mission_allover", taskName))
    end
  end
end

function HomelandStoryTaskManager:OnTaskItemFinish(groupId, taskId)
  if not self._runingTaskGroup then
    return
  end
  if self._runingTaskGroup:GetGroupID() ~= groupId then
    return
  end
  if self._runingTask:GetTaskID() ~= taskId then
    return
  end
  local allFinish = self._runingTaskGroup:CheckFinishAll()
  if allFinish then
    self._runingTaskGroup:OnTaskGroupFinished()
  else
    self:NextTaskItem()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomelandTaskItemChanged)
end

function HomelandStoryTaskManager:NextTaskItem()
  self._runingTask = self._runingTaskGroup:MoveNextTask()
  if self._runingTask then
    self._runingTask:StartRun()
  end
end

function HomelandStoryTaskManager:OnStoryTaskStart(storyTaskID)
end

function HomelandStoryTaskManager:OnStoryTaskEnd(storyTaskID)
end

function HomelandStoryTaskManager:OnModeChanged(mode)
  self._mode = mode
  if self._mode == HomelandMode.Normal then
    if self._runingTask and #self._runingTask:GetTaskNpcs() == 0 then
      self._runingTask:CreateTaskHangPointNpc(false)
      self._runingTask:DisposeTrace()
      self._runingTask:OpenTrace()
    end
    self:RefreshTaskInfo()
  end
  self:SetNpcsVisible(self._mode == HomelandMode.Normal)
end

function HomelandStoryTaskManager:GetClientMode()
  return self._mode
end

function HomelandStoryTaskManager:SetNpcsVisible(visible)
  if self._runingTask then
    self._runingTask:SetNpcsVisible(visible)
  end
end

function HomelandStoryTaskManager:OnHomeLandSpecialCheck(pstid)
  if self._runingTask then
    self._runingTask:OnHomeLandSpecialCheck(pstid)
  end
end

function HomelandStoryTaskManager:CheckStoryTaskGroupFinished(taskId, groupId)
  for key, value in pairs(self._storyTasks) do
    if value:GetStoryTaskID() == taskId then
      for i, j in pairs(value:GetTaskGroups()) do
        if j:GetGroupID() == groupId then
          return j:CheckFinished()
        end
      end
    end
  end
  return false
end

function HomelandStoryTaskManager:GetRunningTask(taskId, groupId)
  for key, value in pairs(self._storyTasks) do
    if value:GetStoryTaskID() == taskId then
      for i, j in pairs(value:GetTaskGroups()) do
        if j:GetGroupID() == groupId and not j:CheckFinished() then
          return j:GetRunTaskItem()
        end
      end
    end
  end
  return
end

function HomelandStoryTaskManager:CheckStoryTaskFinished(taskId)
  for key, value in pairs(self._storyTasks) do
    if key == taskId then
      return value:CheckFinished()
    end
  end
  return false
end

function HomelandStoryTaskManager:GetStoryGroupInfo(groupId)
end

function HomelandStoryTaskManager:GetFinishedStoryTaskCount()
  local count = 0
  for key, value in pairs(self._storyTasks) do
    if value:CheckFinished() then
      count = count + 1
    end
  end
  return count
end

function HomelandStoryTaskManager:ReceiveLastStoryTaskRewards(TT)
  for i = 1, #self._storyTasks do
    local groupitems = self._storyTasks[i]:GetTaskGroups()
    if groupitems then
      for v = 1, #groupitems do
        local items = groupitems[v]:GetTaskItems()
        if items then
          for k = 1, #items do
            if items[k]:GetTaskServerInfo() and items[k]:GetTaskServerInfo():Status() == QuestStatus.QUEST_Completed and items[k]:GetTaskConditionCfg().FinishType == FinishConditionEnum.Other then
              local res, replyEvent = self:GetHomelandModule():HandleHomelandTaskQuestTakeReq(TT, items[k]:GetTaskID())
              if res:GetSucc() then
                Log.info("[HomelandStoryTaskManager]任务结束 领奖成功 任务id:" .. items[k]:GetTaskID())
                local assetList = replyEvent.rewards
                if 0 < #assetList then
                  Log.fatal("[HomelandStoryTaskManager] ReceiveLastRewards succ, res:" .. res:GetResult())
                end
              else
                Log.fatal("[HomelandStoryTaskManager] ReceiveLastRewards fail, res:" .. res:GetResult())
              end
            end
          end
        end
      end
    end
    local res, replyEvent
    for i = 1, #groupitems do
      if groupitems[i]:CheckFinished() and not self:GetHomelandModule():IsRecvGroupTaskReward(groupitems[i]:GetGroupID()) then
        res, replyEvent = self:GetHomelandModule():HandleHomelandTaskGroupTakeReq(TT, groupitems[i]:GetGroupID())
        if res:GetSucc() then
          if groupitems[i]:GetGroupID() then
            Log.info("[HomelandTask]任务组结束 领奖成功 任务id:" .. groupitems[i]:GetGroupID())
          else
          end
          local assetList = replyEvent.rewards
          if 0 < #assetList then
            Log.fatal("[HomelandStoryTaskManager] ReceiveLastRewards taskGroup succ, res:" .. res:GetResult())
          end
        end
      end
    end
  end
end

function HomelandStoryTaskManager:GetStoryTaskUpdate()
  return self._homelandModule.m_homeland_info.story_task_info.id_list
end

function HomelandStoryTaskManager:HandleStoryTaskUpdate()
  local data = self._homelandModule.m_homeland_info.story_task_info.id_list
  if not data then
    return
  end
  for i = 1, #data do
    if not self._storyTaskLocalData.HasPrefsStoryTask(data[i]) then
      self._isNew = true
    end
  end
  self:CheckGroupFinishedCount()
  self:CheckRun()
end

function HomelandStoryTaskManager:CheckGroupFinishedCount()
  local count = 0
  if self._storyTasks then
    for key, value in pairs(self._storyTasks) do
      count = count + value:GetFinishedCount()
    end
  end
  local lastcount = self._storyTaskLocalData.GetPrefsStoryTaskGroup()
  if lastcount ~= count then
    self._isNew = true
    self._storyTaskLocalData.SetPrefsStoryTaskGroup(count)
    self._storyTaskLocalData.SetPrefsStoryTaskGroupNew(1)
  end
end

function HomelandStoryTaskManager:PrintStoryTaskInfos(storyTaskServerData)
  Log.debug("HomelandStoryTaskManager:PrintStoryTaskInfos() Start -----")
  for i, v in pairs(storyTaskServerData) do
    for ii, vv in pairs(v) do
      Log.debug("HomelandStoryTaskManager:PrintStoryTaskInfos() quest_id = ", vv._questInfo.quest_id)
    end
  end
  Log.debug("HomelandStoryTaskManager:PrintStoryTaskInfos() End -----")
end
