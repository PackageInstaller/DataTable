require("skill_phase_param_base")
_class("SkillPhaseScopeGroupParam", SkillPhaseParamBase)
SkillPhaseScopeGroupParam = SkillPhaseScopeGroupParam

function SkillPhaseScopeGroupParam:Constructor(t)
  self._hitAnim = t.hitAnim
  self._gridEffectID = t.gridEffectID
  self._groupAtkDelay = t.groupAtkDelay
  self._hitEffectID = t.hitEffectID or 0
  self._finishDelayTime = t.finishDelayTime or 0
end

function SkillPhaseScopeGroupParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseScopeGroupParam:GetPhaseType()
  return SkillViewPhaseType.ScopeGroup
end

function SkillPhaseScopeGroupParam:GetHitAnimation()
  return self._hitAnim
end

function SkillPhaseScopeGroupParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseScopeGroupParam:GetGroupAtkDelay()
  return self._groupAtkDelay
end

function SkillPhaseScopeGroupParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseScopeGroupParam:GetFinishDelayTime()
  return self._finishDelayTime
end
