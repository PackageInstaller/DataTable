require("skill_effect_result_base")
_class("SkillEffectEnterMirageResult", SkillEffectResultBase)
SkillEffectEnterMirageResult = SkillEffectEnterMirageResult

function SkillEffectEnterMirageResult:Constructor()
end

function SkillEffectEnterMirageResult:GetEffectType()
  return SkillEffectType.EnterMirage
end
