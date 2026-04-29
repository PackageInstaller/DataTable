_class("SkillEffectCalc_ModifyAntiAttackParam", SkillEffectCalc_Base)
SkillEffectCalc_ModifyAntiAttackParam = SkillEffectCalc_ModifyAntiAttackParam

function SkillEffectCalc_ModifyAntiAttackParam:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ModifyAntiAttackParam:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local entity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attributeCmpt = entity:Attributes()
  local modifyType = skillParam:GetModifyType()
  local modifyValue = skillParam:GetModifyParam()
  local curValue = 0
  local newValue = 0
  if modifyType == ModifyAntiAttackParamType.WaitActiveSkillCount then
    modifyType = "WaitActiveSkillCount"
    curValue = attributeCmpt:GetAttribute(modifyType) or 0
    newValue = curValue + modifyValue
    if newValue < 0 then
      newValue = 0
    end
  elseif modifyType == ModifyAntiAttackParamType.AntiSkillCountCurRound then
    modifyType = "MaxAntiSkillCountPerRound"
    curValue = attributeCmpt:GetAttribute(modifyType) or 0
    newValue = curValue + modifyValue
    if newValue < 0 then
      newValue = 0
    end
  elseif modifyType == ModifyAntiAttackParamType.AntiSkillEnabled then
    modifyType = "AntiSkillEnabled"
    newValue = modifyValue
  end
  if not modifyType then
    return
  end
  return SkillEffectResultModifyAntiAttackParam:New(skillEffectCalcParam.casterEntityID, modifyType, newValue)
end
