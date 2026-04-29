require("scope_base")
_class("SkillScopeCalculator_FirstCenterPos", SkillScopeCalculator_Base)
SkillScopeCalculator_FirstCenterPos = SkillScopeCalculator_FirstCenterPos

function SkillScopeCalculator_FirstCenterPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeList = {}
  if centerPos then
    if #centerPos == 0 then
      scopeList = {centerPos}
    else
      scopeList = {
        centerPos[1]
      }
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FirstCenterPos, centerPos, scopeList, scopeList)
  return result
end
