local var_0_0 = singletonClass("OsirisInfinityPoolData")

function var_0_0:Init()
	self.poolList_ = {}

	for iter_1_0, iter_1_1 in ipairs(ActivityInfinityPoolCfg.all) do
		self.poolList_[iter_1_1] = {
			isOpenCoreItem = false,
			openBoxList = {},
			itemList = {},
			resultItemList = {}
		}
	end

	self.openPhase_ = {}
	self.clickPhase_ = {}
end

function var_0_0:InitData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.pool_list) do
		self.openPhase_[ActivityInfinityPoolCfg[iter_2_1.id].activity_id] = self.openPhase_[ActivityInfinityPoolCfg[iter_2_1.id].activity_id] or 1
		self.poolList_[iter_2_1.id] = self:ParsePool(iter_2_1)
	end
end

function var_0_0:ParsePool(arg_3_1)
	if arg_3_1.is_got_core_item and arg_3_1.is_got_core_item == 1 then
		local var_3_0 = table.keyof(ActivityInfinityPoolCfg.get_id_list_by_activity_id[ActivityInfinityPoolCfg[arg_3_1.id].activity_id], arg_3_1.id)
		local var_3_1
		local var_3_3
		local var_3_2

		if self.openPhase_[ActivityInfinityPoolCfg[arg_3_1.id].activity_id] < var_3_0 + 1 then
			self.openPhase_[ActivityInfinityPoolCfg[arg_3_1.id].activity_id] = var_3_0 + 1
			var_3_1 = arg_3_1.item_list
			var_3_2 = self:StatisticsItem(arg_3_1.item_list, arg_3_1.box_list)
			var_3_3 = {}
		end
	end

	var_3_3.openBoxList = arg_3_1.box_list
	var_3_3.coreItem = arg_3_1.core_item.id ~= 0 and {
		arg_3_1.core_item.id,
		arg_3_1.core_item.num
	} or nil
	var_3_3.itemList = var_3_1
	var_3_3.resultItemList = var_3_2
	var_3_3.isOpenCoreItem = arg_3_1.is_got_core_item == 1

	return var_3_3
end

function var_0_0:StatisticsItem(arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		self:InitRewardData(var_4_0, iter_4_1, arg_4_2)
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

function var_0_0:GetPoolList()
	return self.poolList_
end

function var_0_0:GetPoolData(arg_7_1)
	return self.poolList_[arg_7_1]
end

function var_0_0:GetOpenPhase(arg_8_1)
	return self.openPhase_[arg_8_1] or 1
end

function var_0_0:OpenBox(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_3) do
		var_9_0[iter_9_0] = {
			iter_9_1.item.id,
			iter_9_1.item.num
		}
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_2) do
		self.poolList_[arg_9_1].openBoxList[iter_9_3] = var_9_0[iter_9_2]

		self:AddRewardData(self.poolList_[arg_9_1].resultItemList, var_9_0[iter_9_2])
	end

	if self.openPhase_[ActivityInfinityPoolCfg[arg_9_1].activity_id] < #ActivityInfinityPoolCfg.get_id_list_by_activity_id[ActivityInfinityPoolCfg[arg_9_1].activity_id] then
		for iter_9_4, iter_9_5 in ipairs(var_9_0) do
			if self.poolList_[arg_9_1].coreItem and iter_9_5[1] == self.poolList_[arg_9_1].coreItem[1] and iter_9_5[2] == self.poolList_[arg_9_1].coreItem[2] then
				self.openPhase_[ActivityInfinityPoolCfg[arg_9_1].activity_id] = self.openPhase_[ActivityInfinityPoolCfg[arg_9_1].activity_id] + 1
				self.poolList_[arg_9_1].isOpenCoreItem = true

				manager.notify:Invoke(OSIRIS_INFINITY_OPEN_CORE_ITEM)
			end
		end
	end

	if self.poolList_[arg_9_1].coreItem == nil and table.length(self.poolList_[arg_9_1].openBoxList) >= #self.poolList_[arg_9_1].itemList then
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

function var_0_0:ResetPool(arg_11_1, arg_11_2)
	self.poolList_[arg_11_1] = self:ParsePool(arg_11_2)
end

function var_0_0:SetClickPhaseValue(arg_12_1, arg_12_2)
	self.clickPhase_[arg_12_1] = arg_12_2

	saveData("InfinityPhase", tostring(arg_12_1), arg_12_2)
end

function var_0_0:GetClickPhaseValue(arg_13_1)
	local var_13_0 = self.clickPhase_[arg_13_1]

	if not self.clickPhase_[arg_13_1] then
		var_13_0 = getData("InfinityPhase", tostring(arg_13_1))
		var_13_0 = var_13_0 or 1
	end

	return var_13_0
end

return var_0_0
