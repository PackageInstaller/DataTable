require("scope_base")
_class("SkillScopeCalculator_AllMonster", SkillScopeCalculator_Base)
SkillScopeCalculator_AllMonster = SkillScopeCalculator_AllMonster

function SkillScopeCalculator_AllMonster:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local monsterList, monsterPosList = self._gridFilter:SelectAllMonster(casterEntity)
  local ids = {}
  for _, m in pairs(monsterList) do
    ids[#ids + 1] = m:GetID()
  end
  local result = SkillScopeResult:New(SkillScopeType.AllMonster, centerPos, monsterPosList, monsterPosList, ids)
  return result
end
