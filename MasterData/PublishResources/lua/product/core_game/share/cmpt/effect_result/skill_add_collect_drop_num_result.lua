require("skill_effect_result_base")
_class("SkillAddCollectDropNumResult", SkillEffectResultBase)
SkillAddCollectDropNumResult = SkillAddCollectDropNumResult

function SkillAddCollectDropNumResult:Constructor(delta)
  self._delta = delta
end

function SkillAddCollectDropNumResult:GetEffectType()
  return SkillEffectType.AddCollectDropNum
end

function SkillAddCollectDropNumResult:GetDelta()
  return self._delta
end
