_class("N5ConquestRunData", TestRobotRunData)
N5ConquestRunData = N5ConquestRunData

function N5ConquestRunData:Constructor()
  self._battleFieldCount = 4
  self._battleFieldIndex = 1
  self._dayCount = 60
  self._curDay = 1
end

function N5ConquestRunData:GetCurBattleFieldIndex()
  return self._battleFieldIndex
end

function N5ConquestRunData:MoveToNextBattleField()
  self._battleFieldIndex = self._battleFieldIndex + 1
  if self._battleFieldIndex >= self._battleFieldCount then
    self._battleFieldIndex = 1
  end
end

function N5ConquestRunData:IsLastBattleField()
  return self._battleFieldIndex >= self._battleFieldCount
end

function N5ConquestRunData:GetCurDay()
  return self._curDay
end

function N5ConquestRunData:MoveToNextDay()
  self._curDay = self._curDay + 1
  if self._curDay >= self._dayCount then
    self._curDay = 1
  end
end

function N5ConquestRunData:IsLastDay()
  return self._curDay >= self._dayCount
end
