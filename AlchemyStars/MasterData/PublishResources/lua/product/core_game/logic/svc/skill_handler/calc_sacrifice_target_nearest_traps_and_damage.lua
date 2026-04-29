_class("SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage", Object)
SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage = SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage

function SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_SacrificeTargetNearestTrapsAndDamage:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local param = skillEffectCalcParam.skillEffectParam
  local defenderEntity = self._world:GetEntityByID(targetID)
  local defenderPos = defenderEntity:GetGridPosition()
  local utilSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local limitCount = param:GetTrapLimit()
  local checkTrapIDList = param:GetCheckTrapIDList()
  local traps, findTrapPosList, trapIDs = utilScopeSvc:SelectNearestTrapsOnPos(checkTrapIDList, defenderPos, limitCount)
  local trapCount = #traps
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local damageResults = {}
  local mainBasePercent = param:GetMainBasePercent()
  if mainBasePercent then
    local mainAddVal = param:GetMainAddValue()
    local mainAddPercent = mainAddVal
    local mainFormulaID = param:GetMainFormulaID()
    if mainFormulaID == nil then
      mainFormulaID = 100
    end
    local mainSkillDamageParam = SkillDamageEffectParam:New({
      percent = {mainBasePercent},
      addPercent = mainAddPercent,
      formulaID = mainFormulaID,
      damageStageIndex = 1
    })
    local mainDamageStageIndex = mainSkillDamageParam:GetSkillEffectDamageStageIndex()
    local nMianTotalDamage, mainListDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), defenderEntity, defenderEntity:GetGridPosition(), skillEffectCalcParam.skillID, mainSkillDamageParam, SkillEffectType.SacrificeTargetNearestTrapsAndDamage, mainDamageStageIndex)
    local mainDamageResult = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, targetID, nMianTotalDamage, mainListDamageInfo, mainDamageStageIndex)
    table.insert(damageResults, mainDamageResult)
  end
  local basePercent = param:GetBasePercent()
  local addVal = param:GetAddValue()
  local addPercent = addVal
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
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  for i = 1, trapCount do
    local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), defenderEntity, defenderEntity:GetGridPosition(), skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.SacrificeTargetNearestTrapsAndDamage, damageStageIndex)
    local damageResult = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, targetID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(damageResults, damageResult)
  end
  return SkillEffectSacrificeTargetNearestTrapsAndDamageResult:New(trapIDs, damageResults)
end
