require("scope_base")
_class("SkillScopeCalculator_AngleFreeLineFormMonstersToTarget", SkillScopeCalculator_Base)
SkillScopeCalculator_AngleFreeLineFormMonstersToTarget = SkillScopeCalculator_AngleFreeLineFormMonstersToTarget

function SkillScopeCalculator_AngleFreeLineFormMonstersToTarget:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  self._world = self._gridFilter._world
  local bNoExtend = scopeParam.noExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local monsterClassIDs = scopeParam.monsterClassIDs or {}
  local targetMonstersList = {}
  local monsterEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for i, entity in ipairs(monsterEntityList) do
    local curMonsterClassID = entity:MonsterID():GetMonsterClassID()
    if not entity:HasDeadMark() and table.icontains(monsterClassIDs, curMonsterClassID) then
      table.insert(targetMonstersList, entity)
    end
  end
  local utilScope = self._world:GetService("UtilScopeCalc")
  local attackRange = {}
  local wholeRange = {}
  local pickupDestPos = centerPos
  for i, entity in ipairs(targetMonstersList) do
    local curAttackRange = {}
    local curWholeRange = {}
    local pickupInitPos = entity:GetGridPosition()
    utilScope:P2PAngleFreeLineRange(pickupInitPos, pickupDestPos, curAttackRange, curWholeRange, bNoExtend, widthThreshold)
    table.appendArray(attackRange, curAttackRange)
    table.appendArray(wholeRange, curWholeRange)
  end
  return SkillScopeResult:New(SkillScopeType.AngleFreeLineFormMonstersToTarget, centerPos, attackRange, wholeRange)
end
