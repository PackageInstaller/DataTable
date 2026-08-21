require("skill_phase_param_base")
_class("SkillPhaseSacrificeTrapsAndDamageParam", SkillPhaseParamBase)
SkillPhaseSacrificeTrapsAndDamageParam = SkillPhaseSacrificeTrapsAndDamageParam

function SkillPhaseSacrificeTrapsAndDamageParam:Constructor(t)
  self._hitAnimName = t.hitAnimName
  self._hitDelayTime = t.hitDelayTime
  self._hitEffectID = t.hitEffectID
  self._casterAnimName = t.casterAnimName
  self._castEffectID = t.castEffectID
  self._noTrapCasterEffectID = t.noTrapCasterEffectID
  self._successCasterEffectID = t.successCasterEffectID
  self._trapStartDelay = t.trapStartDelay
  self._trapTrajectoryID = t.trapTrajectoryID
  self._trapStartHeight = t.trapStartHeight
  self._trapEndHeight = t.trapEndHeight
  self._trapFlyTotalTime = t.trapFlyTotalTime
  self._bowlderStartDelay = t.bowlderStartDelay
  self._bowlderTrajectoryID = t.bowlderTrajectoryID
  self._bowlderStartHeight = t.bowlderStartHeight
  self._bowlderEndHeight = t.bowlderEndHeight
  self._bowlderFlyTotalTime = t.bowlderFlyTotalTime
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetTrapStartDelay()
  return self._trapStartDelay
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetSuccessCasterEffectID()
  return self._successCasterEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetNoTrapCasterEffectID()
  return self._noTrapCasterEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetCasterAnimName()
  return self._casterAnimName
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetHitAnimationName()
  return self._hitAnimName
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetHitDelayTime()
  return self._hitDelayTime
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetHitEffectId()
  return self._hitEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetCacheTable()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._castEffectID and 0 < self._castEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    })
  end
  if self._noTrapCasterEffectID and 0 < self._noTrapCasterEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._noTrapCasterEffectID].ResPath,
      1
    })
  end
  if self._successCasterEffectID and 0 < self._successCasterEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._successCasterEffectID].ResPath,
      1
    })
  end
  if self._trapTrajectoryID and 0 < self._trapTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapTrajectoryID].ResPath,
      1
    })
  end
  if self._bowlderTrajectoryID and 0 < self._bowlderTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._bowlderTrajectoryID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetPhaseType()
  return SkillViewPhaseType.SacrificeTrapsAndDamage
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetCasterEffectID()
  return self._casterEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetNoTrapCasterEffectID()
  return self._noTrapCasterEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetSuccessCasterEffectID()
  return self._successCasterEffectID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetTrapTrajectoryID()
  return self._trapTrajectoryID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetTrapStartHeight()
  return self._trapStartHeight
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetTrapEndHeight()
  return self._trapEndHeight
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetTrapFlyTotalTime()
  return self._trapFlyTotalTime
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetBowlderTrajectoryID()
  return self._bowlderTrajectoryID
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetBowlderStartHeight()
  return self._bowlderStartHeight
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetBowlderEndHeight()
  return self._bowlderEndHeight
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetBowlderFlyTotalTime()
  return self._bowlderFlyTotalTime
end

function SkillPhaseSacrificeTrapsAndDamageParam:GetBowlderStartDelay()
  return self._bowlderStartDelay or 0
end
