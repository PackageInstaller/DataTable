require("skill_phase_param_base")
_class("SkillPhaseHitBackParam", SkillPhaseParamBase)
SkillPhaseHitBackParam = SkillPhaseHitBackParam

function SkillPhaseHitBackParam:Constructor(t)
  self._hitAnim = t.hitAnim
  self._hitEffectID = t.hitEffectID or 0
  self._turnToTarget = t.turnToTarget or 0
end

function SkillPhaseHitBackParam:GetCacheTable()
  local t = {}
  return t
end

function SkillPhaseHitBackParam:GetPhaseType()
  return SkillViewPhaseType.HitBack
end

function SkillPhaseHitBackParam:GetHitAnim()
  return self._hitAnim
end

function SkillPhaseHitBackParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseHitBackParam:GetTurnToTarget()
  return self._turnToTarget
end
