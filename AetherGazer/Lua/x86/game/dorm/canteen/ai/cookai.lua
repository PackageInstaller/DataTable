local var_0_0 = singletonClass("CookAI")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	Interact = "Interact",
	Move = "Move",
	Idle = "Idle",
	Wait = "Wait"
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listener = EventListener.New()
	var_0_1[var_0_3.Move] = arg_1_0.MoveToTarget
	var_0_1[var_0_3.Interact] = arg_1_0.InteractToTarget
	var_0_1[var_0_3.Idle] = arg_1_0.OnIdle
end

local var_0_4 = 0
local var_0_5 = 1
local var_0_6 = 2

function var_0_0.CurState(arg_2_0, arg_2_1)
	return arg_2_0.CookTargetList[arg_2_1].state
end

function var_0_0.SwitchState(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3 or arg_3_0.CookTargetList[arg_3_1].state

	arg_3_0.CookTargetList[arg_3_1].lastState = var_3_0
	arg_3_0.CookTargetList[arg_3_1].state = arg_3_2

	if var_0_2[var_3_0] then
		var_0_2[var_3_0](arg_3_0, arg_3_1)
	end

	if var_0_1[arg_3_2] then
		var_0_1[arg_3_2](arg_3_0, arg_3_1)
	end
end

function var_0_0.Init(arg_4_0)
	arg_4_0:RegisterEvent()

	arg_4_0.CookTargetList = {}

	local var_4_0 = CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)

	arg_4_0.passtableEID = CanteenAIFunction:GetAllEIDNameSpace(var_4_0)[1]
end

function var_0_0.AIInit(arg_5_0, arg_5_1)
	arg_5_0.CookTargetList[arg_5_1] = {
		state = var_0_3.Idle
	}

	arg_5_0:OnIdle(arg_5_1)
	arg_5_0:AIChoice(arg_5_1)
end

function var_0_0.RegisterEvent(arg_6_0)
	arg_6_0.listener = arg_6_0.listener or EventListener.New()

	arg_6_0.listener:RemoveAll()

	local var_6_0 = {
		[DORM_RESTAURANT_NEW_COOK] = handler(arg_6_0, arg_6_0.ListenGenerate),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(arg_6_0, arg_6_0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(arg_6_0, arg_6_0.ListenInteractEvent),
		[DORM_LOGIC_TICK] = handler(arg_6_0, arg_6_0.Update),
		[DORM_CHARACTER_DISPOSE] = handler(arg_6_0, arg_6_0.DisposeEntity)
	}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		arg_6_0.listener:Register(iter_6_0, iter_6_1)
	end
end

function var_0_0.ListenGenerate(arg_7_0, arg_7_1)
	arg_7_0:AIInit(arg_7_1)
end

function var_0_0.ListenMoveEvent(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.CookTargetList[arg_8_1] then
		return
	end

	arg_8_0:AIChoice(arg_8_1, var_0_5, arg_8_2)
end

function var_0_0.ListenInteractEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3, ...)
	if not arg_9_0.CookTargetList[arg_9_1] then
		return
	end

	if arg_9_3 then
		arg_9_0:AIChoice(arg_9_1, var_0_6, arg_9_3)
	end
end

function var_0_0.RemoveListener(arg_10_0)
	arg_10_0.listener:RemoveAll()
end

local function var_0_7(arg_11_0)
	return DormEnum.RestaurantKitchenWare[BackHomeCanteenFoodCfg[arg_11_0].cook_type]
end

local function var_0_8(arg_12_0)
	local var_12_0 = CanteenAIFunction:GetEntityData(arg_12_0)

	return CanteenAIFunction:GetItemAvailable(arg_12_0) and not var_12_0.cookComplete
end

local function var_0_9(arg_13_0)
	local var_13_0 = CanteenAIFunction:GetEntityData(arg_13_0)

	return CanteenAIFunction:GetItemAvailable(arg_13_0) and var_13_0.cookComplete
end

function var_0_0.ChooseByRestaurantOrders()
	local var_14_0 = Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField)
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs(DormEnum.RestaurantKitchenWare) do
		local var_14_2 = CanteenItemManager.ItemEIdNamespace(iter_14_1)

		for iter_14_2, iter_14_3 in Dorm.storage:ForeachData(var_14_2, pairs) do
			if var_0_8(iter_14_3) then
				var_14_1[iter_14_1] = iter_14_3

				break
			end
		end
	end

	for iter_14_4, iter_14_5 in ipairs(var_14_0) do
		local var_14_3 = var_14_1[var_0_7(iter_14_5.cfgID)]

		if iter_14_5.status == DormEnum.FoodState.Wait and var_14_3 then
			iter_14_5.status = DormEnum.FoodState.Cooking

			return iter_14_5, var_14_3
		end
	end
end

