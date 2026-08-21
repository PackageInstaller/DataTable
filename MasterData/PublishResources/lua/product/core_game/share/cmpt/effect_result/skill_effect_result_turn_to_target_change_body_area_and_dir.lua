require("skill_effect_result_base")
_class("SkillEffectResultTurnToTargetChangeBodyAreaAndDir", SkillEffectResultBase)
SkillEffectResultTurnToTargetChangeBodyAreaAndDir = SkillEffectResultTurnToTargetChangeBodyAreaAndDir

function SkillEffectResultTurnToTargetChangeBodyAreaAndDir:Constructor(casterEntityID, modifyType, newValue)
  self._casterEntityID = casterEntityID
  self._modifyType = modifyType
  self._newValue = newValue
end

function SkillEffectResultTurnToTargetChangeBodyAreaAndDir:GetEffectType()
  return SkillEffectType.TurnToTargetChangeBodyAreaAndDir
end

function SkillEffectResultTurnToTargetChangeBodyAreaAndDir:GetCasterEntityID()
  return self._casterEntityID
end

function SkillEffectResultTurnToTargetChangeBodyAreaAndDir:GetModifyType()
  return self._modifyType
end

function SkillEffectResultTurnToTargetChangeBodyAreaAndDir:GetNewValue()
  return self._newValue
end
