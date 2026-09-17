local this = class("moduleMapTaskInfo", G_UIModuleBase)
local _taskTpl = L_GameTpl:getTaskTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local _mapNodeTpl = L_GameTpl:getMapNodeTpl()
local _taskStepTpl = L_GameTpl:getTaskStepTpl()
local _taskTargetTpl = L_GameTpl:getTaskTargetTpl()
local _worldAreaTpl = L_GameTpl:getWorldAreaTpl()

local function toLuaNumber(value)
  if value == nil then
    return nil
  end
  local num = tonumber(value)
  if num ~= nil then
    return num
  end
  local success, result = pcall(CS.System.Convert.ToInt32, value)
  if success then
    return result
  end
  return value
end

local function getTaskSubmitRewardDesc(submitData)
  local conditionInfoId = toLuaNumber(submitData.conditionInfoId) or submitData.conditionInfoId
  local tplTaskTarget = _taskTargetTpl:getTplById(conditionInfoId)
  if tplTaskTarget then
    return _taskTargetTpl:getDesc(tplTaskTarget)
  end
  return ""
end

local function getTaskSubmitRewardGroup(taskId, nodeId, infos)
  if infos == nil or infos.Count <= 0 then
    return nil
  end
  for i = 0, infos.Count - 1 do
    local info = infos[i]
    local commonData = AzurWorld.TaskMgr:GetTaskNodeCommonData(taskId, nodeId, info.index)
    local targetId = commonData and (toLuaNumber(commonData.targetId) or commonData.targetId) or 0
    if targetId and targetId ~= 0 then
      local submitData = AzurWorld.TaskMgr:GetTaskSubmitEventData(taskId, nodeId, targetId)
      if submitData and submitData.itemDatas and 0 < submitData.itemDatas.Count then
        local reward = {}
        local itemType = toLuaNumber(submitData.itemBigType) or submitData.itemBigType
        for j = 0, submitData.itemDatas.Count - 1 do
          local itemData = submitData.itemDatas[j]
          local itemId = itemData and (toLuaNumber(itemData.itemId) or itemData.itemId) or 0
          local itemCount = itemData and (toLuaNumber(itemData.count) or itemData.count) or 0
          if itemData and itemId ~= 0 and 0 < itemCount then
            local itemHasNum = toLuaNumber(L_ItemTplManager:getItemNum(itemType, itemId)) or 0
            table.insert(reward, {
              [1] = itemType,
              [2] = itemId,
              [3] = itemCount,
              itemNumTxt = string.format("%d/%d", itemHasNum, itemCount)
            })
          end
        end
        if not table.isEmpty(reward) then
          return {
            desc = getTaskSubmitRewardDesc(submitData),
            reward = reward
          }
        end
      end
    end
  end
  return nil
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    icon = "",
    iconBg = "",
    iconBgActive = false,
    name = "",
    desc = "",
    txt_trace = "",
    show_desc = true,
    taskTarget = "",
    mapAreaName = "",
    rewardGroupList = {
      moduleName = "pages/map/bigMap/cellRewardGroupInfo"
    },
    taskInfoList = {
      moduleName = "pages/map/bigMap/cellMapTaskInfo"
    },
    isTraced = false,
    trace = true,
    smallGoto = true,
    longGoto = true
  }
end

function this.methods()
  return {
    onClick_trace = function(self)
      if AzurWorld.TaskMgr:GetIsTraceTask(self.node.id) then
        L_TaskStore:disposeTraceTask(self.node.id)
      else
        L_TaskStore:setTraceTask(self.node.id)
      end
    end,
    onClick_goto = function(self)
      self.parent:teleportNodeLogic()
    end,
    onClick_LongGoto = function(self)
      self.parent:teleportNodeLogic()
    end
  }
end

function this:open()
  self.refreshButtonStateFunc = self.refreshButtonStateFunc or handler(self, self.refreshButtonState)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.refreshButtonStateFunc)
end

function this:close()
  if self.refreshButtonStateFunc then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.SetCurrentTracedTask, self.refreshButtonStateFunc)
  end
end

