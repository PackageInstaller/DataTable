local this = L_BevTree:registClass("baseBehaviorNode")

function this:ctor()
  self.id = 0
  self.parentId = 0
  self.nodeType = nil
  self.tree = nil
  self.param = {}
  self.treeParamsNames = nil
  self.lastExecuteTime = 0
  self.lastResult = L_BevTree.taskResult.none
  self.lastReevaluateTime = 0
  self.lastReevaluateResult = false
  self.lastExecuteReason = ""
end

function this:param()
end

function this:parse(param, paramData)
end

function this:execute(childResult)
end

function this:onEnter()
end

function this:onSuspend()
end

function this:onReset()
end

function this:onResume()
end

function this:onFinish()
end

function this:onDestroy()
end

function this:getOwner()
  return self.tree.owner
end

function this:getIsInRange(dis, angle)
  return self.tree:getIsInRange(dis, angle)
end

function this:getParam(str, isNumber)
  if self.treeParamsNames and self.treeParamsNames[str] then
    str = self.treeParamsNames[str]
  end
  local val = self.tree.param[str] or self.param[str]
  if isNumber then
    return tonumber(val)
  else
    return val
  end
end

function this:getNextSbilingTask()
  return self:getSbilingTask(self.id + 1)
end

function this:getPreSbilingTask()
  return self:getSbilingTask(self.id - 1)
end

function this:getSbilingTask(id)
  local parent = self.tree:getTask(self.parentId)
  local sbiling = self.tree:getTask(id)
  if sbiling == nil or parent == nil then
    return
  end
  sbiling = table.find(parent.children, function(v)
    return v == sbiling
  end)
  return sbiling
end

return this
