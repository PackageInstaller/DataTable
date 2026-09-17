local this = L_BevTree:registClass("returnFailure", L_BevTree.decorator)

function this:param()
end

function this:parse(data)
end

function this:onEnter()
  self.hasSuccess = false
end

function this:execute(childResult)
  if childResult ~= L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Failure
  else
    return L_BevTree.taskResult.Running
  end
end

return this
