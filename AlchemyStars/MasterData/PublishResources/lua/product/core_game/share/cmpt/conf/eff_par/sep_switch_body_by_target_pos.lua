require("skill_damage_effect_param")
_class("SkillEffectSwitchBodyAreaByTargetPosParam", SkillEffectParamBase)
SkillEffectSwitchBodyAreaByTargetPosParam = SkillEffectSwitchBodyAreaByTargetPosParam

function SkillEffectSwitchBodyAreaByTargetPosParam:Constructor(t)
  self._type = t.type
end

function SkillEffectSwitchBodyAreaByTargetPosParam:GetEffectType()
  return SkillEffectType.SwitchBodyAreaByTargetPos
end

function SkillEffectSwitchBodyAreaByTargetPosParam:GetType()
  return self._type
end
