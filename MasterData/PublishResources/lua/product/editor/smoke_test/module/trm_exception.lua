require("test_robot_module")

function TestRobotModule:Exception_DisableAutoKill()
  SmokingTestAgent.IsActive = false
end

function TestRobotModule:Exception_SendWorkWXError(message)
  WorkWXPoster.SendError(message)
end

function TestRobotModule:Exception_DeclareExceptionThrew(msg)
  self:Exception_DisableAutoKill()
  self:Exception_SendWorkWXError(msg)
  if self:GetMissionRunData() then
    self:GetMissionRunData():DeclareException()
    self:WriteProgressLog()
  else
    SmokingTestHub.WriteBoardLog("【异常】测试环境启动失败")
  end
end
