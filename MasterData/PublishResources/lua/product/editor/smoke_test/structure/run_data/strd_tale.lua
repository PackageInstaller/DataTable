require("elemental_run_data")
_class("SmokeTestRunData_Tale", TestRobotElementalRunData)
SmokeTestRunData_Tale = SmokeTestRunData_Tale

function SmokeTestRunData_Tale:ParseLevelData(rawargs)
  local s = string.split(rawargs, ",")
  self._missionID = tonumber(s[1])
end
