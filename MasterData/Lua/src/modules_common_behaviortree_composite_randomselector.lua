local this = L_BevTree:registClass("randomSelector", L_BevTree.composite)

function this:onEnter()
  self.hasSuccess = false
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
  if childResult == L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Running
  elseif childResult == L_BevTree.taskResult.Success then
    self.hasSuccess = true
  elseif childResult == L_BevTree.taskResult.Abort and self.childIndex == #self.children then
    self.hasSuccess = true
  end
  if self.hasSuccess then
    return L_BevTree.taskResult.Success
  else
    return L_BevTree.taskResult.Failure
  end
end

function this:moveNext()
  if self.hasSuccess or self.lastResult == L_BevTree.taskResult.Running then
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
