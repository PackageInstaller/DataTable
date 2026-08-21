require("scope_base")
_class("SkillScopeCalculator_NRowMColSpread", SkillScopeCalculator_Base)
SkillScopeCalculator_NRowMColSpread = SkillScopeCalculator_NRowMColSpread

function SkillScopeCalculator_NRowMColSpread:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local targetArea, wholeArea = self:_CalcNRowMColSpread(scopeParam, centerPos, bodyArea)
  local sortScopeUseCasterDir = scopeParam[4]
  if sortScopeUseCasterDir == 1 then
    local world = self._gridFilter._world
    local utilScopeSvc = world:GetService("UtilScopeCalc")
    targetArea = utilScopeSvc:SortScopeRangeWithDir(targetArea, casterDir)
    wholeArea = utilScopeSvc:SortScopeRangeWithDir(wholeArea, casterDir)
  end
  local result = SkillScopeResult:New(SkillScopeType.NRowsMColumns, centerPos, targetArea, wholeArea)
  return result
end
