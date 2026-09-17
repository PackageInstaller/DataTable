local this = L_BevTree:registClass("repeater", L_BevTree.decorator)

function this:param()
  self.repeatCount = -1
  self.repeatUntilFailure = 0
end

function this:parse()
  self.repeatCount = self:getParam("repeatCount", true)
  self.repeatUntilFailure = self:getParam("repeatUntilFailure") == "1"
end

function this:onEnter()
  self.executedCount = 0
end

function this:execute(childResult)
  if childResult == L_BevTree.taskResult.Failure and self.repeatUntilFailure then
    return L_BevTree.taskResult.Success
  end
  if self.repeatCount == -1 then
    return L_BevTree.taskResult.Running
  else
    if childResult == L_BevTree.taskResult.Success then
      self.executedCount = self.executedCount + 1
    end
    if self.repeatCount == 0 or self.executedCount < self.repeatCount then
      return L_BevTree.taskResult.Running
    end
    return L_BevTree.taskResult.Success
  end
end

return this
