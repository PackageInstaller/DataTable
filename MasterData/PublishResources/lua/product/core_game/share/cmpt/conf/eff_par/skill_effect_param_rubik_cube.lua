require("skill_effect_param_base")
_class("SkillEffectParamRubikCube", SkillEffectParamBase)
SkillEffectParamRubikCube = SkillEffectParamRubikCube

function SkillEffectParamRubikCube:Constructor(t)
  self._times = t.times or 1
end

function SkillEffectParamRubikCube:GetEffectType()
  return SkillEffectType.RubikCube
end

function SkillEffectParamRubikCube:GetTimes()
  return self._times
end
