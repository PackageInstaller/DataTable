local this = class("pageTask", G_UIPageBase)
local _taskTpl = L_GameTpl:getTaskTpl()
local _commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local _TypeId2Module = {
  [1] = "moduleMainTaskInfo",
  [2] = "moduleOtherTaskInfo",
  [3] = "moduleMainTaskInfo",
  [4] = "moduleOtherTaskInfo",
  [5] = "moduleOtherTaskInfo"
}
local _BlackType = {
  [1] = true,
  [2] = true,
  [3] = false,
  [4] = true,
  [5] = true
}

function this.bind()
  return {
    tabList = {
      moduleName = "pages/task/cellTaskTab"
    },
    currentTabId = 0,
    taskGrid = {
      moduleName = "pages/task/cellGroupTask"
    },
    moduleMainTaskInfo = {
      moduleName = "pages/task/moduleMainTaskInfo"
    },
    moduleOtherTaskInfo = {
      moduleName = "pages/task/moduleOtherTaskInfo"
    },
    activeToTrace = false,
    activeCancelTrace = false,
    activeFinish = false,
    activeTraceing = false,
    activeMainMap = false,
    activeMap = false,
    empty_panel = false,
    txtEmptyTip = L_WordsTpl:getValue("ui_task_none"),
    txtEmptyTipSmall = L_WordsTpl:getValue("ui_task_none_small"),
    txtMainMapBtn = L_WordsTpl:getValue("ui_task_btn_jump"),
    activeBtns = true,
    activeEmptyTipSmall = true,
    activeClickMainBtn = true
  }
end

function this.methods()
  return {
    onSelectTab = function(self, tabId)
      self:switchTaskPage(tabId)
    end,
    onClickToTrace = function(self)
      self:setTracedTask(true)
    end,
    onClickCancelTrace = function(self)
      self:setTracedTask(false)
    end,
    onClickMap = function(self)
      self:openBigMap()
    end,
    onClickMainMap = function(self)
      self:openBigMap()
    end
  }
end

function this:ctor()
  this.super.ctor(self)
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.OpenTaskView))
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.task)
  callback(result)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.modules.moduleMainTaskInfo:hideTask()
  self.modules.moduleOtherTaskInfo:hideTask()
  self:initTabs()
  self:refreshNewTask()
  options = options or {}
  if options.jumpParams then
    local jumpType = tonumber(options.jumpParams[1])
    if jumpType == 1 then
      options.tabId = tonumber(options.jumpParams[2])
    elseif jumpType == 2 then
      options.taskId = tonumber(options.jumpParams[2])
    end
    if options.taskId and options.taskId > 0 then
      self:jumpTask(options.taskId)
    elseif options.tabId then
      self.bind.currentTabId = options.tabId
    else
      self.bind.currentTabId = self.bind.tabList[1].tabId
    end
  else
    local taskList = AzurWorld.TaskMgr:GetTraceTaskList()
    local openTaskId = options.taskId
    if not openTaskId and 0 < taskList.Count then
      for i = 0, taskList.Count - 1 do
        local taskId = taskList[i]
        local taskCfg = _taskTpl:getTplById(taskId)
        if not openTaskId or taskCfg.type == L_Const.taskType.main then
          openTaskId = taskId
        end
      end
    end
    if openTaskId and 0 < openTaskId then
      self:jumpTask(openTaskId)
    elseif options.tabId then
      self.bind.currentTabId = options.tabId
    else
      self.bind.currentTabId = self.bind.tabList[1].tabId
    end
  end
end

function this:close()
  this.super.close(self)
end

function this:onEventRefreshTask()
  self:refreshNewTask()
  local curModule = self:getCurTaskModule()
  if curModule then
    curModule:showTask(self.typeId)
    self:setEmptyPanelShow(not curModule.isShow)
  end
end

