local this = class("conditionNode_11011", require(L_R.condition .. "conditionNode"))
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()

function this.checkFunc(condition)
  local techTreeId = condition[2]
  local techTreeLevel = condition[3]
  local level = L_TechnologyStore:getCurTechnologyMaxLevelById(techTreeId)
  return techTreeLevel <= level
end

function this.descFunc(key, codData)
  local techTreeId = codData[2]
  local techTreeLevel = codData[3]
  local techTreeTpl = _homeTechnologyTreeTpl:getTplById(techTreeId)
  local name = _homeTechnologyTreeTpl:getName(techTreeTpl)
  return L_Lang:get(key, {techType = name, level = techTreeLevel})
end

return this
