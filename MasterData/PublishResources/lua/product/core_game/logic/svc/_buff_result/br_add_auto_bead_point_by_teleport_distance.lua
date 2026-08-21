_class("BuffResultAddAutoBeadPointByTeleportDistance", BuffResultBase)
BuffResultAddAutoBeadPointByTeleportDistance = BuffResultAddAutoBeadPointByTeleportDistance

function BuffResultAddAutoBeadPointByTeleportDistance:Constructor(curVal, oldVal)
  self._curPoint = curVal
  self._oldPoint = oldVal
end

function BuffResultAddAutoBeadPointByTeleportDistance:GetCurAutoBeadPoint()
  return self._curPoint
end

function BuffResultAddAutoBeadPointByTeleportDistance:GetOldAutoBeadPoint()
  return self._oldPoint
end
