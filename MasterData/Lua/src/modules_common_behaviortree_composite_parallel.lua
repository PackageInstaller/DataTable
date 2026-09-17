local this = L_BevTree:registClass("parallel", L_BevTree.composite)

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
  self.childIndex = 0
  self.hasFailure = false
end

function this:execute(childResult)
  self.executingResults[self.childIndex] = childResult
  if childResult == L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Running
  end
  self.hasFailure = self.hasFailure or childResult == L_BevTree.taskResult.Failure
  for _, v in ipairs(self.executingResults) do
    if v == L_BevTree.taskResult.Running then
      return L_BevTree.taskResult.Running
    end
  end
  if self.hasFailure then
    return L_BevTree.taskResult.Failure
  else
    return L_BevTree.taskResult.Success
  end
end

function this:moveNext()
  self.childIndex = self.childIndex + 1
  while self.childIndex <= #self.children and self.executingResults[self.childIndex] ~= L_BevTree.taskResult.none and self.executingResults[self.childIndex] ~= L_BevTree.taskResult.Running do
    self.childIndex = self.childIndex + 1
  end
  return self.childIndex <= #self.children
end

return this
