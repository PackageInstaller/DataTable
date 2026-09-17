local this = class("conditionNode_11010", require(L_R.condition .. "conditionNode"))
local _homeTechnologyTypeTpl = L_GameTpl:getHomeTechnologyTypeTpl()

function this.checkFunc(condition)
  local techType = condition[2]
  local techTypeLevel = condition[3]
  local techTypeInfo = L_TechnologyStore:getTechTypeInfo(techType)
  if not techTypeInfo then
    return true
  end
  return techTypeLevel <= techTypeInfo.level
end

function this.descFunc(key, codData)
  local techType = codData[2]
  local techTypeLevel = codData[3]
  local tplTechnologyType = _homeTechnologyTypeTpl:getTplById(techType)
  local name = _homeTechnologyTypeTpl:getTechnologyName(tplTechnologyType)
  return L_Lang:get(key, {techName = name, level = techTypeLevel})
end

return this
