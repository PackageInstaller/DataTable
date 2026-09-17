local this = L_BevTree:registClass("guide.waitPlayerOutOfTheWar", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:onEnter()
end

function this:execute()
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    return L_BevTree.taskResult.Running
  else
    return L_BevTree.taskResult.Success
  end
end

return this
