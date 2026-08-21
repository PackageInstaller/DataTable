require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectParamDetonateMonsterWeak", SkillDamageEffectParam)
SkillEffectParamDetonateMonsterWeak = SkillEffectParamDetonateMonsterWeak
local DetonateMonsterWeakType = {
  NormalAttack = 1,
  ChainInScope = 2,
  ActivePick = 3,
  MAX = 9
}
_enum("DetonateMonsterWeakType", DetonateMonsterWeakType)

function SkillEffectParamDetonateMonsterWeak:Constructor(t)
  self._count = t.count or 1
  self._type = t.type
  self._splashTargetType = t.splashTargetType
  self._splashScopeType = t.splashScopeType
  self._splashScopeParam = t.splashScopeParam
  self._splashFormulaID = t.splashFormulaID
  self._splashPercent = t.splashPercent
end

function SkillEffectParamDetonateMonsterWeak:GetEffectType()
  return SkillEffectType.DetonateMonsterWeak
end

function SkillEffectParamDetonateMonsterWeak:GetDetonateMonsterWeakType()
  return self._type
end

function SkillEffectParamDetonateMonsterWeak:GetDetonateMonsterWeakCount()
  return self._count
end

function SkillEffectParamDetonateMonsterWeak:GetSplashTargetType()
  return self._splashTargetType
end

function SkillEffectParamDetonateMonsterWeak:GetSplashScopeType()
  return self._splashScopeType
end

function SkillEffectParamDetonateMonsterWeak:GetSplashScopeParam()
  return self._splashScopeParam
end

function SkillEffectParamDetonateMonsterWeak:GetSplashFormulaID()
  return self._splashFormulaID
end

function SkillEffectParamDetonateMonsterWeak:GetSplashPercent()
  return self._splashPercent
end
