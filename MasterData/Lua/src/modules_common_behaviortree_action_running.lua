local this = L_BevTree:registClass("running", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:execute()
  return L_BevTree.taskResult.Running
end

return this
