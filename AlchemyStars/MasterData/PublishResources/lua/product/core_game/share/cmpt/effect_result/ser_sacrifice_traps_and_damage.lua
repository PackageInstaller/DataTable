require("skill_effect_result_base")
_class("SkillEffectSacrificeTrapsAndDamageResult", SkillEffectResultBase)
SkillEffectSacrificeTrapsAndDamageResult = SkillEffectSacrificeTrapsAndDamageResult

function SkillEffectSacrificeTrapsAndDamageResult:Constructor(trapIDs, damageResultArray)
  self._trapIDs = trapIDs
  self._damageResultArray = damageResultArray
end

function SkillEffectSacrificeTrapsAndDamageResult:GetTrapIDArray()
  return self._trapIDs
end

function SkillEffectSacrificeTrapsAndDamageResult:GetDamageResultArray()
  return self._damageResultArray
end

function SkillEffectSacrificeTrapsAndDamageResult:GetEffectType()
  return SkillEffectType.SacrificeTrapsAndDamage
end
