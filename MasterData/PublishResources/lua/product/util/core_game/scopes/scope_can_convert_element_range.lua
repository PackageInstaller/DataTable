require("scope_base")
_class("SkillScopeCalculator_CanConvertElementRange", SkillScopeCalculator_Base)
SkillScopeCalculator_CanConvertElementRange = SkillScopeCalculator_CanConvertElementRange

function SkillScopeCalculator_CanConvertElementRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local cross_area = utilScopeSvc:GetFullScreenCanChangeElementRange()
  local result = SkillScopeResult:New(SkillScopeType.CanConvertElementRange, centerPos, cross_area, cross_area)
  return result
end
