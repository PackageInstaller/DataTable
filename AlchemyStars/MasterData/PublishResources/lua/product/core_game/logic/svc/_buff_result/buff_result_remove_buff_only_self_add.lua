_class("BuffResultRemoveBuffOnlySelfAdd", BuffResultBase)
BuffResultRemoveBuffOnlySelfAdd = BuffResultRemoveBuffOnlySelfAdd

function BuffResultRemoveBuffOnlySelfAdd:Constructor()
  self._removedInfo = {}
end

function BuffResultRemoveBuffOnlySelfAdd:AddRemovedInfo(eid, tSeqID)
  table.insert(self._removedInfo, {eid = eid, tSeqID = tSeqID})
end

function BuffResultRemoveBuffOnlySelfAdd:GetBuffArray()
  return self._removedInfo
end
