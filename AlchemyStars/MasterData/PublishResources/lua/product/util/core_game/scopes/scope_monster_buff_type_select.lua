require("scope_base")
_class("SkillScopeCalculator_MonsterBuffTypeSelect", SkillScopeCalculator_Base)
SkillScopeCalculator_MonsterBuffTypeSelect = SkillScopeCalculator_MonsterBuffTypeSelect

function SkillScopeCalculator_MonsterBuffTypeSelect:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local buffEffectType = scopeParam[1]
  local have = scopeParam[2] or 1
  local monsterList, monsterPosList = self._gridFilter:SelectMonsterWithBuff(buffEffectType, casterEntity, have)
  local monsterIds = {}
  for key, monster in pairs(monsterList) do
    if monster:HasMonsterID() then
      table.insert(monsterIds, monster:MonsterID():GetMonsterID())
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.MonsterBuffTypeSelect, casterPos, monsterPosList, monsterPosList, monsterIds)
  return result
end
