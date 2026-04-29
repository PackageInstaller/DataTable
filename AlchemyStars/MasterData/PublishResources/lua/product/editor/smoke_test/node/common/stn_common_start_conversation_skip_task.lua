require("base_state_node")
_class("Common_StartConversationSkipTask", CTestRobot_Base)
Common_StartConversationSkipTask = Common_StartConversationSkipTask

function Common_StartConversationSkipTask:OnWorking()
  local testRobotModule = GameGlobal.GetModule(TestRobotModule)
  if testRobotModule:GetConversationTaskID() then
    return Common_StartConversationSkipTask.super.OnWorking(self)
  end
  local tid = GameGlobal.TaskManager():StartTask(function(TT)
    while true do
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIStoryBanner",
        input = "bgOnClick",
        args = {}
      })
      YIELD(TT, 500)
    end
  end)
  testRobotModule:SetConversationTaskID(tid)
  return Common_StartConversationSkipTask.super.OnWorking(self)
end
