require("skill_effect_result_base")
_class("SkillModifyBuffValueResult", SkillEffectResultBase)
SkillModifyBuffValueResult = SkillModifyBuffValueResult

function SkillModifyBuffValueResult:Constructor(entityId, buffseq, layer)
  self._entityID = entityId
  self._buffSeq = buffseq
  self._buffLayer = layer
end

function SkillModifyBuffValueResult:GetEntityID()
  return self._entityID
end

function SkillModifyBuffValueResult:GetBuffSeq()
  return self._buffSeq
end

function SkillModifyBuffValueResult:GetBuffLayer()
  return self._buffLayer
end

function SkillModifyBuffValueResult:GetEffectType()
  return SkillEffectType.ModifyBuffValue
end
