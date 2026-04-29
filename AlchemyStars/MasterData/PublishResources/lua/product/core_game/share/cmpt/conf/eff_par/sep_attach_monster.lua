require("skill_damage_effect_param")
_class("SkillEffectAttachMonsterParam", SkillEffectParamBase)
SkillEffectAttachMonsterParam = SkillEffectAttachMonsterParam

function SkillEffectAttachMonsterParam:Constructor(t)
  self._element = t.element
  self._addElite = t.addElite or false
end

function SkillEffectAttachMonsterParam:GetEffectType()
  return SkillEffectType.AttachMonster
end

function SkillEffectAttachMonsterParam:GetElement()
  return self._element
end

function SkillEffectAttachMonsterParam:IsAddElite()
  return self._addElite
end
