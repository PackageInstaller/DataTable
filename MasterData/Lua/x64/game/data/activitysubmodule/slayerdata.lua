local var_0_0 = singletonClass("SlayerData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.InitSlayerData(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.slayer.got_reward_id_list) do
		table.insert(var_2_0, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.slayer.sub_activity_list) do
		var_2_1[iter_2_3.activity_id] = iter_2_3.point
	end

	var_0_2[arg_2_1.slayer.activity_id] = clone(var_0_1[arg_2_1.slayer.activity_id])
	var_0_1[arg_2_1.slayer.activity_id] = {
		got_reward_id_list = var_2_0,
		slayer_point_list = var_2_1
	}
end

function var_0_0.GetPoint(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_1] then
		return var_0_1[arg_3_1].slayer_point_list[arg_3_2] or 0
	end

	return 0
end

function var_0_0.GetRewardCount(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		return (var_0_1[arg_4_1].got_reward_id_list or nil) and (#var_0_1[arg_4_1].got_reward_id_list or 0)
	end

	return 0
end

function var_0_0.GetReceivedReward(arg_5_0, arg_5_1, arg_5_2)
	if var_0_1[arg_5_1] then
		return not not table.indexof(var_0_1[arg_5_1].got_reward_id_list, arg_5_2)
	end

	return false
end

function var_0_0.SetReceivedReward(arg_6_0, arg_6_1, arg_6_2)
	if var_0_1[arg_6_1] then
		table.insert(var_0_1[arg_6_1].got_reward_id_list, arg_6_2)
	end
end

function var_0_0.GetOldGetPoint(arg_7_0, arg_7_1, arg_7_2)
	if var_0_2[arg_7_1] then
		return var_0_2[arg_7_1].slayer_point_list[arg_7_2] or 0
	end

	return 0
end

function var_0_0.GetSlayerList(arg_8_0)
	return var_0_1
end

function var_0_0.SetRead(arg_9_0, arg_9_1)
	table.insert(var_0_3, arg_9_1)
end

function var_0_0.GetRead(arg_10_0, arg_10_1)
	return table.indexof(var_0_3, arg_10_1)
end

function var_0_0.GetSelectIndex(arg_11_0, arg_11_1)
	return getData(string.format("Slayer_%d", arg_11_1), "selectIndex")
end

function var_0_0.SetSelectIndex(arg_12_0, arg_12_1, arg_12_2)
	saveData(string.format("Slayer_%d", arg_12_1), "selectIndex", arg_12_2)
end

return var_0_0
