class = var_0_10000

local var_0_0 = "MainActEscortBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_escort"
end

function var_0_1.GetActivityID(arg_2_0)
	return nil
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.maxTimes = var_1.getMaxEscortChallengeTimes(var_3_0)

	local var_3_1 = var_1.escortChallengeTimes < arg_3_0.maxTimes

	setActive = var_4

	local var_3_2 = arg_3_0._tf

	var_4(var_6.Find(var_3_2, "Tip"), var_3_1)

	return
end

function var_0_1.CustomOnClick(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_4_1 = var_1.isOpenSystem

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_4_2 = var_1_10004(var_1_10006)
	local var_4_3, var_4_4 = var_4_1(var_4_0, var_4.getRawData(var_4_2).level, "Escort")
	local var_4_5

	if not var_4_3 then
		pg = var_4_0
		var_4_5 = var_4_0.TipsMgr.GetInstance()

		var_4_0.ShowTips(var_4_5, var_4_4)

		return
	end

	getProxy = var_4_0
	ChapterProxy = var_4_5

	local var_4_6 = var_4_0(var_4_5)

	if var_3.getMaxEscortChallengeTimes(var_4_6) == 0 then
		pg = var_3

		local var_4_7 = var_3.TipsMgr.GetInstance()
		local var_4_8 = var_3.ShowTips

		i18n = var_4_2

		var_4_8(var_4_7, var_4_2("common_activity_end"))

		return
	end

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.emit

	NewMainMediator = var_4_2

	var_4_10(var_4_9, var_4_2.SKIP_ESCORT)

	return
end

return var_0_1
