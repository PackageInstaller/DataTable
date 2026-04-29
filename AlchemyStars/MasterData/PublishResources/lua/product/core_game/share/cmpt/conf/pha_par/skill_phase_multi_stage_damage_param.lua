require("skill_phase_param_base")
_class("SkillPhaseMultiStageDamageParam", SkillPhaseParamBase)
SkillPhaseMultiStageDamageParam = SkillPhaseMultiStageDamageParam

function SkillPhaseMultiStageDamageParam:Constructor(t)
  self._turnToTarget = t.turnToTarget
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._deathClear = false
  self._stageCount = t.stageCount
  self._intervalTime = t.intervalTime or 300
  self._random = t.random or 0
  self._randomPercent = t.randomPercent or 10
end

function SkillPhaseMultiStageDamageParam:GetCacheTable()
  local t = {}
  local gridFxCacheElement = self:GenerateCacheTableElementByID(self._hitEffectID)
  table.insert(t, gridFxCacheElement)
  return t
end

function SkillPhaseMultiStageDamageParam:GetPhaseType()
  return SkillViewPhaseType.MultiStageDamage
end

function SkillPhaseMultiStageDamageParam:GetTurnToTarget()
  return self._turnToTarget
end

function SkillPhaseMultiStageDamageParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseMultiStageDamageParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseMultiStageDamageParam:GetStageCount()
  return self._stageCount
end

function SkillPhaseMultiStageDamageParam:GetIntervalTime()
  return self._intervalTime
end

function SkillPhaseMultiStageDamageParam:GetRandom()
  return self._random
end

function SkillPhaseMultiStageDamageParam:GetRandomPercent()
  return self._randomPercent
end
