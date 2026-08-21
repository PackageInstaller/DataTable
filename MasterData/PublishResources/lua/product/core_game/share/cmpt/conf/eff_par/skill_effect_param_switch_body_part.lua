require("skill_effect_param_base")
_class("SkillEffectParamSwitchBodyPart", SkillEffectParamBase)
SkillEffectParamSwitchBodyPart = SkillEffectParamSwitchBodyPart

function SkillEffectParamSwitchBodyPart:Constructor(t)
  self._showID = t.showID
  self._hideID = t.hideID
end

function SkillEffectParamSwitchBodyPart:GetEffectType()
  return SkillEffectType.SwitchBodyPart
end

function SkillEffectParamSwitchBodyPart:GetShowID()
  return self._showID
end

function SkillEffectParamSwitchBodyPart:GetHideID()
  return self._hideID
end
