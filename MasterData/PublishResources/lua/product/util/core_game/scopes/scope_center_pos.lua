require("scope_base")
_class("SkillScopeCalculator_CenterPos", SkillScopeCalculator_Base)
SkillScopeCalculator_CenterPos = SkillScopeCalculator_CenterPos

function SkillScopeCalculator_CenterPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeList = {}
  if centerPos then
    if #centerPos == 0 then
      scopeList = {centerPos}
    else
      scopeList = centerPos
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CenterPos, centerPos, scopeList, scopeList)
  return result
end
