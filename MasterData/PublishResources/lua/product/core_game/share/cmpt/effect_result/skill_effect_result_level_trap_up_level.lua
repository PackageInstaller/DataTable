require("skill_effect_result_base")
_class("SkillEffectResultTrapUpLevel", SkillEffectResultBase)
SkillEffectResultTrapUpLevel = SkillEffectResultTrapUpLevel

function SkillEffectResultTrapUpLevel:Constructor(summonList, destroyList, hasMaxLevel)
  self._summonList = summonList or {}
  self._destroyList = destroyList or {}
  self._hasMaxLevel = hasMaxLevel or false
end

function SkillEffectResultTrapUpLevel:GetEffectType()
  return SkillEffectType.LevelTrapUpLevel
end

function SkillEffectResultTrapUpLevel:GetSummonList()
  return self._summonList
end

function SkillEffectResultTrapUpLevel:GetDestroyList()
  return self._destroyList
end

function SkillEffectResultTrapUpLevel:HasMaxLevel()
  return self._hasMaxLevel
end
