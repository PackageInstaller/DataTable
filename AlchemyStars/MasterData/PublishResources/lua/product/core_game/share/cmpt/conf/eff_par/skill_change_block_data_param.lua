require("skill_effect_param_base")
_class("SkillChangeBlockDataParam", SkillEffectParamBase)
SkillChangeBlockDataParam = SkillChangeBlockDataParam

function SkillChangeBlockDataParam:Constructor(t)
  self._change = t.change
end

function SkillChangeBlockDataParam:GetEffectType()
  return SkillEffectType.ChangeBlockData
end

function SkillChangeBlockDataParam:GetChangeType()
  return self._change
end
