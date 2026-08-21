_class("SkillEffectCalc_AppointChain", Object)
SkillEffectCalc_AppointChain = SkillEffectCalc_AppointChain

function SkillEffectCalc_AppointChain:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_AppointChain:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_AppointChain:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local targetEntity = self._world:GetEntityByID(defenderEntityID)
  local buffTarget = targetEntity
  local utilDataSvc = self._world:GetService("UtilData")
  local addCount = skillEffectParam:GetAddCount()
  local buffID
  if targetEntity:HasTrap() then
    buffID = skillEffectParam:GetTrapBuffID()
    buffTarget = casterEntity
    casterEntity:BuffComponent():SetBuffValue("EffectReplaceEntityID", targetEntity:GetID())
  else
    utilDataSvc:AddEntityIstavanActiveCount(targetEntity, addCount)
    buffID = skillEffectParam:GetPetBuffID()
    local actualAttack = casterEntity:Attributes():GetAttribute("Attack")
    targetEntity:BuffComponent():SetBuffValue("GuestAttackAppointChain", actualAttack)
  end
  local damageStageIndex = skillEffectParam:GetSkillEffectDamageStageIndex()
  local buffResult = SkillBuffEffectResult:New(buffTarget:GetID())
  buffResult:SetDamageStageIndex(damageStageIndex)
  local cfgNewBuff = Cfg.cfg_buff[buffID]
  if cfgNewBuff then
    local skillID = skillEffectCalcParam:GetSkillID()
    local attackRange = skillEffectCalcParam:GetSkillRange()
    local sTrigger = self._world:GetService("Trigger")
    local buffLogicService = self._world:GetService("BuffLogic")
    local nt = NTEachAddBuffStart:New(skillID, casterEntity, buffTarget, attackRange)
    sTrigger:Notify(nt)
    local seqID
    local buff = buffLogicService:AddBuff(buffID, buffTarget, {casterEntity = casterEntity}, casterEntity)
    seqID = buff:BuffSeq()
    buffResult:AddBuffResult(seqID)
    sTrigger:Notify(NTEachAddBuffEnd:New(skillID, casterEntity, buffTarget, attackRange, buffID, seqID))
  end
  return buffResult
end
