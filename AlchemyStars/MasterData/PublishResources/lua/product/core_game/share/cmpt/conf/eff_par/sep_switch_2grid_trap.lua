require("skill_damage_effect_param")
_class("SkillEffectParamSwitch2GridTrap", SkillDamageEffectParam)
SkillEffectParamSwitch2GridTrap = SkillEffectParamSwitch2GridTrap

function SkillEffectParamSwitch2GridTrap:Constructor(t)
  self._trapID = t.trapID
end

function SkillEffectParamSwitch2GridTrap:GetTrapID()
  return self._trapID
end

function SkillEffectParamSwitch2GridTrap:GetEffectType()
  return SkillEffectType.Switch2GridTrap
end
