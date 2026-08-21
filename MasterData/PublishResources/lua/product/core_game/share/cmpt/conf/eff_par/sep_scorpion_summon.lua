local ScorpionSummonType = {
  ObliqueBack = 1,
  FrontBack = 2,
  RandomInEight = 3,
  RoundSix = 4
}
_enum("ScorpionSummonType", ScorpionSummonType)
require("skill_effect_param_base")
_class("SkillEffectParamScorpionSummon", SkillEffectParam_SummonEverything)
SkillEffectParamScorpionSummon = SkillEffectParamScorpionSummon

function SkillEffectParamScorpionSummon:Constructor(t)
  self._scorpionSummonType = t.scorpionSummonType
end

function SkillEffectParamScorpionSummon:GetEffectType()
  return SkillEffectType.ScorpionSummon
end

function SkillEffectParamScorpionSummon:GetScorpionSummonType()
  return self._scorpionSummonType
end
