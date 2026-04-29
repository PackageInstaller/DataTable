_class("HomelandTaskManager", Object)
HomelandTaskManager = HomelandTaskManager

function HomelandTaskManager:Constructor()
  self._taskGroups = {}
  self._runingTaskGroup = nil
  self._runingTask = nil
  self._mode = HomelandMode.Normal
  self._occupiedPetList = {}
end

function HomelandTaskManager:Init(homelandClient)
  self._homelandClient = homelandClient
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._homelandTaskManagerHelper = HomelandTaskManagerHelper:New(self)
  self._homelandTraceManager = self._homelandClient:GetHomelandTraceManager()
  self._homelandTaskReceiveCallback = GameHelper:GetInstance():CreateCallback(self.RefreshTaskInfo, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.QuestUpdate, self._homelandTaskReceiveCallback)
  self._onTaskSubmitSuccess = GameHelper:GetInstance():CreateCallback(self.OnTaskItemFinish, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnHomeLandTaskSubmit, self._onTaskSubmitSuccess)
  self._onHomeLandSpecialCheck = GameHelper:GetInstance():CreateCallback(self.OnHomeLandSpecialCheck, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnHomeLandSpecialCheck, self._onHomeLandSpecialCheck)
  self._onHomeLandTaskGroupSubmit = GameHelper:GetInstance():CreateCallback(self.OnTaskGroupFinish, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnHomeLandTaskGroupSubmit, self._onHomeLandTaskGroupSubmit)
  self._onHomeLandTaskGroupSubmitAfterReward = GameHelper:GetInstance():CreateCallback(self.OnTaskGroupFinishAfterReward, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnHomeLandTaskGroupSubmitAfterReward, self._onHomeLandTaskGroupSubmitAfterReward)
  self._homelandStoryTaskManager = HomelandStoryTaskManager:New()
  self._homelandStoryTaskManager:Init(homelandClient, self)
  self:ReceiveTaskInfos()
  self:CreateTaskGroups()
  self:StartTaskManager()
  self._taskCore = TaskManager:GetInstance():StartTask(self.ReceiveLastRewards, self)
end

function HomelandTaskManager:Dispose()
  if self._homelandTaskReceiveCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.QuestUpdate, self._homelandTaskReceiveCallback)
    self._homelandTaskReceiveCallback = nil
  end
  if self._onTaskSubmitSuccess then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnHomeLandTaskSubmit, self._onTaskSubmitSuccess)
    self._onTaskSubmitSuccess = nil
  end
  if self._onHomeLandSpecialCheck then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnHomeLandSpecialCheck, self._onHomeLandSpecialCheck)
    self._onHomeLandSpecialCheck = nil
  end
  if self._onHomeLandTaskGroupSubmit then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnHomeLandTaskGroupSubmit, self._onHomeLandTaskGroupSubmit)
    self._onHomeLandTaskGroupSubmit = nil
  end
  if self._onHomeLandTaskGroupSubmitAfterReward then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnHomeLandTaskGroupSubmitAfterReward, self._onHomeLandTaskGroupSubmitAfterReward)
    self._onHomeLandTaskGroupSubmitAfterReward = nil
  end
  if self._taskCore then
    GameGlobal.TaskManager():KillTask(self._taskCore)
    self._taskCore = nil
  end
  if #self._taskGroups > 0 then
    for i = 1, #self._taskGroups do
      self._taskGroups[i]:Dispose()
    end
  end
  self._homelandStoryTaskManager:Dispose()
  self._taskGroups = nil
  self._runingTask = nil
end

function HomelandTaskManager:Update(deltaTimeMS)
  if self._runingTaskGroup then
    self._runingTaskGroup:Update(deltaTimeMS)
  end
  if self._homelandStoryTaskManager then
    self._homelandStoryTaskManager:Update(deltaTimeMS)
  end
end

function HomelandTaskManager:ReceiveTaskInfos()
  self._taskGroupServerData = self._homelandModule:GetHomelandGroupTaskInfo(QuestType.QT_Homeland_Group_Rookie)
end

