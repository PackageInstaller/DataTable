require("skill_damage_effect_param")
_class("SkillEffectDamageBySacrificeTrapsParam", SkillDamageEffectParam)
SkillEffectDamageBySacrificeTrapsParam = SkillEffectDamageBySacrificeTrapsParam

function SkillEffectDamageBySacrificeTrapsParam:Constructor(t)
  self._trapID = {}
  if type(t.trapID) == "number" then
    self._trapID[t.trapID] = true
  elseif type(t.trapID) == "table" then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
end

function SkillEffectDamageBySacrificeTrapsParam:GetTrapID()
  return self._trapID
end

function SkillEffectDamageBySacrificeTrapsParam:GetEffectType()
  return SkillEffectType.DamageBySacrificeTraps
end
