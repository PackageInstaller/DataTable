require("skill_phase_param_base")
_class("SkillPhaseGatherThrowDamageParam", SkillPhaseParamBase)
SkillPhaseGatherThrowDamageParam = SkillPhaseGatherThrowDamageParam

function SkillPhaseGatherThrowDamageParam:Constructor(t)
  self._hitAnimName = t.hitAnim
  self._hitDelayTime = t.hitDelayTime
  self._hitEffectID = t.hitEffectID
  self._casterAnimName = t.casterAnimName
  self._castEffectID = t.castEffectID
  self._monsterStartDelay = t.monsterStartDelay
  self._monsterFlyAnim = t.monsterFlyAnim
  self._monsterEndHeight = t.monsterEndHeight
  self._monsterFlyTotalTime = t.monsterFlyTotalTime
  self._monsterMinScale = t.monsterMinScale or 1
  local monsterFlyToPosTb = t.monsterFlyToPos
  if monsterFlyToPosTb and 2 <= #monsterFlyToPosTb then
    local posX = tonumber(monsterFlyToPosTb[1])
    local posY = tonumber(monsterFlyToPosTb[2])
    self._monsterFlyToPos = Vector2(posX, posY)
  end
  self._bowlderStartDelay = t.bowlderStartDelay
  self._bowlderTrajectoryID = t.bowlderTrajectoryID
  self._bowlderJumpHeight = t.bowlderJumpHeight
  self._bowlderEndHeight = t.bowlderEndHeight
  self._bowlderFlyTotalTime = t.bowlderFlyTotalTime
  local bowlderStartPosTb = t.bowlderStartPos
  if bowlderStartPosTb and 3 <= #bowlderStartPosTb then
    local posX = tonumber(bowlderStartPosTb[1])
    local posY = tonumber(bowlderStartPosTb[2])
    local posZ = tonumber(bowlderStartPosTb[3])
    self._bowlderStartPos = Vector3(posX, posY, posZ)
  end
  self.appearDuration = t.appearDuration or 0
  self.stealthDuration = t.stealthDuration or 0
  self.appearAnimation = t.appearAnimation
end

function SkillPhaseGatherThrowDamageParam:GetMonsterStartDelay()
  return self._monsterStartDelay
end

function SkillPhaseGatherThrowDamageParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseGatherThrowDamageParam:GetCasterAnimName()
  return self._casterAnimName
end

function SkillPhaseGatherThrowDamageParam:GetHitAnimationName()
  return self._hitAnimName
end

function SkillPhaseGatherThrowDamageParam:GetHitDelayTime()
  return self._hitDelayTime
end

function SkillPhaseGatherThrowDamageParam:GetHitEffectId()
  return self._hitEffectID
end

function SkillPhaseGatherThrowDamageParam:GetCacheTable()
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
  if self._noMonsterCasterEffectID and 0 < self._noMonsterCasterEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._noMonsterCasterEffectID].ResPath,
      1
    })
  end
  if self._successCasterEffectID and 0 < self._successCasterEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._successCasterEffectID].ResPath,
      1
    })
  end
  if self._monsterTrajectoryID and 0 < self._monsterTrajectoryID then
    table.insert(t, {
      Cfg.cfg_effect[self._monsterTrajectoryID].ResPath,
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

function SkillPhaseGatherThrowDamageParam:GetPhaseType()
  return SkillViewPhaseType.GatherThrowDamage
end

function SkillPhaseGatherThrowDamageParam:GetCasterEffectID()
  return self._casterEffectID
end

function SkillPhaseGatherThrowDamageParam:GetNoMonsterCasterEffectID()
  return self._noMonsterCasterEffectID
end

function SkillPhaseGatherThrowDamageParam:GetSuccessCasterEffectID()
  return self._successCasterEffectID
end

function SkillPhaseGatherThrowDamageParam:GetMonsterTrajectoryID()
  return self._monsterTrajectoryID
end

function SkillPhaseGatherThrowDamageParam:GetMonsterEndHeight()
  return self._monsterEndHeight
end

function SkillPhaseGatherThrowDamageParam:GetMonsterFlyTotalTime()
  return self._monsterFlyTotalTime
end

function SkillPhaseGatherThrowDamageParam:GetMonsterMinScale()
  return self._monsterMinScale
end

function SkillPhaseGatherThrowDamageParam:GetMonsterFlyToPos()
  return self._monsterFlyToPos
end

function SkillPhaseGatherThrowDamageParam:GetBowlderTrajectoryID()
  return self._bowlderTrajectoryID
end

function SkillPhaseGatherThrowDamageParam:GetBowlderEndHeight()
  return self._bowlderEndHeight
end

function SkillPhaseGatherThrowDamageParam:GetBowlderFlyTotalTime()
  return self._bowlderFlyTotalTime
end

function SkillPhaseGatherThrowDamageParam:GetBowlderStartDelay()
  return self._bowlderStartDelay or 0
end

function SkillPhaseGatherThrowDamageParam:GetBowlderStartPos()
  return self._bowlderStartPos
end

function SkillPhaseGatherThrowDamageParam:GetBowlderJumpHeight()
  return self._bowlderJumpHeight
end
