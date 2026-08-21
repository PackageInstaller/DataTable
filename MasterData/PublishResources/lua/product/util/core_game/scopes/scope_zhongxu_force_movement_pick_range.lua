require("scope_base")
_class("SkillScopeCalculator_ZhongxuForceMovementPickRange", SkillScopeCalculator_Base)
SkillScopeCalculator_ZhongxuForceMovementPickRange = SkillScopeCalculator_ZhongxuForceMovementPickRange

function SkillScopeCalculator_ZhongxuForceMovementPickRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local attackRange = {}
  local wholeRange = {}
  local trapIdList = scopeParam.trapIdList
  local stepLimit = scopeParam.stepLimit
  local foundTrapEntity, foundMonsterEntity, foundEnemyTeamEntity
  if trapIdList and 0 < #trapIdList then
    local utilSvc = world:GetService("UtilData")
    local traps = utilSvc:GetTrapsAtPos(centerPos)
    if traps then
      for index, e in ipairs(traps) do
        local trapId = e:Trap():GetTrapID()
        if table.icontains(trapIdList, trapId) then
          foundTrapEntity = e
          break
        end
      end
    end
  end
  local moveEntity
  local isTrap = false
  if foundTrapEntity then
    isTrap = true
    moveEntity = foundTrapEntity
  elseif world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasPet() then
      local enemy = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
      local enemyPos = enemy:GetGridPosition()
      if enemyPos == centerPos then
        foundEnemyTeamEntity = enemy
        moveEntity = foundEnemyTeamEntity
      end
    end
  else
    local utilScopeSvc = world:GetService("UtilScopeCalc")
    local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(centerPos)
    if isHasMonster then
      local monsterEntity = world:GetEntityByID(monsterID)
      if monsterEntity then
        foundMonsterEntity = monsterEntity
        moveEntity = foundMonsterEntity
      end
    end
  end
  local fixedMaxStep = scopeParam.fixedMaxStep
  if fixedMaxStep then
    local maxStep = fixedMaxStep
    attackRange, wholeRange = self:_CalcPickRange(moveEntity, isTrap, maxStep)
  else
    local recordBuffCmpt = casterEntity:BuffComponent()
    local buffValueKey = "CurRoundForceMoveStep"
    local curRoundForceMoveStep = recordBuffCmpt:GetBuffValue(buffValueKey) or 0
    local eachMoveCostParam = scopeParam.eachMoveCostParam
    local trapMoveCostExtraParam = scopeParam.trapMoveCostExtraParam
    local curLegendPower = casterEntity:Attributes():GetAttribute("LegendPower")
    local maxStep = self:_CalcMaxStep(stepLimit, curLegendPower, curRoundForceMoveStep, eachMoveCostParam, trapMoveCostExtraParam, isTrap)
    attackRange, wholeRange = self:_CalcPickRange(moveEntity, isTrap, maxStep)
  end
  local result = SkillScopeResult:New(SkillScopeType.ZhongxuForceMovementPickRange, casterPos, attackRange, wholeRange)
  return result
end

function SkillScopeCalculator_ZhongxuForceMovementPickRange:_CalcMaxStep(stepLimit, curLegendPower, curRoundForceMoveStep, eachMoveCostParam, trapMoveCostExtraParam, isTrap)
  local totalCost = 0
  local maxStep = 0
  for i = 1, stepLimit do
    local eachCost = eachMoveCostParam
    if isTrap then
      eachCost = trapMoveCostExtraParam
    end
    local curStep = curRoundForceMoveStep + i
    local curStepCost = eachCost * curStep
    totalCost = totalCost + curStepCost
    if curLegendPower >= totalCost then
      maxStep = i
    else
      break
    end
  end
  return maxStep
end

function SkillScopeCalculator_ZhongxuForceMovementPickRange:_CalcPickRange(moveEntity, isTrap, maxStep)
  local world = self._gridFilter._world
  local forceMovementCalculator = ForceMovementCalculator:New(world)
  local e = moveEntity
  if not e then
    return {}, {}
  end
  local entityPos = e:GetGridPosition()
  local bodyPosList = {}
  local upBodyArea = {}
  local rightBodyArea = {}
  local downBodyArea = {}
  local leftBodyArea = {}
  local bodyArea = e:BodyArea():GetArea()
  for index, off in ipairs(bodyArea) do
    local bodyPos = entityPos + off
    table.insert(bodyPosList, bodyPos)
  end
  local attackRange = {}
  local wholeRange = {}
  local fourDir = {
    Vector2.up,
    Vector2.right,
    Vector2.down,
    Vector2.left
  }
  for _, v2Dir in ipairs(fourDir) do
    local dirStep = forceMovementCalculator:CalcTargetForceMovementStep(e, v2Dir, maxStep)
    if dirStep and 0 < dirStep then
      for i = 1, dirStep do
        local tmpEntityPos = entityPos + v2Dir * i
        for index, off in ipairs(bodyArea) do
          local tmpBodyPos = tmpEntityPos + off
          if not table.icontains(bodyPosList, tmpBodyPos) and not table.icontains(attackRange, tmpBodyPos) then
            table.insert(attackRange, tmpBodyPos)
            table.insert(wholeRange, tmpBodyPos)
          end
        end
      end
    end
  end
  return attackRange, wholeRange
end
