local this = class("behaviorTree")

function this:ctor(entity)
  self.owner = entity
  self.param = {}
  self.enabled = true
  self.lastUpdateFrame = 0
  self.time = 0
  self.timeScale = 0
  self.currentFrame = 0
  self.isFinish = false
  self.onTaskUpdateHandler = nil
  self.tasks = {}
end

function this:initialize(jsonData, paramData)
  local data = L_Json.decode(jsonData)
  if table.isEmpty(data) then
    return
  end
  if paramData then
    self.param = paramData
  end
  for i, v in pairs(data.tasks) do
    local cls = L_BevTree:getClass(v.className)
    cls.id = i
    cls.taskType = v.taskType
    cls.lastResult = L_BevTree.taskResult.none
    cls.isReevaluating = false
    cls.lastExecuteTime = 0
    cls.abortableSiblings = v.abortableSiblings
    cls.tree = self
    cls.param = v.param
    cls.className = v.className
    if not table.isEmpty(v.treeParamsNames) then
      cls.treeParamsNames = v.treeParamsNames
    end
    if cls.taskType == L_BevTree.taskType.composite then
      cls.childIndex = -1
      cls.abortType = v.abortType
    end
    cls:parse()
    table.insert(self.tasks, cls)
  end
  for i, v in pairs(self.tasks) do
    local taskData = data.tasks[i]
    if taskData.children then
      for _, cIndex in pairs(taskData.children) do
        local child = self:getTask(cIndex + 1)
        child.parentId = v.id
        table.insert(v.children, self.tasks[cIndex + 1])
      end
    end
  end
  self.time = 0
end

function this:suspend()
end

function this:resume()
end

function this:setOwner(owner)
  self.owner = owner
end

function this:onUpdate(timeScale)
  if not self.enabled or self.isFinish then
    return
  end
  self.timeScale = timeScale or C_Time.deltaTime
  self.time = self.time + self.timeScale
  self.currentFrame = self.currentFrame + 1
  local result = self:run(self:getRootTask())
  self.isFinish = result ~= L_BevTree.taskResult.Running
end

function this:onReset()
  for i, v in ipairs(self.tasks) do
    v:onReset()
  end
end

function this:onDestroy()
  for _, v in pairs(self.tasks) do
    v:onDestroy()
  end
end

function this:run(task)
  if task == nil then
    return
  end
  if task.lastResult ~= L_BevTree.taskResult.Running then
    task:onEnter()
  end
  if task.taskType == L_BevTree.taskType.composite then
    self:run_composite(task)
  elseif task.taskType == L_BevTree.taskType.decorator then
    self:run_decorator(task)
  else
    self:run_leaf(task)
  end
  if task.lastResult ~= L_BevTree.taskResult.Running then
    task:onFinish()
  end
  return task.lastResult
end

function this:run_composite(task)
  if task.lastResult ~= L_BevTree.taskResult.Running or task:canRunParallelChildren() then
    task.childIndex = 0
    task:moveNext()
    if task.childIndex > #task.children then
      return
    end
  elseif (task.abortType == L_BevTree.abortType.selfAbort or task.abortType == L_BevTree.abortType.both) and self:reevaluate(task, L_BevTree.abortType.selfAbort) then
    self:abort(task)
    return L_BevTree.taskResult.Abort
  end
  task.lastResult = L_BevTree.taskResult.none
  repeat
    if task:canRunChildren() == true then
      local child = task:getCurChild()
      if child.lastResult == L_BevTree.taskResult.Running and child.abortableSiblings then
        local abortSiblingIndex = -1
        for _, v in ipairs(child.abortableSiblings) do
          if self:reevaluate(task.children[v + 1], L_BevTree.abortType.lowerPriority) then
            abortSiblingIndex = v + 1
            break
          end
        end
        if 0 <= abortSiblingIndex then
          self:abort(child)
          task.childIndex = abortSiblingIndex
          child = task.children[abortSiblingIndex]
        end
      end
      local childResult = self:run(child)
      task.lastResult = task:execute(childResult)
    end
  until not task:moveNext()
  self:taskStatus(task)
