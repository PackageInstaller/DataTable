local var_0_0 = class("SignInfoStruct_New")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activity_id = arg_1_1.activity_id
	arg_1_0.unlock_reward = arg_1_1.unlock_reward or {}
	arg_1_0.gain_reward = arg_1_1.gain_reward or {}
	arg_1_0.unlock_times = arg_1_1.unlock_times or 0
	arg_1_0.gift_reward = arg_1_1.gift_reward or 0
end

function var_0_0.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id_list
	local var_2_1 = arg_2_1.id
	local var_2_2 = 0

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			table.insert(arg_2_0.gain_reward, iter_2_1)

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.unlock_reward) do
				if iter_2_1 == iter_2_3 then
					var_2_2 = iter_2_2
				end
			end
		end

		table.remove(arg_2_0.unlock_reward, var_2_2)
	end

	if var_2_1 then
		table.insert(arg_2_0.gain_reward, var_2_1)

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.unlock_reward) do
			if var_2_1 == iter_2_5 then
				var_2_2 = iter_2_4
			end
		end

		table.remove(arg_2_0.unlock_reward, var_2_2)
	end
end

function var_0_0.UpdateUnlockTimes(arg_3_0)
	arg_3_0.unlock_times = arg_3_0.unlock_times + 1
end

function var_0_0.UpdateActivityDataByGiftReward(arg_4_0)
	arg_4_0.gift_reward = 1
end

function var_0_0.TotalSignDay(arg_5_0)
	local var_5_0 = ActivityCumulativeSignCfg[arg_5_0.activity_id]

	return var_5_0 and #var_5_0.config_list or 7
end

function var_0_0.OnSignSuccess(arg_6_0, arg_6_1)
	arg_6_0:Update(arg_6_1)
end

function var_0_0.EndTime(arg_7_0)
	return ActivityData:GetActivityData(arg_7_0.activity_id).stopTime
end

function var_0_0.OnCrossDayNew(arg_8_0)
	return
end

function var_0_0.ReSignNum(arg_9_0)
	local var_9_0 = arg_9_0:TotalSignDay()
	local var_9_1 = manager.time
	local var_9_2 = 86400
	local var_9_3 = var_9_1:GetServerTime()
	local var_9_4 = arg_9_0:EndTime() - var_9_3
	local var_9_5 = math.ceil(var_9_4 / var_9_2)

	return (math.max(var_9_0 - var_9_5 - arg_9_0.unlock_times, 0))
end

function var_0_0.SignRewardList(arg_10_0)
	if arg_10_0.reward_list then
		return arg_10_0.reward_list
	end

	arg_10_0.reward_list = {}

	local var_10_0 = ActivityCumulativeSignCfg[arg_10_0.activity_id]

	if not var_10_0 then
		print("ActivityCumulativeSignCfg不存在对应活动的配置------>", arg_10_0.activity_id)

		return
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0.config_list) do
		table.insert(arg_10_0.reward_list, SignCfg[iter_10_1].reward)
	end

	return arg_10_0.reward_list
end

function var_0_0.RedDotCount(arg_11_0)
	return #arg_11_0.unlock_reward
end

function var_0_0.GetGiftRedDotCount(arg_12_0)
	return arg_12_0.gift_reward
end

return var_0_0
