require("skill_damage_effect_param")
_class("SkillEffectParamAppointChain", SkillDamageEffectParam)
SkillEffectParamAppointChain = SkillEffectParamAppointChain

function SkillEffectParamAppointChain:Constructor(t)
  self._baseValue = t.baseValue
  self._mulValue = t.mulValue
  self._trapBuffID = t.trapBuffID
  self._petBuffID = t.petBuffID
  self._addCount = t.addCount or 1
end

function SkillEffectParamAppointChain:GetAddCount()
  return self._addCount
end

function SkillEffectParamAppointChain:GetBaseValue()
  return self._baseValue
end

function SkillEffectParamAppointChain:GetMulValue()
  return self._mulValue
end

function SkillEffectParamAppointChain:GetEffectType()
  return SkillEffectType.AppointCastChain
end

function SkillEffectParamAppointChain:GetTrapBuffID()
  return self._trapBuffID
end

function SkillEffectParamAppointChain:GetPetBuffID()
  return self._petBuffID
end
