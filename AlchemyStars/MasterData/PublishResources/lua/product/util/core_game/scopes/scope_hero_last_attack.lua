require("scope_base")
_class("SkillScopeCalculator_HeroLastAttack", SkillScopeCalculator_Base)
SkillScopeCalculator_HeroLastAttack = SkillScopeCalculator_HeroLastAttack

function SkillScopeCalculator_HeroLastAttack:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local e = casterEntity
  local battleStatComponent = self._gridFilter._world:BattleStat()
  local t = battleStatComponent:GetHeroLastAttackMonster()
  if t then
    local targetId = t[1]
    local targetPos = t[2]
    local result = SkillScopeResult:New(SkillScopeType.HeroLastAttackMonster, centerPos, {targetPos}, {targetPos}, {targetId})
    return result
  end
end
