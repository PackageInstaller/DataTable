local this = L_BevTree:registClass("timePassed", L_BevTree.condition)

function this:param()
  self.timeWait = 1
end

function this:parse()
  self.timeWait = self:getParam("timeWait", true)
end

function this:execute()
  if self.tree.time >= self.timeWait then
    return L_BevTree.taskResult.Success
  end
  return L_BevTree.taskResult.Failure
end

return this
