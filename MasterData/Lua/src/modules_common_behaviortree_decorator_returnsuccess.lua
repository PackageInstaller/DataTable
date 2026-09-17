local this = L_BevTree:registClass("returnSuccess", L_BevTree.decorator)

function this:param()
end

function this:parse(data)
end

function this:onEnter()
  self.hasSuccess = false
end

function this:execute(childResult)
  if childResult ~= L_BevTree.taskResult.Running then
    return L_BevTree.taskResult.Success
  else
    return L_BevTree.taskResult.Running
  end
end

return this
