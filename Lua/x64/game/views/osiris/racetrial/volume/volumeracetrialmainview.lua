RaceTrialMainView = import("game.views.osiris.raceTrial.RaceTrialMainView")

local var_0_0 = class("VolumeRaceTrialMainView", RaceTrialMainView)

function var_0_0.UIName(arg_1_0)
	return RaceTrialTools.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.AddUIListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.firstRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.scoreRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = arg_2_0.activityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.receiveBtn_, nil, function()
		RaceTrialAction:ReceiveScoreReward(arg_2_0.curLv_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.DivineBtn_, nil, function()
		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
end

return var_0_0
