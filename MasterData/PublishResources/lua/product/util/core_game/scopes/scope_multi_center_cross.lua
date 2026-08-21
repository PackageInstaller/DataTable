require("scope_base")
_class("SkillScopeCalculator_MultiCenterCross", SkillScopeCalculator_Base)
SkillScopeCalculator_MultiCenterCross = SkillScopeCalculator_MultiCenterCross

function SkillScopeCalculator_MultiCenterCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local fixedAreaType = scopeParam
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  local cross_area = {}
  local wholeArea = {}
  for i, p in pairs(centerPos) do
    local cross_area_one, totalArea_one = self:CalcMultiCenterCrossList(p, scopeParam[1])
    for k, v in pairs(cross_area_one) do
      table.insert(cross_area, v)
    end
    for k, v in pairs(totalArea_one) do
      table.insert(wholeArea, v)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.MultiCenterCross, centerPos, cross_area, wholeArea)
  return result
end
