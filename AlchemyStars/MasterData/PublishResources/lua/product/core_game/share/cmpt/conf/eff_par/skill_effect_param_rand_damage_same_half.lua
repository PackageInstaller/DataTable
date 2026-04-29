require("skill_damage_effect_param")
_class("SkillEffectParamRandDamageSameHalf", SkillDamageEffectParam)
SkillEffectParamRandDamageSameHalf = SkillEffectParamRandDamageSameHalf

function SkillEffectParamRandDamageSameHalf:Constructor(t)
  self._damageCount = t.damageCount
  self._dampPer = t.dampPer
  self._percentAdd = t.percentAdd or 0
  self._selTargetLoop = t.selTargetLoop or false
  self._damageRandomCount = t.damageRandomCount
  self._repeatAllSameHalf = t.repeatAllSameHalf
  self._keepDampList = t.keepDampList or false
  self._fakeRandomSeed = t.fakeRandomSeed
  self._isFakeRandom = false
  if self._fakeRandomSeed then
    self._isFakeRandom = true
  end
end

function SkillEffectParamRandDamageSameHalf:GetEffectType()
  return SkillEffectType.RandDamageSameHalf
end

function SkillEffectParamRandDamageSameHalf:GetDamageCount()
  return self._damageCount
end

function SkillEffectParamRandDamageSameHalf:GetPercentAdd()
  return self._percentAdd
end

function SkillEffectParamRandDamageSameHalf:GetDampPercent()
  return self._dampPer
end

function SkillEffectParamRandDamageSameHalf:GetIsSelTargetLoop()
  return self._selTargetLoop
end

function SkillEffectParamRandDamageSameHalf:GetIsFakeRandom()
  return self._isFakeRandom
end

function SkillEffectParamRandDamageSameHalf:GetFakeRandomSeed()
  return self._fakeRandomSeed
end

function SkillEffectParamRandDamageSameHalf:GetDamageRandomCount()
  return self._damageRandomCount
end

function SkillEffectParamRandDamageSameHalf:IsRepeatAllSameHalf()
  return self._repeatAllSameHalf
end

function SkillEffectParamRandDamageSameHalf:IsKeepDampList()
  return self._keepDampList
end
