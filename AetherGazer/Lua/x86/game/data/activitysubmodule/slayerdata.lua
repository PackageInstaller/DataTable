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
	local var_2_0 = arg_2_1.slayer
	local var_2_1 = var_2_0.activity_id
	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0.got_reward_id_list) do
		table.insert(var_2_2, iter_2_1)
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_0.sub_activity_list) do
		var_2_3[iter_2_3.activity_id] = iter_2_3.point
	end

	var_0_2[var_2_1] = clone(var_0_1[var_2_1])
	var_0_1[var_2_1] = {
		got_reward_id_list = var_2_2,
		slayer_point_list = var_2_3
	}
end

function var_0_0.GetPoint(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1[arg_3_1]

	if var_3_0 then
		return var_3_0.slayer_point_list[arg_3_2] or 0
	end

	return 0
end

function var_0_0.GetRewardCount(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		local var_4_0 = var_0_1[arg_4_1].got_reward_id_list

		return var_4_0 and #var_4_0 or 0
	end

	return 0
end

function var_0_0.GetReceivedReward(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_1[arg_5_1]

	if var_5_0 then
		return not not table.indexof(var_5_0.got_reward_id_list, arg_5_2)
	end

	return false
end

function var_0_0.SetReceivedReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_1[arg_6_1]

	if var_6_0 then
		table.insert(var_6_0.got_reward_id_list, arg_6_2)
	end
end

function var_0_0.GetOldGetPoint(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_2[arg_7_1]

	if var_7_0 then
		return var_7_0.slayer_point_list[arg_7_2] or 0
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
