require("skill_effect_result_base")
_class("SkillSuicideEffectResult", SkillEffectResultBase)
SkillSuicideEffectResult = SkillSuicideEffectResult

function SkillSuicideEffectResult:Constructor(targetid)
  self._targetID = targetid
end

function SkillSuicideEffectResult:GetEffectType()
  return SkillEffectType.Suicide
end

function SkillSuicideEffectResult:GetTargetID()
  return self._targetID
end

function SkillSuicideEffectResult:SetOtherDeadMonsterList(deadIDList)
  self._otherDeadMonsterList = deadIDList
end

function SkillSuicideEffectResult:GetOtherDeadMonsterList()
  return self._otherDeadMonsterList
end
