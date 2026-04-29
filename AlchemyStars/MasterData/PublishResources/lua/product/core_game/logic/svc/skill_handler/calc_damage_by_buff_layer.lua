_class("SkillEffectCalc_DamageByBuffLayer", Object)
SkillEffectCalc_DamageByBuffLayer = SkillEffectCalc_DamageByBuffLayer

function SkillEffectCalc_DamageByBuffLayer:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DamageByBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local buffEffectType = skillEffectParam:GetAddPercentBuffEffectType()
  local maxLayerCount = skillEffectParam:GetMaxLayerCount()
  local maxAddPercent = skillEffectParam:GetMaxAddPercent()
  local percent = skillEffectParam:GetDamagePercent()
  local power = skillEffectParam:GetDamagePower()
  local basePercent = table.cloneconf(percent)
  local buffSvc = self._world:GetService("BuffLogic")
  local curLayerCount = buffSvc:GetBuffLayer(casterEntity, buffEffectType)
  local powerAdd = (curLayerCount / maxLayerCount) ^ power
  local addPercent = powerAdd * maxAddPercent
  if maxAddPercent < addPercent then
    addPercent = maxAddPercent
  end
  local finalPercent = {}
  for _, value in ipairs(percent) do
    local tmpPercent = value + addPercent
    table.insert(finalPercent, tmpPercent)
  end
  skillEffectParam._percent = finalPercent
  local damageCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam:GetCasterEntityID(), skillEffectCalcParam:GetTargetEntityIDs(), skillEffectParam, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillRange(), skillEffectCalcParam:GetAttackPos(), skillEffectCalcParam:GetGridPos())
  local skillEffectCalc = SkillEffectCalc_Damage:New(self._world)
  local resultList = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
  skillEffectParam._percent = basePercent
  for _, damageRes in ipairs(resultList) do
    damageRes:SetBuffLayerCountForDamage(curLayerCount)
  end
  return resultList
end
