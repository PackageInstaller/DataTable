_class("BuffResultRemoveBuff", BuffResultBase)
BuffResultRemoveBuff = BuffResultRemoveBuff

function BuffResultRemoveBuff:Constructor()
  self._removedInfo = {}
end

function BuffResultRemoveBuff:AddRemovedInfo(eid, tSeqID)
  table.insert(self._removedInfo, {eid = eid, tSeqID = tSeqID})
end

function BuffResultRemoveBuff:GetBuffArray()
  return self._removedInfo
end

function BuffResultRemoveBuff:SetRandHalfDamageIndex(val)
  self._randHalfDamageIndex = val
end

function BuffResultRemoveBuff:GetRandHalfDamageIndex()
  return self._randHalfDamageIndex
end

function BuffResultRemoveBuff:GetWalkPos()
  return self._walkPos
end

function BuffResultRemoveBuff:SetWalkPos(walkPos)
  self._walkPos = walkPos
end

function BuffResultRemoveBuff:SetBlack(black)
  self._black = black
end

function BuffResultRemoveBuff:GetBlack()
  return self._black
end

function BuffResultRemoveBuff:SetNotifyEntityID(id)
  self._notifyEntityID = id
end

function BuffResultRemoveBuff:GetNotifyEntityID()
  return self._notifyEntityID
end

function BuffResultRemoveBuff:SetNotifyChainSkillId(v)
  self._notifyChainSkillId = v
end

function BuffResultRemoveBuff:GetNotifyChainSkillId()
  return self._notifyChainSkillId
end

function BuffResultRemoveBuff:SetNotifyChainSkillTimeIndex(v)
  self._notifyChainSkillTimeIndex = v
end

function BuffResultRemoveBuff:GetNotifyChainSkillTimeIndex()
  return self._notifyChainSkillTimeIndex
end

function BuffResultRemoveBuff:SetNotifyChainSkillStageIndex(v)
  self._notifyChainSkillStageIndex = v
end

function BuffResultRemoveBuff:GetNotifyChainSkillStageIndex()
  return self._notifyChainSkillStageIndex
end

function BuffResultRemoveBuff:SetAutoBeadSkillIndex(skillIndex)
  self._autoBeadSkillIndex = skillIndex
end

function BuffResultRemoveBuff:GetAutoBeadSkillIndex()
  return self._autoBeadSkillIndex
end
