require("skill_phase_param_base")
_class("SkillPhaseSummonTrapParam", SkillPhaseParamBase)
SkillPhaseSummonTrapParam = SkillPhaseSummonTrapParam

function SkillPhaseSummonTrapParam:Constructor(t)
  self._showTimeDelay = t.showTimeDelay or 0
end

function SkillPhaseSummonTrapParam:GetCacheTable()
  local t = {}
  return t
end

function SkillPhaseSummonTrapParam:GetPhaseType()
  return SkillViewPhaseType.SummonTrap
end

function SkillPhaseSummonTrapParam:GetShowTimeDelay()
  return self._showTimeDelay
end
