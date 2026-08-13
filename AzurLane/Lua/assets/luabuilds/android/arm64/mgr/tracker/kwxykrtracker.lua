class = var_0_10000

local var_0_0 = var_0_10000("KwxyKrTracker")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = {}

	TRACKING_TUTORIAL_COMPLETE_1 = var_1_10003
	var_1_0[var_1_10003] = "tutorial_complete_1"
	TRACKING_USER_LEVELUP = var_1_10003
	var_1_0[var_1_10003] = "user_levelup"
	TRACKING_EXP_LV_10 = var_1_10003
	var_1_0[var_1_10003] = "stdlevel10"
	TRACKING_EXP_LV_20 = var_1_10003
	var_1_0[var_1_10003] = "stdlevel20"
	TRACKING_EXP_LV_30 = var_1_10003
	var_1_0[var_1_10003] = "stdlevel30"
	TRACKING_STRIKE_FAILD = var_1_10003
	var_1_0[var_1_10003] = "stdexhausted"
	TRACKING_PAY_OIL = var_1_10003
	var_1_0[var_1_10003] = "stdstaminapurchase"
	TRACKING_PAY_FAILD = var_1_10003
	var_1_0[var_1_10003] = "stdrechargeprompt"
	TRACKING_PAY_SUCCESS = var_1_10003
	var_1_0[var_1_10003] = "stdrecharge"
	TRACKING_BUILD_OR_SKIN_FAILD = var_1_10003
	var_1_0[var_1_10003] = "stdlackofdiamonds"
	arg_1_0.mapping = var_1_0

	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0.mapping[arg_2_1] then
		pg = var_1_10006

		local var_2_0 = var_1_10006.SdkMgr.GetInstance()

		var_6.EventTrack(var_2_0, var_5)
	end

	return
end

return var_0_0
