require("skill_effect_param_summon_everything")
_class("SkillEffectParam_ButterflySummon", SkillEffectParam_SummonEverything)
SkillEffectParam_ButterflySummon = SkillEffectParam_ButterflySummon

function SkillEffectParam_ButterflySummon:GetEffectType()
  return SkillEffectType.ButterflySummon
end

function SkillEffectParam_ButterflySummon:Constructor(t)
  self._summonID = t.summonID
end

function SkillEffectParam_ButterflySummon:GetSummonID()
  return self._summonID
end

function SkillEffectParam_ButterflySummon:GetSummonType()
  return SkillEffectEnum_SummonType.Monster
end
