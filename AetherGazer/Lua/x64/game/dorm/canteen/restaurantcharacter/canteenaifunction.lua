local var_0_0 = {
	FindAvailableChair = function(arg_1_0, arg_1_1)
		return
	end,
	FindAvailableItem = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = Dorm.storage
		local var_2_1 = CanteenItemManager.ItemEIdNamespace(arg_2_2)
		local var_2_2 = {}

		for iter_2_0, iter_2_1 in var_2_0:ForeachData(var_2_1, pairs) do
			if arg_2_0:GetItemAvailable(iter_2_1) then
				table.insert(var_2_2, iter_2_1)
			end
		end

		return var_2_2[math.random(1, #var_2_2)]
	end,
	FindPoint = function(arg_3_0, arg_3_1)
		local var_3_0 = CanteenManager.PosNamespace(arg_3_1)
		local var_3_1 = Dorm.storage:RndPickData(var_3_0)

		if var_3_1 == nil then
			error(string.format("无%s类点可随机挑选", arg_3_1))
		end

		return var_3_1.transform.position
	end
}

function var_0_0.FindNearestPoint(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = CanteenManager.PosNamespace(arg_4_2)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in Dorm.storage:ForeachData(var_4_0, pairs) do
		table.insert(var_4_1, iter_4_1.transform.position)
	end

	return var_0_0:GetNearestPoint(arg_4_1, var_4_1)
end

function var_0_0.GetNearestPoint(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Dorm.DormEntityManager.QueryPosition(arg_5_1)

	return arg_5_0:GetNearestPointFrom(var_5_0, arg_5_2)
end

function var_0_0.GetNearestPointFrom(arg_6_0, arg_6_1, arg_6_2)
	if #arg_6_2 > 1 then
		table.sort(arg_6_2, function(arg_7_0, arg_7_1)
			return arg_7_0:Distance(arg_6_1) < arg_7_1:Distance(arg_6_1)
		end)
	end

	return arg_6_2[1]
end

function var_0_0.GetItemAvailable(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GetEntityData(arg_8_1)

	if var_8_0.available == nil then
		var_8_0.available = true
	end

	return var_8_0.available
end

function var_0_0.SetItemAvailable(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:GetEntityData(arg_9_1).available = arg_9_2
end

function var_0_0.SetCharacterBusy(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:GetEntityData(arg_10_1)

	if var_10_0 then
		var_10_0.busy = arg_10_2
	end
end

function var_0_0.SetCharacterTarget(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetEntityData(arg_11_1)

	if var_11_0 then
		var_11_0.target = arg_11_2
	end
end

function var_0_0.GetCharacterBusy(arg_12_0, arg_12_1)
	return arg_12_0:GetEntityData(arg_12_1).busy
end

function var_0_0.GetCharacterPickItem(arg_13_0, arg_13_1)
	return arg_13_0:GetEntityData(arg_13_1).pick
end

function var_0_0.GetCurCanteenMode(arg_14_0)
	local var_14_0 = CanteenAIFunction:GetEntityIDInSpace(DormEnum.Namespace.RestaurantBusiness, CanteenManager.businessModeField)

	if var_14_0 ~= nil then
		return var_14_0
	else
		error("未获取到当前餐厅运营模式")
	end
end

function var_0_0.GetEntityData(arg_15_0, arg_15_1)
	return DormUtils.GetEntityData(arg_15_1)
end

function var_0_0.GetNameSpace(arg_16_0, arg_16_1)
	return DormUtils.EIdNamespace(arg_16_1)
end

function var_0_0.GetEntityIDInSpace(arg_17_0, arg_17_1, arg_17_2)
	return Dorm.storage:GetData(arg_17_1, arg_17_2)
end

function var_0_0.GetFoodManualIndex(arg_18_0, arg_18_1)
	local var_18_0 = CanteenItemManager.ItemIdxNamespace(DormEnum.ItemType.Food)

	return Dorm.storage:GetData(var_18_0, arg_18_1)
end

function var_0_0.GetAllEIDByItemType(arg_19_0, arg_19_1)
	local var_19_0 = CanteenItemManager.ItemEIdNamespace(arg_19_1)

	return arg_19_0:GetAllEIDNameSpace(var_19_0)
end

function var_0_0.GetAllEIDNameSpace(arg_20_0, arg_20_1)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in Dorm.storage:ForeachData(arg_20_1, pairs) do
		table.insert(var_20_0, iter_20_1)
	end

	return var_20_0
end

function var_0_0.SetCustomerWaitFoodTimer(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:GetEntityData(arg_21_1).waitFoodTimer = arg_21_2

	arg_21_2:Start()
end

function var_0_0.StopCustomerWaitFoodTimer(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetEntityData(arg_22_1)

	if var_22_0.waitFoodTimer ~= nil then
		var_22_0.waitFoodTimer:Stop()

		var_22_0.waitFoodTimer = nil
	end
end

function var_0_0.SetCustomerWaitBillTimer(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:GetEntityData(arg_23_1)

	if var_23_0.waitBillTimer == nil then
		var_23_0.waitBillTimer = arg_23_2
	else
		error("顾客已经有等待结账计时器")
	end
end

function var_0_0.StopCustomerWaiteBillTimer(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetEntityData(arg_24_1)

	if var_24_0 and var_24_0.waitBillTimer then
		var_24_0.waitBillTimer:Stop()
		print("关闭顾客等待结账计时器")
	end
end

function var_0_0.CheckCharacterInteractPostion(arg_25_0, arg_25_1, arg_25_2)
	return
end

function var_0_0.GetEntityType(arg_26_0, arg_26_1)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityType, arg_26_1)
end

function var_0_0.IdentifyCookType(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetEntityType(arg_27_1)

	if var_27_0 == DormEnum.ItemType.Pan or var_27_0 == DormEnum.ItemType.Oven or var_27_0 == DormEnum.ItemType.Pot or var_27_0 == DormEnum.ItemType.Steamer then
		return true
	end

	return false
end

function var_0_0.GetAllEntityInSameGroup(arg_28_0, arg_28_1)
	return arg_28_0:GetEntityData(arg_28_1).peer
end

return var_0_0
