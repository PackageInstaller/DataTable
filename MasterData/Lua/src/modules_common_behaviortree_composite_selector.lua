local this = L_BevTree:registClass("selector", L_BevTree.composite)

function this:onEnter()
  self.hasSuccess = false
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
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

return this
