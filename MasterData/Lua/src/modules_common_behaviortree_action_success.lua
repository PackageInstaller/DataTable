local this = L_BevTree:registClass("success", L_BevTree.action)

function this:param()
end

function this:parse(data)
end

function this:execute(lastResult)
  return L_BevTree.taskResult.Success
end

return this
