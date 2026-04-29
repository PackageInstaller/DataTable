require("skill_effect_result_base")
_class("SkillEffectResultTransferTarget", SkillEffectResultBase)
SkillEffectResultTransferTarget = SkillEffectResultTransferTarget

function SkillEffectResultTransferTarget:Constructor(targetID, gridPos)
  self._targetID = targetID
  self._gridPos = gridPos
end

function SkillEffectResultTransferTarget:GetEffectType()
  return SkillEffectType.TransferTarget
end

function SkillEffectResultTransferTarget:GetTargetEntityID()
  return self._targetID
end

function SkillEffectResultTransferTarget:GetTargetGridPos()
  return self._gridPos
end
