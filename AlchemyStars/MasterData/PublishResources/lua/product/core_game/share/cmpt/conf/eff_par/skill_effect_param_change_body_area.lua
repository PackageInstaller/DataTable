require("skill_effect_param_base")
_class("SkillEffectParamChangeBodyArea", SkillEffectParamBase)
SkillEffectParamChangeBodyArea = SkillEffectParamChangeBodyArea

function SkillEffectParamChangeBodyArea:Constructor(t)
  self._bodyArea = t.bodyArea or {}
end

function SkillEffectParamChangeBodyArea:GetEffectType()
  return SkillEffectType.ChangeBodyArea
end

function SkillEffectParamChangeBodyArea:GetBodyArea()
  return self._bodyArea
end
