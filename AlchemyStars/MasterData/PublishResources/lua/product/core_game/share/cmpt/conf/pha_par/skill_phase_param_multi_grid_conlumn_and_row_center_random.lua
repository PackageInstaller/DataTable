require("skill_phase_param_base")
_class("SkillPhaseParamMultiGridColumnAndRowCenterRandom", SkillPhaseParamBase)
SkillPhaseParamMultiGridColumnAndRowCenterRandom = SkillPhaseParamMultiGridColumnAndRowCenterRandom

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:Constructor(t)
  self._effectID = t.effectID
  self._hitEffectID = t.hitEffectID
  self._hitAnimationName = t.hitAnimName
  self._intervalTime = t.intervalTime
  self._damageWaitTime = t.damageWaitTime
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetPhaseType()
  return SkillViewPhaseType.MultiGridColumnAndRowCenterRandom
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetEffectID()
  return self._effectID
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetEffectIntervalTime()
  return self._intervalTime
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetEffectDamageWaitTime()
  return self._damageWaitTime
end

function SkillPhaseParamMultiGridColumnAndRowCenterRandom:GetCacheTable()
  local t = {}
  table.insert(t, {
    Cfg.cfg_effect[self._effectID].ResPath,
    1
  })
  return t
end
