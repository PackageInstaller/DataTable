local this = class("conditionNode_61002", require(L_R.condition .. "conditionNode"))
local wordsTpl = L_GameTpl:getWordsTpl()

function this.checkFunc(condition)
  if AzurWorld == nil then
    return false
  end
  return false
end

function this.descFunc(key, codData)
  return ""
end

return this
