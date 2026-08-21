_class("HomeTaskItem", Object)
HomeTaskItem = HomeTaskItem
local TaskStateEnum = {
  UnAccept = 0,
  Accept = 1,
  Running = 2,
  Finished = 3,
  Submit = 4,
  Over = 5
}
local TaskStoryType = {Special = 1, Normal = 2}
local TaskCutinType = {CutinAfterEndSpecialStory = 1, CutinAddAfterTaskEnd = 2}

function HomeTaskItem:Constructor(taskID, taskCfg, taskGroup, serverData, startCallBack, endCallBack)
  self._taskID = taskID
  self._taskCfg = taskCfg
  self._taskGroup = taskGroup
  self._taskmanager = taskGroup:GetTaskManager()
  self._taskManagerHelper = self._taskmanager:GetHomelandTaskManagerHelper()
  self._taskFinished = false
  self._homelandClient = self._taskmanager:GetHomelandClient()
  self._petHomelandManager = self._homelandClient:PetManager()
  self._indexInGroup = 0
  self._totleTaskCount = 0
  self._buildManager = self._homelandClient:BuildManager()
  self._taskServerInfo = serverData
  self._startRunCallBack = startCallBack
  self._endRunCallBack = endCallBack
  self._taskState = TaskStateEnum.Accept
  self.npcList = {}
  self:GetModles()
  self._inInit = true
  self._specialCheck = false
  self._holdBuilding = nil
  self._holdBuildingId = nil
end

function HomeTaskItem:GetModles()
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._tiemModule = GameGlobal.GetModule(SvrTimeModule)
  self._petManager = self._taskmanager:GetHomelandClient():PetManager()
end

function HomeTaskItem:Dispose()
  if self._saveBuildingCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSave, self._saveBuildingCallback)
  end
  self:DestroyNpcs()
  self._taskID = nil
  self._taskCfg = nil
  self._taskGroup = nil
  self._taskmanager = nil
  if self.taskTarget then
    self.taskTarget:Destroy()
  end
  self._holdBuilding = nil
  self._holdBuildingId = nil
end

function HomeTaskItem:Update(deltaTimeMS)
  if self._taskState == TaskStateEnum.Running then
    self.hadFinished = self:CheckTaskFinish()
    if self.hadFinished then
      self._taskState = TaskStateEnum.Finished
    end
  elseif self._taskState == TaskStateEnum.Finished and self._finishType ~= FinishConditionEnum.Dialog then
    self:SubmitTask()
  end
end

function HomeTaskItem:StartRun()
  self._saveBuildingCallback = GameHelper:GetInstance():CreateCallback(self.OnSaveBuilding, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandBuildOnSave, self._saveBuildingCallback)
  if self._taskmanager then
    self._taskmanager:OnTaskItemStart(self._taskID)
  end
  if not self._taskCfg then
    Log.fatal("HomeTaskItem:StartRun config is nil ")
    return
  end
  if self:CheckTaskStoryPre() then
    local viewState = self._taskmanager:GetHomelandModule():CanViewGroupTaskStory(HomeLandGroupTaskStoryMask.HomeLandGroupTaskStoryMask_Before, self._taskID)
    if viewState == EStoryViewStoryStatus.NotView then
      self:PlayStoryPre()
    else
      self:_StartInit()
    end
  else
    self:_StartInit()
  end
end

function HomeTaskItem:EndRun()
  if self._saveBuildingCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSave, self._saveBuildingCallback)
  end
  self:DestroyNpcs()
  if self.taskTarget then
    self.taskTarget:Destroy()
  end
end

function HomeTaskItem:StartRunCoro(TT)
  GameGlobal.UIStateManager():Lock("HomeTaskItem:StartRunCoro")
  local res = self._taskmanager:GetHomelandModule():HandleHomelandTaskViewStoryReq(TT, self._taskID, HomeLandGroupTaskStoryMask.HomeLandGroupTaskStoryMask_Before)
  if res:GetSucc() then
    Log.info("[HomelandTask]开始观看任务前置剧情完毕 任务id:" .. self._taskID .. " 剧情id:" .. self._taskCfg.StoryPreId[2])
  else
    Log.fatal("[HomeTaskItem] HandleHomelandTaskViewStoryReq fail, res:" .. res:GetResult())
    return
  end
  self:_StartInit()
  GameGlobal.UIStateManager():UnLock("HomeTaskItem:StartRunCoro")
end

