_class("ElementalSeasonRunData", TestRobotElementalRunData)
ElementalSeasonRunData = ElementalSeasonRunData

function ElementalSeasonRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentID = tonumber(args[2]) or UISeasonID.S1
  self._dailyProcess = tonumber(args[3]) or -1
end

function ElementalSeasonRunData:GetMissionID()
  return self._missionID
end

function ElementalSeasonRunData:GetComponentID()
  return self._componentID
end

function ElementalSeasonRunData:GetDailyProcess()
  return self._dailyProcess
end
