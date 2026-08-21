require("skill_phase_param_base")
_class("SkillPhaseScopeForwardTransformNoAttackParam", SkillPhaseParamBase)
SkillPhaseScopeForwardTransformNoAttackParam = SkillPhaseScopeForwardTransformNoAttackParam

function SkillPhaseScopeForwardTransformNoAttackParam:Constructor(t)
  self._gridEffectIDs = t.gridEffectIDs
  self._gridEdgeEffectID = t.gridEdgeEffectID
  self._gridIntervalTime = t.gridIntervalTime
  self._bestConvertTime = t.bestConvertTime
  self._finishDelayTime = t.finishDelayTime
  self._hasDamage = t.hasDamage
  self._hasConvert = t.hasConvert
  self._hitAnimationName = t.hitAnimationName
  self._hitEffectID = t.hitEffectID
  self._gridEffectDirection = t.gridEffectDirection
  self._effScaleStart = t.effScaleStart
  self._defaultScale = t.defaultScale
  self._layerScale = t.layerScale
  self._effectIgnore = t.effectIgnore or 0
  self._needRotateEff = t.needRotateEff or 1
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetCacheTable()
  local t = {}
  if self._gridEffectIDs and #self._gridEffectIDs > 0 then
    for _, effID in ipairs(self._gridEffectIDs) do
      t[#t + 1] = {
        Cfg.cfg_effect[effID].ResPath,
        1
      }
    end
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetPhaseType()
  return SkillViewPhaseType.ScopeForwardTransformNoAttack
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetGridEffectIDs()
  return self._gridEffectIDs
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseScopeForwardTransformNoAttackParam:HasDamage()
  if self._hasDamage then
    return self._hasDamage == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardTransformNoAttackParam:HasConvert()
  if self._hasConvert then
    return self._hasConvert == 1
  else
    return false
  end
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetGridEffectTime()
  return self._gridEffectTime
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetEffectDirection()
  return self._gridEffectDirection
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetGridEdgeEffect()
  return self._gridEdgeEffectID
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetEffectStart()
  return self._effScaleStart
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetDefaultScale()
  return self._defaultScale
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetLayerScale()
  return self._layerScale
end

function SkillPhaseScopeForwardTransformNoAttackParam:GetEffectIgnore()
  return self._effectIgnore
end

function SkillPhaseScopeForwardTransformNoAttackParam:IsNeedRotateEff()
  if self._needRotateEff ~= 1 then
    return false
  end
  return true
end