function HomeTaskItem:_StartInit()
  Log.info("[HomelandTask]初始化任务运行时数据 任务id:" .. self._taskID)
  self._taskState = TaskStateEnum.Running
  self:CreateTaskItemCondition(self:GetFinishCondition())
  self:CreateTaskNpc()
end

function HomeTaskItem:CheckTaskStoryPre()
  return self._taskCfg.StoryPreId ~= nil
end

function HomeTaskItem:CheckTaskStoryEnd()
  return self._taskCfg.StoryEndId ~= nil
end

function HomeTaskItem:PlayStoryPre()
  Log.info("[HomelandTask]开始观看任务前置剧情 任务id:" .. self._taskID .. " 剧情id:" .. self._taskCfg.StoryPreId[2])
  self:_PlayStory(self._taskCfg.StoryPreId, function()
    GameGlobal.TaskManager():StartTask(self.StartRunCoro, self)
  end)
end

function HomeTaskItem:PlayStoryEnd(npc)
  Log.info("[HomelandTask]查看任务后置剧情 任务id:" .. self._taskID .. "剧情id:" .. self._taskCfg.StoryEndId[2])
  self:_PlayStory(self._taskCfg.StoryEndId, function()
    self:FinishTask()
  end, npc)
end

function HomeTaskItem:GetFinishCondition()
  return self._taskCfg.FinishCondition
end

function HomeTaskItem:GetTaskID()
  return self._taskID
end

function HomeTaskItem:GetGuidId()
  return self._taskCfg.GuideId
end

function HomeTaskItem:GetTaskInfo()
  return self._taskCfg.TaskTitle, self._taskCfg.TaskContent, self._taskCfg.TaskBg
end

function HomeTaskItem:GetTaskInfoBg()
  return self._taskCfg.TaskBg
end

function HomeTaskItem:GetTaskReward()
  return self._taskCfg.Reward
end

function HomeTaskItem:CheckIsOpening()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local now = time_mod:GetServerTime() / 1000
  return now > self._taskCfg.StartTime and now < self._taskCfg.EndTime
end

function HomeTaskItem:SetTaskFinished(finish)
  self._taskFinished = finish
end

function HomeTaskItem:GetTaskFinished()
  return self._taskFinished
end

function HomeTaskItem:GetTaskIndexAndTotle()
  return self._indexInGroup, self._totleTaskCount
end

function HomeTaskItem:CreateTaskNpc()
  if HomelandFishMatchManager:GetInstance():IsInTaskMatchState() then
    return
  end
  local cfgNpcList = self._taskCfg.NpcList
  if cfgNpcList then
    for _, cfgNpcInfo in ipairs(cfgNpcList) do
      local npcId = cfgNpcInfo[1]
      local x, y, z = cfgNpcInfo[2], cfgNpcInfo[3], cfgNpcInfo[4]
      local rotationY = cfgNpcInfo[5]
      local chatId = cfgNpcInfo[6]
      local npc = HomelandTaskNPC:New(Cfg.cfg_homeland_task_npc[npcId], self._homelandClient)
      npc:SetTask(self)
      npc:SetLocation(x, y, z, rotationY)
      if self._checkNpcId ~= nil and self._checkNpcId == npcId then
        npc:SetCheckTalkID(self._checkchatId, self._checktalkId)
      end
      npc:SetChatID(chatId)
      npc:InitInteract()
      table.insert(self.npcList, npc)
    end
  end
  self:CreateTaskHangPointNpc(false)
end

function HomeTaskItem:CreateTaskHangPointNpc(force)
  local cfgNpcPathList = self._taskCfg.HangPointNpcList
  if not cfgNpcPathList then
    return
  end
  for _, cfgNpcInfo in ipairs(cfgNpcPathList) do
    local buildingId = cfgNpcInfo[1]
    self._holdBuildingId = buildingId
  end
  if not force and self._taskmanager:GetClientMode() == HomelandMode.Build then
    return
  end
  if cfgNpcPathList then
    for _, cfgNpcInfo in ipairs(cfgNpcPathList) do
      local buildingId = cfgNpcInfo[1]
      local hangPointId = cfgNpcInfo[2]
      local building = self._buildManager:FindBuildingByCfgID(buildingId)
      self._hangPointId = hangPointId
      self._holdBuildingId = buildingId
      if building then
        self._holdBuilding = building
        local hangTrans = building:GetNpcHangPointTransform(hangPointId)
        local npcId = cfgNpcInfo[3]
        local x, y, z = cfgNpcInfo[4], cfgNpcInfo[5], cfgNpcInfo[6]
        local rotationY = cfgNpcInfo[7]
        local chatId = cfgNpcInfo[8]
        if hangTrans then
          local npc = HomelandTaskNPC:New(Cfg.cfg_homeland_task_npc[npcId], self._homelandClient)
          npc:SetTask(self)
          npc:SetParent(hangTrans)
          npc:SetHoldBuilding(building)
          npc:SetLocation(x, y, z, rotationY, true)
          if self._buildManager:GetBuildEditorMode() == BuildEditorMode.Normal then
            npc:SetVisible(false)
          end
          if self._checkNpcId ~= nil and self._checkNpcId == npcId then
            npc:SetCheckTalkID(self._checkchatId, self._checktalkId)
          end
          npc:SetChatID(chatId)
          npc:InitInteract()
          table.insert(self.npcList, npc)
        end
      end
    end
  end
