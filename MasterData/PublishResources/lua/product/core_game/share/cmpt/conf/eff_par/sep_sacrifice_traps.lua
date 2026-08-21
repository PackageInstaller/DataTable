require("skill_damage_effect_param")
_class("SkillEffectSacrificeTrapsParam", SkillEffectParamBase)
SkillEffectSacrificeTrapsParam = SkillEffectSacrificeTrapsParam

function SkillEffectSacrificeTrapsParam:Constructor(t)
  self._trapID = {}
  if type(t.trapID) == "number" then
    self._trapID[t.trapID] = true
  elseif type(t.trapID) == "table" then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
end

function SkillEffectSacrificeTrapsParam:GetEffectType()
  return SkillEffectType.SacrificeTraps
end

function SkillEffectSacrificeTrapsParam:GetTrapID()
  return self._trapID
end
