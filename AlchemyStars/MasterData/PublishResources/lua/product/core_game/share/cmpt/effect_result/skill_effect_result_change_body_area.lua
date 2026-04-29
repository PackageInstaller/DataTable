require("skill_effect_result_base")
_class("SkillEffectResultChangeBodyArea", SkillEffectResultBase)
SkillEffectResultChangeBodyArea = SkillEffectResultChangeBodyArea

function SkillEffectResultChangeBodyArea:Constructor(entityID, newBodyArea)
  self._entityID = entityID
  self._newBodyArea = newBodyArea
end

function SkillEffectResultChangeBodyArea:GetEffectType()
  return SkillEffectType.ChangeBodyArea
end

function SkillEffectResultChangeBodyArea:GetNewBodyArea()
  return self._newBodyArea
end

function SkillEffectResultChangeBodyArea:GetChangeBodyAreaEntityID()
  return self._entityID
end