end

function HomeTaskItem:DestroyNpcs()
  for _, npc in pairs(self.npcList) do
    npc:Destroy()
  end
  self.npcList = {}
end

function HomeTaskItem:CreateTaskItemCondition(conditionId)
  local info = self:GetConditionInfo()
  if not info then
    return
  end
  conditionId = info.FinishType
  if conditionId == FinishConditionEnum.Position then
    self:_CreateConditionPosition()
  elseif conditionId == FinishConditionEnum.Dialog then
    self:_CreateConditionDialog()
  elseif conditionId == FinishConditionEnum.Item then
    self:_CreateConditionItem()
  elseif conditionId == FinishConditionEnum.PetSearch then
    self:_CreateConditionPetSearch()
  elseif conditionId == FinishConditionEnum.PetNeed then
    self:_CreateConditionPetNeed()
  elseif conditionId == FinishConditionEnum.FinishGame then
    self:_CreateConditionFinishGame()
  elseif conditionId == FinishConditionEnum.Other then
    self:_CreateConditionOther()
  end
end

function HomeTaskItem:GetTaskManager()
  return self._taskmanager
end

function HomeTaskItem:GetTaskGroup()
  return self._taskGroup
end

function HomeTaskItem:CheckFinished()
  if self._taskServerInfo and self._taskServerInfo:Status() >= QuestStatus.QUEST_Completed then
    self:SetTaskFinished(true)
  end
end

function HomeTaskItem:_PlayStory(story, callBack, npc)
  local storyType = story[1]
  local storyId = story[2]
  if storyType == TaskStoryType.Special then
    if not GameGlobal.GetUIModule(HomelandModule):IsRunning() then
      CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn")
      
      local function enterCallback()
        GameGlobal.GetUIModule(HomelandModule):SetEnterCallback(nil)
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeStoryController, storyId, callBack)
      end
      
      GameGlobal.GetUIModule(HomelandModule):SetEnterCallback(enterCallback)
    else
      CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeStoryController, storyId, callBack)
      end)
    end
  elseif storyType == TaskStoryType.Normal then
    GameGlobal.UIStateManager():ShowDialog("UIHomePetInteract", npc, callBack, storyId)
    self._homelandClient:InputManager():GetControllerChar():SetActive(false)
  else
    Log.fatal("任务剧情类型配置错误 任务id:" .. self._taskID)
    callBack()
  end
end

function HomeTaskItem:OpenTrace()
  local traceId = self:GetGuidId()
  self._homelandClient:GetHomelandTraceManager():StartTrace(traceId, TraceEnum.Task, nil, self)
  return traceId
end

function HomeTaskItem:DisposeTrace()
  local traceId = self:GetGuidId()
  self._homelandClient:GetHomelandTraceManager():DisposeTrace(traceId, TraceEnum.Task)
  return traceId
end

function HomeTaskItem:GetViewGroupTaskStoryState()
  return self._taskmanager:GetHomelandModule():CanViewGroupTaskStory(HomeLandGroupTaskStoryMask.HomeLandGroupTaskStoryMast_After, self._taskID)
end

function HomeTaskItem:SubmitTask(finish, npc)
  if self._taskState >= TaskStateEnum.Submit then
    return
  end
  if self.hadFinished or finish then
    self._taskState = TaskStateEnum.Submit
    GameGlobal.TaskManager():StartTask(self.SubmitTaskCoro, self, npc)
  end
end

function HomeTaskItem:SubmitTaskCoro(TT, npc)
  Log.info("[HomelandTask]任务条件达成 任务id:" .. self._taskID)
  if self:CheckTaskStoryEnd() then
    self:PlayStoryEnd(npc)
  else
    self:FinishTaskCoro(TT)
  end
