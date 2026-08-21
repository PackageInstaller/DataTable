local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivityRaceTrialSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.activityID_ = arg_1_1.activityID
end

function var_0_1.GetRaceEffect(arg_2_0)
	return ActivityRaceTrialCfg[arg_2_0.activityID_].race, 3, true
end

return var_0_1
