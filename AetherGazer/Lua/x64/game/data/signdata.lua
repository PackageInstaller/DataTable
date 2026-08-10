local var_0_0 = singletonClass("SignData")
local var_0_1
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = nil
	var_0_2 = {}
end

function var_0_0.InitDailySignData(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.sign_list) do
		table.insert(var_2_0, iter_2_1)
	end

	var_0_1 = {
		id = ActivityConst.SIGN,
		year = arg_2_1.year,
		month = arg_2_1.month,
		day = arg_2_1.day,
		days = var_2_0
	}
end

function var_0_0.InitSevenDaySignData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	var_0_2[var_3_0] = {
		id = var_3_0,
		signCount = arg_3_1.sign_count,
		lastSignTime = arg_3_1.last_sign_time
	}
end

function var_0_0.UpdateDailySign(arg_4_0, arg_4_1)
	table.insert(var_0_1.days, arg_4_1)
end

function var_0_0.UpdateSevenDaySign(arg_5_0, arg_5_1, arg_5_2)
	if var_0_2[arg_5_1] then
		var_0_2[arg_5_1].signCount = var_0_2[arg_5_1].signCount + 1
		var_0_2[arg_5_1].lastSignTime = arg_5_2
	end
end

function var_0_0.GetDailySignInfo(arg_6_0)
	return var_0_1
end

function var_0_0.GetSevenDaySignInfo(arg_7_0, arg_7_1)
	return var_0_2[arg_7_1]
end

local var_0_3 = 1

function var_0_0.GetHistoryIndex(arg_8_0)
	return var_0_3
end

function var_0_0.SetHistoryIndex(arg_9_0, arg_9_1)
	var_0_3 = arg_9_1
end

return var_0_0
