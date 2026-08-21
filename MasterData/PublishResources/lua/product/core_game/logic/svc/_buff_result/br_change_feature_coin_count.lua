_class("BuffResultChangeFeatureCoinCount", BuffResultBase)
BuffResultChangeFeatureCoinCount = BuffResultChangeFeatureCoinCount

function BuffResultChangeFeatureCoinCount:Constructor(curCount, oldCount, modifyValue)
  self._curCount = curCount
  self._oldCount = oldCount
  self._modifyValue = modifyValue
end

function BuffResultChangeFeatureCoinCount:GetCurCount()
  return self._curCount
end

function BuffResultChangeFeatureCoinCount:GetOldCount()
  return self._oldCount
end

function BuffResultChangeFeatureCoinCount:GetModifyValue()
  return self._modifyValue
end

function BuffResultChangeFeatureCoinCount:SetMovePos(pos)
  self._movePos = pos
end

function BuffResultChangeFeatureCoinCount:GetMovePos()
  return self._movePos
end
