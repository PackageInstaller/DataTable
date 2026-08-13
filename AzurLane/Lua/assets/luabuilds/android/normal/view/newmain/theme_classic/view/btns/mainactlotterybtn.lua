class = var_0_10000

local var_0_0 = "MainActLotteryBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_LanternFestival"
end

function var_0_1.GetActivityID(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_2_2

	var_2_2 = var_2_1(var_2_0, var_1_10003.ACTIVITY_TYPE_LOTTERY) and var_1.id

	return var_2_2
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_3_2 = var_3_1(var_3_0, var_1_10003.ACTIVITY_TYPE_LOTTERY)
	local var_3_3 = var_1.getAwardInfos(var_3_2)
	local var_3_4 = var_1
	local var_3_5 = var_1.getConfig(var_3_4, "config_data")

	_ = var_3_4

	local var_3_6 = var_3_4.any(var_3_5, function(arg_4_0)
		ActivityItemPool = var_2_10001

		local var_4_0 = var_2_10001.New({
			id = arg_4_0,
			awards = var_3_3[arg_4_0]
		})
		local var_4_1 = var_1.getComsume(var_4_0)

		getProxy = var_4_0
		PlayerProxy = var_2_10004

		local var_4_2 = var_4_0(var_2_10004)
		local var_4_3 = var_3.getRawData(var_4_2)

		id2res = var_4_2

		return var_4_3[var_4_2(var_4_1.id)] >= var_4_1.count and var_1:getleftItemCount() > 0
	end)

	setActive = var_5

	local var_3_7 = arg_3_0._tf

	var_5(var_6.Find(var_3_7, "Tip"), var_3_6)

	return
end

function var_0_1.CustomOnClick(arg_5_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_5_1(var_5_0, var_1_10003.ACTIVITY_TYPE_LOTTERY) then
		local var_5_2 = arg_5_0
		local var_5_3 = arg_5_0.emit

		NewMainMediator = var_1_10004

		var_5_3(var_5_2, var_1_10004.SKIP_LOTTERY, var_1.id)
	end

	return
end

return var_0_1
