local var_0_0 = singletonClass("WaiterAI")

function var_0_0.Init(arg_1_0)
	arg_1_0:RegisterEvent()

	arg_1_0.WaiterStateList = {}
	arg_1_0.WaiterState = {
		WaiterInteractPassTable = "WaiterInteractPassTable",
		WaiterPassFood = "WaiterPassFood",
		WaiterPlaceFood = "WaiterPlaceFood",
		WaiterIdle = "WaiterIdle",
		WaiterEnterScene = "WaiterEnterScene",
		WaiterMove = "WaiterMove"
	}
end

local function var_0_1()
	local var_2_0 = CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)

	return Dorm.storage:PickData(var_2_0)
end

function var_0_0.AIInit(arg_3_0, arg_3_1)
	if arg_3_1 == nil or arg_3_0.WaiterStateList[arg_3_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	arg_3_0.WaiterStateList[arg_3_1] = {
		state = arg_3_0.WaiterState.WaiterEnterScene,
		lastState = {}
	}

	arg_3_0:AIChoice(arg_3_1)
end

function var_0_0.RegisterEvent(arg_4_0)
	arg_4_0.listener = arg_4_0.listener or EventListener.New()

	arg_4_0.listener:RemoveAll()

	local var_4_0 = {
		[DORM_RESTAURANT_NEW_WAITER] = handler(arg_4_0, arg_4_0.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(arg_4_0, arg_4_0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(arg_4_0, arg_4_0.ListenInteractEvent),
		[DORM_LOGIC_TICK] = handler(arg_4_0, arg_4_0.Update),
		[DORM_CHARACTER_DISPOSE] = handler(arg_4_0, arg_4_0.DisposeEntity)
	}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		arg_4_0.listener:Register(iter_4_0, iter_4_1)
	end
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_0.ListenMoveEvent(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.WaiterStateList[arg_5_1] then
		return
	end

	arg_5_0:AIChoice(arg_5_1, var_0_3, arg_5_2)
end

function var_0_0.ListenInteractEvent(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.WaiterStateList[arg_6_1] then
		return
	end

	arg_6_0:AIChoice(arg_6_1, var_0_4, arg_6_2)
end

function var_0_0.RemoveListener(arg_7_0)
	arg_7_0.listener:RemoveAll()
end

function var_0_0.SwitchState(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.WaiterStateList[arg_8_1].lastState = arg_8_3 or arg_8_0.WaiterStateList[arg_8_1].state
	arg_8_0.WaiterStateList[arg_8_1].state = arg_8_2
end

function var_0_0.MoveToTarget(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0:ChoiceEndPosition(arg_9_1)
	local var_9_2 = arg_9_0.WaiterStateList[arg_9_1].state

	if var_9_1 then
		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, var_9_2, arg_9_1, var_9_0, var_9_1, false)
	else
		DormEventInvoke(DORM_CHARACTER_MOVE, var_9_2, arg_9_1, var_9_0, false)
	end
end

function var_0_0.ShouldReturnFoodToPassTable(arg_10_0)
	if arg_10_0.pick and arg_10_0.selectedOrder then
		if arg_10_0.selectedOrder.status == DormEnum.FoodState.Canceled then
			return true
		end

		if NormalCustomerAI.CheckFoodServeComplete(arg_10_0.selectedOrder.orderCharacterID) then
			return true
		end
	end
end

function var_0_0.AIChoice(arg_11_0, arg_11_1, arg_11_2, ...)
	local var_11_0 = arg_11_0.WaiterStateList[arg_11_1].state

	if var_11_0 == nil then
		print("服务员列表不存在该实例对象id")

		return
	end

	local var_11_1 = CanteenAIFunction:GetEntityData(arg_11_1)
	local var_11_2 = {
		...
	}

	if var_11_0 == arg_11_0.WaiterState.WaiterEnterScene then
		arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterMove)
		arg_11_0:MoveToTarget(arg_11_1)
	elseif var_11_0 == arg_11_0.WaiterState.WaiterMove then
		if arg_11_0.ShouldReturnFoodToPassTable(var_11_1) then
			var_11_1.selectedOrder = nil

			Dorm.DormEntityManager.StopAllCmd(arg_11_1)
			arg_11_0:MoveToTarget(arg_11_1)
		elseif arg_11_2 == var_0_3 then
			if CanteenAIFunction:GetCharacterPickItem(arg_11_1) then
				if var_11_1.selectedOrder then
					arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterPlaceFood)

					local var_11_3 = var_11_1.selectedOrder.orderTableID

					DormEventInvoke(DORM_CHARACTER_INTERACT, var_11_0, arg_11_1, var_11_3)
				else
					arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, var_11_0, arg_11_1, var_0_1())
				end
			else
				arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterIdle)
				CanteenAIFunction:SetCharacterBusy(arg_11_1, false)
			end
		end
	elseif var_11_0 == arg_11_0.WaiterState.WaiterIdle then
		if arg_11_2 == var_0_2 then
			local var_11_4 = var_11_2[1]

			for iter_11_0, iter_11_1 in ipairs(var_11_4) do
				local var_11_5 = arg_11_0:ArrangeFood(iter_11_1)

				if var_11_5 then
					CanteenAIFunction:SetCharacterBusy(arg_11_1, true)
					CanteenAIFunction:SetCharacterTarget(arg_11_1, var_11_5)

					var_11_1.selectedOrder = iter_11_1
					iter_11_1.status = DormEnum.FoodState.HasServer

					arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, var_11_0, arg_11_1, var_0_1())
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, iter_11_1.orderTableID)

					break
				end
			end
		end
	elseif var_11_0 == arg_11_0.WaiterState.WaiterInteractPassTable then
		if arg_11_2 == var_0_4 then
			arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterMove)
			arg_11_0:MoveToTarget(arg_11_1)
		end
	elseif var_11_0 == arg_11_0.WaiterState.WaiterPlaceFood then
		if arg_11_2 == var_0_4 then
			arg_11_0:SwitchState(arg_11_1, arg_11_0.WaiterState.WaiterMove)
			arg_11_0:MoveToTarget(arg_11_1)
		end
	else
		error("未找到对应状态")
	end
