local InteractUtil = import(".InteractUtil")

local function var_0_2(arg_1_0)
	local var_1_0 = arg_1_0.targetID
	local var_1_1 = arg_1_0.finish
	local var_1_3 = arg_1_0.targetData

	for iter_1_0, iter_1_1 in pairs(arg_1_0.targetData.booked) do
		CanteenAIFunction:SetItemAvailable(iter_1_1, false)
	end

	InteractUtil.commonAction.PlaceCarryingItemAction(arg_1_0.entityID, arg_1_0.targetID, function(arg_2_0)
		InteractUtil.PutFoodOnTable(arg_2_0, var_1_0)
		InteractUtil.RefreshFoodContainer(var_1_0)

		for iter_2_0, iter_2_1 in pairs(var_1_3.booked) do
			CanteenAIFunction:SetItemAvailable(iter_2_1, true)
		end
	end):Then(function()
		var_1_1:Notify()
	end):Start()
end

local function var_0_3(arg_4_0)
	local var_4_0 = arg_4_0.targetID
	local var_4_1 = arg_4_0.finish

	if arg_4_0.entityData.pick then
		InteractUtil.PlaceCarryingItemAction(arg_4_0.entityID, arg_4_0.targetID, function(arg_5_0)
			InteractUtil.PutFoodOnTable(arg_5_0, var_4_0)
			InteractUtil.RefreshFoodContainer(var_4_0)
		end):Then(function(arg_6_0)
			var_4_1:Notify()
		end):Start()
	else
		CanteenManager.RefreshOrder()

		arg_4_0.entityData.target = InteractUtil.PickFoodFromTable(arg_4_0.entityData.target, arg_4_0.targetID)

		InteractUtil.commonAction.PickItemAction(arg_4_0.entityID, arg_4_0.targetID, function(arg_7_0)
			InteractUtil.RefreshFoodContainer(var_4_0)
		end):Then(function()
			var_4_1:Notify()
		end):Start()
	end
end

return function(arg_9_0)
	if arg_9_0.targetType == DormEnum.ItemType.DinningTable then
		var_0_2(arg_9_0)
	elseif arg_9_0.targetType == DormEnum.ItemType.PassTable then
		var_0_3(arg_9_0)
	else
		arg_9_0.finish:Notify(false)
		error("错误交互")
	end
end
