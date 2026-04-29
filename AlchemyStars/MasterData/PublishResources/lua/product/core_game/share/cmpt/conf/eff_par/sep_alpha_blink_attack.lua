require("skill_effect_param_base")
_class("SkillEffectAlphaBlinkAttackParam", SkillEffectParamBase)
SkillEffectAlphaBlinkAttackParam = SkillEffectAlphaBlinkAttackParam

function SkillEffectAlphaBlinkAttackParam:Constructor(t)
  self._trapID = t.trapID
  self._backOffset = t.backOffset
  self._height = t.height
end

function SkillEffectAlphaBlinkAttackParam:GetEffectType()
  return SkillEffectType.AlphaBlinkAttack
end

function SkillEffectAlphaBlinkAttackParam:GetTrapID()
  return self._trapID
end

function SkillEffectAlphaBlinkAttackParam:GetBackOffset()
  return self._backOffset
end

function SkillEffectAlphaBlinkAttackParam:GetTrapHeight()
  return self._height
end
