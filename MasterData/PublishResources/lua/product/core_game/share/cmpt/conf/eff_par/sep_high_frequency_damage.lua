require("skill_damage_effect_param")
_class("SkillEffectParam_HighFrequencyDamage", SkillDamageEffectParam)
SkillEffectParam_HighFrequencyDamage = SkillEffectParam_HighFrequencyDamage

function SkillEffectParam_HighFrequencyDamage:Constructor(paramList)
  self._maxAttackTimes = tonumber(paramList.maxAttackTimes)
  if not self._maxAttackTimes then
    Log.exception(self._className, "需要maxAttackTimes参数")
  end
  self._paramList = paramList
  self._tractionOnLastTarget = tonumber(paramList.tractionOnLastTarget) == 1
  self._lastTargetBuffID = tonumber(paramList.lastTargetBuffID)
  if self._lastTargetBuffID and not Cfg.cfg_buff[self._lastTargetBuffID] then
    Log.exception(self._className, "lastTargetBuffID 在buff表中没找到：", tostring(self._lastTargetBuffID))
  end
  self._serialScopeType = paramList.serialScopeType
  self._radius = paramList.radius
  self._pieceType = paramList.pieceType
  self._onePieceAddAttackCount = paramList.onePieceAddAttackCount
end

function SkillEffectParam_HighFrequencyDamage:GetEffectType()
  return SkillEffectType.HighFrequencyDamage
end

function SkillEffectParam_HighFrequencyDamage:GetMaxAttackTimes()
  return self._maxAttackTimes
end

function SkillEffectParam_HighFrequencyDamage:GetParamList()
  return self._paramList
end

function SkillEffectParam_HighFrequencyDamage:IsTractionOnLastTarget()
  return self._tractionOnLastTarget
end

function SkillEffectParam_HighFrequencyDamage:GetLastTargetBuffID()
  return self._lastTargetBuffID
end

function SkillEffectParam_HighFrequencyDamage:GetSerialScopeType()
  return self._serialScopeType
end

function SkillEffectParam_HighFrequencyDamage:GetRadius()
  return self._radius
end

function SkillEffectParam_HighFrequencyDamage:GetPieceType()
  return self._pieceType
end

function SkillEffectParam_HighFrequencyDamage:GetOnePieceAddAttackCount()
  return self._onePieceAddAttackCount
end
