local this = L_BevTree:registClass("_inverter", L_BevTree.composite)

function this:param()
end

function this:parse(data)
end

function this:onEnter()
  self.hasSuccess = false
end

function this:execute(childResult)
  if childResult == L_BevTree.taskResult.Success then
    return L_BevTree.taskResult.Failure
  end
  if childResult == L_BevTree.taskResult.Failure then
    return L_BevTree.taskResult.Success
  end
  return childResult
end

return this
