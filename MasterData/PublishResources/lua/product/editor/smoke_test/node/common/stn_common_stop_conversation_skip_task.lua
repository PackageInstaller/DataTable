require("base_state_node")
_class("Common_StopConversationSkipTask", CTestRobot_Base)
Common_StopConversationSkipTask = Common_StopConversationSkipTask

function Common_StopConversationSkipTask:OnWorking()
  local testRobotModule = GameGlobal.GetModule(TestRobotModule)
  local tid = testRobotModule:GetConversationTaskID()
  if not tid then
    return Common_StopConversationSkipTask.super.OnWorking(self)
  end
  testRobotModule:SetConversationTaskID(nil)
  GameGlobal.TaskManager():KillTask(tid)
  return Common_StopConversationSkipTask.super.OnWorking(self)
end
