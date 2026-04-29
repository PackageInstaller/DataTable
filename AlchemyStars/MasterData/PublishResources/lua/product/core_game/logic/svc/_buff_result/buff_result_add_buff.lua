_class("BuffResultAddBuff", BuffResultBase)
BuffResultAddBuff = BuffResultAddBuff

function BuffResultAddBuff:Constructor()
  self._buffArray = {}
end

function BuffResultAddBuff:AddBuffData(eid, buffseq)
  table.insert(self._buffArray, {eid, buffseq})
end

function BuffResultAddBuff:GetBuffArray()
  return self._buffArray
end

function BuffResultAddBuff:SetLight(v)
  self._light = v
end

function BuffResultAddBuff:GetLight()
  return self._light
end

function BuffResultAddBuff:SetAttackPos(pos)
  self._atkPos = pos
end

function BuffResultAddBuff:GetAttackPos()
  return self._atkPos
end

function BuffResultAddBuff:SetTargetPos(pos)
  self._tarPos = pos
end

function BuffResultAddBuff:GetTargetPos()
  return self._tarPos
end

function BuffResultAddBuff:SetRandHalfDamageIndex(val)
  self._randHalfDamageIndex = val
end

function BuffResultAddBuff:GetRandHalfDamageIndex()
  return self._randHalfDamageIndex
end

function BuffResultAddBuff:GetWalkPos()
  return self._walkPos
end

function BuffResultAddBuff:SetWalkPos(walkPos)
  self._walkPos = walkPos
end

function BuffResultAddBuff:SetNotifyLayerChange_Entity(e)
  self._setNotifyLayerChange_entity = e
end

function BuffResultAddBuff:SetNotifyLayerChange_TotalLayer(n)
  self._setNotifyLayerChange_totalLayer = n
end

function BuffResultAddBuff:GetNotifyLayerChange_Entity()
  return self._setNotifyLayerChange_entity
end

function BuffResultAddBuff:GetNotifyLayerChange_TotalLayer()
  return self._setNotifyLayerChange_totalLayer
end

function BuffResultAddBuff:SetAutoBeadSkillIndex(skillIndex)
  self._autoBeadSkillIndex = skillIndex
end

function BuffResultAddBuff:GetAutoBeadSkillIndex()
  return self._autoBeadSkillIndex
end

function BuffResultAddBuff:SetLevelTotalRoundCount(val)
  self._levelTotalRoundCount = val
end

function BuffResultAddBuff:GetLevelTotalRoundCount()
  return self._levelTotalRoundCount
end

function BuffResultAddBuff:SetAddBuffSeq(buffSeq)
  self._addBuffSeq = buffSeq
end

function BuffResultAddBuff:GetAddBuffSeq()
  return self._addBuffSeq
end

function BuffResultAddBuff:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function BuffResultAddBuff:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end

function BuffResultAddBuff:SetSkillID(skillID)
  self._skillID = skillID
end

function BuffResultAddBuff:GetSkillID()
  return self._skillID
end
