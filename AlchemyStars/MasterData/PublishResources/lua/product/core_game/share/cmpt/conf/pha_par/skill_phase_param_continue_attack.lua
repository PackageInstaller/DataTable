require("skill_phase_param_base")
_class("SkillPhaseParamContinueAttack", SkillPhaseParamBase)
SkillPhaseParamContinueAttack = SkillPhaseParamContinueAttack

function SkillPhaseParamContinueAttack:Constructor(t)
  self._startIndex = tonumber(t.startIndex)
  self._lastStartIndex = tonumber(t.lastStartIndex)
  self._audioId = t.audioID
  self._animName = t.animName
  self._effectId = t.effectID
  self._effectOffsetX = tonumber(t.effectOffsetX)
  self._effectOffsetY = tonumber(t.effectOffsetY)
  self._effectOffsetZ = tonumber(t.effectOffsetZ)
  self._waitEffectTime = tonumber(t.waitEffectTime)
  self._waitBulletEffectTime = tonumber(t.waitBulletEffectTime)
  self._waitAnimTime = tonumber(t.waitAnimTime)
  self._bulletEffectId = t.bulletEffectId
  self._bulletFlySpeed = t.bulletFlySpeed
  self._bulletFlyTrace = t.bulletFlyTrace
  self._bulletEffectOffsetX = tonumber(t.bulletEffectOffsetX)
  self._bulletEffectOffsetY = tonumber(t.bulletEffectOffsetY)
  self._bulletEffectOffsetZ = tonumber(t.bulletEffectOffsetZ)
  self._waitHitTime = t.waitHitTime
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._turnToTarget = t.turnToTarget
  self._deathClear = t.deathClear
end

function SkillPhaseParamContinueAttack:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._effectId)
  self:AddEffectIDToListID(listID, self._bulletEffectId)
  self:AddEffectIDToListID(listID, self._hitEffectID)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParamContinueAttack:GetSoundCacheTable()
  local t = {}
  table.insert(t, self._audioId)
  return t
end

function SkillPhaseParamContinueAttack:GetPhaseType()
  return SkillViewPhaseType.ContinueAttack
end

function SkillPhaseParamContinueAttack:GetStartIndex()
  return self._startIndex
end

function SkillPhaseParamContinueAttack:GetLastStartIndex()
  return self._lastStartIndex
end

function SkillPhaseParamContinueAttack:GetAudioId()
  return self._audioId
end

function SkillPhaseParamContinueAttack:GetAnimName()
  return self._animName
end

function SkillPhaseParamContinueAttack:GetEffectId()
  return self._effectId
end

function SkillPhaseParamContinueAttack:GetEffectOffsetX()
  return self._effectOffsetX
end

function SkillPhaseParamContinueAttack:GetEffectOffsetY()
  return self._effectOffsetY
end

function SkillPhaseParamContinueAttack:GetEffectOffsetZ()
  return self._effectOffsetZ
end

function SkillPhaseParamContinueAttack:GetWaitEffectTime()
  return self._waitEffectTime
end

function SkillPhaseParamContinueAttack:GetWaitBulletEffectTime()
  return self._waitBulletEffectTime
end

function SkillPhaseParamContinueAttack:GetWaitAnimTime()
  return self._waitAnimTime
end

function SkillPhaseParamContinueAttack:GetBulletEffectId()
  return self._bulletEffectId
end

function SkillPhaseParamContinueAttack:GetBulletFlySpeed()
  return self._bulletFlySpeed
end

function SkillPhaseParamContinueAttack:GetBulletFlyTrace()
  return self._bulletFlyTrace
end

function SkillPhaseParamContinueAttack:GetBulletEffectOffsetX()
  return self._bulletEffectOffsetX
end

function SkillPhaseParamContinueAttack:GetBulletEffectOffsetY()
  return self._bulletEffectOffsetY
end

function SkillPhaseParamContinueAttack:GetBulletEffectOffsetZ()
  return self._bulletEffectOffsetZ
end

function SkillPhaseParamContinueAttack:GetWaitHitTime()
  return self._waitHitTime
end

function SkillPhaseParamContinueAttack:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseParamContinueAttack:GetHitEffectId()
  return self._hitEffectID
end

function SkillPhaseParamContinueAttack:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseParamContinueAttack:GetDeathClear()
  return self._deathClear
end
