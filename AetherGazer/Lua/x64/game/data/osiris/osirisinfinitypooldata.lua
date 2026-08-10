local var_0_0 = singletonClass("OsirisInfinityPoolData")

function var_0_0.Init(arg_1_0)
	arg_1_0.poolList_ = {}

	for iter_1_0, iter_1_1 in ipairs(ActivityInfinityPoolCfg.all) do
		arg_1_0.poolList_[iter_1_1] = {
			isOpenCoreItem = false,
			openBoxList = {},
			itemList = {},
			resultItemList = {}
		}
	end

	arg_1_0.openPhase_ = {}
	arg_1_0.clickPhase_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.pool_list) do
		local var_2_0 = ActivityInfinityPoolCfg[iter_2_1.id].activity_id

		arg_2_0.openPhase_[var_2_0] = arg_2_0.openPhase_[var_2_0] or 1
		arg_2_0.poolList_[iter_2_1.id] = arg_2_0:ParsePool(iter_2_1)
	end
end

function var_0_0.ParsePool(arg_3_0, arg_3_1)
	if arg_3_1.is_got_core_item and arg_3_1.is_got_core_item == 1 then
		local var_3_0 = ActivityInfinityPoolCfg[arg_3_1.id].activity_id
		local var_3_1 = table.keyof(ActivityInfinityPoolCfg.get_id_list_by_activity_id[var_3_0], arg_3_1.id)

		if arg_3_0.openPhase_[var_3_0] < var_3_1 + 1 then
			arg_3_0.openPhase_[var_3_0] = var_3_1 + 1
		end
	end

	local var_3_2 = arg_3_1.box_list
	local var_3_3 = arg_3_1.item_list
	local var_3_4 = arg_3_0:StatisticsItem(var_3_3, var_3_2)

	return {
		openBoxList = var_3_2,
		coreItem = arg_3_1.core_item.id ~= 0 and {
			arg_3_1.core_item.id,
			arg_3_1.core_item.num
		} or nil,
		itemList = var_3_3,
		resultItemList = var_3_4,
		isOpenCoreItem = arg_3_1.is_got_core_item == 1
	}
end

function var_0_0.StatisticsItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		arg_4_0:InitRewardData(var_4_0, iter_4_1, arg_4_2)
	end

	return var_4_0
end

function var_0_0.InitRewardData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_1.reward[1] == arg_5_2[1] and iter_5_1.reward[2] == arg_5_2[2] then
			iter_5_1.maxCnt = iter_5_1.maxCnt + 1

			return
		end
	end

	local var_5_0 = 0

	for iter_5_2, iter_5_3 in pairs(arg_5_3) do
		if arg_5_2[1] == iter_5_3[1] and arg_5_2[2] == iter_5_3[2] then
			var_5_0 = var_5_0 + 1
		end
	end

	table.insert(arg_5_1, {
		maxCnt = 1,
		reward = arg_5_2,
		cnt = var_5_0
	})
end

function var_0_0.GetPoolList(arg_6_0)
	return arg_6_0.poolList_
end

function var_0_0.GetPoolData(arg_7_0, arg_7_1)
	return arg_7_0.poolList_[arg_7_1]
end

function var_0_0.GetOpenPhase(arg_8_0, arg_8_1)
	return arg_8_0.openPhase_[arg_8_1] or 1
end

function var_0_0.OpenBox(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_3) do
		var_9_0[iter_9_0] = {
			iter_9_1.item.id,
			iter_9_1.item.num
		}
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_2) do
		arg_9_0.poolList_[arg_9_1].openBoxList[iter_9_3] = var_9_0[iter_9_2]

		arg_9_0:AddRewardData(arg_9_0.poolList_[arg_9_1].resultItemList, var_9_0[iter_9_2])
	end

	local var_9_1 = arg_9_0.poolList_[arg_9_1]
	local var_9_2 = ActivityInfinityPoolCfg[arg_9_1].activity_id

	if arg_9_0.openPhase_[var_9_2] < #ActivityInfinityPoolCfg.get_id_list_by_activity_id[var_9_2] then
		for iter_9_4, iter_9_5 in ipairs(var_9_0) do
			if var_9_1.coreItem and iter_9_5[1] == var_9_1.coreItem[1] and iter_9_5[2] == var_9_1.coreItem[2] then
				arg_9_0.openPhase_[var_9_2] = arg_9_0.openPhase_[var_9_2] + 1
				arg_9_0.poolList_[arg_9_1].isOpenCoreItem = true

				manager.notify:Invoke(OSIRIS_INFINITY_OPEN_CORE_ITEM)
			end
		end
	end

	if var_9_1.coreItem == nil and table.length(arg_9_0.poolList_[arg_9_1].openBoxList) >= #arg_9_0.poolList_[arg_9_1].itemList then
		manager.notify:Invoke(OSIRIS_INFINITY_OPEN_CORE_ITEM)
	end
end

function var_0_0.AddRewardData(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if iter_10_1.reward[1] == arg_10_2[1] and iter_10_1.reward[2] == arg_10_2[2] then
			iter_10_1.cnt = iter_10_1.cnt + 1

			return
		end
	end
end

function var_0_0.ResetPool(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.poolList_[arg_11_1] = arg_11_0:ParsePool(arg_11_2)
end

function var_0_0.SetClickPhaseValue(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.clickPhase_[arg_12_1] = arg_12_2

	saveData("InfinityPhase", tostring(arg_12_1), arg_12_2)
end

function var_0_0.GetClickPhaseValue(arg_13_0, arg_13_1)
	return arg_13_0.clickPhase_[arg_13_1] or getData("InfinityPhase", tostring(arg_13_1)) or 1
end

return var_0_0
