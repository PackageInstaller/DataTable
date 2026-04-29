require("scope_base")
_class("SkillScopeCalculator_TwoScopeProgressive", SkillScopeCalculator_Base)
SkillScopeCalculator_TwoScopeProgressive = SkillScopeCalculator_TwoScopeProgressive

function SkillScopeCalculator_TwoScopeProgressive:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local scopeType1 = scopeParam[1]
  local scopeParam1 = scopeParam[2]
  local scopeType2 = scopeParam[3]
  local scopeParam2 = scopeParam[4]
  local world = self._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local cross_area = {}
  local scopeResult1 = scopeCalculator:ComputeScopeRange(scopeType1, scopeParam1, centerPos, bodyArea)
  local attackRange1 = scopeResult1:GetAttackRange()
  if attackRange1 and table.count(attackRange1) > 0 then
    local scopeResult2 = scopeCalculator:ComputeScopeRange(scopeType2, scopeParam2, attackRange1[1], bodyArea)
    local attackRange2 = scopeResult2:GetAttackRange()
    cross_area = attackRange2
  end
  local result = SkillScopeResult:New(SkillScopeType.TwoScopeProgressive, centerPos, cross_area, cross_area)
  return result
end
