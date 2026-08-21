require("scope_base")
_class("SkillScopeCalculator_QierMonsterRoundRandom", SkillScopeCalculator_Base)
SkillScopeCalculator_QierMonsterRoundRandom = SkillScopeCalculator_QierMonsterRoundRandom

function SkillScopeCalculator_QierMonsterRoundRandom:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if not self._gridFilter._world then
    return SkillScopeResult:New(SkillScopeType.QierMonsterRoundRandom, centerPos, {}, {})
  end
  local ringLength = scopeParam.ringLength
  local aroundBodyAreaLength = scopeParam.aroundBodyAreaLength
  local attackRange = {}
  local wholeRange = {}
  local damageResults = {}
  local world = self._gridFilter._world
  local skillResultContainer = casterEntity:SkillContext():GetResultContainer()
  if not skillResultContainer then
    return SkillScopeResult:New(SkillScopeType.QierMonsterRoundRandom, centerPos, {}, {})
  end
  damageResults = skillResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local monsterIDs = {}
  for _, result in ipairs(damageResults) do
    local targetID = result:GetTargetID()
    if targetID ~= -1 then
      table.insert(monsterIDs, targetID)
    end
  end
  local tSkipPos = {casterPos}
  local aroundCalc = SkillScopeCalculator_AroundBodyArea:New(self._hub)
  for _, id in ipairs(monsterIDs) do
    local e = world:GetEntityByID(id)
    local monsterCenterPos = e:GetGridPosition()
    local monsterBodyArea = e:BodyArea():GetArea()
    local monsterDir = e:GetGridDirection()
    local aroundScopeResult = aroundCalc:CalcRange(SkillScopeType.AroundBodyArea, {0, aroundBodyAreaLength}, monsterCenterPos, monsterBodyArea, monsterDir, SkillTargetType.Board, casterPos, casterEntity)
    local range = aroundScopeResult:GetAttackRange()
    if range and 0 < #range then
      local tEmptyPos = self._gridFilter:GetEmptyPieces(range)
      local pool = {}
      for _, v2 in ipairs(tEmptyPos) do
        if not table.icontains(tSkipPos, v2) then
          table.insert(pool, v2)
        end
      end
      if 0 < #pool then
        local randomIndex = self._gridFilter:_GetRandomNumber(1, #pool)
        local pos = table.remove(pool, randomIndex)
        table.insert(tSkipPos, pos)
        self:_InsertTargetGrid(attackRange, pos, wholeRange)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.QierMonsterRoundRandom, centerPos, attackRange, wholeRange)
  return result
end
