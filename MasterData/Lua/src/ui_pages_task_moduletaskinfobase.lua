local this = class("moduleTaskInfoBase", G_UIModuleBase)
local _taskTpl = L_GameTpl:getTaskTpl()
local _taskStepTpl = L_GameTpl:getTaskStepTpl()
local _taskTargetTpl = L_GameTpl:getTaskTargetTpl()

function this:showTask(typeId, playAnim)
  if self:refreshTaskByType(typeId) then
    self.gameObject:SetActive(true)
    if playAnim then
      self:playShowAnim()
    end
    self.isShow = true
  elseif playAnim then
    self.isShow = false
  else
    self:hideTask()
  end
end

function this:hideTask()
  self.isShow = false
  self.gameObject:SetActive(false)
end

function this:playShowAnim()
end

function this:refreshTaskByType(typeId)
  self.typeId = typeId
end

function this:refreshTaskTraceInfo()
end

function this:refreshTask(taskId)
  self.taskId = taskId
  local tplTask = _taskTpl:getTplById(taskId)
  if tplTask == nil then
    return
  end
  self:refreshTaskTraceInfo()
  self.nodeId = AzurWorld.TaskMgr:GetExcuteNode(taskId)
  local list = AzurWorld.TaskMgr:GetTaskNodeCommonData(taskId)
  if list.Count > 0 then
    self.bind.txtMap = AzurWorld.TaskMgr:GetCityBorthData(list[0].sceneId, list[0].birthId, true)
  else
    self.bind.txtMap = ""
  end
  self.bind.activeMap = not string.isEmpty(self.bind.txtMap)
  self.bind.txtDes = ""
  local info
  if self.nodeId then
    local infos = AzurWorld.TaskMgr:GetNodeInfoParam(self.taskId, self.nodeId)
    if infos.Count > 0 then
      info = infos[0]
    end
  end
  local tplTaskStep, sign, rewards
  if info then
    local tplTaskTarget = _taskTargetTpl:getTplById(info.conditionInfoId)
    if tplTaskTarget then
      self.stepId = _taskTargetTpl:getStepId(tplTaskTarget)
      tplTaskStep = _taskStepTpl:getTplById(self.stepId)
      if tplTaskStep then
        sign = _taskStepTpl:getSign(tplTaskStep)
        self.bind.txtDes = _taskStepTpl:getDesc(tplTaskStep)
        rewards = self:getStepRewards(self.stepId)
      else
        error("stepid:" .. tostring(self.stepId) .. "不在task_step表里 请检查一下")
      end
    else
      error("conditionInfoId:" .. tostring(info.conditionInfoId) .. "不在task_target表里 请检查一下任务编辑器和表")
    end
  else
    error("info 为空 请联系一下程序")
  end
  if string.isEmpty(sign) then
    self.bind.activeSign = false
  else
    self.bind.activeSign = true
    self.bind.txtSign = sign
  end
  local taskRewards = _taskTpl:getTaskReward(tplTask)
  if rewards and 0 < #rewards then
    self.bind.activeReward = true
    if 0 < #taskRewards then
      self.bind.activeRewardTab = true
      self.bind.activeRewardTitle = false
      self.bind.selectedRewardTabId = 1
    else
      self.bind.activeRewardTab = false
      self.bind.activeRewardTitle = true
      self.bind.txtRewardTitle = L_WordsTpl:getValue("ui_task_finishstagereward")
    end
    self:showRewards(rewards)
  elseif 0 < #taskRewards then
    self.bind.activeReward = true
    self.bind.activeRewardTab = false
    self.bind.activeRewardTitle = true
    self.bind.txtRewardTitle = L_WordsTpl:getValue("ui_task_finishtotalreward")
    self:showRewards(taskRewards)
  else
    self.bind.activeReward = false
  end
  self.bind.targetList:clear()
  if tplTaskStep then
    local infos = AzurWorld.TaskMgr:GetNodeInfoParam(taskId, self.nodeId)
    if _taskStepTpl:getIsLimitStep(tplTaskStep) then
      self.bind.activeLimit = true
      for i = 0, infos.Count - 1 do
        if not infos[i].isComplate then
          local txt = L_WordsTpl:getValue("ui_task_unlock_text")
          self.bind.txtLimit = txt .. AzurWorld.TaskMgr:GetTaskUIModule():GetTaskNodeTargetText(infos[i], false)
          break
        end
      end
    else
      self.bind.activeLimit = false
      local listDatas = L_DataUtil.getEmptyModuleDatas(infos.Count)
      for i = 1, #listDatas do
        local taskInfo = infos[i - 1]
        listDatas[i].txt_info = AzurWorld.TaskMgr:GetTaskUIModule():GetTaskNodeTargetText(taskInfo, true)
        listDatas[i].toggle_isDone = taskInfo.isComplate
        listDatas[i].isSecondary = taskInfo.isUnneed
      end
      self.bind.targetList:insert_array(listDatas)
    end
  end
  if self.parent then
    self.parent:onShowTask(taskId)
  end
  if 0 < taskId and taskId == AzurWorld.TaskMgr:GetTaskUIModule():GetNextTaskId() then
    local tpl = _taskTpl:getTplById(taskId)
    if tpl then
      self.bind.txtDes = _taskTpl:getDesc(tpl)
    end
  end
end

function this:onSelectRewardTab(tabId)
  if tabId == 1 then
    local rewards = self:getStepRewards(self.stepId)
    self:showRewards(rewards)
  elseif tabId == 2 then
    local tplTask = _taskTpl:getTplById(self.taskId)
    local rewards = _taskTpl:getTaskReward(tplTask)
    self:showRewards(rewards)
  end
end

function this:getStepRewards(stepId)
  if not stepId then
    return
  end
  local tplTaskStep = _taskStepTpl:getTplById(stepId)
  if tplTaskStep then
    return _taskStepTpl:getRewardShow(tplTaskStep)
  end
end

function this:showRewards(rewards)
  self.bind.rewardList:clear()
  if rewards == nil then
    return
  end
  local rewardData = L_DataUtil.parseRewardConfig(rewards)
  for _, v in ipairs(rewardData) do
    local itemConf = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
    v.quality = itemConf.quality
  end
  L_CommonUtil.multipleSortByKey(rewardData, {
    "quality",
    "-itemType",
    "-itemId"
  })
  self.bind.rewardList:insert_array(rewardData)
end

function this:setDefaultOpenTaskId(taskId)
end

function this:refreshTrace()
  self:refreshTaskTraceInfo()
end

return this
