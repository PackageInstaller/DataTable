require("skill_effect_result_base")
_class("SkillEffectResultLevelTrapAbsortSummon", SkillEffectResultBase)
SkillEffectResultLevelTrapAbsortSummon = SkillEffectResultLevelTrapAbsortSummon

function SkillEffectResultLevelTrapAbsortSummon:Constructor(summonList, destroyList, hasMaxLevel)
  self._summonList = summonList or {}
  self._destroyList = destroyList or {}
  self._hasMaxLevel = hasMaxLevel or false
end

function SkillEffectResultLevelTrapAbsortSummon:GetEffectType()
  return SkillEffectType.LevelTrapAbsortSummon
end

function SkillEffectResultLevelTrapAbsortSummon:GetSummonList()
  return self._summonList
end

function SkillEffectResultLevelTrapAbsortSummon:GetDestroyList()
  return self._destroyList
end

function SkillEffectResultLevelTrapAbsortSummon:HasMaxLevel()
  return self._hasMaxLevel
end
