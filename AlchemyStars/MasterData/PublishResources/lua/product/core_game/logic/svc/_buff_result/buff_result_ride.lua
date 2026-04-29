_class("BuffResultRide", BuffResultBase)
BuffResultRide = BuffResultRide

function BuffResultRide:Constructor(rideID, mountID, gridLocRes)
  self._rideID = rideID
  self._mountID = mountID
  self._gridLocRes = gridLocRes
end

function BuffResultRide:GetRideEntityID()
  return self._rideID
end

function BuffResultRide:GetMountEntityID()
  return self._mountID
end

function BuffResultRide:GetDataGridLocationResult()
  return self._gridLocRes
end

function BuffResultRide:SetNotifyEntity(entity)
  self._notifyEntity = entity
end

function BuffResultRide:GetNotifyEntity()
  return self._notifyEntity
end

function BuffResultRide:SetNotifyPos(notifyPos)
  self._notifyPos = notifyPos
end

function BuffResultRide:GetNotifyPos()
  return self._notifyPos
end

function BuffResultRide:SetTargetPos(targetPos)
  self._targetPos = targetPos
end

function BuffResultRide:GetTargetPos()
  return self._targetPos
end

function BuffResultRide:SetNotifyChainSkillTimeIndex(v)
  self._notifyChainSkillTimeIndex = v
end

function BuffResultRide:GetNotifyChainSkillTimeIndex()
  return self._notifyChainSkillTimeIndex
end

function BuffResultRide:SetNotifyChainSkillStageIndex(v)
  self._notifyChainSkillStageIndex = v
end

function BuffResultRide:GetNotifyChainSkillStageIndex()
  return self._notifyChainSkillStageIndex
end

function BuffResultRide:SetPlayed(hasPlayed)
  self._hasPlayed = hasPlayed
end

function BuffResultRide:HasPlayed()
  if self._hasPlayed and self._hasPlayed == true then
    return true
  end
  return false
end
