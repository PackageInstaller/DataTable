require("skill_phase_param_base")
_class("SkillPhaseAttackAnimationParam", SkillPhaseParamBase)
SkillPhaseAttackAnimationParam = SkillPhaseAttackAnimationParam

function SkillPhaseAttackAnimationParam:Constructor(t)
  self._hitAnimation = t.onHitAnimation
  self._castTotalTime = t.castTotalTime
  self._longCastTotalTime = t.longCastTotalTime
  self._hpDelayTime = t.hpDelayTime
  self._nDamageIndex = t.damageIndex or 1
  self._castAnimation = t.castAnimation
  self._castLongAnimation = t.castLongAnimation
  self._castEffectID = t.castEffectID
  self._hitEffectID = t.hitEffectID
  self._hitPointDelay = t.hitPointDelay
  self._longHitPointDelay = t.longHitPointDelay
  self._atkEffectDelay = t.atkEffectDelay or 0
  self._longAtkEffectDelay = t.longAtkEffectDelay or 0
  self._hitPointDelaySecond = t.hitPointDelaySecond
  self._longHitPointDelaySecond = t.longHitPointDelaySecond
  self._slantCastAnimation = t.slantCastAnimation
  self._slantCastLongAnimation = t.slantCastLongAnimation
  self._slantCastEffectID = t.slantCastEffectID
  self._slantHitEffectID = t.slantHitEffectID
  self._slantHitPointDelay = t.slantHitPointDelay
  self._slantLongHitPointDelay = t.slantLongHitPointDelay
  self._slantAtkEffectDelay = t.slantAtkEffectDelay or 0
  self._slantLongAtkEffectDelay = t.slantLongAtkEffectDelay or 0
  self._usePermanentEffectPlayAnim = t.usePermanentEffectPlayAnim
  self._permanentEffSpecialAnimRoot = t.permanentEffSpecialAnimRoot
  self._skillStageIndex = t.skillStageIndex
end

function SkillPhaseAttackAnimationParam:GetPhaseType()
  return SkillViewPhaseType.AttackAnimation
end

function SkillPhaseAttackAnimationParam:GetCastEffectID(isSlantAttack)
  if isSlantAttack then
    return self._slantCastEffectID
  end
  return self._castEffectID
end

function SkillPhaseAttackAnimationParam:GetSlantCastEffectID()
  return self._slantCastEffectID
end

function SkillPhaseAttackAnimationParam:GetAnimationName(isFinalAttack, isSlantAttack)
  if isSlantAttack then
    if isFinalAttack and self._slantCastLongAnimation then
      return self._slantCastLongAnimation
    else
      return self._slantCastAnimation
    end
  end
  if isFinalAttack and self._castLongAnimation then
    return self._castLongAnimation
  else
    return self._castAnimation
  end
end

function SkillPhaseAttackAnimationParam:GetHitPointDelay(isFinalAttack, isSlantAttack)
  if isSlantAttack then
    if isFinalAttack and self._slantLongHitPointDelay then
      return self._slantLongHitPointDelay
    else
      return self._slantHitPointDelay
    end
  end
  if isFinalAttack and self._longHitPointDelay then
    return self._longHitPointDelay
  else
    return self._hitPointDelay
  end
end

function SkillPhaseAttackAnimationParam:GetHitPointDelaySecond(isFinalAttack)
  if isFinalAttack and self._longHitPointDelaySecond then
    return self._longHitPointDelaySecond
  else
    return self._hitPointDelaySecond
  end
end

function SkillPhaseAttackAnimationParam:GetHitAnimation()
  return self._hitAnimation
end

function SkillPhaseAttackAnimationParam:GetHitEffectID(isSlantAttack)
  if isSlantAttack then
    return self._slantHitEffectID
  end
  return self._hitEffectID
end

function SkillPhaseAttackAnimationParam:GetCastTotalTime(isFinalAttack)
  if isFinalAttack and self._longCastTotalTime then
    return self._longCastTotalTime
  else
    return self._castTotalTime
  end
end

function SkillPhaseAttackAnimationParam:GetCacheTable()
  local t = {}
  if self._castEffectID and self._castEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._slantCastEffectID and 0 < self._slantCastEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._slantCastEffectID].ResPath,
      1
    })
  end
  if self._slantHitEffectID and 0 < self._slantHitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._slantHitEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseAttackAnimationParam:GetHPDelay()
  return self._hpDelayTime
end

function SkillPhaseAttackAnimationParam:GetHitEffectDelay(isFinalAttack, isSlantAttack)
  if isSlantAttack then
    if isFinalAttack and self._slantLongAtkEffectDelay then
      return self._slantLongAtkEffectDelay
    else
      return self._slantAtkEffectDelay
    end
  end
  if isFinalAttack and self._longAtkEffectDelay then
    return self._longAtkEffectDelay
  else
    return self._atkEffectDelay
  end
end

function SkillPhaseAttackAnimationParam:GetDamageIndex()
  return self._nDamageIndex
end

function SkillPhaseAttackAnimationParam:IsUsePermanentEffectPlayAnim()
  return self._usePermanentEffectPlayAnim
end

function SkillPhaseAttackAnimationParam:GetPermanentEffSpecialAnimRoot()
  return self._permanentEffSpecialAnimRoot
end

function SkillPhaseAttackAnimationParam:GetSkillStageIndex()
  return self._skillStageIndex
end
