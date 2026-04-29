require("skill_effect_result_base")
_class("SkillEffectResultLevelTrapSummonOrUpLevel", SkillEffectResultBase)
SkillEffectResultLevelTrapSummonOrUpLevel = SkillEffectResultLevelTrapSummonOrUpLevel

function SkillEffectResultLevelTrapSummonOrUpLevel:Constructor(summonList, destroyList, hasMaxLevel)
  self._summonList = summonList or {}
  self._destroyList = destroyList or {}
  self._hasMaxLevel = hasMaxLevel or false
end

function SkillEffectResultLevelTrapSummonOrUpLevel:GetEffectType()
  return SkillEffectType.LevelTrapSummonOrUpLevel
end

function SkillEffectResultLevelTrapSummonOrUpLevel:GetSummonList()
  return self._summonList
end

function SkillEffectResultLevelTrapSummonOrUpLevel:GetDestroyList()
  return self._destroyList
end

function SkillEffectResultLevelTrapSummonOrUpLevel:HasMaxLevel()
  return self._hasMaxLevel
end
