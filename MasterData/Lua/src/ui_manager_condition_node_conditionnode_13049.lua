local this = class("conditionNode_13049", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local bSceneCanMount = C_MountUtil.CheckSceneCanMount()
  local isInBattle = L_BattleStore:getIsInBattle()
  local canMount = L_BattleDataManager:getIsCanMount()
  return bSceneCanMount and (not isInBattle or not not canMount)
end

return this
