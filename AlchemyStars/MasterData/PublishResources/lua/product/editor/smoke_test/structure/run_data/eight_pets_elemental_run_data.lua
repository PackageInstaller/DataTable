_class("ElementalEightPetsRunData", TestRobotElementalRunData)
ElementalEightPetsRunData = ElementalEightPetsRunData

function ElementalEightPetsRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentID = tonumber(args[2])
end

function ElementalEightPetsRunData:GetMissionID()
  return self._missionID
end

function ElementalEightPetsRunData:GetComponentID()
  return self._componentID
end

function ElementalEightPetsRunData:GetComponentConfigID()
  return self._componentID
end
