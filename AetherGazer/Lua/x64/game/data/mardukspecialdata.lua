local var_0_0 = singletonClass("MardukSpecialData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitDataFromServer(arg_2_0, arg_2_1)
	if not var_0_1[arg_2_1.activity_id] then
		var_0_1[arg_2_1.activity_id] = {}
	end

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
	local var_3_0 = var_0_1[arg_3_1]

	if not var_3_0 then
		return 0
	end

	return var_3_0.point
end

function var_0_0.GetCanGetRewardIndex(arg_4_0, arg_4_1)
	local var_4_0 = ActivityCfg[arg_4_1].sub_activity_list

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = MardukSpecialData:GetPoint(iter_4_1)
		local var_4_2

		for iter_4_2, iter_4_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1]) do
			local var_4_3 = ActivityPointRewardCfg[iter_4_3]
			local var_4_4 = MardukSpecialData:HaveGotReward(iter_4_1, iter_4_3)

			if var_4_1 >= var_4_3.need and not var_4_4 then
				return table.indexof(var_4_0, iter_4_1)
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
	local var_6_0 = var_0_1[arg_6_1]

	if not var_6_0 then
		return false
	end

	if table.indexof(var_6_0.got_reward_id_list, arg_6_2) then
		return true
	end

	return false
end

function var_0_0.OnGotReward(arg_7_0, arg_7_1)
	local var_7_0 = ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_7_1]

		for iter_7_2, iter_7_3 in ipairs(var_7_1) do
			if table.indexof(arg_7_1, iter_7_3) then
				local var_7_2 = var_0_1[iter_7_1]

				table.insert(var_7_2.got_reward_id_list, iter_7_3)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
			end
		end
	end

	local var_7_3 = ActivityCfg[ActivityConst.ACTIVITY_2_2_SPECIAL].sub_activity_list

	for iter_7_4, iter_7_5 in ipairs(var_7_3) do
		local var_7_4 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_7_5]

		for iter_7_6, iter_7_7 in ipairs(var_7_4) do
			if table.indexof(arg_7_1, iter_7_7) then
				local var_7_5 = var_0_1[iter_7_5]

				table.insert(var_7_5.got_reward_id_list, iter_7_7)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.ACTIVITY_2_2_SPECIAL)
			end
		end
	end

	manager.notify:Invoke(MARDUK_SPECIAL_REWARD_UPDATE, arg_7_1)
end

return var_0_0
