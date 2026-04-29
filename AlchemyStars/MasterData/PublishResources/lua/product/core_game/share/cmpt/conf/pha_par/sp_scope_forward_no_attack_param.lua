require("skill_phase_param_base")
_class("SkillPhaseScopeForwardNoAttackParam", SkillPhaseParamBase)
SkillPhaseScopeForwardNoAttackParam = SkillPhaseScopeForwardNoAttackParam

function SkillPhaseScopeForwardNoAttackParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._gridIntervalTime = t.gridIntervalTime
  self._bestConvertTime = t.bestConvertTime
  self._finishDelayTime = t.finishDelayTime
  self._hasDamage = t.hasDamage
  self._hasConvert = t.hasConvert
  self._hitAnimationName = t.hitAnimationName
  self._hitEffectID = t.hitEffectID
  self._gridEffectDirection = t.gridEffectDirection
  self._backward = t.backward
  self._backwardByPickNum = t.backwardByPickNum
end

function SkillPhaseScopeForwardNoAttackParam:GetCacheTable(skillConfigData)
  local skillScopeType = skillConfigData:GetSkillScopeType()
  local skillScopeParam = skillConfigData:GetSkillScopeParam()
  local cacheNum = self:_CalcScopeRangeGridNum(skillScopeType, skillScopeParam)
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      cacheNum
    }
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      cacheNum
    }
  end
  return t
end

function SkillPhaseScopeForwardNoAttackParam:GetPhaseType()
  return SkillViewPhaseType.ScopeForwardNoAttack
end

function SkillPhaseScopeForwardNoAttackParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseScopeForwardNoAttackParam:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseScopeForwardNoAttackParam:GetBestEffectTime()
  return self._bestConvertTime
end

function SkillPhaseScopeForwardNoAttackParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseScopeForwardNoAttackParam:HasDamage()
  if self._hasDamage then
    return self._hasDamage == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardNoAttackParam:HasConvert()
  if self._hasConvert then
    return self._hasConvert == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardNoAttackParam:GetGridEffectTime()
  return self._gridEffectTime
end

function SkillPhaseScopeForwardNoAttackParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseScopeForwardNoAttackParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseScopeForwardNoAttackParam:GetEffectDirection()
  return self._gridEffectDirection
end

function SkillPhaseScopeForwardNoAttackParam:IsBackward(pickNum)
  if self._backward then
    return self._backward == 1
  elseif self._backwardByPickNum and pickNum and self._backwardByPickNum == pickNum then
    return true
  end
  return false
end
