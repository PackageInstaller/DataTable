require("scope_base")
_class("SkillScopeCalculator_Nearest", SkillScopeCalculator_Base)
SkillScopeCalculator_Nearest = SkillScopeCalculator_Nearest

function SkillScopeCalculator_Nearest:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local target_pos = centerPos
  local limit = scopeParam
  local monsterList, monsterPosList = self._gridFilter:SelectNearestMonsterOnPos(target_pos, limit)
  local ids = {}
  for _, m in pairs(monsterList) do
    ids[#ids + 1] = m:GetID()
  end
  local result = SkillScopeResult:New(SkillScopeType.Nearest, target_pos, monsterPosList, monsterPosList, ids)
  return result
end
