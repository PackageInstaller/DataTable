local var_0_0 = class("IslandRoleDelegationData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateData(arg_1_1)

	return
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.ship_id = arg_2_1.ship_id
	arg_2_0.formula_id = arg_2_1.formula_id
	arg_2_0.start_time = arg_2_1.start_time

	arg_2_0:SetCostList(arg_2_1.cost_time_list)

	arg_2_0.extraList = arg_2_1.times_extra or {}
	arg_2_0.once_cost_power = arg_2_1.once_cost_power
	arg_2_0.speed_time = arg_2_1.speed_time or 0

	arg_2_0:SetIsSend(false)

	return
end

function var_0_0.AddExtraList(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0.extraList, iter_3_1)
	end

	return
end

function var_0_0.GetExtraMainProduct(arg_4_0, arg_4_1)
	if arg_4_0.extraList[arg_4_1] then
		return arg_4_0.extraList[arg_4_1].main_extra or 0
	end
end

function var_0_0.GetExtraExtraProduct(arg_5_0, arg_5_1)
	if arg_5_0.extraList[arg_5_1] then
		return arg_5_0.extraList[arg_5_1].other_extra or 0
	end
end

function var_0_0.GetExtraExtraCost(arg_6_0, arg_6_1)
	if arg_6_0.extraList[arg_6_1] then
		return arg_6_0.extraList[arg_6_1].cost_extra or 0
	end
end

function var_0_0.AddCostList(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_0.cost_time_list
	local var_7_1 = #arg_7_0.cost_time_list == 0 and 0 or arg_7_0.cost_time_list[var_7_0]
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.cost_time_list, iter_7_1)

		arg_7_0.cost_Alltime_list[var_7_0 + iter_7_0] = iter_7_1 + var_7_1 + var_7_2
		var_7_2 = iter_7_1 + var_7_2
	end

	arg_7_0.end_time = arg_7_0.end_time + var_7_2
	arg_7_0.allTime = arg_7_0.allTime + var_7_2

	return
end

function var_0_0.SetCostList(arg_8_0, arg_8_1)
	arg_8_0.cost_time_list = arg_8_1
	arg_8_0.cost_Alltime_list = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.cost_time_list) do
		arg_8_0.cost_Alltime_list[iter_8_0] = iter_8_1 + 0
	end

	arg_8_0.end_time = arg_8_0.start_time

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.cost_time_list) do
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
		local var_10_0 = pg.TimeMgr.GetInstance():GetServerTime() >= arg_10_0.end_time + 1

		return var_10_0
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
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime() - arg_15_0.start_time

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.cost_Alltime_list) do
		if var_15_0 <= iter_15_1 then
			return iter_15_0
		end
	end

	return #arg_15_0.cost_Alltime_list
end

function var_0_0.GetCountByTimestamp(arg_16_0, arg_16_1)
	for iter_16_0 = #arg_16_0.cost_Alltime_list, 1, -1 do
		if arg_16_1 - arg_16_0.start_time >= arg_16_0.cost_Alltime_list[iter_16_0] then
			return iter_16_0
		end
	end

	return 0
end

function var_0_0.InCurrentTimeStart(arg_17_0, arg_17_1)
	local var_17_0 = 0

	for iter_17_0 = 1, arg_17_1 - 1 do
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
	if pg.TimeMgr.GetInstance():GetServerTime() >= arg_20_0.end_time then
		return #arg_20_0.cost_time_list
	end

	return arg_20_0:InCurrentTime() - 1
end

function var_0_0.GetCurrentCanRewardExtraMainNum(arg_21_0)
	local var_21_0 = 0

	for iter_21_0 = 1, arg_21_0:InCurrentTime() - 1 do
		var_21_0 = var_21_0 + arg_21_0:GetExtraMainProduct(iter_21_0)
	end

	return var_21_0
end

function var_0_0.GetReturnExtraNum(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0 = #arg_22_0.cost_time_list, #arg_22_0.cost_time_list - arg_22_1 + 1, -1 do
		var_22_0 = var_22_0 + arg_22_0:GetExtraExtraCost(iter_22_0)
	end

	return var_22_0
end

function var_0_0.LastTimes(arg_23_0)
	return #arg_23_0.cost_time_list - (arg_23_0:InCurrentTime() - 1)
end

function var_0_0.OnGetAwardMidway(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.start_time = arg_24_1

	arg_24_0:SetCostList(arg_24_2)

	for iter_24_0 = 1, arg_24_3 do
		table.remove(arg_24_0.extraList, 1)
	end

	return
end

return var_0_0
