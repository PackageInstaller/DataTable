local var_0_0 = class("SignInfoStruct")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activity_id = arg_1_1.activity_id

	arg_1_0:Update(arg_1_1)
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.sign_num = arg_2_1.sign_num or 0
	arg_2_0.today_buy_num = arg_2_1.today_buy_num or 0
	arg_2_0.left_sign_time = arg_2_1.left_sign_time or 1
end

function var_0_0.SignDay(arg_3_0)
	return arg_3_0.sign_num or 0
end

function var_0_0.TotalSignDay(arg_4_0)
	local var_4_0 = ActivityCumulativeSignCfg[arg_4_0.activity_id]

	return var_4_0 and #var_4_0.config_list or 7
end

function var_0_0.CumulativeLoginDay(arg_5_0)
	return arg_5_0.sign_num + arg_5_0.left_sign_time
end

function var_0_0.TodayBuyNum(arg_6_0)
	return arg_6_0.today_buy_num or 0
end

function var_0_0.LeftSignTimes(arg_7_0)
	return arg_7_0.left_sign_time or 0
end

function var_0_0.OnSignSuccess(arg_8_0, arg_8_1)
	arg_8_0:Update(arg_8_1)
end

function var_0_0.EndTime(arg_9_0)
	return ActivityData:GetActivityData(arg_9_0.activity_id).stopTime
end

function var_0_0.OnCrossDay(arg_10_0)
	if arg_10_0:TotalSignDay() > arg_10_0:CumulativeLoginDay() then
		arg_10_0.left_sign_time = 1
	end
end

function var_0_0.IsReSign(arg_11_0)
	if arg_11_0.left_sign_time > 0 then
		return false
	end

	local var_11_0 = arg_11_0:TotalSignDay()

	if var_11_0 <= arg_11_0:CumulativeLoginDay() then
		return false
	end

	local var_11_1 = manager.time
	local var_11_2 = 86400
	local var_11_3 = var_11_1:GetServerTime()
	local var_11_4 = arg_11_0:EndTime() - var_11_3
	local var_11_5 = math.ceil(var_11_4 / var_11_2)

	return math.max(var_11_0 - var_11_5 - arg_11_0.today_buy_num, 0) > 0
end

function var_0_0.ReSignNum(arg_12_0)
	if arg_12_0.left_sign_time > 0 then
		return 0
	end

	local var_12_0 = arg_12_0:TotalSignDay()

	if var_12_0 <= arg_12_0:CumulativeLoginDay() then
		return 0
	end

	local var_12_1 = manager.time
	local var_12_2 = 86400
	local var_12_3 = var_12_1:GetServerTime()
	local var_12_4 = arg_12_0:EndTime() - var_12_3
	local var_12_5 = math.ceil(var_12_4 / var_12_2)

	return (math.max(var_12_0 - var_12_5 - arg_12_0.today_buy_num, 0))
end

function var_0_0.SignRewardList(arg_13_0)
	if arg_13_0.reward_list then
		return arg_13_0.reward_list
	end

	arg_13_0.reward_list = {}

	local var_13_0 = ActivityCumulativeSignCfg[arg_13_0.activity_id]

	if not var_13_0 then
		print("ActivityCumulativeSignCfg不存在对应活动的配置------>", arg_13_0.activity_id)

		return
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0.config_list) do
		table.insert(arg_13_0.reward_list, SignCfg[iter_13_1].reward)
	end

	return arg_13_0.reward_list
end

function var_0_0.RedDotCount(arg_14_0)
	return arg_14_0.left_sign_time
end

return var_0_0
