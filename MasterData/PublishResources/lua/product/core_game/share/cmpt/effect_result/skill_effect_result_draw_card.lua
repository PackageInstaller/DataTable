require("skill_effect_result_base")
_class("SkillEffectResultDrawCard", SkillEffectResultBase)
SkillEffectResultDrawCard = SkillEffectResultDrawCard

function SkillEffectResultDrawCard:Constructor(cardType)
  self._cardType = cardType
end

function SkillEffectResultDrawCard:GetEffectType()
  return SkillEffectType.DrawCard
end

function SkillEffectResultDrawCard:GetCardType()
  return self._cardType
end