function HomelandTaskManager:CreateTaskGroups()
  if #self._taskGroups > 0 then
    for i = 1, #self._taskGroups do
      self._taskGroups[i]:Dispose()
    end
    self._taskGroups = {}
  end
  for groupId, data in pairs(self._taskGroupServerData) do
    local cfg = self._homelandTaskManagerHelper:GetTaskGroupCfg(groupId)
    local group = HomeTaskGroup:New(groupId, cfg, self, data)
    table.insert(self._taskGroups, group)
  end
end

function HomelandTaskManager:StartTaskManager()
  if #self._taskGroups > 0 then
    local priGroup
    for i = 1, #self._taskGroups do
      if self._taskGroups[i] and not self._taskGroups[i]:CheckFinished() then
        priGroup = self._taskGroups[i]
        break
      end
    end
    self:SetRuningTaskGroup(priGroup)
  end
end

function HomelandTaskManager:GetNextGroup()
  self:ReceiveTaskInfos()
  self:CreateTaskGroups()
  self:StartTaskManager()
end

function HomelandTaskManager:RefreshTaskInfo()
  self._homelandStoryTaskManager:RefreshTaskInfo()
  if self:GetClientMode() ~= HomelandMode.Normal then
    return
  end
  self:ReceiveTaskInfos()
  for groupId, quests in pairs(self._taskGroupServerData) do
    if self._runingTaskGroup and self._runingTaskGroup:GetGroupID() == groupId then
      self._runingTaskGroup:SetServerData(quests)
    end
  end
end

function HomelandTaskManager:GetRuningTaskGroup()
  return self._runingTaskGroup
end

function HomelandTaskManager:GetRuningTask()
  return self._runingTask
end

function HomelandTaskManager:GetHomelandTaskManagerHelper()
  return self._homelandTaskManagerHelper
end

function HomelandTaskManager:GetHomelandClient()
  return self._homelandClient
end

function HomelandTaskManager:GetHomelandModule()
  return self._homelandModule
end

function HomelandTaskManager:SetRuningTaskGroup(taskGroup)
  if #self._taskGroups == 0 then
    Log.fatal("当前无任务！！！！！！！！！！！！！")
    return
  end
  if not taskGroup then
    Log.fatal("当前无任务！！！！！！！！！！！！！:")
    return
  end
  self._runingTaskGroup = taskGroup
  self._runingTaskGroup:StartRun()
  self._runingTask = taskGroup:GetRuningTask()
end

function HomelandTaskManager:OnTaskGroupFinish(groupId)
  self._homelandStoryTaskManager:OnTaskGroupFinish(groupId)
  if not self._runingTaskGroup then
    return
  end
  if self._runingTaskGroup:GetGroupID() ~= groupId then
    return
  end
  self._lastTaskGroupId = groupId
  if self._runingTask then
    self._runingTask:Dispose()
    self._runingTask = nil
  end
  self:GetNextGroup()
end

function HomelandTaskManager:OnTaskGroupFinishAfterReward(groupId)
  self._homelandStoryTaskManager:OnTaskGroupFinishAfterReward(groupId)
end

function HomelandTaskManager:OnTaskItemFinish(groupId, taskId)
  self._homelandStoryTaskManager:OnTaskItemFinish(groupId, taskId)
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

function HomelandTaskManager:NextTaskItem()
  self._runingTask = self._runingTaskGroup:MoveNextTask()
  if self._runingTask then
    self._runingTask:StartRun()
  end
end

function HomelandTaskManager:OnTaskGroupStart(groupId)
  Log.info("[HomelandTask]当前 执行 任务组---------------:" .. groupId)
end

function HomelandTaskManager:OnTaskGroupEnd(groupId)
  Log.info("[HomelandTask]当前 执行 任务组  停止---------------:" .. groupId)
end

function HomelandTaskManager:OnTaskItemStart(taskId)
  Log.info("[HomelandTask]当前 执行 任务---------------:" .. taskId)
end

function HomelandTaskManager:OnModeChanged(mode)
  self._mode = mode
  if self._mode == HomelandMode.Normal then
    self:RefreshTaskInfo()
  end
  self:SetNpcsVisible(self._mode == HomelandMode.Normal)
  self._homelandStoryTaskManager:OnModeChanged(mode)
