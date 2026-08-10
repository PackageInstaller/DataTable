local var_0_0 = singletonClass("NewServerData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 4
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 0
local var_0_8 = 0

function var_0_0.Init(arg_1_0)
	var_0_2 = 0
	var_0_3 = 0
	var_0_4 = {}
	var_0_5 = {}
	var_0_6 = {}
	var_0_7 = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1 = arg_2_1.activity_id
	var_0_2 = arg_2_1.receive_sign_index
	var_0_3 = arg_2_1.last_update_receive_time

	local var_2_0 = arg_2_1.received_sign_list

	var_0_4 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_0_4, iter_2_1)
	end

	local var_2_1 = arg_2_1.bp

	if var_2_1 ~= nil then
		var_0_7 = var_2_1.is_recharge

		for iter_2_2, iter_2_3 in ipairs(var_2_1.bp_assignment) do
			var_0_6[iter_2_3.id] = {
				id = iter_2_3.id,
				is_receive_reward = iter_2_3.is_receive_reward,
				is_receive_recharge_reward = iter_2_3.is_receive_recharge_reward
			}
		end
	end

	local var_2_2 = arg_2_1.gashapon_reward_list

	if var_2_2 ~= nil then
		for iter_2_4, iter_2_5 in ipairs(var_2_2) do
			var_0_5[iter_2_5.id] = {
				id = iter_2_5.id,
				remain_num = iter_2_5.residual_num
			}
		end
	end

	var_0_8 = arg_2_1.acc_num or 0
end

function var_0_0.GetActivityID(arg_3_0)
	return var_0_1
end

function var_0_0.IsSignReward(arg_4_0, arg_4_1)
	return not not table.indexof(var_0_4, arg_4_1)
end

function var_0_0.UpdateSign(arg_5_0, arg_5_1)
	table.insert(var_0_4, arg_5_1)
end

function var_0_0.GetSignIndex(arg_6_0)
	local var_6_0 = manager.time:GetTodayFreshTime()
	local var_6_1 = NewServerCfg[var_0_1] and NewServerCfg[var_0_1].sign_reward or {}

	if var_0_2 >= #var_6_1 then
		return #var_6_1
	end

	if var_6_0 > var_0_3 then
		return var_0_2 + 1
	end

	return var_0_2
end

function var_0_0.GetBPTaskStatus(arg_7_0)
	return var_0_6
end

function var_0_0.GetBPTaskIsRecharge(arg_8_0)
	return var_0_7
end

function var_0_0.SetBPTaskIsRecharge(arg_9_0)
	var_0_7 = 1
end

function var_0_0.SetBPTaskStatus(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if var_0_6[iter_10_1.id] == nil then
			var_0_6[iter_10_1.id] = {
				is_receive_recharge_reward = 0,
				is_receive_reward = 0,
				id = iter_10_1.id
			}
		end

		if iter_10_1.receive_type == 1 then
			var_0_6[iter_10_1.id].is_receive_reward = 1
		else
			var_0_6[iter_10_1.id].is_receive_recharge_reward = 1
		end
	end
end

function var_0_0.GetCapsuleToysStatus(arg_11_0)
	return var_0_5
end

function var_0_0.SetCapsuleToysStatus(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = iter_12_1[1]

		if var_0_5[var_12_0] then
			var_0_5[var_12_0].remain_num = var_0_5[var_12_0].remain_num - 1
			var_0_5[var_12_0].remain_num = var_0_5[var_12_0].remain_num < 0 and 0 or var_0_5[var_12_0].remain_num
		end
	end
end

function var_0_0.GetAccumulateCurrency(arg_13_0)
	return var_0_8
end

function var_0_0.SetAccumulateCurrency(arg_14_0, arg_14_1)
	var_0_8 = arg_14_1
end

return var_0_0
