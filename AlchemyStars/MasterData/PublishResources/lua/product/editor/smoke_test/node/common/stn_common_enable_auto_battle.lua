require("base_state_node")
_class("Common_EnableAutoBattle", CTestRobot_Base)
Common_EnableAutoBattle = Common_EnableAutoBattle

function Common_EnableAutoBattle:OnWorking()
  GameGlobal.GetUIModule(MatchModule):SetIsAutoFighting(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFight, true)
  return Common_EnableAutoBattle.super.OnWorking(self)
end
