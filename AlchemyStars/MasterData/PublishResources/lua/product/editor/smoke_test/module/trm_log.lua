require("test_robot_module")

function TestRobotModule:Log(...)
  Log.debug("[TestRobot]", ...)
  local tmp = {
    ...
  }
  local t = {}
  for _, v in ipairs(tmp) do
    table.insert(t, tostring(v))
  end
  SmokingTestHub.WriteFullLog(table.concat(t, " "))
end

function TestRobotModule:Warn(...)
  Log.debug("[TestRobot][?]", ...)
  local tmp = {
    ...
  }
  local t = {}
  for _, v in ipairs(tmp) do
    table.insert(t, tostring(v))
  end
  table.insert(t, 1, "[?]")
  SmokingTestHub.WriteFullLog(table.concat(t, " "))
end

function TestRobotModule:Error(...)
  Log.debug("[TestRobot][!]", ...)
  local tmp = {
    ...
  }
  local t = {}
  for _, v in ipairs(tmp) do
    table.insert(t, tostring(v))
  end
  table.insert(t, 1, "[!]")
  local msg = table.concat(t, " ")
  SmokingTestHub.WriteFullLog(msg)
  self:Exception_DeclareExceptionThrew(msg)
end

function TestRobotModule:Panic(...)
  Log.debug("[TestRobot][!]", ...)
  local t = {
    ...
  }
  table.insert(t, 1, "[!]")
  local msg = table.concat(t, " ")
  SmokingTestHub.WriteFullLog(msg)
  self:Exception_SendWorkWXError(msg)
  if self:GetMissionRunData() then
    self:GetMissionRunData():DeclareException()
  end
  self:WriteProgressLog()
end
