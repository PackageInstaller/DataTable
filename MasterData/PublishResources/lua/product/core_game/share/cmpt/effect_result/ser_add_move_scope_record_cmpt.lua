_class("SkillEffectResultAddMoveScopeRecordCmpt", SkillEffectResultBase)
SkillEffectResultAddMoveScopeRecordCmpt = SkillEffectResultAddMoveScopeRecordCmpt

function SkillEffectResultAddMoveScopeRecordCmpt:Constructor(hostEntityID, offSet)
  self._hostEntityID = hostEntityID
  self._offSet = offSet
end

function SkillEffectResultAddMoveScopeRecordCmpt:GetEffectType()
  return SkillEffectType.AddMoveScopeRecordCmpt
end

function SkillEffectResultAddMoveScopeRecordCmpt:SetHostEntityID(hostEntityID)
  self._hostEntityID = hostEntityID
end

function SkillEffectResultAddMoveScopeRecordCmpt:GetHostEntityID()
  return self._hostEntityID
end

function SkillEffectResultAddMoveScopeRecordCmpt:SetOffSet(offSet)
  self._offSet = offSet
end

function SkillEffectResultAddMoveScopeRecordCmpt:GetOffSet()
  return self._offSet
end
