local var_0_0 = singletonClass("KagutsuchiGachaData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0:InitDrawData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((self:GetPoolIds(arg_2_1.activity_id))) do
		self:InitPoolData(iter_2_1, arg_2_1)
	end
end

function var_0_0.InitPoolData(arg_3_0, arg_3_1, arg_3_2)
	var_0_1[arg_3_1] = {}
	var_0_1[arg_3_1].all = {}
	var_0_1[arg_3_1].displayItemIds = ActivityRewardPoolCfg[arg_3_1].icon_info
	var_0_1[arg_3_1].cost = ActivityRewardPoolCfg[arg_3_1].cost_once

	for iter_3_0, iter_3_1 in ipairs(ActivityRewardPoolItemCfg.get_id_list_by_activity_id[arg_3_1]) do
		var_0_1[arg_3_1][iter_3_1] = {
			id = iter_3_1,
			num = ActivityRewardPoolItemCfg[iter_3_1].total
		}

		table.insert(var_0_1[arg_3_1].all, iter_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2.reward_pool_list) do
		if iter_3_3.pool_id == arg_3_1 then
			for iter_3_4, iter_3_5 in ipairs(iter_3_3.reward_history_list) do
				var_0_1[arg_3_1][iter_3_5.id].num = var_0_1[arg_3_1][iter_3_5.id].num - iter_3_5.num
			end
		end
	end

	local var_3_0 = 0

	for iter_3_6, iter_3_7 in ipairs(ActivityRewardPoolItemCfg.get_id_list_by_activity_id[arg_3_1]) do
		var_3_0 = var_3_0 + var_0_1[arg_3_1][iter_3_7].num
	end

	var_0_1[arg_3_1].poolRemains = var_3_0
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	if var_0_1[arg_4_1] then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			var_0_1[arg_4_1][iter_4_1].num = math.max(var_0_1[arg_4_1][iter_4_1].num - 1, 0)
			var_0_1[arg_4_1].poolRemains = math.max(var_0_1[arg_4_1].poolRemains - 1, 0)
		end
	end
end

function var_0_0.GetPoolIds(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityRewardPoolCfg.all) do
		if ActivityRewardPoolCfg[iter_5_1].activity_id == arg_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.GetDrawItemReward(arg_6_0, arg_6_1, arg_6_2)
	return ActivityRewardPoolItemCfg[arg_6_2].reward[1], ActivityRewardPoolItemCfg[arg_6_2].reward[2]
end

function var_0_0.GetDrawItemTotalCount(arg_7_0, arg_7_1, arg_7_2)
	return ActivityRewardPoolItemCfg[arg_7_2].total
end

function var_0_0.GetDrawItemRemainCount(arg_8_0, arg_8_1, arg_8_2)
	return var_0_1[arg_8_1][arg_8_2].num
end

function var_0_0.GetDrawCost(arg_9_0, arg_9_1, arg_9_2)
	if var_0_1[arg_9_1] == nil then
		return
	end

	return var_0_1[arg_9_1].cost[1], var_0_1[arg_9_1].cost[2] * arg_9_2
end

function var_0_0.GetAllDrawItemIds(arg_10_0, arg_10_1)
	return var_0_1[arg_10_1].all
end

function var_0_0.GetDisplayDrawItemIds(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1].displayItemIds
end

function var_0_0:GetMaxDrawTimes(arg_12_1)
	local var_12_0 = math.min(math.floor(ItemTools.getItemNum(var_0_1[arg_12_1].cost[1]) / var_0_1[arg_12_1].cost[2]), 10)

	if var_12_0 == 0 then
		return var_12_0
	end

	return math.min(var_12_0, (self:GetPoolRemains(arg_12_1)))
end

function var_0_0.GetPoolRemains(arg_13_0, arg_13_1)
	if not arg_13_1 or not var_0_1[arg_13_1] then
		return 0
	end

	return var_0_1[arg_13_1].poolRemains
end

return var_0_0
