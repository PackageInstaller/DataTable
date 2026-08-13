class = var_0_10000

local var_0_0 = var_0_10000("IslandRoleDelegationData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateData(arg_1_1)

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.ship_id = arg_2_1.ship_id
	arg_2_0.formula_id = arg_2_1.formula_id
	arg_2_0.start_time = arg_2_1.start_time

	arg_2_0:SetCostList(arg_2_1.cost_time_list)

	local var_2_0

	if not arg_2_1.times_extra then
		var_2_0 = {}
	end

	arg_2_0.extraList = var_2_0
	arg_2_0.once_cost_power = arg_2_1.once_cost_power

	local var_2_1

	if not arg_2_1.speed_time then
		var_2_1 = 0
	end

	arg_2_0.speed_time = var_2_1

	arg_2_0:SetIsSend(false)

	return
end

function var_0_0.AddExtraList(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_1) do
		table = var_1_10007

		var_1_10007.insert(arg_3_0.extraList, iter_3_1)
	end

	return
end

function var_0_0.GetExtraMainProduct(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.extraList[arg_4_1] or not arg_4_0.extraList[arg_4_1].main_extra then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_0.GetExtraExtraProduct(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_0.extraList[arg_5_1] or not arg_5_0.extraList[arg_5_1].other_extra then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_0.GetExtraExtraCost(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.extraList[arg_6_1] or not arg_6_0.extraList[arg_6_1].cost_extra then
		var_6_0 = 0
	end

	return var_6_0
end

function var_0_0.AddCostList(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_0.cost_time_list == 0 and 0 or arg_7_0.cost_time_list[var_2]
	local var_7_1 = 0

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(arg_7_1) do
		table = var_1_10010

		var_1_10010.insert(arg_7_0.cost_time_list, iter_7_1)

		var_1_10010 = arg_7_0.cost_Alltime_list
		var_1_10010[var_2 + iter_7_0] = iter_7_1 + var_7_0 + var_7_1
		var_7_1 = iter_7_1 + var_7_1
	end

	arg_7_0.end_time = arg_7_0.end_time + var_7_1
	arg_7_0.allTime = arg_7_0.allTime + var_7_1

	return
end

function var_0_0.SetCostList(arg_8_0, arg_8_1)
	arg_8_0.cost_time_list = arg_8_1
	arg_8_0.cost_Alltime_list = {}

	local var_8_0 = 0

	ipairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.cost_time_list) do
		arg_8_0.cost_Alltime_list[iter_8_0] = iter_8_1 + var_8_0
		var_8_0 = var_8_0 + iter_8_1
	end

	arg_8_0.end_time = arg_8_0.start_time
	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(arg_8_0.cost_time_list) do
		arg_8_0.end_time = arg_8_0.end_time + iter_8_3
	end

	arg_8_0.allTime = arg_8_0.end_time - arg_8_0.start_time

	return
end

function var_0_0.AddSpeedTime(arg_9_0, arg_9_1)
	arg_9_0.speed_time = arg_9_0.speed_time + arg_9_1

	return
end

function var_0_0.isEnd(arg_10_0)
	if arg_10_0.end_time > 0 then
		pg = var_1

		local var_10_0 = var_1.TimeMgr.GetInstance()
		local var_10_1

		if not (var_1.GetServerTime(var_10_0) >= arg_10_0.end_time + 1) then
			var_10_1 = false
		else
			var_10_1 = true
		end

		return var_10_1
	end
end

function var_0_0.GetFinishTime(arg_11_0)
	return arg_11_0.end_time
end

function var_0_0.GetAllTime(arg_12_0)
	return arg_12_0.allTime
end

function var_0_0.isSend(arg_13_0)
	return arg_13_0.issend
end

function var_0_0.SetIsSend(arg_14_0, arg_14_1)
	arg_14_0.issend = arg_14_1

	return
end

function var_0_0.InCurrentTime(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()
	local var_15_1 = var_1.GetServerTime(var_15_0) - arg_15_0.start_time

	ipairs = var_15_0

	for iter_15_0, iter_15_1 in var_15_0(arg_15_0.cost_Alltime_list) do
		if var_15_1 <= iter_15_1 then
			return iter_15_0
		end
	end

	return #arg_15_0.cost_Alltime_list
end

function var_0_0.GetCountByTimestamp(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 - arg_16_0.start_time

	for iter_16_0 = #arg_16_0.cost_Alltime_list, 1, -1 do
		if var_16_0 >= arg_16_0.cost_Alltime_list[iter_16_0] then
			return iter_16_0
		end
	end

	return 0
end

function var_0_0.InCurrentTimeStart(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_1 - 1

	for iter_17_0 = 1, var_17_1 do
		var_17_0 = var_17_0 + arg_17_0.cost_time_list[iter_17_0]
	end

	return var_17_0 + arg_17_0.start_time
end

function var_0_0.CurrentTimeNeed(arg_18_0, arg_18_1)
	return arg_18_0.cost_time_list[arg_18_1]
end

function var_0_0.CheckDelegationIsEnd(arg_19_0)
	if not arg_19_0:isSend() and arg_19_0:isEnd() then
		return true
	end

	return
end

function var_0_0.CanRewardTimes(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_20_0) >= arg_20_0.end_time then
		return #arg_20_0.cost_time_list
	end

	return arg_20_0:InCurrentTime() - 1
end

function var_0_0.GetCurrentCanRewardExtraMainNum(arg_21_0)
	local var_21_0 = arg_21_0:InCurrentTime() - 1
	local var_21_1 = 0

	for iter_21_0 = 1, var_21_0 do
		var_21_1 = var_21_1 + arg_21_0:GetExtraMainProduct(iter_21_0)
	end

	return var_21_1
end

function var_0_0.GetReturnExtraNum(arg_22_0, arg_22_1)
	local var_22_0 = #arg_22_0.cost_time_list - arg_22_1 + 1
	local var_22_1 = 0

	for iter_22_0 = #arg_22_0.cost_time_list, var_22_0, -1 do
		var_22_1 = var_22_1 + arg_22_0:GetExtraExtraCost(iter_22_0)
	end

	return var_22_1
end

function var_0_0.LastTimes(arg_23_0)
	return #arg_23_0.cost_time_list - (arg_23_0:InCurrentTime() - 1)
end

function var_0_0.OnGetAwardMidway(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.start_time = arg_24_1

	arg_24_0:SetCostList(arg_24_2)

	for iter_24_0 = 1, arg_24_3 do
		table = var_1_10008

		var_1_10008.remove(arg_24_0.extraList, 1)
	end

	return
end

return var_0_0
