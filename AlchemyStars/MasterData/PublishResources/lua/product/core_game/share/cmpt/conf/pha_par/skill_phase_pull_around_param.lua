require("skill_phase_param_base")
_class("SkillPhasePullAroundParam", SkillPhaseParamBase)
SkillPhasePullAroundParam = SkillPhasePullAroundParam

function SkillPhasePullAroundParam:Constructor(t)
  self._hitAnimationName = t.hitAnimationName
  self._moveSpeed = t.moveSpeed
end

function SkillPhasePullAroundParam:GetCacheTable()
  local t = {}
  return t
end

function SkillPhasePullAroundParam:GetPhaseType()
  return SkillViewPhaseType.PullAround
end

function SkillPhasePullAroundParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhasePullAroundParam:GetMoveSpeed()
  return self._moveSpeed
end
