local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailBattleEventView", var_0_0)

function var_0_1.AcceptEvent(arg_1_0)
	JumpTools.OpenPageByJump("/sailLotteryGame", {
		activityID = arg_1_0.activityID_,
		stageIndex = arg_1_0.stageIndex_
	})
end

function var_0_1.RefreshReward(arg_2_0)
	SetActive(arg_2_0.rewardPanelGo_, false)
end

return var_0_1
