local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("SummerWaterTeamInfoView", var_0_0)

function var_0_1.ExtraSorter(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	return true, arg_1_1.id < arg_1_2.id
end

function var_0_1.GetTrialHeroList(arg_2_0)
	return {
		arg_2_0.heroTrialList_[1]
	}
end

function var_0_1.GetHeroList(arg_3_0)
	return {}
end

function var_0_1.OnWaterResult(arg_4_0)
	ShowTips("TIME_OVER")
	arg_4_0:Back()
end

return var_0_1
