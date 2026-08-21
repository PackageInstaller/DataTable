require("test_robot_module")

function TestRobotModule:GetNodeEnv()
  return setmetatable({}, _G)
end