function this:initTabs()
  local typeTpl = L_GameTpl:getTaskTypeTpl()
  local datas = {}
  local guideTasks = AzurWorld.TaskMgr:GetCurTaskIdsByType(L_Const.taskType.guide)
  for _, v in pairs(typeTpl.data) do
    if typeTpl:getShow(v) ~= 0 then
      local trace = self:CheckTypeIsTracing(v.id)
      if _BlackType[v.id] then
        table.insert(datas, {
          tabId = v.id,
          order = typeTpl:getOrder(v),
          txtNameOn = typeTpl:getName(v),
          txtNameOff = typeTpl:getName(v),
          txtNameSubOn = typeTpl:getEnglishName(v),
          txtNameSubOff = typeTpl:getEnglishName(v),
          txtIconOn = typeTpl:getTypeIcon(v),
          txtIconOff = typeTpl:getTypeIcon(v),
          activeLine = true,
          activeTraceOn = trace,
          activeTraceOff = trace
        })
      end
    end
  end
  table.sort(datas, function(a, b)
    return a.order < b.order
  end)
  datas[#datas].activeLine = false
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(datas)
end

function this:CheckTypeIsTracing(type)
  if type == L_Const.taskType.main then
    return true
  end
  local taskIds = AzurWorld.TaskMgr:GetNowTransTaskIdList()
  local Count = taskIds.Count - 1
  for i = 0, Count do
    local tplTask = _taskTpl:getTplById(taskIds[i])
    if type == _taskTpl:getTabType(tplTask) then
      return true
    end
  end
  return false
end

function this:refreshTabTrace()
  local guideTasks = AzurWorld.TaskMgr:GetCurTaskIdsByType(L_Const.taskType.guide)
  local guideTaskTace = guideTasks.Count > 0
  for i = 1, #self.modules.tabList do
    local tabItem = self.modules.tabList[i]
    local trace = self:CheckTypeIsTracing(tabItem.bind.tabId)
    tabItem.bind.activeTraceOn = trace
    tabItem.bind.activeTraceOff = trace
  end
end

function this:switchTaskPage(typeId)
  local playAnim = self.typeId ~= nil
  local lastModule = self:getCurTaskModule()
  local curModule = self:getTaskModule(typeId)
  self.typeId = typeId
  if not curModule then
    if lastModule then
      lastModule:hideTask()
    end
    self:setEmptyPanelShow(true, false)
    return
  end
  curModule:showTask(typeId, playAnim and not self.isEmpty)
  if curModule.isShow and lastModule and lastModule ~= curModule then
    lastModule:hideTask()
  end
  self:setEmptyPanelShow(not curModule.isShow, lastModule, playAnim)
end

function this:getCurTaskModule()
  if self.isEmpty then
    return
  end
  return self:getTaskModule(self.typeId)
end

function this:getTaskModule(typeId)
  if not typeId then
    return
  end
  local moduleKey = _TypeId2Module[typeId]
  if not moduleKey then
    errorf("该类型未开发" .. tostring(typeId))
  end
  return self.modules[moduleKey]
end

function this:jumpTask(taskId)
  local tabType = L_TaskManager:getTaskTabType(taskId)
  local module = self:getTaskModule(tabType)
  if module then
    module:setDefaultOpenTaskId(taskId)
  end
  if tabType ~= self.bind.currentTabId then
    if tabType ~= 1 and tabType ~= 2 and tabType ~= 5 and tabType ~= 4 then
      self.bind.currentTabId = 1
    else
      self.bind.currentTabId = tabType
    end
  end
end

function this:setEmptyPanelShow(show, laskModule, playAnim)
  if show then
    local descTip = self.typeId ~= 1 and L_WordsTpl:getValue("ui_task_none") or L_WordsTpl:getValue("notice_task_main_notask")
    self.bind.txtEmptyTip = descTip
  end
  if self.isEmpty == show then
    return
  end
  self.isEmpty = show
  local isShowSmallTip = self.typeId ~= 1
  self.bind.activeEmptyTipSmall = isShowSmallTip
  self.bind.activeBtns = not show
  if not playAnim then
    self.bind.empty_panel = show
    if self.isEmpty and laskModule then
      laskModule:hideTask()
    end
    return
  end
  self.bindComponents.animEmpty:Stop()
  self.bindComponents.animContent:Stop()
  if show then
    self.bindComponents.animEmpty:Play("anim_task_empty_show")
    self.bindComponents.animContent:Play("anim_task_content_hide")
    self.bind.empty_panel = true
    self:AddChangeTypeAnimTimer(0.333, function()
      if laskModule then
        laskModule:hideTask()
      end
    end)
  else
    self.bindComponents.animEmpty:Play("anim_task_empty_hide")
    self.bindComponents.animContent:Play("anim_task_content_show")
    self:AddChangeTypeAnimTimer(0.233, function()
      self.bind.empty_panel = false
      L_AudioUtil.playSound("Play_SFX_System_UI_Mission_Open")
    end)
  end
end

function this:AddChangeTypeAnimTimer(time, cb)
  L_TimerManager:newOrResetTimer(self, "ChangeType", cb, time)
end

function this:onShowTask(taskId)
  self:handleCurrentTaskBtn(taskId)
  self:removeNewTask(taskId)
end

function this:handleCurrentTaskBtn(taskId)
  self.taskId = taskId
  if AzurWorld.TaskMgr:GetTaskUIModule():IsTaskInLimitStep(taskId) then
    self.bind.activeToTrace = false
    self.bind.activeTraceing = false
    self.bind.activeCancelTrace = false
    self.bind.activeMap = false
    self.bind.activeMainMap = false
    return
  end
  local isGuide = L_TaskManager:getTaskType(taskId) == L_Const.taskType.guide
  local isMain = L_TaskManager:getTaskType(taskId) == L_Const.taskType.main
  self.bind.activeClickMainBtn = true
  if isGuide then
    self.bind.activeToTrace = false
    self.bind.activeTraceing = true
    self.bind.activeCancelTrace = false
    self.bind.activeMainMap = false
    local list = AzurWorld.TaskMgr:GetTaskNodeCommonData(self.taskId)
    local flag = false
    for i = 0, list.Count - 1 do
      local data = list[i]
      if 0 < data.sceneId and 0 < data.birthId then
        flag = true
        break
      end
    end
    self.bind.activeMap = flag and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.adventure)
  elseif AzurWorld.TaskMgr:GetIsTraceTask(taskId) then
    self.bind.activeToTrace = false
    self.bind.activeTraceing = false
    self.bind.activeCancelTrace = not isMain
    self.bind.activeMainMap = isMain
    self.bind.activeMap = not isMain and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.adventure)
  else
    self.bind.activeToTrace = true
    self.bind.activeTraceing = false
    self.bind.activeCancelTrace = false
    self.bind.activeMainMap = false
    self.bind.activeMap = false
  end
  if isMain then
    self.bind.activeToTrace = false
    self.bind.activeMainMap = true
    if 0 < taskId and taskId == AzurWorld.TaskMgr:GetTaskUIModule():GetNextTaskId() then
      local taskLockInfo = AzurWorld.TaskMgr:GetTaskIsOpenCondition(taskId)
      local conditions = taskLockInfo.param
      for i = 0, conditions.Count - 1, 2 do
        if 0 < conditions[i] then
          local conditionTpl = _commonConditionTpl:getTplById(conditions[i])
          if conditionTpl then
            local isIngore = false
            local conditionTypeName = _commonConditionTpl:getName(conditionTpl)
            local descShow = _commonConditionTpl:getDescShowKey(conditionTpl)
            local desc = "None"
            if conditionTypeName == "Level" then
              desc = string.gsub(descShow, "{playerlevel}", tostring(conditions[i + 1]))
              self.bind.txtMainMapBtn = desc
            end
          end
        end
      end
      self.bind.activeClickMainBtn = false
    end
  end
