require("elemental_run_data")
_class("ElementalExtraMissionRunData", TestRobotElementalRunData)
ElementalExtraMissionRunData = ElementalExtraMissionRunData

function ElementalExtraMissionRunData:ParseLevelData(rawargs)
  local s = string.split(rawargs, ",")
  self._extChapterID = tonumber(s[1])
  self._extMissionID = tonumber(s[2])
  self._missionID = self._extMissionID
end

function ElementalExtraMissionRunData:GetExtChapterID()
  return self._extChapterID
end

function ElementalExtraMissionRunData:GetExtMissionID()
  return self._extMissionID
end
