require("base_state_node")
_class("GoldbergEvent_UpdateProgress", CTestRobot_Base)
GoldbergEvent_UpdateProgress = GoldbergEvent_UpdateProgress

function GoldbergEvent_UpdateProgress:OnWorking()
  return GoldbergEvent_UpdateProgress.super.OnWorking(self)
end
