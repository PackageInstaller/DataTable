require("skill_effect_result_base")
_class("SkillDelayHitBackEffectResult", SkillEffectResultBase)
SkillDelayHitBackEffectResult = SkillDelayHitBackEffectResult

function SkillDelayHitBackEffectResult:Constructor(casterEntityID, victimID, distance, dirType, asterPos, gridPos, targetLocationCenter, targetBodyArea)
  self._casterID = casterEntityID
  self._victimID = victimID
  self._distance = distance
  self._dirType = dirType
  self._casterPos = asterPos
  self._gridPos = gridPos
  self._targetLocationCenter = targetLocationCenter
  self._targetBodyArea = targetBodyArea
  if asterPos then
    self._attackDistance = math.abs(asterPos.y - gridPos.y) + math.abs(asterPos.x - gridPos.x)
  end
end

function SkillDelayHitBackEffectResult:GetEffectType()
  return SkillEffectType.HitBack
end

function SkillDelayHitBackEffectResult:GetCasterEntityID()
  return self._casterID
end

function SkillDelayHitBackEffectResult:GetCasterPos()
  return self._casterPos
end

function SkillDelayHitBackEffectResult:GetGridPos()
  return self._gridPos
end

function SkillDelayHitBackEffectResult:GetTargetLocationCenter()
  return self._targetLocationCenter
end

function SkillDelayHitBackEffectResult:GetTargetBodyArea()
  return self._targetBodyArea
end

function SkillDelayHitBackEffectResult:GetAttackDistance()
  return self._attackDistance
end

function SkillDelayHitBackEffectResult:GetTargetID()
  return self._victimID
end

function SkillDelayHitBackEffectResult:GetHitbackDistance()
  return self._distance
end

function SkillDelayHitBackEffectResult:GetHitbackDirType()
  return self._dirType
end

function SkillDelayHitBackEffectResult:SetHitbackDirType(newHitbackDirType)
  self._dirType = newHitbackDirType
end

function SkillDelayHitBackEffectResult:GetCalcType()
  return HitBackCalcType.Delay
end
