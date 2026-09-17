local this = class("conditionNode_11009", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local targetHomeLevel = condition[2]
  local curHomeLevel = AzurWorld.HomeMgr:OnGetHomeLevel()
  return targetHomeLevel <= curHomeLevel
end

function this.descFunc(key, codData)
  local targetHomeLevel = codData[2]
  return L_Lang:get(key, {value = targetHomeLevel})
end

return this
