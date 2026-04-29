_class("SkillEffectCalc_MoveTrap", Object)
SkillEffectCalc_MoveTrap = SkillEffectCalc_MoveTrap

function SkillEffectCalc_MoveTrap:Constructor(world)
  self._world = world
end

function SkillEffectCalc_MoveTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam.skillEffectParam
  local trapID = effectParam:GetTrapID()
  if type(trapID) ~= "table" then
    trapID = {trapID}
  end
  local moveScopeType = effectParam:GetMoveScopeType()
  local moveScopeParam = effectParam:GetMoveScopeParam()
  local resultArray = {}
  local utilSvc = self._world:GetService("UtilData")
  local range = skillEffectCalcParam.skillRange or {}
  local moveTrapEntity = {}
  for _, pos in ipairs(range) do
    local array = utilSvc:GetTrapsAtPos(pos)
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:Trap()
      if cTrap and not eTrap:HasDeadMark() and table.intable(trapID, cTrap:GetTrapID()) then
        table.insert(moveTrapEntity, eTrap)
      end
    end
  end
  local centerPos = skillEffectCalcParam:GetCenterPos()
  
  local function CmpDistancefunc(entity1, entity2)
    local pos1 = entity1:GetGridPosition()
    local pos2 = entity2:GetGridPosition()
    local dis1 = Vector2.Distance(pos1, centerPos)
    local dis2 = Vector2.Distance(pos2, centerPos)
    return dis1 < dis2
  end
  
  table.sort(moveTrapEntity, CmpDistancefunc)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local invalidGridList = {}
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  for _, entity in ipairs(moveTrapEntity) do
    local scopeResult = scopeCalculator:ComputeScopeRange(moveScopeType, invalidGridList, entity:GetGridPosition(), entity:BodyArea():GetArea(), nil, nil, entity:GetGridPosition(), entity)
    local entityID = entity:GetID()
    local posOld = entity:GetGridPosition()
    local posNew = entity:GetGridPosition()
    local attackRange = scopeResult:GetAttackRange()
    if attackRange and table.count(attackRange) > 0 then
      posNew = attackRange[1]
    end
    table.insert(resultArray, SkillEffectResultMoveTrap:New(entityID, posOld, posNew))
    table.insert(invalidGridList, posNew)
  end
  return resultArray
end
