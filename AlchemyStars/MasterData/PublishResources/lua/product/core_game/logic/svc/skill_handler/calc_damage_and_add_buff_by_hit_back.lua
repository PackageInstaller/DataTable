_class("SkillEffectCalc_DamageAndAddBuffByHitBack", Object)
SkillEffectCalc_DamageAndAddBuffByHitBack = SkillEffectCalc_DamageAndAddBuffByHitBack

function SkillEffectCalc_DamageAndAddBuffByHitBack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
end

function SkillEffectCalc_DamageAndAddBuffByHitBack:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local param = skillEffectCalcParam.skillEffectParam
  local isTransmitDamage = param:IsTransmitDamage()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local resultArray = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local hitBackRes = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.HitBack, targetID)
    if hitBackRes and hitBackRes:GetIsBlocked() then
      local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
      if 0 < #result then
        table.appendArray(resultArray, result)
      end
      local blockMonsterID = hitBackRes:GetBlockMonsterID()
      local blockMonsterEntity = self._world:GetEntityByID(blockMonsterID)
      if isTransmitDamage and blockMonsterEntity and self._skillScopeTargetSelector:SelectConditionFilter(blockMonsterEntity) then
        local result = self:_CalculateSingleTarget(skillEffectCalcParam, blockMonsterID)
        if 0 < #result then
          table.appendArray(resultArray, result)
        end
      end
    end
  end
  return resultArray
end

function SkillEffectCalc_DamageAndAddBuffByHitBack:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local resultArray = {}
  local damageRes = self:CalcDamageResult(skillEffectCalcParam, targetID)
  if damageRes then
    table.insert(resultArray, damageRes)
  end
  local canAddBuff = false
  for _, damageInfo in ipairs(damageRes:GetDamageInfoArray()) do
    canAddBuff = canAddBuff or damageInfo:GetDamageValue() > 0
  end
  if canAddBuff then
    local addBuffRes = self:CalcAddBuffResult(skillEffectCalcParam, targetID)
    if addBuffRes then
      table.insert(resultArray, addBuffRes)
    end
  end
  return resultArray
end

function SkillEffectCalc_DamageAndAddBuffByHitBack:CalcDamageResult(skillEffectCalcParam, targetID)
  local skillID = skillEffectCalcParam:GetSkillID()
  local param = skillEffectCalcParam.skillEffectParam
  local percent = param:GetPercent()
  local curFormulaID = param:GetFormulaID()
  local damageStageIndex = param:GetSkillEffectDamageStageIndex()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local defenderEntity = self._world:GetEntityByID(targetID)
  local defenderPos = defenderEntity:GetGridPosition()
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = percent,
    formulaID = curFormulaID,
    damageStageIndex = damageStageIndex
  })
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterPos, defenderEntity, defenderPos, skillID, skillDamageParam, SkillEffectType.DamageAndAddBuffByHitBack, damageStageIndex)
  local damageRes = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, targetID, nTotalDamage, listDamageInfo, damageStageIndex)
  return damageRes
end

function SkillEffectCalc_DamageAndAddBuffByHitBack:CalcAddBuffResult(skillEffectCalcParam, targetID)
  local skillID = skillEffectCalcParam:GetSkillID()
  local attackRange = skillEffectCalcParam:GetSkillRange()
  local param = skillEffectCalcParam.skillEffectParam
  local buffID = param:GetBuffID()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local defenderEntity = self._world:GetEntityByID(targetID)
  local buffLogicService = self._world:GetService("BuffLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local buffResult = SkillBuffEffectResult:New(targetID)
  local cfgNewBuff = Cfg.cfg_buff[buffID]
  if cfgNewBuff then
    triggerSvc:Notify(NTEachAddBuffStart:New(skillID, casterEntity, defenderEntity, attackRange))
    local buff = buffLogicService:AddBuff(buffID, defenderEntity, {casterEntity = casterEntity})
    local seqID
    if buff then
      seqID = buff:BuffSeq()
      buffResult:AddBuffResult(seqID)
    end
    triggerSvc:Notify(NTEachAddBuffEnd:New(skillID, casterEntity, defenderEntity, attackRange, buffID, seqID))
  end
  return buffResult
end
