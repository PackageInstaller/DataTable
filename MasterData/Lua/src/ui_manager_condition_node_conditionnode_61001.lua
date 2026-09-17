local this = class("conditionNode_61001", require(L_R.condition .. "conditionNode"))
local _nationsTpl = L_GameTpl:getGroupsTpl()

function this.checkFunc(condition)
  local forceData = L_ReputationStore:getDataById(condition[2])
  if forceData == nil then
    return false
  end
  return forceData.level >= condition[3]
end

function this.descFunc(key, codData)
  local forceName = _nationsTpl:getName(_nationsTpl:getTplById(codData[2]))
  local forceLv = codData[3]
  return L_Lang:get(key, {name = forceName, lv = forceLv})
end

return this