end

function HomeTaskItem:StartSubmitTaskImmediatelyCoro()
  GameGlobal.TaskManager():StartTask(self.SubmitTaskImmediately, self)
end

function HomeTaskItem:SubmitTaskImmediately(TT)
  self._dialogRes, self.replyEvent = nil, nil
  self._dialogRes, self.replyEvent = self._taskmanager:GetHomelandModule():HandleHomelandFinishTaskReq(TT, self._taskID)
  Log.info("[HomelandTask]主动立刻提交 任务id:" .. self._taskID .. ": 对话类不能配置后置激情")
end

function HomeTaskItem:GetRewardsImmediately(npc)
  if self._dialogRes and self._dialogRes:GetSucc() then
    self._taskState = TaskStateEnum.Submit
    local assetList = self.replyEvent.rewards
    if 0 < #assetList then
      GameGlobal.UIStateManager():ShowDialog("UIHomeShowAwards", assetList, function()
        self:AfterFinishTask()
      end, false, nil)
    else
      self:AfterFinishTask()
    end
  else
    Log.info("[HomelandTask]任务结束 领奖成功 任务id:" .. self._taskID .. ": 对话类不能配置后置激情")
  end
end

function HomeTaskItem:FinishTaskCoro(TT, endStoryReq)
  GameGlobal.UIStateManager():Lock("HomeTaskItem:FinishTaskCoro")
  if endStoryReq then
    if self._taskCfg.CutinType == TaskCutinType.CutinAfterEndSpecialStory then
      self:DestroyNpcs()
    end
    local res = self._taskmanager:GetHomelandModule():HandleHomelandTaskViewStoryReq(TT, self._taskID, HomeLandGroupTaskStoryMask.HomeLandGroupTaskStoryMast_After)
    if res:GetSucc() then
    else
      Log.fatal("[HomeTaskItem] HandleHomelandTaskViewStoryReq fail, res:" .. res:GetResult())
    end
  end
  if self._isPassiveTask and self._taskServerInfo:Status() == QuestStatus.QUEST_Taken then
    Log.info("[HomelandTask]任务结束 没有奖品 任务id:" .. self._taskID .. " 是否被动任务:" .. tostring(self._isPassiveTask))
    self:AfterFinishTask()
    GameGlobal.UIStateManager():UnLock("HomeTaskItem:FinishTaskCoro")
    return
  end
  Log.info("[HomelandTask]任务结束 开始领奖 任务id:" .. self._taskID .. " 是否被动任务:" .. tostring(self._isPassiveTask))
  local res, replyEvent
  if self._isPassiveTask then
    res, replyEvent = self._taskmanager:GetHomelandModule():HandleHomelandTaskQuestTakeReq(TT, self._taskID)
  else
    res, replyEvent = self._taskmanager:GetHomelandModule():HandleHomelandFinishTaskReq(TT, self._taskID)
  end
  if endStoryReq then
    YIELD(TT, 500)
  end
  GameGlobal.UIStateManager():UnLock("HomeTaskItem:FinishTaskCoro")
  if res:GetSucc() then
    Log.info("[HomelandTask]任务结束 领奖成功 任务id:" .. self._taskID)
    local assetList = replyEvent.rewards
    if 0 < #assetList then
      GameGlobal.UIStateManager():ShowDialog("UIHomeShowAwards", assetList, function()
        self:AfterFinishTask()
      end, false, nil)
    else
      self:AfterFinishTask()
    end
  else
    Log.fatal("[HomeTaskItem] HandleHomelandFinishTaskReq fail, res:" .. res:GetResult())
    return
  end
end

function HomeTaskItem:AfterFinishTask()
  if not self._taskCfg then
    return
  end
  if self._taskCfg.CutinType == TaskCutinType.CutinAddAfterTaskEnd then
    GameGlobal.UIStateManager():Lock("HomeTaskItem:AfterFinishTask")
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
      self:TaskOver(true)
    end)
  else
    self:TaskOver()
  end
end

function HomeTaskItem:TaskOver(fromCutscene)
  if fromCutscene then
    GameGlobal.UIStateManager():UnLock("HomeTaskItem:AfterFinishTask")
    CutsceneManager.ExcuteCutsceneOut()
  end
  self:SetTaskFinished(true)
  self:DestroyNpcs()
  self._taskState = TaskStateEnum.Over
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandTaskSubmit, self._taskGroup:GetGroupID(), self:GetTaskID())
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSave, self._saveBuildingCallback)
end