end

function var_0_0.ChoiceEndPosition(arg_12_0, arg_12_1)
	local var_12_0 = CanteenAIFunction:GetEntityData(arg_12_1)

	if var_12_0.pick and var_12_0.selectedOrder ~= nil and not arg_12_0.ShouldReturnFoodToPassTable(var_12_0) then
		local var_12_1 = var_12_0.selectedOrder.orderTableID
		local var_12_2 = CanteenItemManager.GetItemInteractPositions(var_12_1)

		return CanteenAIFunction:GetNearestPoint(arg_12_1, var_12_2), Dorm.DormEntityManager.QueryPosition(var_12_1)
	else
		local var_12_3 = CanteenItemManager.GetItemInteractPositions(var_0_1())

		return CanteenAIFunction:GetNearestPoint(arg_12_1, var_12_3)
	end
end

local function var_0_5()
	return Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField)
end

function var_0_0.Update(arg_14_0)
	local var_14_0 = var_0_5()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.WaiterStateList) do
		arg_14_0:AIChoice(iter_14_0, var_0_2, var_14_0)
	end
end

function var_0_0.FindFood(arg_15_0, arg_15_1)
	local var_15_0 = CanteenAIFunction:GetEntityData(var_0_1())
	local var_15_1 = nullable(var_15_0, "foodList")

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if arg_15_1 == CanteenAIFunction:GetEntityData(iter_15_1).cfgID then
				return iter_15_1
			end
		end
	end
end

function var_0_0.ArrangeFood(arg_16_0, arg_16_1)
	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		if arg_16_1.status == DormEnum.FoodState.Wait then
			local var_16_0 = arg_16_0:FindFood(arg_16_1.cfgID)

			if var_16_0 then
				arg_16_1.status = DormEnum.FoodState.HasCook
				arg_16_1.foodEID = var_16_0

				return arg_16_1.foodEID
			end
		end
	elseif arg_16_1.status == DormEnum.FoodState.HasCook then
		return arg_16_1.foodEID
	end
end

function var_0_0.AnyFreeWaiter(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.WaiterStateList) do
		if not CanteenAIFunction:GetCharacterBusy(iter_17_0) then
			return iter_17_0
		end
	end
end

function var_0_0.DisposeEntity(arg_18_0, arg_18_1)
	if arg_18_0.WaiterStateList[arg_18_1] then
		arg_18_0.WaiterStateList[arg_18_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_19_0)
	arg_19_0.WaiterStateList = {}
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:DisposeAllEntity()
	arg_20_0:RemoveListener()
end

return var_0_0
