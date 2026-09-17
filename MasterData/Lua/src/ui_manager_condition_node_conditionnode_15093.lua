local this = class("conditionNode_15093", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local curState = L_GuideStore:checkConditionEnabled(condition[1]) and 1 or 0
  return condition[2] == curState
end

return this
