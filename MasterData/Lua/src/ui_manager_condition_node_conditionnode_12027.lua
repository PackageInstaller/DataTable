local this = class("conditionNode_12027", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local num = L_HomeStore:getBuildingUseNumByGroupId(condition[2])
  return num >= condition[3]
end

return this
