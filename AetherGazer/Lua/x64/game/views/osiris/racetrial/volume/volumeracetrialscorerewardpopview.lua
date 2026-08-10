local var_0_0 = import("game.views.osiris.raceTrial.RaceTrialScoreRewardPopView")
local var_0_1 = class("VolumeRaceTrialScoreRewardPopView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return RaceTrialTools.GetScoreRewardUIName(arg_1_0.params_.mainActivityID)
end

function var_0_1.GetRewardItemClass(arg_2_0)
	return VolumeRaceTrialScoreRewardItem
end

return var_0_1
