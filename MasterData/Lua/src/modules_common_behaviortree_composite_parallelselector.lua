local this = L_BevTree:registClass("parallelSelector", L_BevTree.composite)

function this:ctor()
  this.super.ctor(self)
  self.executingResults = {}
end

function this:param()
end

function this:parse()
end

function this:canRunParallelChildren()
  return true
end

function this:onEnter()
  for i, v in ipairs(self.children) do
    if self.executingResults[i] then
      self.executingResults[i] = L_BevTree.taskResult.none
    else
      table.insert(self.executingResults, L_BevTree.taskResult.none)
    end
  end
  self.hasSuccess = false
end

function this:execute(childResult)
  self.executingResults[self.childIndex] = childResult
  self.hasSuccess = self.hasSuccess or childResult == L_BevTree.taskResult.Success
  if childResult == L_BevTree.taskResult.Success then
    return L_BevTree.taskResult.Success
  end
  for _, v in ipairs(self.executingResults) do
    if v == L_BevTree.taskResult.Running then
      return L_BevTree.taskResult.Running
    end
  end
  if self.hasSuccess then
    return L_BevTree.taskResult.Success
  else
    return L_BevTree.taskResult.Failure
  end
end

function this:moveNext()
  if self.hasSuccess then
    return false
  end
  self.childIndex = self.childIndex + 1
  while self.childIndex <= #self.children and self.executingResults[self.childIndex] ~= L_BevTree.taskResult.none and self.executingResults[self.childIndex] ~= L_BevTree.taskResult.Running do
    self.childIndex = self.childIndex + 1
  end
  return self.childIndex <= #self.children
end

function this:onFinish()
  for i, v in pairs(self.children) do
    if v.lastResult == L_BevTree.taskResult.Running then
      v.lastResult = L_BevTree.taskResult.Failure
      self.tree:abort(v)
    end
  end
end

return this
