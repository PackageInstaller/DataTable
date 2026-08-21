_class("SkillEffectCalc_SacrificeTrapsAndDamage", Object)
SkillEffectCalc_SacrificeTrapsAndDamage = SkillEffectCalc_SacrificeTrapsAndDamage

function SkillEffectCalc_SacrificeTrapsAndDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SacrificeTrapsAndDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_SacrificeTrapsAndDamage:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local param = skillEffectCalcParam.skillEffectParam
  local trapID = param:GetTrapID()
  local utilSvc = self._world:GetService("UtilData")
  local traps = {}
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    local entities = utilSvc:GetTrapsAtPos(pos)
    for _, entity in ipairs(entities) do
      local trapComponent = entity:Trap()
      if trapID[trapComponent:GetTrapID()] then
        table.insert(traps, entity:GetID())
      end
    end
  end
  local trapCount = #traps
  local basePercent = param:GetBasePercent()
  local addVal = param:GetAddValue()
  local addPercent = addVal * trapCount
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local defenderEntity = self._world:GetEntityByID(targetID)
  local curFormulaID = param:GetSacrificeFormulaID()
  if curFormulaID == nil then
    curFormulaID = 100
  end
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = {basePercent},
    addPercent = addPercent,
    formulaID = curFormulaID,
    damageStageIndex = 1
  })
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local targetType = skillEffectCalcParam.skillEffectParam:GetDamageTargetType()
  local damageScopeResult = scopeCalculator:ComputeScopeRange(skillEffectCalcParam.skillEffectParam:GetDamageScopeType(), skillEffectCalcParam.skillEffectParam:GetDamageScopeParam(), casterEntity:GetGridPosition(), casterEntity:BodyArea():GetArea(), casterEntity:GridLocation():GetGridDir(), targetType)
  local targetArray = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, damageScopeResult, skillEffectCalcParam.skillID)
  local target = self:_TransTargetData(targetArray)
  local damageTarget = self._world:GetEntityByID(target)
  if not damageTarget then
    return
  end
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), damageTarget, damageTarget:GetGridPosition(), skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.SacrificeTrapsAndDamage, 1)
  local damageInfo = listDamageInfo[1]
  local damageInfoArray = {damageInfo}
  local serDamage = self._skillEffectService:NewSkillDamageEffectResult(skillEffectCalcParam.gridPos, target, damageInfo:GetDamageValue(), damageInfoArray)
  return SkillEffectSacrificeTrapsAndDamageResult:New(traps, {serDamage})
end

function SkillEffectCalc_SacrificeTrapsAndDamage:_TransTargetData(targetData)
  local nReturn = 0
  if type(targetData) == "number" then
    nReturn = targetData
  elseif type(targetData) == "table" then
    nReturn = targetData[1]
  end
  return nReturn
end
