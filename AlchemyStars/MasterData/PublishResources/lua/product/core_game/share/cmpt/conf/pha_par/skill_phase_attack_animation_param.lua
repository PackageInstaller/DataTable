require("skill_phase_param_base")
_class("SkillPhaseAttackEffectAnimationParam", SkillPhaseParamBase)
SkillPhaseAttackEffectAnimationParam = SkillPhaseAttackEffectAnimationParam

function SkillPhaseAttackEffectAnimationParam:Constructor(t)
  self._castEffectID = t.castEffectID
  self._castAnimation = t.castAnimation
  self._hitPointDelay = t.hitPointDelay
  self._hitAnimation = t.onHitAnimation
  self._hitEffectID = t.hitEffectID
  self._castTotalTime = t.castTotalTime
  self._hpDelayTime = t.hpDelayTime
end

function SkillPhaseAttackEffectAnimationParam:GetPhaseType()
  return SkillViewPhaseType.EffectRangeAttack
end

function SkillPhaseAttackEffectAnimationParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseAttackEffectAnimationParam:GetAnimationName()
  return self._castAnimation
end

function SkillPhaseAttackEffectAnimationParam:GetHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseAttackEffectAnimationParam:GetHitAnimation()
  return self._hitAnimation
end

function SkillPhaseAttackEffectAnimationParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseAttackEffectAnimationParam:GetCastTotalTime()
  return self._castTotalTime
end

function SkillPhaseAttackEffectAnimationParam:GetCacheTable()
  local cacheNum = 4
  local t = {}
  if self._castEffectID and self._castEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      cacheNum
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      cacheNum
    })
  end
  return t
end

function SkillPhaseAttackEffectAnimationParam:GetHPDelay()
  return self._hpDelayTime
end
