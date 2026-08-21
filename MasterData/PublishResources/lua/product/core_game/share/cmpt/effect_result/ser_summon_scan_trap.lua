require("skill_effect_result_base")
_class("SkillEffectResult_SummonScanTrap", SkillEffectResultBase)
SkillEffectResult_SummonScanTrap = SkillEffectResult_SummonScanTrap
SkillEffectResult_SummonScanTrap.__EFFECT_TYPE = SkillEffectType.SummonScanTrap

function SkillEffectResult_SummonScanTrap:Constructor(trapEntityID, tDestroyTrapID, tAddBuffResults)
  self._summonTrapEntityID = trapEntityID
  self._tDestroyTrapID = tDestroyTrapID
  self._tAddBuffResults = tAddBuffResults
end

function SkillEffectResult_SummonScanTrap:GetSummonTrapEntityID()
  return self._summonTrapEntityID
end

function SkillEffectResult_SummonScanTrap:GetDestroyTrapID()
  return self._tDestroyTrapID
end

function SkillEffectResult_SummonScanTrap:GetAddBuffResults()
  return self._tAddBuffResults
end
