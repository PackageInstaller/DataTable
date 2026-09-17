local this = class("conditionNode_12098", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local checkResult = AzurWorld.ConditionMgr:SafeQuickCheckByLua(condition) or false
  return checkResult
end

return this
