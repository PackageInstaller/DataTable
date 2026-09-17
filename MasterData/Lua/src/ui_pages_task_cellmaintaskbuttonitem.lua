local item = class("cellMainTaskButtonItem", G_UIModuleBase)
local stateType = {
  complate = 1,
  lock = 2,
  select = 3,
  available = 4
}
local position = {
  [1] = {x = -150.3, y = -89.3},
  [2] = {x = -126.7, y = -148.1},
  [3] = {x = -103, y = -205.1}
}

function item.bind()
  return {
    childTaskName = "",
    noActive_Active = true,
    selectedActive_Active = false,
    taskTraceComplete = false
  }
end

function item.methods()
  return {
    onClick = function(self)
      local data = {
        nodeId = self.bind.nodeId,
        desc = self.bind.desc,
        childTaskName = self.bind.childTaskName,
        taskId = self.bind.taskId
      }
      L_TaskStore:setCurrentTask(data.taskId, data.nodeId)
      self:emit("onClick", data)
    end
  }
end

function item:open()
  self.bindComponents.cellTrans.anchoredPosition = C_Vector2(position[self.bind.index].x, position[self.bind.index].y)
end

function item:refresh()
  local taskId, nodeId = L_TaskStore:getCurrentTaskID()
  if self.bind.childTaskName ~= "" then
    self.bind.childTaskName_selected = self.bind.childTaskName
  end
  self.bind.taskTraceComplete = stateType.complate == self.bind.state
  if self.bind.taskTraceComplete == false then
    if self.bind.taskId == taskId and self.bind.nodeId == nodeId then
      self.bind.noActive_Active = false
      self.bind.selectedActive_Active = true
    else
      self.bind.noActive_Active = true
      self.bind.selectedActive_Active = false
    end
  else
    self.bind.noActive_Active = false
    self.bind.selectedActive_Active = false
  end
end

return item
