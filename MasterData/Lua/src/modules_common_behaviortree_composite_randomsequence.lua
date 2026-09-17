local this = L_BevTree:registClass("randomSequence", L_BevTree.composite)

function this:param()
end

function this:parse(data)
end

function this:onEnter()
  self.childrenOrder = {}
  for i = 1, #self.children do
    table.insert(self.childrenOrder, i)
  end
  for i = 1, #self.childrenOrder do
    local next = math.random(1, #self.children)
    local temp = self.childrenOrder[i]
    self.childrenOrder[i] = self.childrenOrder[next]
    self.childrenOrder[next] = temp
  end
  self.executedCount = 0
end

function this:execute(childResult)
  if childResult == L_BevTree.taskResult.Failure or childResult == L_BevTree.taskResult.Running then
    return childResult
  end
  return L_BevTree.taskResult.Success
end

function this:moveNext()
  if self.lastResult == L_BevTree.taskResult.Failure or self.lastResult == L_BevTree.taskResult.Running then
    return false
  end
  self.executedCount = self.executedCount + 1
  if self.executedCount > #self.childrenOrder then
    return false
  end
  self.childIndex = self.childrenOrder[self.executedCount]
  return true
end

return this
