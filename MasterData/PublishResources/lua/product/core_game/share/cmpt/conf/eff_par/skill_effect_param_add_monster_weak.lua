require("skill_effect_param_base")
require("skill_damage_effect_param")
_class("SkillEffectParamAddMonsterWeak", SkillDamageEffectParam)
SkillEffectParamAddMonsterWeak = SkillEffectParamAddMonsterWeak
local AddMonsterWeakType = {
  SelectMonster = 1,
  AllMonster = 2,
  MAX = 9
}
_enum("AddMonsterWeakType", AddMonsterWeakType)

function SkillEffectParamAddMonsterWeak:Constructor(t)
  self._count = t.count
  self._type = t.type or AddMonsterWeakType.SelectMonster
  self._extraProb = t.extraProb or 0
end

function SkillEffectParamAddMonsterWeak:GetEffectType()
  return SkillEffectType.AddMonsterWeak
end

function SkillEffectParamAddMonsterWeak:GetAddMonsterWeakType()
  return self._type
end

function SkillEffectParamAddMonsterWeak:GetAddMonsterWeakCount()
  return self._count
end

function SkillEffectParamAddMonsterWeak:GetExtraProb()
  return self._extraProb
end
