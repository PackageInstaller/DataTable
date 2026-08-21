local var_0_0 = singletonClass("NormalCustomerAI")
local var_0_1 = {
	NormalCustomerEnterScene = "NormalCustomerEnterScene",
	NormalCustomerOrderFood = "NormalCustomerOrderFood",
	NormalCustomerTakeSeat = "NormalCustomerTakeSeat",
	NormalCustomerWaitFood = "NormalCustomerWaitFood",
	FvckOff = "NormalCustomerExpel",
	NormalCustomerTakeBillWithCashier = "NormalCustomerTakeBillWithCashier",
	NormalCustomerGotoExit = "NormalCustomerGotoExit",
	NormalCustomerGotoTable = "NormalCustomerGotoTable",
	NormalCustomerEatFood = "NormalCustomerEatFood",
	NormalCustomerDispose = "NormalCustomerDispose",
	NormalCustomerWaitBill = "NormalCustomerWaitBill",
	NormalCustomerGotoCashier = "NormalCustomerGotoCashier",
	NormalCustomerLeaveSeat = "NormalCustomerLeaveSeat",
	NormalCustomerThinkOrder = "NormalCustomerThinkOrder"
}
local var_0_2 = {
	[var_0_1.NormalCustomerGotoTable] = function(arg_1_0, arg_1_1)
		local var_1_0, var_1_1 = var_0_0.GotoDinningChair(arg_1_0)

		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, arg_1_1, arg_1_0, var_1_0, var_1_1)
	end,
	[var_0_1.NormalCustomerLeaveSeat] = function(arg_2_0, arg_2_1)
		local var_2_0 = CanteenAIFunction:GetEntityData(arg_2_0).chairEid

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_2_1, arg_2_0, var_2_0)

		local var_2_1 = CanteenItemManager.GetItemInteractPositions(var_2_0)
		local var_2_2 = CanteenAIFunction:GetNearestPoint(arg_2_0, var_2_1)

		DormEventInvoke(DORM_CHARACTER_MOVE, arg_2_1, arg_2_0, var_2_2, true, true)
	end,
	[var_0_1.NormalCustomerGotoExit] = function(arg_3_0, arg_3_1)
		local var_3_0 = CanteenAIFunction:FindNearestPoint(arg_3_0, DormEnum.Points.RestaurantExit)

		Dorm.DormEntityManager.FadeOutNearPoint(arg_3_0, var_3_0, 0.75)
		DormEventInvoke(DORM_CHARACTER_MOVE, arg_3_1, arg_3_0, var_3_0)
	end,
	[var_0_1.NormalCustomerGotoCashier] = function(arg_4_0, arg_4_1)
		local var_4_0 = CanteenAIFunction:FindPoint(DormEnum.Points.RestaurantCustomerPay)

		DormEventInvoke(DORM_CHARACTER_MOVE, arg_4_1, arg_4_0, var_4_0)
	end,
	[var_0_1.NormalCustomerOrderFood] = function(arg_5_0, arg_5_1)
		local var_5_0 = CanteenAIFunction:GetEntityData(arg_5_0)
		local var_5_1 = CanteenAIFunction:GetNameSpace(DormEnum.ItemType.OrderFoodDummy)
		local var_5_2 = CanteenAIFunction:GetAllEIDNameSpace(var_5_1)[1]

		var_5_0.orderInfo = var_0_0.OrderFood(var_5_0.peer)

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_5_1, arg_5_0, var_5_2)
	end,
	[var_0_1.NormalCustomerEatFood] = function(arg_6_0, arg_6_1)
		local var_6_0 = CanteenAIFunction:GetEntityData(arg_6_0).tableEid

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_6_1, arg_6_0, var_6_0)
	end
}
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7

function var_0_0.Init(arg_7_0)
	arg_7_0:RegisterEvent()

	arg_7_0.NormalCustomerStateList = {}
end

