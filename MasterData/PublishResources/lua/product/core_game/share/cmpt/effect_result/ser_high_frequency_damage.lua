require("skill_effect_result_base")
_class("SkillEffectHighFrequencyDamageResult", SkillEffectResultBase)
SkillEffectHighFrequencyDamageResult = SkillEffectHighFrequencyDamageResult
SkillEffectHighFrequencyDamageResult.__EFFECT_TYPE = SkillEffectType.HighFrequencyDamage

function SkillEffectHighFrequencyDamageResult:Constructor(tDamageInfo)
  self._tDamageResult = tDamageInfo
  self._finalAttackIndex = 0
end

function SkillEffectHighFrequencyDamageResult:GetDamageResultArray()
  return self._tDamageResult
end

function SkillEffectHighFrequencyDamageResult:GetFinalAttackIndex()
  return self._finalAttackIndex
end

function SkillEffectHighFrequencyDamageResult:SetFinalAttackIndex(i)
  self._finalAttackIndex = i
end