end

function HomelandTaskManager:GetClientMode()
  return self._mode
end

function HomelandTaskManager:SetNpcsVisible(visible)
  if self._runingTask then
    self._runingTask:SetNpcsVisible(visible)
  end
end

function HomelandTaskManager:AddNpcOccupyingPet(petTplID)
  self._occupiedPetList[petTplID] = true
  self._homelandClient:PetManager():RefreshPetVisible(petTplID)
end

function HomelandTaskManager:RemoveNpcOccupyingPet(petTplID)
  self._occupiedPetList[petTplID] = nil
  self._homelandClient:PetManager():RefreshPetVisible(petTplID)
end

function HomelandTaskManager:IsPetOccupiedAsNpc(petTplID)
  if self._occupiedPetList and table.count(self._occupiedPetList) > 0 then
    for tmpid, value in pairs(self._occupiedPetList) do
      local pet_a_sp = false
      local pet_b_sp = false
      local tmpid_a = tmpid
      local cfg_pet_a = Cfg.cfg_pet[tmpid_a]
      if cfg_pet_a.BinderPetID then
        pet_a_sp = true
        tmpid_a = cfg_pet_a.BinderPetID
      end
      local tmpid_b = petTplID
      local cfg_pet_b = Cfg.cfg_pet[tmpid_b]
      if cfg_pet_b.BinderPetID then
        pet_b_sp = true
        tmpid_b = cfg_pet_b.BinderPetID
      end
      local isThisPet = false
      if pet_a_sp and pet_b_sp then
        if tmpid_a == tmpid_b then
          isThisPet = true
          Log.debug("###[sp] 两个都是sp，并且id相同,tmpid_a ", tmpid_a)
        end
      elseif tmpid == petTplID then
        isThisPet = true
        Log.debug("###[sp] 两个都不是sp，但是id相同,tmpid ", tmpid)
      end
      if isThisPet then
        return true
      end
    end
  end
  return false
end

function HomelandTaskManager:OnHomeLandSpecialCheck(pstid)
  self._homelandStoryTaskManager:OnHomeLandSpecialCheck(pstid)
  if self._runingTask then
    self._runingTask:OnHomeLandSpecialCheck(pstid)
  end
end

function HomelandTaskManager:ReceiveLastRewards(TT)
  for i = 1, #self._taskGroups do
    local items = self._taskGroups[i]:GetTaskItems()
    if items then
      for k = 1, #items do
        if items[k]:GetTaskServerInfo() and items[k]:GetTaskServerInfo():Status() == QuestStatus.QUEST_Completed and items[k]:GetTaskConditionCfg().FinishType == FinishConditionEnum.Other then
          local res, replyEvent = self:GetHomelandModule():HandleHomelandTaskQuestTakeReq(TT, items[k]:GetTaskID())
          if res:GetSucc() then
            Log.info("[HomelandTaskManager]任务结束 领奖成功 任务id:" .. items[k]:GetTaskID())
            local assetList = replyEvent.rewards
            if 0 < #assetList then
              Log.fatal("[HomelandTaskManager] ReceiveLastRewards succ, res:" .. res:GetResult())
            end
          else
            Log.fatal("[HomelandTaskManager] ReceiveLastRewards fail, res:" .. res:GetResult())
          end
        end
      end
    end
    local res, replyEvent
    if self._taskGroups[i]:CheckFinished() and not self:GetHomelandModule():IsRecvGroupTaskReward(self._taskGroups[i]:GetGroupID()) then
      res, replyEvent = self:GetHomelandModule():HandleHomelandTaskGroupTakeReq(TT, self._taskGroups[i]:GetGroupID())
      if res:GetSucc() then
        Log.info("[HomelandTask]任务组结束 领奖成功 任务id:" .. self._taskGroups[i]:GetGroupID())
        local assetList = replyEvent.rewards
        if 0 < #assetList then
          Log.fatal("[HomelandTaskManager] ReceiveLastRewards taskGroup succ, res:" .. res:GetResult())
        end
      end
    end
  end
end

function HomelandTaskManager:GetHomelandStoryTaskManager()
  return self._homelandStoryTaskManager
end
