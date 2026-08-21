require("skill_effect_param_base")
TractionCenterType = {
  Normal = 0,
  PetANaTuoLi = 1,
  BossANaTuoLi = 2,
  MAX = 9
}
_enum("TractionCenterType", TractionCenterType)
_class("SkillEffectMultiTractionParam", SkillEffectParamBase)
SkillEffectMultiTractionParam = SkillEffectMultiTractionParam

function SkillEffectMultiTractionParam:Constructor(t)
  self._finalDamageIncreaseRate = tonumber(t.finalDamageIncreaseRate)
  self._casterCentered = tonumber(t.casterCentered) == 1
  self._maxMoveStep = tonumber(t.maxMoveStep) or 0
  self._forceMove = tonumber(t.forceMove) == 1 or false
  self._enableByPickNum = t.enableByPickNum
  self._canMoveToCenter = t.canMoveToCenter
  self._tractionCenterType = t.tractionCenterType or TractionCenterType.Normal
  self._skipTractionByPickNum = t.skipTractionByPickNum
  self._isPreview = t.isPreview
  self._petANaTuoLiCanTractionSelf = t.petANaTuoLiCanTractionSelf
  self._bossANaTuoLiTractionMonsterClassID = t.bossANaTuoLiTractionMonsterClassID
end

function SkillEffectMultiTractionParam:GetEffectType()
  return SkillEffectType.MultiTraction
end

function SkillEffectMultiTractionParam:GetFinalDamageIncreaseRate()
  return self._finalDamageIncreaseRate
end

function SkillEffectMultiTractionParam:IsCasterCentered()
  return self._casterCentered
end

function SkillEffectMultiTractionParam:GetMaxMoveStep()
  return self._maxMoveStep
end

function SkillEffectMultiTractionParam:GetEnableByPickNum()
  return self._enableByPickNum
end

function SkillEffectMultiTractionParam:GetForceMove()
  return self._forceMove
end

function SkillEffectMultiTractionParam:GetCanMoveToCenter()
  return self._canMoveToCenter
end

function SkillEffectMultiTractionParam:GetTractionCenterType()
  return self._tractionCenterType
end

function SkillEffectMultiTractionParam:GetSkipTractionByPickNum()
  return self._skipTractionByPickNum
end

function SkillEffectMultiTractionParam:GetIsPreview()
  return self._isPreview and self._isPreview == 1
end

function SkillEffectMultiTractionParam:GetPetANaTuoLiCanTractionSelf()
  return self._petANaTuoLiCanTractionSelf and self._petANaTuoLiCanTractionSelf == 1
end

function SkillEffectMultiTractionParam:GetBossANaTuoLiTractionMonsterClassID()
  return self._bossANaTuoLiTractionMonsterClassID
end
