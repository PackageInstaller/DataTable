local var_0_0 = import(".InteractUtil")
local var_0_1 = var_0_0.NewTask

local function var_0_2(arg_1_0)
	local var_1_0 = arg_1_0.entityID
	local var_1_1 = arg_1_0.targetID
	local var_1_2 = arg_1_0.finish
	local var_1_3 = arg_1_0.entityData
	local var_1_4 = arg_1_0.targetData

	for iter_1_0, iter_1_1 in pairs(var_1_4.booked) do
		CanteenAIFunction:SetItemAvailable(iter_1_1, false)
	end

	var_0_0.commonAction.PlaceCarryingItemAction(var_1_0, var_1_1, function(arg_2_0)
		var_0_0.PutFoodOnTable(arg_2_0, var_1_1)
		var_0_0.RefreshFoodContainer(var_1_1)

		for iter_2_0, iter_2_1 in pairs(var_1_4.booked) do
			CanteenAIFunction:SetItemAvailable(iter_2_1, true)
		end
	end):Then(function()
		var_1_2:Notify()
	end):Start()
end

local function var_0_3(arg_4_0)
	local var_4_0 = arg_4_0.entityID
	local var_4_1 = arg_4_0.targetID
	local var_4_2 = arg_4_0.finish
	local var_4_3 = arg_4_0.entityData

	if var_4_3.pick then
		var_0_0.PlaceCarryingItemAction(var_4_0, var_4_1, function(arg_5_0)
			var_0_0.PutFoodOnTable(arg_5_0, var_4_1)
			var_0_0.RefreshFoodContainer(var_4_1)
		end):Then(function(arg_6_0)
			var_4_2:Notify()
		end):Start()
	else
		CanteenManager.RefreshOrder()

		var_4_3.target = var_0_0.PickFoodFromTable(var_4_3.target, var_4_1)

		var_0_0.commonAction.PickItemAction(var_4_0, var_4_1, function(arg_7_0)
			var_0_0.RefreshFoodContainer(var_4_1)
		end):Then(function()
			var_4_2:Notify()
		end):Start()
	end
end

return function(arg_9_0)
	local var_9_0 = arg_9_0.targetType
	local var_9_1 = arg_9_0.finish

	if var_9_0 == DormEnum.ItemType.DinningTable then
		var_0_2(arg_9_0)
	elseif var_9_0 == DormEnum.ItemType.PassTable then
		var_0_3(arg_9_0)
	else
		var_9_1:Notify(false)
		error("错误交互")
	end
end
