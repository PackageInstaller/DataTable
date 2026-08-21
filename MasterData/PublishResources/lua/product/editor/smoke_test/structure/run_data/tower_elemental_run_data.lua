_class("ElementalTowerRunData", TestRobotElementalRunData)
ElementalTowerRunData = ElementalTowerRunData

function ElementalTowerRunData:ParseLevelData(rawargs)
  local s = string.split(rawargs, ",")
  local missionID = tonumber(s[2])
  self._missionID = missionID
  local towerElementType = tonumber(s[1])
  self._towerElementType = towerElementType
end

function ElementalTowerRunData:GetTowerElementType()
  return self._towerElementType
end
