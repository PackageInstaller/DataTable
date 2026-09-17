local this = L_BevTree:registClass("random", L_BevTree.composite)

function this:param()
  self.executeNumber = 1
end

function this:parse()
  self.executeNumber = self:getParam("executeNumber", true)
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
  self.executeNumber = math.min(#self.children, self.executeNumber)
end

function this:execute(childResult)
  if childResult == L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Running
  end
  if childResult == L_BevTree.taskResult.Failure then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Success
end

function this:moveNext()
  if self.lastResult == L_BevTree.taskResult.Failure or self.lastResult == L_BevTree.taskResult.Running then
    return false
  end
  self.executedCount = self.executedCount + 1
  if self.executedCount > self.executeNumber then
    return false
  end
  self.childIndex = self.childrenOrder[self.executedCount]
  return true
end

return this
