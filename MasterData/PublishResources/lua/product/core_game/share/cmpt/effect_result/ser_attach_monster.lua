require("skill_effect_result_base")
_class("SkillEffectAttachMonsterResult", SkillEffectResultBase)
SkillEffectAttachMonsterResult = SkillEffectAttachMonsterResult

function SkillEffectAttachMonsterResult:Constructor(targetID, eliteIDArray)
  self._targetID = targetID
  self._eliteIDArray = eliteIDArray
  self._newBuffSeqArray = {}
end

function SkillEffectAttachMonsterResult:GetEffectType()
  return SkillEffectType.AttachMonster
end

function SkillEffectAttachMonsterResult:GetTargetID()
  return self._targetID
end

function SkillEffectAttachMonsterResult:GetEliteIDArray()
  return self._eliteIDArray
end

function SkillEffectAttachMonsterResult:AddBuffSeq(buffSeq)
  self._newBuffSeqArray[#self._newBuffSeqArray + 1] = buffSeq
end

function SkillEffectAttachMonsterResult:GetAddBuffSeqArray()
  return self._newBuffSeqArray
end
