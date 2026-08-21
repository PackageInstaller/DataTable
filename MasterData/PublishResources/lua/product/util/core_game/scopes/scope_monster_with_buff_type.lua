require("scope_base")
_class("SkillScopeCalculator_MonsterWithBuffType", SkillScopeCalculator_Base)
SkillScopeCalculator_MonsterWithBuffType = SkillScopeCalculator_MonsterWithBuffType

function SkillScopeCalculator_MonsterWithBuffType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local monsterList, monsterPosList = self._gridFilter:SelectMonsterWithBuff(scopeParam, casterEntity, 1)
  local monsterIds = {}
  for key, monster in pairs(monsterList) do
    if monster:HasMonsterID() then
      table.insert(monsterIds, monster:MonsterID():GetMonsterID())
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.MonsterWithBuffType, casterPos, monsterPosList, monsterPosList, monsterIds)
  return result
end
