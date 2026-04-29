require("skill_effect_result_base")
_class("SkillEffectResultChangeTargetAttributeBasedOnDamage", SkillEffectResultBase)
SkillEffectResultChangeTargetAttributeBasedOnDamage = SkillEffectResultChangeTargetAttributeBasedOnDamage

function SkillEffectResultChangeTargetAttributeBasedOnDamage:Constructor(entityID, targetBuffSeq, targetEffectType, layer, isUnload)
  self._stageIndex = 1
  self._entityID = entityID
  self._targetBuffSeq = targetBuffSeq
  self._targetEffectType = targetEffectType
  self._layer = layer
  self._isUnload = isUnload
end
