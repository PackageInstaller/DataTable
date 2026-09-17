local this = L_BevTree:registClass("guide.kiboSummonEnable", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:onEnter()
  CS.Lens.Gameplay.Modules.BigWorld.KiboDuelAPI.SetSummonEnable(true)
end

function this:execute()
  return L_BevTree.taskResult.Success
end

return this
