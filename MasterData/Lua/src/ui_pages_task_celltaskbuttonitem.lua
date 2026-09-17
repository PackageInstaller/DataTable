local item = class("cellTaskButtonItem", G_UIModuleBase)
local stateType = {
  complate = 1,
  lock = 2,
  select = 3,
  available = 4
}

function item.bind()
  return {
    levelLimit = "",
    levelLimitActive = false,
    childTaskName = "",
    childTaskName_selected = "",
    childTaskName_1_Active = true,
    childTaskName_2_Active = false,
    taskTraceComplete = false,
    taskTraceLock = false,
    taskTraceSelected = false,
    taskTraceAvailable = false,
    taskFinishLine = false
  }
end

function item.methods()
  return {
    onClick = function(self)
      local taskId, nodeId = L_TaskStore:getCurrentTaskID()
      if taskId == self.bind.taskId and nodeId == self.bind.nodeId then
        return
      end
      local data = {
        nodeId = self.bind.nodeId,
        levelLimit = self.bind.levelLimit,
        childTaskName = self.bind.childTaskName,
        taskId = self.bind.taskId,
        isFinish = self.bind.isFinish,
        isLast = self.bind.isLast
      }
      L_TaskStore:setCurrentTask(data.taskId, data.nodeId)
      self:emit("onClick", data)
    end
  }
end

function item:refresh()
  local taskId, nodeId = L_TaskStore:getCurrentTaskID()
  if self.bind.childTaskName ~= "" then
    self.bind.childTaskName_selected = self.bind.childTaskName
  end
  if self.bind.taskId == taskId and self.bind.nodeId == nodeId then
    self.bind.childTaskName_1_Active = false
    self.bind.childTaskName_2_Active = true
  else
    self.bind.childTaskName_1_Active = true
    self.bind.childTaskName_2_Active = false
  end
  self.bind.taskTraceComplete = stateType.complate == self.bind.state
  self.bind.taskFinishLine = self.bind.taskTraceComplete == true
  self.bind.taskTraceLock = stateType.lock == self.bind.state
  self.bind.taskTraceSelected = stateType.select == self.bind.state
  self.bind.taskTraceAvailable = stateType.available == self.bind.state
end

return item
