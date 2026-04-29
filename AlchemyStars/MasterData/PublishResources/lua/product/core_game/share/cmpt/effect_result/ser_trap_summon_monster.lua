require("skill_effect_result_base")
_class("SkillEffectTrapSummonMonsterResult", SkillEffectResultBase)
SkillEffectTrapSummonMonsterResult = SkillEffectTrapSummonMonsterResult

function SkillEffectTrapSummonMonsterResult:Constructor(summonEntityID, trapOpenStateChange, trapOpenState)
  self._summonEntityID = summonEntityID
  self._trapOpenStateChange = trapOpenStateChange or false
  self._trapOpenState = trapOpenState
  self._monsterTransformParam = nil
end

function SkillEffectTrapSummonMonsterResult:SetMonsterTransformParam(param)
  self._monsterTransformParam = param
end

function SkillEffectTrapSummonMonsterResult:GetMonsterTransformParam()
  return self._monsterTransformParam
end

function SkillEffectTrapSummonMonsterResult:GetEffectType()
  return SkillEffectType.TrapSummonMonster
end

function SkillEffectTrapSummonMonsterResult:GetSummonEntityID()
  return self._summonEntityID
end

function SkillEffectTrapSummonMonsterResult:GetTrapOpenStateChange()
  return self._trapOpenStateChange
end

function SkillEffectTrapSummonMonsterResult:SetTrapOpenStateChange(change)
  self._trapOpenStateChange = true
end

function SkillEffectTrapSummonMonsterResult:SetTrapOpenState(state)
  self._trapOpenState = state
end

function SkillEffectTrapSummonMonsterResult:GetTrapOpenState()
  return self._trapOpenState
end
