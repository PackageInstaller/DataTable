local this = L_BevTree:registClass("sequencer", L_BevTree.composite)

function this:param()
end

function this:parse(data)
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
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

return this
