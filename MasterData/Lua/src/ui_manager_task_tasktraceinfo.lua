local this = class("TaskTraceInfo")
local _taskConditionTpl = L_GameTpl:getTaskConditionTpl()
local _worldMapTpl = L_GameTpl:getWorldMapTpl()
local _worldCityTpl = L_GameTpl:getWorldCityTpl()

function this:ctor(taskId, nodeId, index)
  self.taskId = taskId
  self.nodeId = nodeId
  self.index = index
  self.traceInfo = AzurWorld.TaskMgr:GetTraceInfo(self.taskId, self.nodeId, self.index)
  self.traceInfo.TaskTraceUpdateAction = handler(self, self.onTaskTraceUpdate)
  self.taskMapTriggerData = self.traceInfo.TriggerData
  self.isCondition = self.taskMapTriggerData.triggerType == L_Const.taskTraceTargetType.guide
  if self.isCondition then
    L_TimerManager:newOrResetTimer(self, "checkCondition", handler(self, self._checkCondition), 0.1, -1)
  end
end

function this:hasTrace()
  return self.traceInfo.HasTrace
end

function this:getTaskInfoData()
  return L_TaskManager:GetNodeInfoParamByIndex(self.taskId, self.nodeId, self.index)
end

function this:canTrace()
  return not self.limitText and self.traceInfo:CanTrace()
end

function this:isInScene(sceneId)
  sceneId = sceneId or 0
  return self.traceInfo:IsInScene(sceneId)
end

function this:checkHaveRelationScene(sceneId)
  sceneId = sceneId or AzurWorldInstance.CurWorldId
  local taskSceneId = self.taskMapTriggerData and self.taskMapTriggerData.sceneId
  if math.isEmpty(taskSceneId) then
    return false
  end
  local cityTpl = _worldCityTpl:getTplById(taskSceneId)
  local enterPoint = _worldCityTpl:getEnterPoint(cityTpl)
  if enterPoint[sceneId] then
    return true
  end
  return false
end

function this:getPosition(addHeight, targetSceneId)
  if not self.traceInfo or not self.taskMapTriggerData then
    return
  end
  local taskSceneId = self.taskMapTriggerData.sceneId
  if math.isEmpty(taskSceneId) then
    return
  end
  if self.isCondition and self.conditionLockIdx then
    return
  end
  targetSceneId = targetSceneId or AzurWorldInstance.CurWorldId
  if taskSceneId ~= targetSceneId then
    local cityTpl = _worldCityTpl:getTplById(taskSceneId)
    local enterPoint = _worldCityTpl:getEnterPoint(cityTpl)
    if not table.isEmpty(enterPoint) then
      for sceneId, worldMapId in pairs(enterPoint) do
        if sceneId == targetSceneId then
          local worldMapTpl = _worldMapTpl:getTplById(sceneId, worldMapId)
          return _worldMapTpl:getPosition(worldMapTpl)
        end
      end
    end
  end
  local res, x, y, z = self.traceInfo:TryGetPositionLua(addHeight)
  if res then
    return L_Vector3.new(x, y, z)
  end
end

function this:getTraceSceneText()
  if self.limitText then
    return
  end
  if self:isInScene() or self:checkHaveRelationScene() then
    return
  end
  local res = AzurWorld.TaskMgr:GetCityBorthData(self.taskMapTriggerData.sceneId, self.taskMapTriggerData.birthId, true)
  if not string.isEmpty(res) then
    return L_WordsTpl:getValue("ui_task_main_goto", {
      [0] = res
    })
  end
end

function this:_checkCondition()
  local tplCond = _taskConditionTpl:getTplById(self.taskMapTriggerData.targetId)
  local conditions = _taskConditionTpl:getGuideCondition(tplCond)
  local lockIdx
  for i, v in ipairs(conditions) do
    if not L_ConditionManager:singleIsComplete(v) then
      lockIdx = i
      break
    end
  end
  if self.conditionLockIdx ~= lockIdx then
    self.conditionLockIdx = lockIdx
    if self.conditionLockIdx then
      self.limitText = _taskConditionTpl:getGuideDesc(tplCond, self.conditionLockIdx)
    else
      self.limitText = nil
    end
    self:onTaskTraceUpdate()
  end
end

function this:dispose()
  L_TimerManager:clearTimer(self)
  if self.traceInfo then
    AzurWorld.TaskMgr:ReleaseTraceInfo(self.traceInfo)
    self.traceInfo = nil
  end
end

function this:onTaskTraceUpdate()
  L_TaskStore:call(L_TaskStore.event.refreshTask)
end

return this
