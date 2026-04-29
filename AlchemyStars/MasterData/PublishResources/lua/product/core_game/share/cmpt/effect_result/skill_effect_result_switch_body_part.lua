require("skill_effect_result_base")
_class("SkillEffectResultSwitchBodyPart", SkillEffectResultBase)
SkillEffectResultSwitchBodyPart = SkillEffectResultSwitchBodyPart

function SkillEffectResultSwitchBodyPart:Constructor(showID, hideID)
  self._showID = showID
  self._hideID = hideID
end

function SkillEffectResultSwitchBodyPart:GetEffectType()
  return SkillEffectType.SwitchBodyPart
end

function SkillEffectResultSwitchBodyPart:GetShowID()
  return self._showID
end

function SkillEffectResultSwitchBodyPart:GetHideID()
  return self._hideID
end
