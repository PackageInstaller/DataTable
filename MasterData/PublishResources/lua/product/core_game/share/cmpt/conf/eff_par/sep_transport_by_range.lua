require("skill_effect_param_base")
_class("SkillEffectParamTransportByRange", SkillEffectParamBase)
SkillEffectParamTransportByRange = SkillEffectParamTransportByRange

function SkillEffectParamTransportByRange:Constructor(t)
  self._isPickUp = t.isPickUp or 0
  self._transportTarget = t.transportTarget or false
end

function SkillEffectParamTransportByRange:GetEffectType()
  return SkillEffectType.TransportByRange
end

function SkillEffectParamTransportByRange:IsPickUp()
  return self._isPickUp
end

function SkillEffectParamTransportByRange:IsTransportTarget()
  return self._transportTarget == 1
end
