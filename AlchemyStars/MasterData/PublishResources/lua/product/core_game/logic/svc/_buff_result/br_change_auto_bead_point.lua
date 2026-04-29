_class("BuffResultChangeAutoBeadPoint", BuffResultBase)
BuffResultChangeAutoBeadPoint = BuffResultChangeAutoBeadPoint

function BuffResultChangeAutoBeadPoint:Constructor(curVal, oldVal)
  self._curPoint = curVal
  self._oldPoint = oldVal
end

function BuffResultChangeAutoBeadPoint:GetCurAutoBeadPoint()
  return self._curPoint
end

function BuffResultChangeAutoBeadPoint:GetOldAutoBeadPoint()
  return self._oldPoint
end