end

function this:refreshTraceTask()
  self:refreshTabTrace()
  local module = self:getCurTaskModule()
  if module and module.refreshTrace then
    module:refreshTrace()
  end
  self:handleCurrentTaskBtn(self.taskId)
end

function this:setTracedTask(isTrace)
  if AzurWorld.FunctionModuleForbidMgr:CheckIsFunctionModuleForbid(C_EForbidModuleType.ChangeTaskTrack, true) then
    return
  end
  local isTaskKiboTransfer = AzurWorld.TaskMgr:CheckTaskKiboTransfer(self.taskId)
  local isTraceTask = AzurWorld.TaskMgr:GetIsTraceTask(self.taskId)
  if isTraceTask then
    if not isTrace then
      if isTaskKiboTransfer then
        self:showTaskTip("notice_special_cannot_cancel_task")
      end
      L_TaskStore:disposeTraceTask(self.taskId, function()
        self:refreshTraceTask()
      end)
    end
    return
  end
  if not isTrace then
    return
  end
  local txtContentKey = not isTaskKiboTransfer and "task_changetasktrace_content" or "notice_special_cannot_set_trace_task"
  self:showTaskTip(txtContentKey, function()
    L_TaskStore:setTraceTask(self.taskId, function()
      self:openBigMap(function()
        L_UI:close(self.pageName)
      end)
    end)
  end)
  self:refreshMainTaskHud(isTrace)
end

function this:showTaskTip(txtContentKey, cb)
  L_GameUtil.showCommonTip({
    txtTitle = L_WordsTpl:getValue("task_changetasktrace_title"),
    txtContent = L_WordsTpl:getValue(txtContentKey),
    closeCallback = cb,
    hideConfirm = true,
    hideCancel = true
  })
end

function this:refreshNewTask()
  local ids = AzurWorld.TaskMgr:GetTaskExecuteTaskId()
  self.newTasks = {}
  for i = 0, ids.Count - 1 do
    if not L_CommonUtil.getLocalValue("NewTask_" .. ids[i]) then
      local tplTask = _taskTpl:getTplById(ids[i])
      local type = _taskTpl:getTabType(tplTask)
      if not self.newTasks[type] then
        self.newTasks[type] = {}
      end
      self.newTasks[type][ids[i]] = true
    end
  end
  for _, v in ipairs(self.modules.tabList) do
    if not table.isEmpty(self.newTasks[v.bind.tabId]) then
      v.bind.activeRed = true
    end
  end
end

function this:removeNewTask(taskId)
  local tplTask = _taskTpl:getTplById(taskId)
  local type = _taskTpl:getTabType(tplTask)
  if self.newTasks[type] and self.newTasks[type][taskId] then
    self.newTasks[type][taskId] = nil
    L_CommonUtil.setLocalValue("NewTask_" .. taskId, "1")
    if table.isEmpty(self.newTasks[type]) then
      for _, v in ipairs(self.modules.tabList) do
        if v.bind.tabId == type then
          v.bind.activeRed = false
        end
      end
    end
  end
end

function this:openBigMap(cb)
  if not self.taskId then
    return
  end
  AzurWorld.TaskMgr:OpenMapByTaskId(self.taskId, -1, -1, cb, true)
end

function this:refreshMainTaskHud(isOpen)
  local list = C_VarList:Get()
  list:AddInt(1)
  list:AddBool(isOpen)
  C_MainCityEvent.instance:Dispatch(C_EMainCityEvents.ChangeTaskHud, list)
end

return this
