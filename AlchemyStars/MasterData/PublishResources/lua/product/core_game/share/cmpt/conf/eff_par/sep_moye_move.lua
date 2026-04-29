require("skill_effect_param_base")
_class("SkillEffectParamMoyeMove", SkillEffectParamBase)
SkillEffectParamMoyeMove = SkillEffectParamMoyeMove

function SkillEffectParamMoyeMove:Constructor(t)
  self._convertType = t.convertType
end

function SkillEffectParamMoyeMove:GetEffectType()
  return SkillEffectType.MoyeMove
end

function SkillEffectParamMoyeMove:GetConvertType()
  return self._convertType
end
