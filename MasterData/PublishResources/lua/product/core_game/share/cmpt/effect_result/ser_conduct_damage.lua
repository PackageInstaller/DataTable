_class("SkillEffectConductDamage_AtomData", Object)
SkillEffectConductDamage_AtomData = SkillEffectConductDamage_AtomData

function SkillEffectConductDamage_AtomData:Constructor(conductIndex, damageResult)
  self._conductIndex = conductIndex
  self._damageResult = damageResult
end

function SkillEffectConductDamage_AtomData:GetDamageResult()
  return self._damageResult
end

require("skill_effect_result_base")
_class("SkillEffectConductDamageResult", SkillEffectResultBase)
SkillEffectConductDamageResult = SkillEffectConductDamageResult
SkillEffectConductDamageResult.__EFFECT_TYPE = SkillEffectType.ConductDamage

function SkillEffectConductDamageResult:Constructor(damageIndex, centerTargetID)
  self._damageIndex = damageIndex
  self._centerTargetID = centerTargetID
  self._atomDataArray = {}
end

function SkillEffectConductDamageResult:GetEffectType()
  return SkillEffectType.ConductDamage
end

function SkillEffectConductDamageResult:AddAtomData(atomData)
  table.insert(self._atomDataArray, atomData)
end

function SkillEffectConductDamageResult:CreateAtomData(...)
  local atomData = SkillEffectConductDamage_AtomData:New(...)
  table.insert(self._atomDataArray, atomData)
end

function SkillEffectConductDamageResult:GetAtomDataArray()
  return self._atomDataArray
end

function SkillEffectConductDamageResult:GetCenterTargetID()
  return self._centerTargetID
end
