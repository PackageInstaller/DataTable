local this = class("conditionNode_13122", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local versionId = condition[2]
  local curVersion = L_GameTpl:getGameConstTpl():getData("CONDITION_VERSION_COMPARE", L_Const.GameTplType.float)
  return versionId <= curVersion
end

return this
