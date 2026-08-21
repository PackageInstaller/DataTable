_class("UIHomeLandTaskInfo", UICustomWidget)
UIHomeLandTaskInfo = UIHomeLandTaskInfo

function UIHomeLandTaskInfo:OnShow()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  if not self.homelandClient then
    return
  end
  self._homelandTraceManager = self.homelandClient:GetHomelandTraceManager()
  self:InitWidget()
  self:_AttachEvents()
end

function UIHomeLandTaskInfo:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if self.taskID then
    GameGlobal.UIStateManager():UnLock("UIHomeLandTaskInfo:ShowAniCore")
    GameGlobal.TaskManager():KillTask(self.taskID)
    self.taskID = nil
  end
  self:_DetachEvents()
  if not self.homelandClient then
    return
  end
  local taskGroup = self:_GetRunningTaskGroup()
  if not taskGroup then
    return
  end
  local task = self.homelandClient:GetHomelandTaskManager():GetRuningTask()
  task = task or self.homelandClient:GetHomelandTaskManager():GetHomelandStoryTaskManager():GetRuningTaskItem()
  self.runningtask = task
  if self.runningtask then
    local traceId = self.runningtask:GetGuidId()
    if traceId then
      self._homelandTraceManager:DisposeTrace(traceId, TraceEnum.Task)
    end
  end
  self._lastTaskId = nil
end

function UIHomeLandTaskInfo:InitWidget()
  self._bg = self:GetUIComponent("Image", "bgImage")
  self._titleText = self:GetUIComponent("UILocalizationText", "titleText")
  self._contentText = self:GetUIComponent("UILocalizationText", "contentText")
  self._ani = self:GetUIComponent("Animator", "Anim")
  self._bgPoint = self:GetGameObject("bgImage")
  self._point = self:GetGameObject("point")
  self:RefreshUI()
  self:ShowAni()
end

function UIHomeLandTaskInfo:SetShow(show)
  self:GetGameObject():SetActive(show)
end

function UIHomeLandTaskInfo:GetFormatTaskTitle(tasktitle)
  if tasktitle == nil then
    tasktitle = ""
    local task = self:_GetRunningTask()
    if task then
      local title = task:GetTaskInfo()
      tasktitle = StringTable.Get(title)
    end
  end
  return string.format("<color=#fef488>%s</color>", tasktitle)
end

function UIHomeLandTaskInfo:RefreshUI()
  local title, content
  local task = self:_GetRunningTask()
  if not self.view then
    return
  end
  if task then
    if task:GetTaskID() ~= self._lastTaskId then
      self.view:SetShow(false, self)
    end
    self.view:SetShow(true, self)
    title, content = task:GetTaskInfo()
    local tasktitle = StringTable.Get(title)
    tasktitle = self:GetFormatTaskTitle(tasktitle)
    local finishInfo = task:GetConditionInfo()
    local finishType = finishInfo.FinishType
    if finishType == FinishConditionEnum.Item or finishType == FinishConditionEnum.PetSearch or finishType == FinishConditionEnum.PetNeed then
      local itemId, itemCount = finishInfo.NeedItems[1], finishInfo.NeedItems[2]
      local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(itemId)
      local colorContent
      if itemCount <= haveCount then
        colorContent = string.format("<color=#fbc305>%s</color>", haveCount)
        content = StringTable.Get(content, colorContent, itemCount)
      else
        colorContent = string.format("<color=#fbc305>%s</color>", haveCount)
        content = StringTable.Get(content, colorContent, itemCount)
      end
    else
      content = StringTable.Get(content)
    end
    self._titleText:SetText(tasktitle)
    self._contentText:SetText(content)
  else
    self._titleText:SetText("")
    self._contentText:SetText("")
    self.view:SetShow(false, self)
  end
  if task then
    if task:GetTaskID() == self._lastTaskId then
      Log.fatal("task:GetTaskID()" .. task:GetTaskID())
    else
      self:ShowTrace()
      self._lastTaskId = task:GetTaskID()
    end
  else
    self._lastTaskId = nil
    if self._traceId then
      self._homelandTraceManager:DisposeTrace(self._traceId, TraceEnum.Task)
      self._traceId = nil
      if self._timerHandler then
        GameGlobal.Timer():CancelEvent(self._timerHandler)
        self._timerHandler = nil
      end
    end
  end
end

function UIHomeLandTaskInfo:ShowTrace()
  self._hideTime = 600
  self:OpenTraceCoro()
end

function UIHomeLandTaskInfo:HideTrace()
  local taskGroup = self:_GetRunningTaskGroup()
  if not taskGroup then
    return
  end
  local task = self:_GetRunningTask()
  if not task then
    return
  end
  self.runningtask = task
  local traceId = self.runningtask:GetGuidId()
  if not traceId then
    return
  end
  self._homelandTraceManager:SetTraceItemShowIcons(traceId, false)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIHomeLandTaskInfo:OpenTraceCoro()
  if self._traceId then
    self._homelandTraceManager:DisposeTrace(self._traceId, TraceEnum.Task)
    self._traceId = nil
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
  end
  local taskGroup = self:_GetRunningTaskGroup()
  if not taskGroup then
    return
  end
  local task = self:_GetRunningTask()
  if not task then
    return
  end
  self.runningtask = task
  self._traceId = self.runningtask:GetGuidId()
  if not self._traceId then
    return
  end
  if self._homelandTraceManager:CheckHadTraceItem(self._traceId) then
    return
  end
  self._homelandTraceManager:StartTrace(self._traceId, TraceEnum.Task, nil, self.runningtask)
  if not self._timerHandler then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000 * self._hideTime, TimerTriggerCount.Once, function()
      self:HideTrace()
    end)
  end
