require("elemental_run_data")
_class("SailingMissionRunData", TestRobotElementalRunData)
SailingMissionRunData = SailingMissionRunData

function SailingMissionRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._layerID = tonumber(args[1])
  self._missionID = tonumber(args[2])
end

function SailingMissionRunData:GetMissionID()
  return self._missionID
end

function SailingMissionRunData:GetLayerID()
  return self._layerID
end
