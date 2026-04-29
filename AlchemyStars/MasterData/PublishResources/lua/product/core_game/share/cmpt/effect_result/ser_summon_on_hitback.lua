_class("SkillEffectSummonOnHitbackResult", SkillEffectResultBase)
SkillEffectSummonOnHitbackResult = SkillEffectSummonOnHitbackResult

function SkillEffectSummonOnHitbackResult:Constrctor(hitbackResultArray, summonResultArray)
  self._hitbackResults = hitbackResultArray
  self._summonResults = summonResultArray
end

function SkillEffectSummonOnHitbackResult:GetHitbackResultArray()
  return self._hitbackResults
end

function SkillEffectSummonOnHitbackResult:GetSummonResultArray()
  return self._summonResults
end