end

function UIHomeLandTaskInfo:_GetRunningTaskGroup()
  local runningTaskGroup = self.homelandClient:GetHomelandTaskManager():GetRuningTaskGroup()
  runningTaskGroup = runningTaskGroup or self.homelandClient:GetHomelandTaskManager():GetHomelandStoryTaskManager():GetRuningTaskroup()
  Log.debug("UIHomeLandTaskInfo:_GetRunningTaskGroup() runningTaskGroup = ", runningTaskGroup and runningTaskGroup._runningTaskId)
  return runningTaskGroup
end

function UIHomeLandTaskInfo:_GetRunningTask()
  local task = self.homelandClient:GetHomelandTaskManager():GetRuningTask()
  task = task or self.homelandClient:GetHomelandTaskManager():GetHomelandStoryTaskManager():GetRuningTaskItem()
  Log.debug("UIHomeLandTaskInfo:_GetRunningTask() task = ", task and task._taskID)
  return task
end

function UIHomeLandTaskInfo:_AttachEvents()
  self:AttachEvent(GameEventType.OnHomeLandTaskSubmit, self._OnHomeLandTaskRefresh)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnHomeLandTaskItemCountChanged)
  self:AttachEvent(GameEventType.OnHomeLandTaskGroupSubmit, self._OnHomeLandTaskRefresh)
  self:AttachEvent(GameEventType.StoryTaskChangeState, self._OnHomeLandTaskRefresh)
  self:AttachEvent(GameEventType.StoryTaskTraceSuccess, self._OnHomeLandTaskRefresh)
  self:AttachEvent(GameEventType.OnHomelandTaskItemChanged, self._OnHomeLandTaskItemCountChanged)
end

function UIHomeLandTaskInfo:_DetachEvents()
  self:DetachEvent(GameEventType.OnHomeLandTaskSubmit, self._OnHomeLandTaskRefresh)
  self:DetachEvent(GameEventType.ItemCountChanged, self._OnHomeLandTaskItemCountChanged)
  self:DetachEvent(GameEventType.OnHomeLandTaskGroupSubmit, self._OnHomeLandTaskRefresh)
  self:DetachEvent(GameEventType.StoryTaskChangeState, self._OnHomeLandTaskRefresh)
  self:DetachEvent(GameEventType.StoryTaskTraceSuccess, self._OnHomeLandTaskRefresh)
  self:AttachEvent(GameEventType.OnHomelandTaskItemChanged, self._OnHomeLandTaskItemCountChanged)
end

function UIHomeLandTaskInfo:_OnHomeLandTaskRefresh()
  self:RefreshUI()
  self:ShowAni()
end

function UIHomeLandTaskInfo:_OnHomeLandTaskItemCountChanged()
  self:RefreshUI()
end

function UIHomeLandTaskInfo:BtnOnClick()
  local runningTaskGroup = self:_GetRunningTaskGroup()
  if not runningTaskGroup then
    return
  end
  local taskItem = runningTaskGroup:GetRuningTask()
  if not taskItem then
    return
  end
  self._traceId = taskItem:GetGuidId()
  if not self._traceId then
    return
  end
  if not taskItem:ShowTraceInfo() then
    return
  end
  if self._traceId then
    self._homelandTraceManager:StartTrace(self._traceId, TraceEnum.Task, nil, taskItem)
  end
  self._homelandTraceManager:SetTraceItemShowIcons(self._traceId, true)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if not self._timerHandler then
    self._timerHandler = GameGlobal.Timer():AddEventTimes(1000 * self._hideTime, TimerTriggerCount.Once, function()
      self:HideTrace()
    end)
  end
end

function UIHomeLandTaskInfo:ShowAni()
  self._ani.enabled = false
  self._ani.enabled = true
  self:MatchAniAlpha()
end

function UIHomeLandTaskInfo:MatchAniAlpha()
  if not self.taskID then
    self.taskID = self:StartTask(self.ShowAniCore, self)
  end
end

function UIHomeLandTaskInfo:ShowAniCore(TT)
  local key = 30
  local curtime = 0
  local str
  local text = self._titleText.text
  local match = "#(%x+)"
  local color, res
  GameGlobal.UIStateManager():Lock("UIHomeLandTaskInfo:ShowAniCore")
  while key >= curtime and self._titleText ~= nil do
    curtime = curtime + 1
    color = self._titleText.color.a
    str = string.format("0x%06x", math.ceil(color * 255))
    color = string.sub(str, 7, 8)
    str = "#fef488" .. color
    text = self:GetFormatTaskTitle()
    res = string.gsub(text, match, str)
    self._titleText.text = res
    YIELD(TT, 1)
  end
  local task = self:_GetRunningTask()
  self._point:SetActive(task ~= nil)
  if task and task._taskCfg then
    local title, content = task:GetTaskInfo()
    local tasktitle = StringTable.Get(title)
    tasktitle = string.format("<color=#fef488>%s</color>", tasktitle)
    self._titleText:SetText(tasktitle)
  else
    self._titleText:SetText("")
  end
  GameGlobal.UIStateManager():UnLock("UIHomeLandTaskInfo:ShowAniCore")
  self.taskID = nil
end

function UIHomeLandTaskInfo:ShowOnInteract(bShow)
  self._bgPoint:SetActive(bShow)
end
