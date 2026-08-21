require("skill_damage_effect_param")
_class("SkillEffectDetachMonsterParam", SkillEffectParamBase)
SkillEffectDetachMonsterParam = SkillEffectDetachMonsterParam

function SkillEffectDetachMonsterParam:Constructor(t)
  self._element = t.element
  self._removeElite = t.removeElite or false
end

function SkillEffectDetachMonsterParam:GetEffectType()
  return SkillEffectType.DetachMonster
end

function SkillEffectDetachMonsterParam:GetElement()
  return self._element
end

function SkillEffectDetachMonsterParam:IsRemoveElite()
  return self._removeElite
end
