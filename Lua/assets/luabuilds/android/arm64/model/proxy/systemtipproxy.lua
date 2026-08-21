local var_0_0 = class("SystemTipProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:on(21536, function(arg_2_0)
		arg_1_0:SetIslandTipData(arg_2_0.get_num, arg_2_0.empty_num, arg_2_0.get_times, arg_2_0.mange_flag)

		return
	end)

	arg_1_0.islandAwardCnt = 0
	arg_1_0.islandEmptyCnt = 0
	arg_1_0.islandTimestamps = {}
	arg_1_0.islandPostFlag = 0

	return
end

function var_0_0.SetIslandTipData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.islandAwardCnt = arg_3_1
	arg_3_0.islandEmptyCnt = arg_3_2
	arg_3_0.islandTimestamps = arg_3_3

	table.sort(arg_3_0.islandTimestamps)

	arg_3_0.islandPostFlag = arg_3_4

	return
end

function var_0_0.GetIslandTipInfos(arg_4_0)
	if arg_4_0.islandPostFlag == 0 then
		return 0, 0
	end

	local var_4_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return underscore.reduce(arg_4_0.islandTimestamps, arg_4_0.islandAwardCnt, function(arg_5_0, arg_5_1)
		return arg_5_0 + (arg_5_1 <= var_4_0 and 1 or 0)
	end), arg_4_0.islandEmptyCnt
end

function var_0_0.IsIslandRedDotTip(arg_6_0)
	if arg_6_0.islandClickRecord then
		return false
	end

	local var_6_0, var_6_1 = arg_6_0:GetIslandTipInfos()

	return var_6_0 > 0 or var_6_1 > 0
end

function var_0_0.SetIslandClickRecord(arg_7_0)
	arg_7_0.islandClickRecord = true

	return
end

return var_0_0
