local var_0_0 = singletonClass("RegressionData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 4
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = ""
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = 0
local var_0_12 = 0

function var_0_0.Init(arg_1_0)
	var_0_1 = 0
	var_0_2 = 0
	var_0_3 = 0
	var_0_4 = 0
	var_0_5 = 0
	var_0_6 = {}
	var_0_7 = 0
	var_0_8 = ""
	var_0_9 = {}
	var_0_10 = {}
	var_0_11 = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1 = arg_2_1.vs
	var_0_2 = arg_2_1.return_login_time
	var_0_3 = arg_2_1.return_last_offline_time
	var_0_4 = arg_2_1.receive_sign_index
	var_0_5 = arg_2_1.last_update_receive_time

	local var_2_0 = arg_2_1.received_sign_list

	var_0_6 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_0_6, iter_2_1)
	end

	var_0_7 = arg_2_1.is_receive_gift
	var_0_8 = arg_2_1.url

	local var_2_1 = arg_2_1.bp

	if var_2_1 ~= nil then
		var_0_11 = var_2_1.is_recharge

		for iter_2_2, iter_2_3 in ipairs(var_2_1.bp_assignment) do
			var_0_10[iter_2_3.id] = {
				id = iter_2_3.id,
				is_receive_reward = iter_2_3.is_receive_reward,
				is_receive_recharge_reward = iter_2_3.is_receive_recharge_reward
			}
		end
	end

	local var_2_2 = arg_2_1.gashapon_reward

	if var_2_2 ~= nil then
		for iter_2_4, iter_2_5 in ipairs(var_2_2) do
			var_0_9[iter_2_5.id] = {
				id = iter_2_5.id,
				remain_num = iter_2_5.residual_num
			}
		end
	end

	var_0_12 = arg_2_1.acc_num or 0
end

function var_0_0.IsRegressionOpen(arg_3_0)
	if var_0_1 == 0 then
		return false
	end

	local var_3_0 = manager.time:GetServerTime()
	local var_3_1 = 86400 * GameSetting.return_duration_time.value[1]

	return var_3_0 < var_0_2 + var_3_1
end

function var_0_0.CheckRegressionGift(arg_4_0)
	return arg_4_0:IsRegressionOpen() and var_0_7 == 0
end

function var_0_0.GetRegressionVersion(arg_5_0)
	return var_0_1
end

function var_0_0.GetRegressionLoginTime(arg_6_0)
	return var_0_2
end

function var_0_0.UpdateRegressionGift(arg_7_0)
	var_0_7 = 1
end

function var_0_0.GetRegressionGiftReceive(arg_8_0)
	return var_0_7 == 1
end

function var_0_0.IsSignReward(arg_9_0, arg_9_1)
	return not not table.indexof(var_0_6, arg_9_1)
end

function var_0_0.UpdateSign(arg_10_0, arg_10_1)
	table.insert(var_0_6, arg_10_1)
end

function var_0_0.GetSignIndex(arg_11_0)
	local var_11_0 = manager.time:GetTodayFreshTime()

	if var_0_1 == 0 then
		return 0
	end

	local var_11_1 = RegressionCfg[var_0_1] and RegressionCfg[var_0_1].sign_reward or {}

	if var_0_4 >= #var_11_1 then
		return #var_11_1
	end

	if var_11_0 > var_0_5 then
		return var_0_4 + 1
	end

	return var_0_4
end

function var_0_0.GetUrl(arg_12_0)
	return var_0_8
end

function var_0_0.GetBPTaskStatus(arg_13_0)
	return var_0_10
end

function var_0_0.GetBPTaskIsRecharge(arg_14_0)
	return var_0_11
end

function var_0_0.SetBPTaskIsRecharge(arg_15_0)
	var_0_11 = 1
end

function var_0_0.SetBPTaskStatus(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if var_0_10[iter_16_1.id] == nil then
			var_0_10[iter_16_1.id] = {
				is_receive_recharge_reward = 0,
				is_receive_reward = 0,
				id = iter_16_1.id
			}
		end

		if iter_16_1.receive_type == 1 then
			var_0_10[iter_16_1.id].is_receive_reward = 1
		else
			var_0_10[iter_16_1.id].is_receive_recharge_reward = 1
		end
	end
end

function var_0_0.GetCapsuleToysStatus(arg_17_0)
	return var_0_9
end

function var_0_0.SetCapsuleToysStatus(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = iter_18_1[1]

		if var_0_9[var_18_0] then
			var_0_9[var_18_0].remain_num = var_0_9[var_18_0].remain_num - 1
			var_0_9[var_18_0].remain_num = var_0_9[var_18_0].remain_num < 0 and 0 or var_0_9[var_18_0].remain_num
		end
	end
end

function var_0_0.GetAccumulateCurrency(arg_19_0)
	return var_0_12
end

function var_0_0.SetAccumulateCurrency(arg_20_0, arg_20_1)
	var_0_12 = var_0_12 + arg_20_1
end

function var_0_0.GetLastOfflineTime(arg_21_0)
	return var_0_3
end

return var_0_0
