_class("BuffResultChangeAutoBeadNeedEnergy", BuffResultBase)
BuffResultChangeAutoBeadNeedEnergy = BuffResultChangeAutoBeadNeedEnergy

function BuffResultChangeAutoBeadNeedEnergy:Constructor(curTotalNeed, oldTotalNeed)
  self._curTotalNeed = curTotalNeed
  self._oldTotalNeed = oldTotalNeed
end

function BuffResultChangeAutoBeadNeedEnergy:GetCurAutoBeadPointToPower()
  return self._curTotalNeed
end

function BuffResultChangeAutoBeadNeedEnergy:GetOldAutoBeadPointToPower()
  return self._oldTotalNeed
end
