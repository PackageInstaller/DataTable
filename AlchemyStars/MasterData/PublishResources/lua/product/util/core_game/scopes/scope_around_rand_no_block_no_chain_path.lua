require("scope_base")
_class("SkillScopeCalculator_AroundRandNoBlockNoChainPath", SkillScopeCalculator_Base)
SkillScopeCalculator_AroundRandNoBlockNoChainPath = SkillScopeCalculator_AroundRandNoBlockNoChainPath

function SkillScopeCalculator_AroundRandNoBlockNoChainPath:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local attackRange = {}
  local wholeRange = {}
  if centerPos then
    table.insert(attackRange, centerPos)
    table.insert(wholeRange, centerPos)
  end
  return SkillScopeResult:New(SkillScopeType.AroundRandNoBlockNoChainPath, centerPos, attackRange, wholeRange)
end
