require("skill_phase_param_base")
_class("SkillPhaseScopeForwardParam", SkillPhaseParamBase)
SkillPhaseScopeForwardParam = SkillPhaseScopeForwardParam

function SkillPhaseScopeForwardParam:Constructor(t)
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

function SkillPhaseScopeForwardParam:GetCacheTable(skillConfigData)
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

function SkillPhaseScopeForwardParam:GetPhaseType()
  return SkillViewPhaseType.ScopeForward
end

function SkillPhaseScopeForwardParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseScopeForwardParam:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseScopeForwardParam:GetBestEffectTime()
  return self._bestConvertTime
end

function SkillPhaseScopeForwardParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseScopeForwardParam:HasDamage()
  if self._hasDamage then
    return self._hasDamage == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardParam:HasConvert()
  if self._hasConvert then
    return self._hasConvert == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardParam:GetGridEffectTime()
  return self._gridEffectTime
end

function SkillPhaseScopeForwardParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseScopeForwardParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseScopeForwardParam:GetEffectDirection()
  return self._gridEffectDirection
end

function SkillPhaseScopeForwardParam:IsBackward(pickNum)
  if self._backward then
    return self._backward == 1
  elseif self._backwardByPickNum and pickNum and self._backwardByPickNum == pickNum then
    return true
  end
  return false
end
