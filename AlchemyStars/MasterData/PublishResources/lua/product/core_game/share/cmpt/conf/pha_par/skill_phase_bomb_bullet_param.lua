require("skill_phase_param_base")
_class("SkillPhaseBombBulletParam", SkillPhaseParamBase)
SkillPhaseBombBulletParam = SkillPhaseBombBulletParam

function SkillPhaseBombBulletParam:Constructor(t)
  self._bulletEffectId = t.bulletEffectId
  self._oneGridFlyTime = t.oneGridFlyTime
  self._bombEffectId = t.bombEffectId
  self._bombDelayTime = t.bombDelayTime
  self._bombEffectId2 = t.bombEffectId2
  self._damageDelayTime = t.damageDelayTime
  self._hitAnimName = t.hitAnimName
  self._hitEffectId = t.hitEffectId
  self._delayTime = t.delayTime
  self._audioId = t.audioID
end

function SkillPhaseBombBulletParam:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._bulletEffectId)
  self:AddEffectIDToListID(listID, self._bombEffectId)
  self:AddEffectIDToListID(listID, self._bombEffectId2)
  self:AddEffectIDToListID(listID, self._hitEffectId)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseBombBulletParam:GetSoundCacheTable()
  local t = {}
  table.insert(t, self._audioId)
  return t
end

function SkillPhaseBombBulletParam:GetAudioId()
  return self._audioId
end

function SkillPhaseBombBulletParam:GetPhaseType()
  return SkillViewPhaseType.BombBullet
end

function SkillPhaseBombBulletParam:GetBulletEffectId()
  return self._bulletEffectId
end

function SkillPhaseBombBulletParam:GetOnGridFlyTime()
  return self._oneGridFlyTime
end

function SkillPhaseBombBulletParam:GetBombEffectId()
  return self._bombEffectId
end

function SkillPhaseBombBulletParam:GetBombDelayTime()
  return self._bombDelayTime
end

function SkillPhaseBombBulletParam:GetBombEffectId2()
  return self._bombEffectId2
end

function SkillPhaseBombBulletParam:GetDamageDelayTime()
  return self._damageDelayTime
end

function SkillPhaseBombBulletParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseBombBulletParam:GetHitEffectId()
  return self._hitEffectId
end

function SkillPhaseBombBulletParam:GetDelayTime()
  return self._delayTime
end
