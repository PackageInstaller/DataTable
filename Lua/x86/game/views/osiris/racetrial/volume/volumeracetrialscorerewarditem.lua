local var_0_0 = import("game.views.osiris.raceTrial.RaceTrialScoreRewardItem")
local var_0_1 = class("VolumeRaceTrialScoreRewardItem", var_0_0)

function var_0_1.RefreshTitle(arg_1_0)
	arg_1_0.title_.text = arg_1_0.cfg_.need
end

return var_0_1
