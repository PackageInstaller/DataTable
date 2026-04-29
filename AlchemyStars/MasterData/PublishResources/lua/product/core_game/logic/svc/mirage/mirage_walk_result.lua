_class("MirageWalkResult", Object)
MirageWalkResult = MirageWalkResult

function MirageWalkResult:Constructor()
  self._walkPos = nil
  self._oldPosColor = PieceType.None
  self._newPosColor = PieceType.None
  self._trapResultList = {}
end

function MirageWalkResult:GetWalkPos()
  return self._walkPos
end

function MirageWalkResult:SetWalkPos(pos)
  self._walkPos = pos
end

function MirageWalkResult:SetOldPosColor(color)
  self._oldPosColor = color
end

function MirageWalkResult:GetOldPosColor()
  return self._oldPosColor
end

function MirageWalkResult:SetNewPosColor(color)
  self._newPosColor = color
end

function MirageWalkResult:GetNewPosColor()
  return self._newPosColor
end

function MirageWalkResult:GetWalkTrapResultList()
  return self._trapResultList
end

function MirageWalkResult:AddWalkTrap(trapEntityID, skillResult)
  local res = WalkTriggerTrapResult:New()
  res:SetTrapEntityID(trapEntityID)
  res:SetTrapResult(skillResult)
  self._trapResultList[#self._trapResultList + 1] = res
end
