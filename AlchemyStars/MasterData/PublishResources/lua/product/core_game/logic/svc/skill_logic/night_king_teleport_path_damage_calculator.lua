_class("NightKingTeleportPathDamageCalculator", Object)
NightKingTeleportPathDamageCalculator = NightKingTeleportPathDamageCalculator

function NightKingTeleportPathDamageCalculator:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function NightKingTeleportPathDamageCalculator:Calculate(casterEntity, skillEffectCalcParam, finalScopeFilterParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local teleportResult
  local skillEffectResult_Teleport_Array = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
  if 0 < #skillEffectResult_Teleport_Array then
    teleportResult = skillEffectResult_Teleport_Array[1]
  end
  if not teleportResult then
    return
  end
  local telPath = teleportResult:GetRenderTeleportPath()
  if 1 < #telPath then
  elseif #telPath == 1 then
  else
    return
  end
  local startPos = teleportResult:GetPosOld()
  local finishPos = teleportResult:GetPosNew()
  local results = {}
  local renderTelLastPos = startPos
  for index, tarPos in ipairs(telPath) do
    if index ~= #telPath then
      local damageStageIndex = index
      local damageResults = self:_CalcTeleportToTrapDamage(casterEntity, skillEffectCalcParam, renderTelLastPos, tarPos, damageStageIndex)
      table.appendArray(results, damageResults)
    else
      local damageStageIndex = index
      local damageResults = self:_CalcTeleportToFinalDamage(casterEntity, skillEffectCalcParam, renderTelLastPos, tarPos, damageStageIndex)
      table.appendArray(results, damageResults)
    end
    renderTelLastPos = tarPos
  end
  for _, v in ipairs(results) do
    skillEffectResultContainer:AddEffectResult(v)
  end
  return results
end

function NightKingTeleportPathDamageCalculator:_CalcTeleportToTrapDamage(casterEntity, skillEffectCalcParam, fromPos, toPos, damageStageIndex)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local casterPos = casterEntity:GetGridPosition()
  local scopeType = skillEffectCalcParam:GetPathDamageScopeType()
  local scopeParam = skillEffectCalcParam:GetPathDamageScopeParam()
  local targetType = skillEffectCalcParam:GetPathDamageTargetType()
  local scopeResult = scopeCalc:ComputeScopeRange(scopeType, scopeParam, {fromPos, toPos}, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), targetType, casterEntity:GetGridPosition())
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, scopeResult)
  local results = {}
  for index, targetID in ipairs(targetIDList) do
    local targetEntity = self._world:GetEntityByID(targetID)
    local damageCalcParam = SkillEffectCalcParam:New(casterEntity:GetID(), {targetID}, skillEffectCalcParam, skillID, scopeResult:GetAttackRange(), toPos, targetEntity:GetGridPosition())
    local skillEffectCalc = SkillEffectCalc_Damage:New(self._world)
    local result = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
    for index, dmgResult in ipairs(result) do
      dmgResult._damageStageIndex = damageStageIndex
    end
    table.appendArray(results, result)
  end
  return results
end

function NightKingTeleportPathDamageCalculator:_CalcTeleportToFinalDamage(casterEntity, skillEffectCalcParam, fromPos, toPos, damageStageIndex)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local casterPos = casterEntity:GetGridPosition()
  local scopeType = skillEffectCalcParam:GetFinalDamageScopeType()
  local scopeParam = skillEffectCalcParam:GetFinalDamageScopeParam()
  local targetType = skillEffectCalcParam:GetFinalDamageTargetType()
  local scopeResult = scopeCalc:ComputeScopeRange(scopeType, scopeParam, toPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), targetType, casterPos)
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, scopeResult)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local results = {}
  for index, targetID in ipairs(targetIDList) do
    local targetEntity = self._world:GetEntityByID(targetID)
    local damageCalcParam = SkillEffectCalcParam:New(casterEntity:GetID(), {targetID}, skillEffectCalcParam, skillID, scopeResult:GetAttackRange(), toPos, targetEntity:GetGridPosition())
    local skillEffectCalc = SkillEffectCalc_Damage:New(self._world)
    local result = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
    for index, dmgResult in ipairs(result) do
      dmgResult._damageStageIndex = damageStageIndex
    end
    table.appendArray(results, result)
  end
  return results
end