function var_0_0.AIChoice(arg_15_0, arg_15_1, arg_15_2, ...)
	local var_15_0 = CanteenAIFunction:GetEntityData(arg_15_1)
	local var_15_1 = arg_15_0.CookTargetList[arg_15_1].state

	if var_15_1 == nil then
		print("厨圣列表不存在该实例对象id")

		return
	end

	if var_15_1 == var_0_3.Idle then
		if var_15_0.pick then
			arg_15_0:SetAITarget(arg_15_1, arg_15_0.passtableEID)
		else
			local var_15_2 = arg_15_0:PickFood()

			if var_15_2 then
				arg_15_0:SetAITarget(arg_15_1, var_15_2)
			else
				local var_15_3 = arg_15_0:CookFood(arg_15_1)

				if var_15_3 then
					arg_15_0:SetAITarget(arg_15_1, var_15_3)
				end
			end
		end

		if arg_15_0:HasAITarget(arg_15_1) then
			arg_15_0:SwitchState(arg_15_1, var_0_3.Move)
		end
	elseif var_15_1 == var_0_3.Move then
		if arg_15_2 == var_0_5 then
			arg_15_0:SwitchState(arg_15_1, var_0_3.Wait)
		end
	elseif var_15_1 == var_0_3.Wait then
		if CanteenAIFunction:GetItemAvailable(arg_15_0.CookTargetList[arg_15_1].targetItem) then
			arg_15_0:SwitchState(arg_15_1, var_0_3.Interact)
		end
	elseif var_15_1 == var_0_3.Interact and arg_15_2 == var_0_6 then
		arg_15_0:SwitchState(arg_15_1, var_0_3.Idle)
	end
end

local function var_0_10(arg_16_0)
	return {
		cfgID = arg_16_0,
		quality = DormEnum.FoodQuality.normal
	}
end

function var_0_0.CookFood(arg_17_0, arg_17_1)
	local var_17_0 = CanteenAIFunction:GetEntityData(arg_17_1)
	local var_17_1, var_17_2 = arg_17_0.ChooseByRestaurantOrders()

	if var_17_1 then
		CanteenAIFunction:SetCharacterBusy(arg_17_1, true)

		var_17_0.selectedOrder = var_17_1

		local var_17_3 = var_17_0.selectedOrder.cfgID

		CanteenAIFunction:GetEntityData(var_17_2).curCooking = var_0_10(var_17_3)

		return var_17_2
	end
end

function var_0_0.PickFood(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(DormEnum.RestaurantKitchenWare) do
		local var_18_0 = CanteenAIFunction:GetNameSpace(iter_18_1)

		for iter_18_2, iter_18_3 in Dorm.storage:ForeachData(var_18_0, pairs) do
			if var_0_9(iter_18_3) then
				return iter_18_3
			end
		end
	end
end

function var_0_0.ToTargetPos(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = CanteenItemManager.GetItemInteractPositions(arg_19_2)

	return CanteenAIFunction:GetNearestPoint(arg_19_1, var_19_0)
end

function var_0_0.Move(arg_20_0, arg_20_1, arg_20_2)
	DormEventInvoke(DORM_CHARACTER_MOVE, arg_20_0:CurState(arg_20_1), arg_20_1, arg_20_2)
end

function var_0_0.MoveLookToDir(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, arg_21_0:CurState(arg_21_1), arg_21_1, arg_21_2, arg_21_3)
end

function var_0_0.MoveToTarget(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.CookTargetList[arg_22_1].targetItem
	local var_22_1 = arg_22_0:ToTargetPos(arg_22_1, var_22_0)

	if var_22_0 == arg_22_0.passtableEID then
		arg_22_0:Move(arg_22_1, var_22_1)
	else
		local var_22_2 = Dorm.DormEntityManager.QueryForwardDir(var_22_0)

		arg_22_0:MoveLookToDir(arg_22_1, var_22_1, var_22_2)
	end
end

function var_0_0.InteractToTarget(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.CookTargetList[arg_23_1].targetItem

	DormEventInvoke(DORM_CHARACTER_INTERACT, arg_23_0:CurState(arg_23_1), arg_23_1, var_23_0)
end

function var_0_0.HasAITarget(arg_24_0, arg_24_1)
	return arg_24_0.CookTargetList[arg_24_1].targetItem ~= nil
end

function var_0_0.SetAITarget(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.CookTargetList[arg_25_1].targetItem = arg_25_2
end

function var_0_0.OnIdle(arg_26_0, arg_26_1)
	arg_26_0.CookTargetList[arg_26_1].targetItem = nil

	CanteenAIFunction:SetCharacterBusy(arg_26_1, false)
end

function var_0_0.DisposeEntity(arg_27_0, arg_27_1)
	arg_27_0.CookTargetList[arg_27_1] = nil
end

function var_0_0.DisposeAllEntity(arg_28_0)
	arg_28_0.CookTargetList = nil
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:RemoveListener()
	arg_29_0:DisposeAllEntity()
end

function var_0_0.Update(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.CookTargetList) do
		arg_30_0:AIChoice(iter_30_0, var_0_4)
	end
end

return var_0_0