function var_0_0.AIInit(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == nil or arg_8_0.NormalCustomerStateList[arg_8_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	arg_8_0.NormalCustomerStateList[arg_8_1] = {
		state = var_0_1.NormalCustomerEnterScene
	}

	arg_8_0:AIChoice(arg_8_1, var_0_7, "Init")
end

function var_0_0.RegisterEvent(arg_9_0)
	local var_9_0 = arg_9_0.listener or EventListener.New()

	var_9_0:RemoveAll()
	var_9_0:Register(DORM_RESTAURANT_NEW_CUSTOMER, handler(arg_9_0, arg_9_0.AIInit))
	var_9_0:Register(ON_DORM_CHARACTER_MOVE_FINISH, handler(arg_9_0, arg_9_0.ListenMoveEvent))
	var_9_0:Register(ON_DORM_CHARACTER_INTERACT_FINISH, handler(arg_9_0, arg_9_0.ListenInteractEvent))
	var_9_0:Register(DORM_RESTAURANT_INTERACT_CUSTOMER, handler(arg_9_0, arg_9_0.ListenPlayerInteractEvent))
	var_9_0:Register(DORM_LOGIC_TICK, handler(arg_9_0, arg_9_0.Update))
	var_9_0:Register(DORM_CHARACTER_DISPOSE, handler(arg_9_0, arg_9_0.DisposeEntity))

	arg_9_0.listener = var_9_0
end

function var_0_0.RemoveListener(arg_10_0)
	arg_10_0.listener:RemoveAll()
end

function var_0_0.ListenMoveEvent(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.NormalCustomerStateList[arg_11_1] then
		return
	end

	if arg_11_2 then
		arg_11_0:AIChoice(arg_11_1, var_0_4)
	end
end

function var_0_0.ListenInteractEvent(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0.NormalCustomerStateList[arg_12_1] then
		return
	end

	arg_12_0:AIChoice(arg_12_1, var_0_5, arg_12_2)
end

function var_0_0.ListenPlayerInteractEvent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	for iter_13_0, iter_13_1 in ipairs(CanteenAIFunction:GetEntityData(arg_13_1).peer) do
		arg_13_0:SwitchState(iter_13_1, var_0_1.FvckOff)
	end
end

function var_0_0.SwitchState(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0.NormalCustomerStateList[arg_14_1].lastState = arg_14_3 or arg_14_0.NormalCustomerStateList[arg_14_1].state
	arg_14_0.NormalCustomerStateList[arg_14_1].state = arg_14_2

	if var_0_2[arg_14_2] then
		var_0_2[arg_14_2](arg_14_1, arg_14_2)
	end
end

function var_0_0.GetState(arg_15_0, arg_15_1)
	return arg_15_0.NormalCustomerStateList[arg_15_1].state
end

local function var_0_8(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		if not CanteenAIFunction:GetEntityData(iter_16_1).sit then
			return false
		end
	end

	return true
end

function var_0_0.CheckFoodDelivering(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(arg_17_0.curOrder) do
		if iter_17_1.status == DormEnum.FoodState.HasServer then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0 > (arg_17_0.foodList and #arg_17_0.foodList or 0)
end

function var_0_0.AIChoice(arg_18_0, arg_18_1, arg_18_2, ...)
	local var_18_0 = {
		...
	}
	local var_18_1 = arg_18_0.NormalCustomerStateList[arg_18_1].state

	if var_18_1 == nil then
		error("普通客人列表不存在实例对象id:" .. arg_18_1)

		return
	end

	local var_18_2 = CanteenAIFunction:GetEntityData(arg_18_1)
	local var_18_3 = var_18_2.tableEid
	local var_18_4 = CanteenAIFunction:GetEntityData(var_18_3)

	if var_18_1 == var_0_1.NormalCustomerEnterScene then
		arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoTable)
	elseif var_18_1 == var_0_1.NormalCustomerGotoTable then
		if arg_18_2 == var_0_4 then
			local var_18_5 = var_0_1.NormalCustomerTakeSeat

			arg_18_0:SwitchState(arg_18_1, var_18_5)

			local var_18_6 = var_18_2.chairEid
			local var_18_7 = var_18_2.chairEid
			local var_18_8 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(var_18_7, "gua_start_sit")
			local var_18_9 = Dorm.DormEntityManager.QueryForwardDir(var_18_7)

			DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, var_18_5, arg_18_1, var_18_8, var_18_9, true, true)
			DormEventInvoke(DORM_CHARACTER_INTERACT, var_18_5, arg_18_1, var_18_6, true)
		end
	elseif var_18_1 == var_0_1.NormalCustomerTakeSeat then
		if var_18_2.pay then
			if arg_18_2 == var_0_5 then
				arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerOrderFood)
			end
		elseif var_0_8(var_18_2.peer) then
			arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerWaitFood)
		end
	elseif var_18_1 == var_0_1.NormalCustomerOrderFood then
		if arg_18_2 == var_0_5 then
			if #var_18_4.curOrder == 0 then
				arg_18_0:SwitchState(arg_18_1, var_0_1.FvckOff)
			else
				arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerWaitFood)

				local var_18_10 = var_18_2.tableEid

				if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
					local var_18_11 = DormCharacterActionManager.taskRunner:NewTimer(function()
						arg_18_0:WaitFoodCallBack(var_18_2, var_18_4.curOrder)
					end, GameSetting.dorm_customer_wait_food_time.value[1], 1)

					CanteenAIFunction:SetCustomerWaitFoodTimer(var_18_10, var_18_11)
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_18_10)
				end
			end
		end
	elseif var_18_1 == var_0_1.NormalCustomerWaitFood then
		local var_18_12 = var_18_4.foodList

		if arg_18_2 == var_0_3 then
			if nullable(var_18_4, "curOrder") and #var_18_4.curOrder == 0 then
				arg_18_0:SwitchState(arg_18_1, var_0_1.FvckOff)
			elseif arg_18_0.CheckFoodServeComplete(arg_18_1) then
				if var_18_2.pay then
					CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_2.tableEid)

					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						var_18_4.hasServer = true
						var_18_4.quality = arg_18_0:CalculateFoodQuality(arg_18_1, var_18_12, var_18_3)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, var_18_3)
					end
				end

				arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerEatFood)
			elseif arg_18_0.NormalCustomerStateList[arg_18_1].timeout and var_18_2.pay and not arg_18_0.CheckFoodDelivering(var_18_4) then
				local var_18_13

				if arg_18_0:HasFoodToEat(arg_18_1) then
					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						var_18_4.hasServer = true
						var_18_4.quality = arg_18_0:CalculateFoodQuality(arg_18_1, var_18_12, var_18_3)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, var_18_3)
					end

					var_18_13 = var_0_1.NormalCustomerEatFood
				else
					var_18_13 = var_0_1.NormalCustomerLeaveSeat
				end

				for iter_18_0, iter_18_1 in pairs(var_18_2.peer) do
					arg_18_0:SwitchState(iter_18_1, var_18_13)
				end

				CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_2.tableEid)
			end
		elseif arg_18_2 == var_0_6 then
			arg_18_0.NormalCustomerStateList[arg_18_1].timeout = true
		end
	elseif var_18_1 == var_0_1.NormalCustomerEatFood then
		if arg_18_2 == var_0_5 then
			local var_18_14 = true

			if var_18_14 then
				arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerLeaveSeat)
				manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, var_18_3)
			end
		end
	elseif var_18_1 == var_0_1.NormalCustomerLeaveSeat then
		if arg_18_2 == var_0_4 then
			local var_18_15 = arg_18_0.NormalCustomerStateList[arg_18_1].lastState

			if var_18_2.pay then
				local var_18_16 = true

				if var_18_2.eat and var_18_15 ~= var_0_1.FvckOff and var_18_16 then
					arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoCashier)
				else
					arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
				end
			else
				arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
			end
		end
	elseif var_18_1 == var_0_1.NormalCustomerGotoCashier then
		if arg_18_2 == var_0_4 then
			arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerTakeBillWithCashier)

			local var_18_17 = CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.RestaurantCashier)
			local var_18_18 = CanteenAIFunction:GetAllEIDNameSpace(var_18_17)[1]

			DormEventInvoke(DORM_CHARACTER_INTERACT, var_0_1.NormalCustomerTakeBillWithCashier, arg_18_1, var_18_18)
		end
	elseif var_18_1 == var_0_1.NormalCustomerTakeBillWithCashier then
		if arg_18_2 == var_0_5 then
			arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
		end
	elseif var_18_1 == var_0_1.NormalCustomerGotoExit then
		if arg_18_2 == var_0_4 then
			CanteenCharacterManager.FindAndRemoveEntity(arg_18_1)
		end
	elseif var_18_1 == var_0_1.FvckOff then
		if var_18_2.pay then
			CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_2.tableEid)
		end

		if var_18_2.sit then
			arg_18_0:SwitchState(arg_18_1, var_0_1.NormalCustomerLeaveSeat)
			manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, var_18_3)
		end
	else
		error("未找到" .. arg_18_1 .. "对象的选择")
	end