function HomeTaskItem:FinishTask()
  GameGlobal.TaskManager():StartTask(self.FinishTaskCoro, self, true)
end

function HomeTaskItem:SetServerInfo(serverInfo)
  self._taskServerInfo = serverInfo
  self:CheckFinished()
  self:SetSpecialCheck()
  if self._taskState == TaskStateEnum.Running and self._taskServerInfo:Status() <= QuestStatus.QUEST_Completed and self._taskServerInfo:IsHomeLandQuestComplete() and self:GetConditionInfo().FinishType > FinishConditionEnum.FinishConditionEnum_End and not self._specialCheck then
    self:SubmitTask(true)
  end
end

function HomeTaskItem:SetSpecialCheck()
  local cli_cfg = GameGlobal.GetZoneCfgTable("cfg_quest", self._taskID)
  local condition = self._taskManagerHelper:GetTaskConditionCfg(self:GetFinishCondition())
  if cli_cfg and condition.FinishType == FinishConditionEnum.Other and self._inInit then
    local checkType
    checkType, self._itemCheckId = self:GetFixCheckConfig(cli_cfg.Cond)
    if self._taskServerInfo and checkType then
      local state = self._taskServerInfo:Status()
      local comp = self._taskServerInfo:IsHomeLandQuestComplete()
      if state < QuestStatus.QUEST_Completed and not comp then
        self._inInit = false
        self._specialCheck = true
      end
    end
  end
end

function HomeTaskItem:GetFixCheckConfig(condStr)
  local conds = string.split(condStr, "&")
  for _, cond in ipairs(conds) do
    local c = string.split(cond, ",")
    if c[1] and c[1] == "2006" then
      return true, c[2]
    end
  end
  return false
end

function HomeTaskItem:GetConditionInfo()
  local finishConditionId = self:GetFinishCondition()
  local finishCondition = self._taskManagerHelper:GetTaskConditionCfg(finishConditionId)
  return finishCondition
end

function HomeTaskItem:CheckTaskFinish()
  self._finishCondition = self._taskManagerHelper:GetTaskConditionCfg(self:GetFinishCondition())
  if not self._finishCondition then
    return
  end
  self._finishType = self._finishCondition.FinishType
  self.hadFinished = false
  if self._finishType == FinishConditionEnum.Position then
    local playerPos = self._homelandClient:CharacterManager():MainCharacterController():Position()
    if self.taskTarget then
      local distance = self._finishCondition.Target[2][1]
      self.hadFinished = distance > Vector3.Distance(playerPos, self.taskTarget.transform.position)
    end
  elseif self._finishType == FinishConditionEnum.Dialog then
  elseif self._finishType == FinishConditionEnum.PetSearch then
  elseif self._finishType == FinishConditionEnum.PetNeed then
  elseif self._finishType == FinishConditionEnum.Item then
    local itemId, itemCount = self._finishCondition.NeedItems[1], self._finishCondition.NeedItems[2]
    local haveCount = self._itemModule:GetItemCount(itemId)
    if itemCount <= haveCount then
      self.hadFinished = true
    else
      self.hadFinished = false
    end
  elseif self._finishType == FinishConditionEnum.FinishGame then
    self.hadFinished = false
  elseif not (self._finishType == FinishConditionEnum.Other and self._taskCfg) or self._specialCheck then
  elseif self._taskServerInfo and self._taskServerInfo:IsHomeLandQuestComplete() then
    self._isPassiveTask = true
    self.hadFinished = true
  end
  return self.hadFinished
end

function HomeTaskItem:GetClientMode()
  local mode = self._homelandClient:CurrentMode()
  return mode
end

function HomeTaskItem:_CreateCondition_ChatTargetId()
  local finishCondition = self:GetConditionInfo()
  local chatTargetId = finishCondition.ChatTargetId
  if not chatTargetId then
    Log.fatal("HomeTaskItem:_CreateConditionPetSearch is ERROR, cfg_homeland_task_finish_conditions[", finishCondition.id, "] ChatTargetId = nil")
  end
  self._checkNpcId = chatTargetId[1]
  self._checkchatId = chatTargetId[2]
  self._checktalkId = chatTargetId[3]
end

