local base = require("ui/pages/task/moduleTaskInfoBase")
local this = class("moduleOtherTaskInfo", base)
local pageType = {SubTask = 2, Activity = 4}
local _taskTpl = L_GameTpl:getTaskTpl()
local _taskStepTpl = L_GameTpl:getTaskStepTpl()
local _taskTargetTpl = L_GameTpl:getTaskTargetTpl()
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()

function this:bind()
  return {
    txtName = "",
    activeName = false,
    txtNameOn = "",
    activeNameOn = false,
    txtMap = "",
    activeMap = false,
    targetList = {
      moduleName = "pages/task/cellTaskTargetInfo"
    },
    txtDes = "",
    activeSign = false,
    txtSign = "",
    selectedRewardTabId = 0,
    rewardList = L_Const.ModuleInfo.CellIconBag,
    activeRewardTab = false,
    activeRewardTitle = false,
    txtRewardTitle = "",
    activeReward = false,
    activeLimit = false,
    txtLimit = "",
    selectTaskTabId = 0,
    tabList = {
      moduleName = "pages/task/cellGroupTask"
    },
    curshowLimit = false,
    curtxtLimit = "",
    curTaskTypeLabel = ""
  }
end

function this:methods()
  return {
    onSelectRewardTab = function(self, tabId, a)
      self:onSelectRewardTab(tabId)
    end,
    onSelectTaskTab = function(self, tabId, a)
      for _, v in ipairs(self.modules.tabList) do
        v:refreshSelected()
      end
      self.curSelectedId = tabId
      self:refreshTask(tabId)
      if not self.hasPlayedSwitchAnim then
        self.bindComponents.animation:Stop()
        self.bindComponents.animation:Play("anim_task_m2_fresh")
      else
        self.hasPlayedSwitchAnim = false
      end
      self:refreshTimeMark(tabId)
    end
  }
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshTaskPage, self)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.refreshTaskPage)
end

function this:refreshTaskPage()
  if self.typeId == pageType.SubTask then
    self:refreshTaskByType(self.typeId)
  end
end

function this:playShowAnim()
  self.bindComponents.animation:Stop()
  if self.isShow then
    self.bindComponents.animation:Play("anim_task_m2_fresh")
  else
    self.bindComponents.animation:Play("anim_task_m2_switch")
  end
  self.hasPlayedSwitchAnim = true
end

function this:refreshTaskByType(typeId)
  local isSameType = typeId == self.typeId
  self.super.refreshTaskByType(self, typeId)
  local taskIds = AzurWorld.TaskMgr:GetTaskUIModule():GetCurTaskIdsByTabType(typeId)
  if taskIds.Count < 1 then
    return false
  end
  local datas = {}
  for _, id in ipairs(taskIds) do
    local tplTask = _taskTpl:getTplById(id)
    local timeLimit = false
    local endTime = 0
    if typeId == pageType.SubTask then
      timeLimit, endTime = AzurWorld.TaskMgr:TryGetTaskEndTime(id)
    elseif typeId == pageType.Activity then
      local actId = AzurWorld.TaskMgr:GetExternParams(id, 1)
      local activityData = L_GameEventStore:getGameEventData(actId)
      if activityData then
        timeLimit = true
        endTime = activityData.end_time
      end
    end
    local taskLimit, limitTxt = self:tryGetTaskShortLimitTxt(id)
    local txtMap
    local list = AzurWorld.TaskMgr:GetTaskNodeCommonData(id)
    if list.Count > 0 then
      txtMap = AzurWorld.TaskMgr:GetCityBorthData(list[0].sceneId, list[0].birthId, true)
    end
    local namePos = string.isEmpty(txtMap) and C_Vector2(217, 0) or C_Vector2(217, 9.4)
    endTime = timeLimit and (type(endTime) == "number" and endTime or C_TimeUtility.DateTimeToTimestamp(endTime))
    local isOverTime = timeLimit and 0 >= endTime - L_TimeUtil.getServerTime()
    if not timeLimit or not isOverTime then
      local data = {
        tabId = id,
        txtNameOn = _taskTpl:getName(tplTask),
        txtNameOff = _taskTpl:getName(tplTask),
        txtMapOn = txtMap or "",
        txtMapOff = txtMap or "",
        tacking = AzurWorld.TaskMgr:GetIsTraceTask(id),
        activeRed = L_CommonUtil.getLocalValue("NewTask_" .. id) == nil,
        anchoredPosNameOn = namePos,
        anchoredPosNameOff = namePos,
        activeLimitIcon = taskLimit,
        endTime = endTime,
        showLimit = taskLimit,
        txtLimit = limitTxt,
        typeId = self.typeId
      }
      table.insert(datas, data)
    end
  end
  for _, v in ipairs(self.modules.tabList) do
    v.bind.tabId = 0
  end
  if not isSameType then
    self.bindComponents.tabScroll.content.anchoredPosition = C_Vector2(0, 0)
  end
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(datas)
  if table.count(datas) == 0 then
    return false
  end
  self.curSelectedId = self:IsTaskExist(self.curSelectedId, datas) and self.curSelectedId or nil
  self.defaultOpenTaskId = self:IsTaskExist(self.defaultOpenTaskId, datas) and self.defaultOpenTaskId or nil
  local targetTask = 0
  if isSameType and self.curSelectedId and self.curSelectedId ~= 0 then
    targetTask = self.curSelectedId
  else
    targetTask = self.defaultOpenTaskId or datas[1].tabId or self.taskId
    self.curSelectedId = targetTask
  end
  self.defaultOpenTaskId = nil
  self.bind.selectTaskTabId = targetTask
  local index = -1
  for i, v in ipairs(datas) do
    if v.tabId == self.bind.selectTaskTabId then
      index = i
      break
    end
  end
  if index ~= -1 then
    self.bindComponents.tabScroll:ReloadData(index - 1)
  else
    self.bindComponents.tabScroll:ReloadData(0)
  end
  self.taskId = nil
  self:refreshTask(targetTask)
  self.bind.curshowLimit = false
  for i, v in ipairs(datas) do
    if v.tabId == targetTask and v.endTime then
      self:refreshTimeLimit(v.endTime)
      
      function v.refreshRightPage(leftTime)
        self:refreshTimeLimit(leftTime)
      end
      
      self.bind.curshowLimit = true
      break
    end
  end
  local tpl = _taskTypeTpl:getTplById(self.typeId)
  self.bind.curTaskTypeLabel = _taskTypeTpl:getName(tpl)
  return true
