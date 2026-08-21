require("skill_phase_param_base")
_class("SkillPhaseNormalAttackForAddBloodParam", SkillPhaseParamBase)
SkillPhaseNormalAttackForAddBloodParam = SkillPhaseNormalAttackForAddBloodParam

function SkillPhaseNormalAttackForAddBloodParam:Constructor(t)
  self._castTotalTime = t.castTotalTime
  self._longCastTotalTime = t.longCastTotalTime
  self._hpDelayTime = t.hpDelayTime
  self._nDamageIndex = t.damageIndex or 1
  self._castAnimation = t.castAnimation
  self._castLongAnimation = t.castLongAnimation
  self._castEffectID = t.castEffectID
  self._hitPointDelay = t.hitPointDelay
  self._longHitPointDelay = t.longHitPointDelay
  self._atkEffectDelay = t.atkEffectDelay or 0
  self._longAtkEffectDelay = t.longAtkEffectDelay or 0
  self._normalDoubleHitEffectID = t.normalDoubleHitEffectID
  self._normalDoubleHitAnimation = t.normalDoubleHitAnimation
end

function SkillPhaseNormalAttackForAddBloodParam:GetPhaseType()
  return SkillViewPhaseType.NormalAttackForAddBlood
end

function SkillPhaseNormalAttackForAddBloodParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseNormalAttackForAddBloodParam:GetAnimationName(isFinalAttack)
  if isFinalAttack and self._castLongAnimation then
    return self._castLongAnimation
  else
    return self._castAnimation
  end
end

function SkillPhaseNormalAttackForAddBloodParam:GetHitPointDelay(isFinalAttack)
  if isFinalAttack and self._longHitPointDelay then
    return self._longHitPointDelay
  else
    return self._hitPointDelay
  end
end

function SkillPhaseNormalAttackForAddBloodParam:GetCastTotalTime(isFinalAttack)
  if isFinalAttack and self._longCastTotalTime then
    return self._longCastTotalTime
  else
    return self._castTotalTime
  end
end

function SkillPhaseNormalAttackForAddBloodParam:GetCacheTable()
  local t = {}
  if self._castEffectID and self._castEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseNormalAttackForAddBloodParam:GetHPDelay()
  return self._hpDelayTime
end

function SkillPhaseNormalAttackForAddBloodParam:GetHitEffectDelay(isFinalAttack)
  if isFinalAttack and self._longAtkEffectDelay then
    return self._longAtkEffectDelay
  else
    return self._atkEffectDelay
  end
end

function SkillPhaseNormalAttackForAddBloodParam:GetDamageIndex()
  return self._nDamageIndex
end

function SkillPhaseNormalAttackForAddBloodParam:GetNormalDoubleHitEffectID()
  return self._normalDoubleHitEffectID
end

function SkillPhaseNormalAttackForAddBloodParam:GetNormalDoubleHitAnimation()
  return self._normalDoubleHitAnimation
end
