require("skill_effect_param_base")
_class("SkillEffectParamCalEdgePos", SkillEffectParamBase)
SkillEffectParamCalEdgePos = SkillEffectParamCalEdgePos

function SkillEffectParamCalEdgePos:Constructor(t)
  self.targetType = t.targetType
end

function SkillEffectParamCalEdgePos:GetEffectType()
  return SkillEffectType.CalEdgePos
end

function SkillEffectParamCalEdgePos:GetTargetType()
  return self.targetType
end
