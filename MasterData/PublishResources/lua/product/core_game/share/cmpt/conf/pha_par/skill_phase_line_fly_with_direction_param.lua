require("skill_phase_param_base")
_class("SkillPhaseLineFlyWithDirectionParam", SkillPhaseParamBase)
SkillPhaseLineFlyWithDirectionParam = SkillPhaseLineFlyWithDirectionParam

function SkillPhaseLineFlyWithDirectionParam:Constructor(t)
  self._effectID = t.effectID
  self._effectDirection = t.effectDirection
  self._finishDelayTime = t.finishDelayTime
  self._effectFlyOneGridMs = t.effectFlyOneGridMs
  self._effectHit = t.effectHit
  self._hitAnimationName = t.hitAnimationName
  self._hasDamage = t.hasDamage
end

function SkillPhaseLineFlyWithDirectionParam:GetCacheTable()
  local t = {}
  if self._effectID and self._effectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    }
  end
  if self._effectHit and 0 < self._effectHit then
    t[#t + 1] = {
      Cfg.cfg_effect[self._effectHit].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseLineFlyWithDirectionParam:GetPhaseType()
  return SkillViewPhaseType.EffectLineFlyWithDirection
end

function SkillPhaseLineFlyWithDirectionParam:GetEffectID()
  return self._effectID
end

function SkillPhaseLineFlyWithDirectionParam:GetEffectDirection()
  return self._effectDirection
end

function SkillPhaseLineFlyWithDirectionParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseLineFlyWithDirectionParam:GetEffectFlyOneGridMs()
  return self._effectFlyOneGridMs
end

function SkillPhaseLineFlyWithDirectionParam:GetHitEffect()
  return self._effectHit
end

function SkillPhaseLineFlyWithDirectionParam:GetHitAnimation()
  return self._hitAnimationName
end

function SkillPhaseLineFlyWithDirectionParam:HasDamage()
  if self._hasDamage then
    return self._hasDamage == 1
  end
  return false
end
