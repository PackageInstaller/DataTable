require("skill_effect_result_base")
_class("SkillEffectResultTransposition", SkillEffectResultBase)
SkillEffectResultTransposition = SkillEffectResultTransposition

function SkillEffectResultTransposition:Constructor(trapID, summonPosList)
end

function SkillEffectResultTransposition:GetEffectType()
  return SkillEffectType.Transposition
end
