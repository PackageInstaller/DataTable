_class("SkillEffectCalc_DamageCountByBuffLayer", SkillEffectCalc_Damage)
SkillEffectCalc_DamageCountByBuffLayer = SkillEffectCalc_DamageCountByBuffLayer

function SkillEffectCalc_DamageCountByBuffLayer:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DamageCountByBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local buffEffectType = skillEffectParam:GetAddPercentBuffEffectType()
  local buffSvc = self._world:GetService("BuffLogic")
  local skillResultList = {}
  local buffPreCount = skillEffectParam:GetBuffPreCount()
  if #targetIDList == 1 and targetIDList[1] == -1 then
    return {}
  end
  for _, targetID in ipairs(targetIDList) do
    local targetEntity = self._world:GetEntityByID(targetID)
    local curLayerCount = buffSvc:GetBuffLayer(targetEntity, buffEffectType)
    local i = 1
    while buffPreCount <= curLayerCount do
      local results = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
      for _, result in ipairs(results) do
        result:SetDamageIndex(i)
        table.insert(skillResultList, result)
      end
      i = i + 1
      curLayerCount = curLayerCount - buffPreCount
    end
  end
  return skillResultList
end
