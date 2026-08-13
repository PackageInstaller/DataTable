class = var_0_10000

local var_0_0 = "WinterFestival2025Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...PSS.Hei5.PSSHei5Scene"))

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025UI"
end

function var_0_1.initTplVar(arg_2_0)
	arg_2_0.helpBtnTip = "battlepass_main_help_1211"
	WinterFestival2025AwardPage = var_1
	arg_2_0.awardPageCls = var_1
	WinterFestival2025TaskPage = var_1
	arg_2_0.taskPageCls = var_1
	WinterFestival2025CruiseChargePage = var_1
	arg_2_0.chargePageCls = var_1
	arg_2_0.dayTextTip = "winter_battlepass_main_time_title"
	arg_2_0.titleTextTip = "winter_cruise_title_1211"
	arg_2_0.rewardTip = "winter_battlepass_rewards"
	arg_2_0.missionTip = "winter_battlepass_mission"

	local var_2_0 = arg_2_0._tf
	local var_2_1

	var_2_1, setText = var_1.Find(var_2_0, "frame/phase/btn_pay/Text"), var_2_0
	i18n = var_1_10004

	var_2_0(var_2_1, var_1_10004("winter_cruise_btn_pay"))

	local var_2_2 = arg_2_0._tf
	local var_2_3

	var_2_3, setText = var_2.Find(var_2_2, "frame/phase/AwardTipText"), var_2_2
	i18n = var_5

	var_2_2(var_2_3, var_5("winter_cruise_pay_reward"))

	return
end

return var_0_1
