require("skill_phase_param_base")
_class("SkillPhaseAOEDamageParam", SkillPhaseParamBase)
SkillPhaseAOEDamageParam = SkillPhaseAOEDamageParam

function SkillPhaseAOEDamageParam:Constructor(t)
  self._casterEffectID = t.casterEffectID
  self._hitPointDelay = t.hitPointDelay
  self._intervalTime = t.intervalTime
  self._hitEffectID = t.hitEffectID
  self._hitAnimName = t.hitAnimName
end

function SkillPhaseAOEDamageParam:GetCacheTable()
  local t = {}
  if self._casterEffectID and self._casterEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._casterEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseAOEDamageParam:GetPhaseType()
  return SkillViewPhaseType.AOEDamage
end

function SkillPhaseAOEDamageParam:GetSkillCastEffectID()
  return self._casterEffectID
end

function SkillPhaseAOEDamageParam:GetSkillHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseAOEDamageParam:GetSkillAOEInterval()
  return self._intervalTime
end

function SkillPhaseAOEDamageParam:GetSkillHitEffectID()
  return self._hitEffectID
end

function SkillPhaseAOEDamageParam:GetSkillHitAnimName()
  return self._hitAnimName
end