function HomeTaskItem:_CreateConditionPosition()
  local finishCondition = self:GetConditionInfo()
  if not finishCondition then
    Log.error(" no finishConditionId pos ：", finishCondition.Id)
    return
  end
  local transformInfo = finishCondition.Target
  self._req = ResourceManager:GetInstance():SyncLoadAsset("TaskCheckPoint.prefab", LoadType.GameObject)
  if not self._req then
    Log.error("找不到模型")
  end
  self.taskTarget = self._req.Obj
  self.taskTarget.transform.position = Vector3(transformInfo[1][1], transformInfo[1][2], transformInfo[1][3])
end

function HomeTaskItem:_CreateConditionDialog()
  self:_CreateCondition_ChatTargetId()
end

function HomeTaskItem:_CreateConditionItem()
end

function HomeTaskItem:_CreateConditionPetSearch()
  self:_CreateCondition_ChatTargetId()
end

function HomeTaskItem:_CreateConditionPetNeed()
  self:_CreateCondition_ChatTargetId()
end

function HomeTaskItem:_CreateConditionFinishGame()
  local finishCondition = self:GetConditionInfo()
  self._checkGameFinish = finishCondition.GameFinish
end

function HomeTaskItem:_CreateConditionOther()
end

function HomeTaskItem:SetNpcsVisible(visible)
  for _, npc in pairs(self.npcList) do
    npc:SetVisible(visible)
  end
end

function HomeTaskItem:GetTaskNpcs()
  if self.npcList then
    return self.npcList
  end
end

function HomeTaskItem:OnHomeLandSpecialCheck(args)
  if self._specialCheck and tostring(args) == self._itemCheckId and self._taskServerInfo:IsHomeLandQuestComplete() then
    self._specialCheck = false
  end
end

function HomeTaskItem:GetTaskServerInfo()
  return self._taskServerInfo
end

function HomeTaskItem:GetTaskConditionCfg()
  return self._taskManagerHelper:GetTaskConditionCfg(self:GetFinishCondition())
end

function HomeTaskItem:CheckPetSearch()
  if not self._finishCondition.NeedItems then
    Log.Error(" task finish condition  Item is nil")
  end
  local itemId, itemCount = self._finishCondition.NeedItems[1], self._finishCondition.NeedItems[2]
  local haveCount = self._itemModule:GetItemCount(itemId)
  return itemCount <= haveCount
end

function HomeTaskItem:CheckPetNeed()
  if not self._finishCondition.NeedItems then
    Log.Error(" task finish condition  Item is nil")
  end
  local itemId, itemCount = self._finishCondition.NeedItems[1], self._finishCondition.NeedItems[2]
  local haveCount = self._itemModule:GetItemCount(itemId)
  return itemCount <= haveCount
end

function HomeTaskItem:GetCheckItem()
  local finishCondition = self:GetConditionInfo()
  if not finishCondition then
    return
  end
  return finishCondition.NeedItems[1], finishCondition.NeedItems[2]
end

function HomeTaskItem:GetGameFinish()
  local finishCondition = self:GetConditionInfo()
  if not finishCondition then
    return
  end
  return finishCondition.GameFinish
end

function HomeTaskItem:OnSaveBuilding(delete, newadd)
  if not self._holdBuildingId then
    return
  end
  for key, value in pairs(delete) do
    if value == self._holdBuildingId then
      for i = #self.npcList, 1, -1 do
        for key, cfgNpcInfo in pairs(self._taskCfg.HangPointNpcList) do
          if self.npcList[i].npcID == cfgNpcInfo[3] then
            self.npcList[i]:Destroy()
            table.remove(self.npcList, i)
          end
        end
      end
    end
  end
  for key, value in pairs(newadd) do
    if value == self._holdBuildingId then
      local building = self._buildManager:FindBuildingByCfgID(self._holdBuildingId)
      self._holdBuilding = building
      if self._holdBuilding then
        self:CreateTaskHangPointNpc(true)
        for _, npc in pairs(self.npcList) do
          for key, cfgNpcInfo in pairs(self._taskCfg.HangPointNpcList) do
            if npc.npcID == cfgNpcInfo[3] then
              npc:SetVisible(false)
            end
          end
        end
      end
      break
    end
  end
end

function HomeTaskItem:GetHoldBuilding()
  return self._holdBuildingId
end

function HomeTaskItem:ShowTraceInfo()
  if self._holdBuildingId ~= nil then
    local building = self._buildManager:FindBuildingByCfgID(self._holdBuildingId)
    if not building then
      local cfg = Cfg.cfg_item_architecture[self._holdBuildingId]
      ToastManager.ShowHomeToast(StringTable.Get("str_homeland_task_canttrace", StringTable.Get(cfg.Name)))
      return false
    end
  end
  return true
end
