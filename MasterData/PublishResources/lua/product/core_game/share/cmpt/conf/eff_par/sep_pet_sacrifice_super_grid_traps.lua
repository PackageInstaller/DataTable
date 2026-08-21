require("skill_damage_effect_param")
_class("SkillEffectPetSacrificeSuperGridTrapsParam", SkillEffectParamBase)
SkillEffectPetSacrificeSuperGridTrapsParam = SkillEffectPetSacrificeSuperGridTrapsParam

function SkillEffectPetSacrificeSuperGridTrapsParam:Constructor(t)
  self._trapID = {}
  if type(t.trapID) == "number" then
    self._trapID[t.trapID] = true
  elseif type(t.trapID) == "table" then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
end

function SkillEffectPetSacrificeSuperGridTrapsParam:GetEffectType()
  return SkillEffectType.PetSacrificeSuperGridTraps
end

function SkillEffectPetSacrificeSuperGridTrapsParam:GetTrapID()
  return self._trapID
end