end

function var_0_0.GotoDinningChair(arg_20_0)
	local var_20_0 = CanteenAIFunction:GetEntityData(arg_20_0)

	if var_20_0.chairEid == nil then
		var_20_0.chairEid = CanteenAIFunction:FindAvailableItem(arg_20_0, DormEnum.ItemType.DinningChair)

		CanteenAIFunction:SetItemAvailable(var_20_0.chairEid, false)
	end

	local var_20_1 = CanteenItemManager.GetItemInteractPositions(var_20_0.chairEid)
	local var_20_2 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(var_20_0.chairEid, "gua_start_sit")

	return CanteenAIFunction:GetNearestPointFrom(var_20_2, var_20_1), var_20_2
end

function var_0_0.CheckFoodServeComplete(arg_21_0)
	local var_21_0 = CanteenAIFunction:GetEntityData(arg_21_0)
	local var_21_1 = CanteenAIFunction:GetEntityData(var_21_0.tableEid)

	if var_21_1.curOrder == nil then
		return false
	end

	local var_21_2 = var_21_1.foodList

	if var_21_2 == nil then
		return false
	end

	if #var_21_2 >= #var_21_1.curOrder then
		return true
	end

	return false
end

function var_0_0.HasFoodToEat(arg_22_0, arg_22_1)
	local var_22_0 = CanteenAIFunction:GetEntityData(arg_22_1)
	local var_22_1 = CanteenAIFunction:GetEntityData(var_22_0.tableEid).foodList

	return var_22_1 and #var_22_1 > 0
