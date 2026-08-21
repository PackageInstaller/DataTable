_class("SkillEffectCalc_PetMinosGhostDamage", Object)
SkillEffectCalc_PetMinosGhostDamage = SkillEffectCalc_PetMinosGhostDamage

function SkillEffectCalc_PetMinosGhostDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_PetMinosGhostDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local utilSvc = self._world:GetService("UtilData")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local logicPath = logicChainPathCmpt:GetLogicChainPath()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  self.skillID = skillEffectCalcParam.skillID
  local damageResults = {}
  local centerPos = skillEffectCalcParam:GetCenterPos()
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local dmgResult = self:_CalculateSingleTarget(skillEffectCalcParam, casterEntity, targetID)
    if dmgResult then
      table.insert(damageResults, dmgResult)
    end
  end
  local result = SkillEffectResultPetMinosGhostDamage:New(centerPos, damageResults, logicPath)
  return {result}
end

function SkillEffectCalc_PetMinosGhostDamage:_CalculateSingleTarget(skillEffectCalcParam, casterEntity, defenderEntityID)
  local targetEntity = self._world:GetEntityByID(defenderEntityID)
  if targetEntity then
    local dmgResult = self:_Attack(casterEntity, targetEntity, skillEffectCalcParam.skillEffectParam)
    if dmgResult then
      return dmgResult
    end
  end
end

function SkillEffectCalc_PetMinosGhostDamage:_Attack(casterEntity, targetEntity, param)
  local effectCalcSvc = self._skillEffectService
  local damageStageIndex = param:GetSkillEffectDamageStageIndex()
  local attackPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local percent = param:GetDamagePercent()
  local tmpParam = SkillDamageEffectParam:New({
    percent = percent,
    formulaID = param:GetDamageFormulaID(),
    damageStageIndex = damageStageIndex
  })
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackPos, targetEntity, targetPos, self.skillID, tmpParam, SkillEffectType.PetMinosGhostDamage, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetPos, targetEntity:GetID(), nTotalDamage, listDamageInfo, damageStageIndex)
  return skillResult
end