end

function this:IsTaskExist(taskId, taskDatas)
  for _, data in ipairs(taskDatas) do
    if data.tabId == taskId then
      return true
    end
  end
  return false
end

function this:tryGetTaskShortLimitTxt(taskId)
  local nodeId = AzurWorld.TaskMgr:GetExcuteNode(taskId)
  if nodeId then
    local stepId = AzurWorld.TaskMgr:GetTaskStepId(taskId, nodeId)
    local tplTaskStep = _taskStepTpl:getTplById(stepId)
    if tplTaskStep and _taskStepTpl:getIsLimitStep(tplTaskStep) then
      local infos = AzurWorld.TaskMgr:GetNodeInfoParam(taskId, nodeId)
      for i = 0, infos.Count - 1 do
        local taskInfoData = infos[i]
        if not taskInfoData.isComplate then
          local tplTaskTarget = _taskTargetTpl:getTplById(taskInfoData.conditionInfoId)
          if not tplTaskTarget then
            errorf(string.format("Can't get tplTaskTarget by id:%s, taskNodeId:%s", taskInfoData.conditionInfoId, taskInfoData.nodeId))
            return
          end
          return true, _taskTargetTpl:getShortLockText(tplTaskTarget)
        end
      end
    end
  end
end

function this:refreshTaskTraceInfo()
  local tplTask = _taskTpl:getTplById(self.taskId)
  if AzurWorld.TaskMgr:GetIsTraceTask(self.taskId) then
    self.bind.txtNameOn = _taskTpl:getName(tplTask)
    self.bind.activeName = false
    self.bind.activeNameOn = true
  else
    self.bind.txtName = _taskTpl:getName(tplTask)
    self.bind.activeName = true
    self.bind.activeNameOn = false
  end
end

function this:showRewards(rewards)
  self.super.showRewards(self, rewards)
  if #self.bind.rewardList < 9 then
    self.bindComponents.rewardList.contentPivot = Unity.Vector2(0.5, 0.5)
  else
    self.bindComponents.rewardList.contentPivot = Unity.Vector2(0, 0.5)
  end
  self.bindComponents.content.localPosition = L_Vector3.zero
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.content)
end

function this:setDefaultOpenTaskId(taskId)
  self.defaultOpenTaskId = taskId
end

function this:refreshTrace()
  self.super.refreshTrace(self)
  self:refreshTaskTraceInfo()
end

function this:refreshTimeMark(id)
  local timeLimit = false
  local endTime = 0
  if self.typeId == pageType.SubTask then
    timeLimit, endTime = AzurWorld.TaskMgr:TryGetTaskEndTime(id)
  elseif self.typeId == pageType.Activity then
    local actId = AzurWorld.TaskMgr:GetExternParams(id, 1)
    local activityData = L_GameEventStore:getGameEventData(actId)
    if activityData then
      timeLimit = true
      endTime = activityData.end_time
    end
  end
  self.bind.curshowLimit = false
  for k, item in ipairs(self.bind.tabList:getItemCls()) do
    item.bind.refreshRightPage = nil
    if item.bind.tabId == id and timeLimit then
      self:refreshTimeLimit(item.bind.endTime)
      
      function item.bind.refreshRightPage(endTime)
        if endTime - L_TimeUtil.getServerTime() <= 0 then
        else
          self:refreshTimeLimit(endTime)
        end
      end
      
      self.bind.curshowLimit = true
    end
  end
end

function this:refreshTimeLimit(endTime)
  if self.typeId == pageType.SubTask then
    self.bind.curtxtLimit = L_TimeUtil.getLeftTimeString2(endTime)
  elseif self.typeId == pageType.Activity then
    self.bind.curtxtLimit = L_WordsTpl:getValue("ui_game_events_end_time")
  end
end

return this