end

local function var_0_9(arg_23_0)
	local var_23_0 = BackHomeCanteenFoodCfg[arg_23_0].tag
	local var_23_1 = math.random(1, #var_23_0)

	return {
		cfgID = arg_23_0,
		taste = var_23_0[var_23_1]
	}
end

local function var_0_10(arg_24_0)
	local var_24_0 = BackHomeCustomerCfg[arg_24_0].food_list

	if next(var_24_0) == nil then
		var_24_0 = BackHomeCanteenFoodCfg.all
	end

	return var_24_0
end

local function var_0_11(arg_25_0)
	local var_25_0

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		var_25_0 = CanteenManager.CalcCanOrderFoodList()
	else
		var_25_0 = {}

		for iter_25_0, iter_25_1 in pairs(CanteenFoodData:GetChooseFoodList()) do
			var_25_0[iter_25_1] = true
		end
	end

	local var_25_1 = {}

	for iter_25_2, iter_25_3 in pairs(arg_25_0) do
		local var_25_2 = CanteenAIFunction:GetEntityData(iter_25_3)

		for iter_25_4, iter_25_5 in pairs(var_0_10(var_25_2.cfgID)) do
			if var_25_0[iter_25_5] then
				var_25_1[iter_25_5] = true
			end
		end
	end

	local var_25_3 = {}

	for iter_25_6, iter_25_7 in pairs(var_25_1) do
		table.insert(var_25_3, iter_25_6)
	end

	return var_25_3
end

function var_0_0.OrderFood(arg_26_0)
	local var_26_0 = var_0_11(arg_26_0)
	local var_26_1 = {}

	if next(var_26_0) then
		if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
			for iter_26_0 = 1, math.min(DormConst.ORDER_FOOD_NUM, #var_26_0) do
				local var_26_2 = math.random(#var_26_0)

				var_26_0[var_26_2], var_26_0[#var_26_0] = var_26_0[#var_26_0], var_26_0[var_26_2]

				local var_26_3 = table.remove(var_26_0)

				table.insert(var_26_1, var_0_9(var_26_3))
			end
		else
			for iter_26_1 = 1, DormConst.ORDER_FOOD_NUM do
				table.insert(var_26_1, var_0_9(var_26_0[math.random(#var_26_0)]))
			end
		end
	end

	return var_26_1
end

function var_0_0.CalculateFoodQuality(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = CanteenAIFunction:GetEntityData(arg_27_1)

	if var_27_0.pay == false then
		return
	end

	local var_27_1 = var_27_0.orderInfo
	local var_27_2 = 0
	local var_27_3 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		local var_27_4 = false

		for iter_27_2, iter_27_3 in ipairs(var_27_1) do
			local var_27_5 = CanteenAIFunction:GetEntityData(iter_27_1)

			if var_27_5.cfgID == iter_27_3.cfgID and not iter_27_3.hasCalculat then
				var_27_2 = var_27_2 + var_27_5.quality
				iter_27_3.hasCalculat = true

				if var_27_5.taste == iter_27_3.taste then
					var_27_3 = var_27_3 + 0.5
				else
					var_27_3 = var_27_3 - 0.5
				end

				var_27_4 = true

				break
			end
		end

		if not var_27_4 then
			var_27_2 = var_27_2 + DormEnum.FoodQuality.low
		end

		local var_27_6 = CanteenAIFunction:GetFoodManualIndex(iter_27_1)

		CanteenManualData:RecordFoodDelivery(var_27_6, arg_27_1, var_27_0.cfgID)
	end

	if #arg_27_2 == 1 then
		var_27_2 = var_27_2 + DormEnum.FoodQuality.low
	end

	local var_27_7 = var_27_2 - 1 + math.floor(var_27_3)
	local var_27_8 = GameSetting.canteen_customer_evaluation.value[1][1]
	local var_27_9 = GameSetting.canteen_customer_evaluation.value[#GameSetting.canteen_customer_evaluation.value][1]

	if var_27_7 < var_27_8 then
		var_27_7 = var_27_8
	end

	if var_27_9 < var_27_7 then
		var_27_7 = var_27_9
	end

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		CanteenManualData:RecordFoodQuality(arg_27_2, var_27_7)
		CanteenManualData:AddPopularityNum(var_27_7)
	end

	return var_27_7
end

function var_0_0.WaitFoodCallBack(arg_28_0, arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in pairs(arg_28_2) do
		if iter_28_1.status ~= DormEnum.FoodState.HasServer then
			iter_28_1.status = DormEnum.FoodState.TimeOut
		end
	end

	manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, arg_28_1.tableEid)

	for iter_28_2, iter_28_3 in pairs(arg_28_1.peer) do
		arg_28_0:AIChoice(iter_28_3, var_0_6)
	end

	CanteenAIFunction:StopCustomerWaitFoodTimer(arg_28_1.tableEid)
end

function var_0_0.Update(arg_29_0)
	if arg_29_0.NormalCustomerStateList then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.NormalCustomerStateList) do
			arg_29_0:AIChoice(iter_29_0, var_0_3)
		end
	end
end

function var_0_0.DisposeEntity(arg_30_0, arg_30_1)
	if arg_30_0.NormalCustomerStateList[arg_30_1] then
		arg_30_0.NormalCustomerStateList[arg_30_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_31_0)
	arg_31_0.NormalCustomerStateList = nil
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0:DisposeAllEntity()
	arg_32_0:RemoveListener()
end

return var_0_0
