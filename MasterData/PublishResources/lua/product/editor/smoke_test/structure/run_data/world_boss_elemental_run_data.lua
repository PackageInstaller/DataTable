_class("ElementalWorldBossRunData", TestRobotElementalRunData)
ElementalWorldBossRunData = ElementalWorldBossRunData

function ElementalWorldBossRunData:ParseLevelData(rawargs)
  local s = string.split(rawargs, ",")
  local missionID = tonumber(s[1])
  self._missionID = missionID
end
