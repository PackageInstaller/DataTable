require("skill_damage_effect_param")
require("skill_hit_back_effect_param")
_class("SkillEffectParamDamageAfterHitBack", SkillHitBackEffectParam)
SkillEffectParamDamageAfterHitBack = SkillEffectParamDamageAfterHitBack

function SkillEffectParamDamageAfterHitBack:Constructor(t)
  self._hitBackPercent = t.hitBackPercent
  self._hitBackFormulaID = t.hitBackFormulaID
  self._stopPercent = t.stopPercent
  self._stopFormulaID = t.stopFormulaID
  self._times = t.times
end

function SkillEffectParamDamageAfterHitBack:GetTimes()
  return self._times
end

function SkillEffectParamDamageAfterHitBack:GetEffectType()
  return SkillEffectType.DamageAfterHitBack
end

function SkillEffectParamDamageAfterHitBack:GetHitBackPercent()
  return self._hitBackPercent
end

function SkillEffectParamDamageAfterHitBack:GetHitBackFormulaID()
  return self._hitBackFormulaID
end

function SkillEffectParamDamageAfterHitBack:GetStopPercent()
  return self._stopPercent
end

function SkillEffectParamDamageAfterHitBack:GetStopFormulaID()
  return self._stopFormulaID
end
