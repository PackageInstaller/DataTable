require("skill_phase_param_base")
_class("SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam", SkillPhaseParamBase)
SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam = SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:Constructor(t)
  self._hitAnimName = t.hitAnim
  self._hitDelayTime = t.hitDelayTime
  self._hitEffectID = t.hitEffectID
  self._eachDamageTime = t.eachDamageTime or 0
  self._trapStartDelay = t.trapStartDelay
  self._trapTrajectoryID = t.trapTrajectoryID
  self._trapGridEffID = t.trapGridEffID
  self._trapStartHeight = t.trapStartHeight
  self._trapEndHeight = t.trapEndHeight
  self._trapFlyTotalTime = t.trapFlyTotalTime
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetCacheTable()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._trapTrajectoryID and 0 < self._trapTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapTrajectoryID].ResPath,
      1
    })
  end
  if self._trapGridEffID and 0 < self._trapGridEffID then
    table.insert(t, {
      Cfg.cfg_effect[self._trapGridEffID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetPhaseType()
  return SkillViewPhaseType.AbsorbTrapsAndDamageByPickupTarget
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetHitAnimationName()
  return self._hitAnimName
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetHitDelayTime()
  return self._hitDelayTime
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetEachDamageTime()
  return self._eachDamageTime
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetHitEffectId()
  return self._hitEffectID
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapStartDelay()
  return self._trapStartDelay
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapTrajectoryID()
  return self._trapTrajectoryID
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapGridEffID()
  return self._trapGridEffID
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapStartHeight()
  return self._trapStartHeight
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapEndHeight()
  return self._trapEndHeight
end

function SkillPhaseAbsorbTrapsAndDamageByPickupTargetParam:GetTrapFlyTotalTime()
  return self._trapFlyTotalTime
end
