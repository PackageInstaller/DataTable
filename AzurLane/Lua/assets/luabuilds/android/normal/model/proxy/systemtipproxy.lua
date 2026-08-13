class = var_0_10000

local var_0_0 = "SystemTipProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:on(21536, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.SetIslandTipData(var_2_0, arg_2_0.get_num, arg_2_0.empty_num, arg_2_0.get_times, arg_2_0.mange_flag)

		return
	end)

	arg_1_0.islandAwardCnt = 0
	arg_1_0.islandEmptyCnt = 0
	arg_1_0.islandTimestamps = {}
	arg_1_0.islandPostFlag = 0

	return
end

function var_0_1.SetIslandTipData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.islandAwardCnt = arg_3_1
	arg_3_0.islandEmptyCnt = arg_3_2
	arg_3_0.islandTimestamps = arg_3_3
	table = var_1_10005

	var_1_10005.sort(arg_3_0.islandTimestamps)

	arg_3_0.islandPostFlag = arg_3_4

	return
end

function var_0_1.GetIslandTipInfos(arg_4_0)
	if arg_4_0.islandPostFlag == 0 then
		return 0, 0
	end

	pg = var_1

	local var_4_0 = var_1.TimeMgr.GetInstance()
	local var_4_1 = var_1.GetServerTime(var_4_0)

	underscore = var_4_0

	return var_4_0.reduce(arg_4_0.islandTimestamps, arg_4_0.islandAwardCnt, function(arg_5_0, arg_5_1)
		return arg_5_0 + (arg_5_1 <= var_4_1 and 1 or 0)
	end), arg_4_0.islandEmptyCnt
end

function var_0_1.IsIslandRedDotTip(arg_6_0)
	if arg_6_0.islandClickRecord then
		return false
	end

	local var_6_0, var_6_1 = arg_6_0:GetIslandTipInfos()

	return var_6_0 > 0 or var_6_1 > 0
end

function var_0_1.SetIslandClickRecord(arg_7_0)
	arg_7_0.islandClickRecord = true

	return
end

return var_0_1
