require("skill_damage_effect_param")
_class("SkillEffectParam_ForceMovement", SkillEffectParamBase)
SkillEffectParam_ForceMovement = SkillEffectParam_ForceMovement

function SkillEffectParam_ForceMovement:Constructor(t)
  self._step = t.step
  self._isIncludeMultiSize = t.includeMultiSize
  self._isIncludeTrap = t.includeTrap
  self._calcStepByPick = t.calcStepByPick
  self._recordCurRoundForceMoveStep = t.recordCurRoundForceMoveStep
end

function SkillEffectParam_ForceMovement:GetEffectType()
  return SkillEffectType.ForceMovement
end

function SkillEffectParam_ForceMovement:GetStep()
  return self._step
end

function SkillEffectParam_ForceMovement:IsIncludeMultiSize()
  return self._isIncludeMultiSize
end

function SkillEffectParam_ForceMovement:IsCalcStepByPick()
  return self._calcStepByPick
end

function SkillEffectParam_ForceMovement:IsRecordCurRoundForceMoveStep()
  return self._recordCurRoundForceMoveStep
end

function SkillEffectParam_ForceMovement:IsIncludeTrap()
  return self._isIncludeTrap
end
