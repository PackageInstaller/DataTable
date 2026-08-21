require("skill_phase_param_base")
_class("SkillPhaseMultiGridDamageTraceParam", SkillPhaseParamBase)
SkillPhaseMultiGridDamageTraceParam = SkillPhaseMultiGridDamageTraceParam

function SkillPhaseMultiGridDamageTraceParam:Constructor(t)
  self._pathEffectID = t.pathEffectID
  self._hitEffectID = t.hitEffectID
  self._interval = t.interval or 0
end

function SkillPhaseMultiGridDamageTraceParam:GetPhaseType()
  return SkillViewPhaseType.MultiGridDamageTrace
end

function SkillPhaseMultiGridDamageTraceParam:GetPathEffectID()
  return self._pathEffectID
end

function SkillPhaseMultiGridDamageTraceParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseMultiGridDamageTraceParam:GetInterval()
  return self._interval
end

function SkillPhaseMultiGridDamageTraceParam:GetCacheTable()
  local t = {}
  if self._pathEffectID and self._pathEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._pathEffectID].ResPath,
      1
    })
  end
  if self._pathEffectID and self._pathEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._pathEffectID].ResPath,
      1
    })
  end
  return t
end
