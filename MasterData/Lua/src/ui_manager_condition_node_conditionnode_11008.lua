local this = class("conditionNode_11008", require(L_R.condition .. "conditionNode"))
local _homeScienceTpl = L_GameTpl.getHomeScienceTpl()

function this.checkFunc(condition)
  local scienceId = condition[2]
  return false
end

function this.descFunc(key, codData)
  local homeScienceTpl = _homeScienceTpl:getTplById(codData[2])
  local name = _homeScienceTpl:getObjName(homeScienceTpl)
  return L_Lang:get(key, {sciencename = name})
end

return this