function this:initModule(node)
  self.node = node
  self.bind.icon = node.iconPath
  if node.iconBg and type(node.iconBg) == "string" and string.len(node.iconBg) > 0 then
    self.bind.iconBgActive = true
    self.bind.iconBg = node.iconBg
  else
    self.bind.iconBgActive = false
  end
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.desc = node.desc
  self.bind.name = node.name
  local sceneTpl = _worldCityTpl:getTplById(node.sceneId)
  self.bind.mapAreaName = node.mapAreaName
  if self.bind.show_desc then
    L_GameUtil.forceRebuildLayout(self.bindComponents.rect_desc)
  end
  if node.id then
    local data = {}
    local taskNodeId = AzurWorld.TaskMgr:GetExcuteNode(node.id)
    local stepId = AzurWorld.TaskMgr:GetTaskStepId(node.id, taskNodeId)
    local tplTaskStep = _taskStepTpl:getTplById(stepId)
    local infos = AzurWorld.TaskMgr:GetNodeInfoParam(node.id, taskNodeId)
    if tplTaskStep then
      self.bind.desc = _taskStepTpl:getDesc(tplTaskStep)
      local reward = _taskStepTpl:getRewardShow(tplTaskStep)
      if not table.isEmpty(reward) then
        table.insert(data, {
          desc = L_WordsTpl:getValue("ui_period_13"),
          reward = _taskStepTpl:getRewardShow(tplTaskStep)
        })
      end
    end
    local submitRewardGroup = getTaskSubmitRewardGroup(node.id, taskNodeId, infos)
    if submitRewardGroup then
      table.insert(data, 1, submitRewardGroup)
    end
    local taskData = _taskTpl:getTplById(node.id)
    local curReward = _taskTpl:getTaskReward(taskData)
    if not table.isEmpty(curReward) then
      table.insert(data, {
        desc = L_WordsTpl:getValue("ui_period_14"),
        reward = curReward
      })
    end
    self.bind.rewardGroupList:clear()
    self.bind.rewardGroupList:insert_array(data)
    local taskInfo = {}
    if infos and 0 < infos.Count then
      for i = 0, infos.Count - 1 do
        local tips = AzurWorld.TaskMgr:GetTaskUIModule():GetTaskNodeTargetText(infos[i], true)
        local isDone = infos[i].isComplate
        local isSecondary = infos[i].isUnneed
        local _, colorUndone, colorDone
        _, colorUndone = C_ColorUtility.TryParseHtmlString("#ffa200")
        _, colorDone = C_ColorUtility.TryParseHtmlString("#ffa200")
        if isDone then
          local colorStr = isSecondary and "#8fb9b9" or "#ffa200"
          _, colorDone = C_ColorUtility.TryParseHtmlString(colorStr)
        else
          local colorStr = isSecondary and "#bad2d1" or "#fdd275"
          _, colorUndone = C_ColorUtility.TryParseHtmlString(colorStr)
        end
        table.insert(taskInfo, {
          desc = isDone and string.format("<s>%s</s>", tips) or tips,
          color_undone = colorUndone,
          color_done = colorDone,
          go_undone = not isDone,
          go_done = isDone
        })
      end
    end
    self.bind.taskInfoList:clear()
    if 0 < #taskInfo then
      self.bind.taskInfoList:insert_array(taskInfo)
    end
    self:refreshButtonState()
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.taskListTrans)
  L_GameUtil.forceRebuildLayout(self.bindComponents.infoTrans)
end

function this:refreshButtonState(_, args)
  local taskTpl = L_GameTpl:getTaskTpl()
  local tpl = taskTpl:getTplById(self.node.id)
  local taskType = taskTpl:getType(tpl)
  if taskType == L_Const.taskType.guide then
    self.bind.isTraced = true
    self.bind.trace = false
    self.bind.smallGoto = true
    self.bind.longGoto = false
  else
    if taskType == L_Const.taskType.main then
      self.bind.isTraced = false
      self.bind.trace = false
      self.bind.smallGoto = false
      self.bind.longGoto = true
    else
      self.bind.isTraced = false
      self.bind.trace = true
      self.bind.smallGoto = true
      self.bind.longGoto = false
    end
    local isCurTracdTask = AzurWorld.TaskMgr:GetIsTraceTask(self.node.id)
    if isCurTracdTask then
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_05")
    else
      self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
    end
  end
end

return this
