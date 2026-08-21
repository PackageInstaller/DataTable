require("skill_damage_effect_param")
_class("SkillEffectTrapSummonMonsterParam", SkillEffectParamBase)
SkillEffectTrapSummonMonsterParam = SkillEffectTrapSummonMonsterParam

function SkillEffectTrapSummonMonsterParam:Constructor(t)
  self._summonType = t.summonType
  self._monsterIDList = t.monsterIDList
  self._interval = t.interval
  self._delay = t.delay or 0
end

function SkillEffectTrapSummonMonsterParam:GetEffectType()
  return SkillEffectType.TrapSummonMonster
end

function SkillEffectTrapSummonMonsterParam:GetSummonType()
  return self._summonType
end

function SkillEffectTrapSummonMonsterParam:GetMonsterIDList()
  return self._monsterIDList
end

function SkillEffectTrapSummonMonsterParam:GetInterval()
  return self._interval
end

function SkillEffectTrapSummonMonsterParam:GetDelay()
  return self._delay
end

local TrapSummonMonsterType = {SequenceType = 1, CycleType = 2}
_enum("TrapSummonMonsterType", TrapSummonMonsterType)
