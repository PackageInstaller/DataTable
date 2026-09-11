local var_0_0 = singletonClass("MardukSpecialData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitDataFromServer(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = var_0_1[arg_2_1.activity_id] or {}
	var_0_1[arg_2_1.activity_id].activity_id = arg_2_1.activity_id
	var_0_1[arg_2_1.activity_id].point = arg_2_1.point
	var_0_1[arg_2_1.activity_id].got_reward_id_list = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_reward_id_list) do
		table.insert(var_0_1[arg_2_1.activity_id].got_reward_id_list, iter_2_1)
	end

	MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
	MardukSpecialAction.UpdateRedPoint(ActivityConst.ACTIVITY_2_2_SPECIAL)
	manager.notify:Invoke(MARDUK_SPECIAL_DATA_UPDATE, {})
end

function var_0_0.GetPoint(arg_3_0, arg_3_1)
	if not var_0_1[arg_3_1] then
		return 0
	end

	return var_0_1[arg_3_1].point
end

function var_0_0.GetCanGetRewardIndex(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(ActivityCfg[arg_4_1].sub_activity_list) do
		local var_4_0 = MardukSpecialData:GetPoint(iter_4_1)

		for iter_4_2, iter_4_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1]) do
			if var_4_0 >= ActivityPointRewardCfg[iter_4_3].need and not MardukSpecialData:HaveGotReward(iter_4_1, iter_4_3) then
				return table.indexof(ActivityCfg[arg_4_1].sub_activity_list, iter_4_1)
			end
		end
	end

	return 1
end

function var_0_0.GetGotRewardNum(arg_5_0, arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if var_0_1[iter_5_1] then
			var_5_0 = var_5_0 + #var_0_1[iter_5_1].got_reward_id_list
		end
	end

	return var_5_0
end

function var_0_0.HaveGotReward(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_1[arg_6_1] then
		return false
	end

	if table.indexof(var_0_1[arg_6_1].got_reward_id_list, arg_6_2) then
		return true
	end

	return false
end

function var_0_0.OnGotReward(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		for iter_7_2, iter_7_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_7_1]) do
			if table.indexof(arg_7_1, iter_7_3) then
				table.insert(var_0_1[iter_7_1].got_reward_id_list, iter_7_3)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
			end
		end
	end

	for iter_7_4, iter_7_5 in ipairs(ActivityCfg[ActivityConst.ACTIVITY_2_2_SPECIAL].sub_activity_list) do
		for iter_7_6, iter_7_7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_7_5]) do
			if table.indexof(arg_7_1, iter_7_7) then
				table.insert(var_0_1[iter_7_5].got_reward_id_list, iter_7_7)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.ACTIVITY_2_2_SPECIAL)
			end
		end
	end

	manager.notify:Invoke(MARDUK_SPECIAL_REWARD_UPDATE, arg_7_1)
end

return var_0_0
