require("skill_effect_param_summon_everything")
local SummonMonsterFindPosType = {RangRandom = 1, RangeFixed4 = 2}
_enum("SummonMonsterFindPosType", SummonMonsterFindPosType)
_class("SkillEffectParam_SummonMonster", SkillEffectParam_SummonEverything)
SkillEffectParam_SummonMonster = SkillEffectParam_SummonMonster

function SkillEffectParam_SummonMonster:GetEffectType()
  return SkillEffectType.SummonMonster
end

function SkillEffectParam_SummonMonster:Constructor(t)
  self._monsterID = t.monsterID
  self._findPosType = t.findPosType
end

function SkillEffectParam_SummonMonster:GetMonsterID()
  return self._monsterID
end

function SkillEffectParam_SummonMonster:GetFindPosType()
  return self._findPosType
end
