_class("SkillEffectCalc_ChangeTargetAttributeBasedOnDamage", Object)
SkillEffectCalc_ChangeTargetAttributeBasedOnDamage = SkillEffectCalc_ChangeTargetAttributeBasedOnDamage

function SkillEffectCalc_ChangeTargetAttributeBasedOnDamage:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeTargetAttributeBasedOnDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local addBuffParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local stageIndex = addBuffParam:GetCheckDamageEffectResultWithStageIndex() or 1
  local skillResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, stageIndex)
  if not skillResultArray or table.count(skillResultArray) == 0 then
    return {}
  end
  local mulValue = addBuffParam:GetMulValue()
  local addValue = addBuffParam:GetAddValue()
  local attributeType = addBuffParam:GetAttributeType()
  for _, v in ipairs(skillResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local damageInfo = damageResult:GetDamageInfo(1)
    local hasDamage = true
    if damageInfo and damageInfo:GetDamageType() == DamageType.Miss or damageInfo:GetDamageType() == DamageType.Guard then
      hasDamage = false
    end
    if hasDamage and targetEntity then
      local damageValue = damageInfo:GetDamageValue()
      local add_value = damageValue * mulValue + addValue
      if add_value < 0 then
        add_value = 0
      end
      if add_value ~= 0 then
        if attributeType == CalcChangeTargetAttributeType.MaxHP then
          local damageInfoRecover = DamageInfo:New(add_value, DamageType.Recover)
          local calcDamage = self._world:GetService("CalcDamage")
          calcDamage:AddTargetHP(entity:GetID(), damageInfoRecover)
        end
        local result = SkillEffectResultChangeTargetAttributeBasedOnDamage:New(targetEntityID)
        table.insert(results, result)
      end
    end
  end
  return results
end

function SkillEffectCalc_ChangeTargetAttributeBasedOnDamage:EachApplyAddBlood(attacker, addBloodResult, skillType)
  local targetID = addBloodResult:GetTargetID()
  local healValue = addBloodResult:GetAddValue()
  local damageInfo = DamageInfo:New(healValue, DamageType.Recover)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(targetID, damageInfo)
  addBloodResult:SetDamageInfo(damageInfo)
  local target = self._world:GetEntityByID(targetID)
  if target:HasPetPstID() or target:HasTeam() then
    self._world:GetDataLogger():AddDataLog("OnSkillAddBlood", skillType, target, healValue)
  end
end