end

function this:run_decorator(task)
  local childResult = self:run(task.children[1])
  if childResult == L_BevTree.taskResult.Running then
    task.lastResult = childResult
  else
    task.lastResult = task:execute(childResult)
  end
  self:taskStatus(task)
end

function this:run_leaf(task)
  task.lastExecuteReason = ""
  task.lastResult = task:execute(task.lastResult)
  self:taskStatus(task)
end

function this:abort(task)
  if task.lastResult == L_BevTree.taskResult.Running then
    task.lastResult = L_BevTree.taskResult.Abort
  end
  if task.children then
    for _, child in ipairs(task.children) do
      if child.lastResult == L_BevTree.taskResult.Running then
        self:abort(child)
      end
    end
  end
  task:onFinish()
end

function this:reevaluate(task, abortType)
  if task.lastReevaluateTime == self.currentFrame then
    return task.lastReevaluateTime
  end
  if task.taskType == L_BevTree.taskType.composite then
    if task.abortType == L_BevTree.abortType.none then
      return false
    end
    if task.abortType ~= L_BevTree.abortType.both and task.abortType ~= abortType then
      return false
    end
    for _, child in ipairs(task.children) do
      if child.taskType == L_BevTree.taskType.action then
        if child.lastResult == L_BevTree.taskResult.Running then
          task.lastReevaluateResult = false
          break
        end
      elseif child.taskType == L_BevTree.taskType.composite and child.abortType ~= task.abortType and child.abortType ~= L_BevTree.abortType.both then
      else
        task.lastReevaluateResult = self:reevaluate(child, abortType)
        if task.lastReevaluateResult then
          break
        end
      end
    end
  elseif task.taskType == L_BevTree.taskType.decorator then
    local finalChild = task.children[1]
    while finalChild.taskType == L_BevTree.taskType.decorator do
      finalChild = finalChild.children[1]
    end
    if finalChild.taskType == L_BevTree.taskType.composite then
      if finalChild.abortType == L_BevTree.abortType.none then
        return false
      elseif finalChild.abortType ~= L_BevTree.abortType.both and finalChild.abortType ~= abortType then
        return false
      end
    end
    local child = task.children[1]
    local result = self:reevaluate(child, abortType)
    task.lastReevaluateResult = result
  elseif task.taskType == L_BevTree.taskType.condition then
    local lastResult = task.lastResult
    task:onEnter()
    local result = task:execute(lastResult)
    task.lastResult = result
    task.lastReevaluateResult = lastResult ~= L_BevTree.taskResult.none and lastResult ~= result
  else
    printf(self:getName(), "行为树错误:不应评估action节点")
  end
  self:taskReevaluateStatus(task)
  return task.lastReevaluateResult
end

function this:taskStatus(task)
  task.lastExecuteTime = Unity.Time.time
  if self.onTaskUpdateHandler then
    self.onTaskUpdateHandler(task.id)
  end
end

function this:taskReevaluateStatus(task)
  task.lastReevaluateTime = Unity.Time.time
  if self.onTaskUpdateHandler then
    self.onTaskUpdateHandler(task.id)
  end
end

function this:getTask(id)
  return self.tasks[id]
end

function this:getRootTask()
  return self:getTask(1)
end

function this:getIsInRange(dis, angle)
  local owner = self.owner:getTransform()
  local target = self.owner:getTarget():getTransform()
  return L_GameUtil.getIsInRange(owner, target, dis, angle)
end

function this:sqrDisWithTarget()
  local v1 = L_Vector3.getPos(self.owner:getTransform())
  local v2 = L_Vector3.getPos(self.owner:getTarget():getTransform())
  local sqrDis = L_Vector3.sqrDistance(v1, v2)
  return sqrDis
end

function this:getAngle()
  local selfPos = owner.position
  selfPos.y = 0
  local tarPos = target.forward
  tarPos.y = 0
  local angle = C_Vector3.Angle(selfPos, tarPos)
  return angle
end

return this
