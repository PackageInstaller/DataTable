_class("BuffLogicDoModifyDamageFromTeamMember", BuffLogicBase)
BuffLogicDoModifyDamageFromTeamMember = BuffLogicDoModifyDamageFromTeamMember

function BuffLogicDoModifyDamageFromTeamMember:Constructor(_buffIns, logicParam)
  self._modifyValue = logicParam.modifyValue
end

function BuffLogicDoModifyDamageFromTeamMember:DoLogic()
  local val = self._modifyValue
  self._buffLogicService:ChangeFinalBehitByTeamMemberDamageParam(self._entity, self:GetBuffSeq(), val)
end

function BuffLogicDoModifyDamageFromTeamMember:DoOverlap(logicParam)
  self._modifyValue = logicParam.modifyValue
  self:DoLogic()
end

_class("BuffLogicRemoveModifyDamageFromTeamMember", BuffLogicBase)
BuffLogicRemoveModifyDamageFromTeamMember = BuffLogicRemoveModifyDamageFromTeamMember

function BuffLogicRemoveModifyDamageFromTeamMember:DoLogic()
  self._buffLogicService:RemoveFinalBehitByTeamMemberDamageParam(self._entity, self:GetBuffSeq())
end
