require("skill_damage_effect_param")
_class("SkillEffectParam_ChangePetTeamOrder", SkillEffectParamBase)
SkillEffectParam_ChangePetTeamOrder = SkillEffectParam_ChangePetTeamOrder

function SkillEffectParam_ChangePetTeamOrder:Constructor(paramList)
  self._targetOrder = paramList.targetOrder
end

function SkillEffectParam_ChangePetTeamOrder:GetEffectType()
  return SkillEffectType.ChangePetTeamOrder
end

function SkillEffectParam_ChangePetTeamOrder:GetTargetOrder()
  return self._targetOrder
end
