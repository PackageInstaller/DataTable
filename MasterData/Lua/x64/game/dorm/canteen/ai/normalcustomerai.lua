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
		DormEventInvoke(DORM_CHARACTER_MOVE, arg_2_1, arg_2_0, CanteenAIFunction:GetNearestPoint(arg_2_0, (CanteenItemManager.GetItemInteractPositions(var_2_0))), true, true)
	end,
	[var_0_1.NormalCustomerGotoExit] = function(arg_3_0, arg_3_1)
		local var_3_0 = CanteenAIFunction:FindNearestPoint(arg_3_0, DormEnum.Points.RestaurantExit)

		Dorm.DormEntityManager.FadeOutNearPoint(arg_3_0, var_3_0, 0.75)
		DormEventInvoke(DORM_CHARACTER_MOVE, arg_3_1, arg_3_0, var_3_0)
	end,
	[var_0_1.NormalCustomerGotoCashier] = function(arg_4_0, arg_4_1)
		DormEventInvoke(DORM_CHARACTER_MOVE, arg_4_1, arg_4_0, (CanteenAIFunction:FindPoint(DormEnum.Points.RestaurantCustomerPay)))
	end,
	[var_0_1.NormalCustomerOrderFood] = function(arg_5_0, arg_5_1)
		local var_5_0 = CanteenAIFunction:GetEntityData(arg_5_0)

		var_5_0.orderInfo = var_0_0.OrderFood(var_5_0.peer)

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_5_1, arg_5_0, CanteenAIFunction:GetAllEIDNameSpace((CanteenAIFunction:GetNameSpace(DormEnum.ItemType.OrderFoodDummy)))[1])
	end,
	[var_0_1.NormalCustomerEatFood] = function(arg_6_0, arg_6_1)
		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_6_1, arg_6_0, CanteenAIFunction:GetEntityData(arg_6_0).tableEid)
	end
}
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7

function var_0_0:Init()
	self:RegisterEvent()

	self.NormalCustomerStateList = {}
end

function var_0_0:AIInit(arg_8_1, arg_8_2)
	if arg_8_1 == nil or self.NormalCustomerStateList[arg_8_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	self.NormalCustomerStateList[arg_8_1] = {
		state = var_0_1.NormalCustomerEnterScene
	}

	self:AIChoice(arg_8_1, var_0_7, "Init")
end

function var_0_0:RegisterEvent()
	local var_9_0 = self.listener or EventListener.New()

	var_9_0:RemoveAll()
	var_9_0:Register(DORM_RESTAURANT_NEW_CUSTOMER, handler(self, self.AIInit))
	var_9_0:Register(ON_DORM_CHARACTER_MOVE_FINISH, handler(self, self.ListenMoveEvent))
	var_9_0:Register(ON_DORM_CHARACTER_INTERACT_FINISH, handler(self, self.ListenInteractEvent))
	var_9_0:Register(DORM_RESTAURANT_INTERACT_CUSTOMER, handler(self, self.ListenPlayerInteractEvent))
	var_9_0:Register(DORM_LOGIC_TICK, handler(self, self.Update))
	var_9_0:Register(DORM_CHARACTER_DISPOSE, handler(self, self.DisposeEntity))

	self.listener = var_9_0
end

function var_0_0:RemoveListener()
	self.listener:RemoveAll()
end

function var_0_0:ListenMoveEvent(arg_11_1, arg_11_2)
	if not self.NormalCustomerStateList[arg_11_1] then
		return
	end

	if arg_11_2 then
		self:AIChoice(arg_11_1, var_0_4)
	end
end

function var_0_0:ListenInteractEvent(arg_12_1, arg_12_2)
	if not self.NormalCustomerStateList[arg_12_1] then
		return
	end

	self:AIChoice(arg_12_1, var_0_5, arg_12_2)
end

function var_0_0:ListenPlayerInteractEvent(arg_13_1, arg_13_2, arg_13_3)
	for iter_13_0, iter_13_1 in ipairs(CanteenAIFunction:GetEntityData(arg_13_1).peer) do
		self:SwitchState(iter_13_1, var_0_1.FvckOff)
	end
end

function var_0_0:SwitchState(arg_14_1, arg_14_2, arg_14_3)
	self.NormalCustomerStateList[arg_14_1].lastState = arg_14_3 or self.NormalCustomerStateList[arg_14_1].state
	self.NormalCustomerStateList[arg_14_1].state = arg_14_2

	if var_0_2[arg_14_2] then
		var_0_2[arg_14_2](arg_14_1, arg_14_2)
	end
end

function var_0_0:GetState(arg_15_1)
	return self.NormalCustomerStateList[arg_15_1].state
end

local function var_0_8(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		if not CanteenAIFunction:GetEntityData(iter_16_1).sit then
			return false
		end
	end

	return true
end

function var_0_0:CheckFoodDelivering()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(self.curOrder) do
		if iter_17_1.status == DormEnum.FoodState.HasServer then
			var_17_0 = var_17_0 + 1
		end
	end

	return ((self.foodList or nil) and (#self.foodList or 0)) < var_17_0
end

function var_0_0:AIChoice(arg_18_1, arg_18_2, ...)
	local var_18_0 = {
		...
	}

	if self.NormalCustomerStateList[arg_18_1].state == nil then
		error("普通客人列表不存在实例对象id:" .. arg_18_1)

		return
	end

	local var_18_1 = CanteenAIFunction:GetEntityData(arg_18_1)
	local var_18_2 = CanteenAIFunction:GetEntityData(var_18_1.tableEid)

	if self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerEnterScene then
		self:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoTable)
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerGotoTable then
		if arg_18_2 == var_0_4 then
			self:SwitchState(arg_18_1, var_0_1.NormalCustomerTakeSeat)
			DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, var_0_1.NormalCustomerTakeSeat, arg_18_1, Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(var_18_1.chairEid, "gua_start_sit"), Dorm.DormEntityManager.QueryForwardDir(var_18_1.chairEid), true, true)
			DormEventInvoke(DORM_CHARACTER_INTERACT, var_0_1.NormalCustomerTakeSeat, arg_18_1, var_18_1.chairEid, true)
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerTakeSeat then
		if var_18_1.pay then
			if arg_18_2 == var_0_5 then
				self:SwitchState(arg_18_1, var_0_1.NormalCustomerOrderFood)
			end
		elseif var_0_8(var_18_1.peer) then
			self:SwitchState(arg_18_1, var_0_1.NormalCustomerWaitFood)
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerOrderFood then
		if arg_18_2 == var_0_5 then
			if #var_18_2.curOrder == 0 then
				self:SwitchState(arg_18_1, var_0_1.FvckOff)
			else
				self:SwitchState(arg_18_1, var_0_1.NormalCustomerWaitFood)

				if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
					CanteenAIFunction:SetCustomerWaitFoodTimer(var_18_1.tableEid, (DormCharacterActionManager.taskRunner:NewTimer(function()
						self:WaitFoodCallBack(var_18_1, var_18_2.curOrder)
					end, GameSetting.dorm_customer_wait_food_time.value[1], 1)))
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_18_1.tableEid)
				end
			end
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerWaitFood then
		if arg_18_2 == var_0_3 then
			if nullable(var_18_2, "curOrder") and #var_18_2.curOrder == 0 then
				self:SwitchState(arg_18_1, var_0_1.FvckOff)
			elseif self.CheckFoodServeComplete(arg_18_1) then
				if var_18_1.pay then
					CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_1.tableEid)

					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						var_18_2.hasServer = true
						var_18_2.quality = self:CalculateFoodQuality(arg_18_1, var_18_2.foodList, var_18_1.tableEid)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, var_18_1.tableEid)
					end
				end

				self:SwitchState(arg_18_1, var_0_1.NormalCustomerEatFood)
			elseif self.NormalCustomerStateList[arg_18_1].timeout and var_18_1.pay and not self.CheckFoodDelivering(var_18_2) then
				local var_18_3

				if self:HasFoodToEat(arg_18_1) then
					if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
						var_18_2.hasServer = true
						var_18_2.quality = self:CalculateFoodQuality(arg_18_1, var_18_2.foodList, var_18_1.tableEid)

						manager.notify:Invoke(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, var_18_1.tableEid)
					end

					var_18_3 = var_0_1.NormalCustomerEatFood
				else
					var_18_3 = var_0_1.NormalCustomerLeaveSeat
				end

				for iter_18_0, iter_18_1 in pairs(var_18_1.peer) do
					self:SwitchState(iter_18_1, var_18_3)
				end

				CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_1.tableEid)
			end
		elseif arg_18_2 == var_0_6 then
			self.NormalCustomerStateList[arg_18_1].timeout = true
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerEatFood then
		if arg_18_2 == var_0_5 then
			if true then
				self:SwitchState(arg_18_1, var_0_1.NormalCustomerLeaveSeat)
				manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, var_18_1.tableEid)
			end
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerLeaveSeat then
		if arg_18_2 == var_0_4 then
			if var_18_1.pay then
				if var_18_1.eat and self.NormalCustomerStateList[arg_18_1].lastState ~= var_0_1.FvckOff and true then
					self:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoCashier)
				else
					self:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
				end
			else
				self:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
			end
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerGotoCashier then
		if arg_18_2 == var_0_4 then
			self:SwitchState(arg_18_1, var_0_1.NormalCustomerTakeBillWithCashier)
			DormEventInvoke(DORM_CHARACTER_INTERACT, var_0_1.NormalCustomerTakeBillWithCashier, arg_18_1, CanteenAIFunction:GetAllEIDNameSpace((CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.RestaurantCashier)))[1])
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerTakeBillWithCashier then
		if arg_18_2 == var_0_5 then
			self:SwitchState(arg_18_1, var_0_1.NormalCustomerGotoExit)
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.NormalCustomerGotoExit then
		if arg_18_2 == var_0_4 then
			CanteenCharacterManager.FindAndRemoveEntity(arg_18_1)
		end
	elseif self.NormalCustomerStateList[arg_18_1].state == var_0_1.FvckOff then
		if var_18_1.pay then
			CanteenAIFunction:StopCustomerWaitFoodTimer(var_18_1.tableEid)
		end

		if var_18_1.sit then
			self:SwitchState(arg_18_1, var_0_1.NormalCustomerLeaveSeat)
			manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, var_18_1.tableEid)
		end
	else
		error("未找到" .. arg_18_1 .. "对象的选择")
	end
end

function var_0_0.GotoDinningChair(arg_20_0)
	local var_20_0 = CanteenAIFunction:GetEntityData(arg_20_0)
	local var_20_1

	if var_20_0.chairEid == nil then
		var_20_0.chairEid = CanteenAIFunction:FindAvailableItem(arg_20_0, DormEnum.ItemType.DinningChair)

		CanteenAIFunction:SetItemAvailable(var_20_0.chairEid, false)

		var_20_1 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(var_20_0.chairEid, "gua_start_sit")
	end

	return CanteenAIFunction:GetNearestPointFrom(var_20_1, (CanteenItemManager.GetItemInteractPositions(var_20_0.chairEid))), var_20_1
end

function var_0_0.CheckFoodServeComplete(arg_21_0)
	local var_21_0 = CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(arg_21_0).tableEid)

	if var_21_0.curOrder == nil then
		return false
	end

	local var_21_1 = var_21_0.foodList

	if var_21_0.foodList == nil then
		return false
	end

	if #var_21_1 >= #var_21_0.curOrder then
		return true
	end

	return false
end

function var_0_0.HasFoodToEat(arg_22_0, arg_22_1)
	local var_22_0 = CanteenAIFunction:GetEntityData(CanteenAIFunction:GetEntityData(arg_22_1).tableEid).foodList

	return var_22_0 and #var_22_0 > 0
end

local function var_0_9(arg_23_0)
	return {
		cfgID = arg_23_0,
		taste = BackHomeCanteenFoodCfg[arg_23_0].tag[math.random(1, #BackHomeCanteenFoodCfg[arg_23_0].tag)]
	}
end

local function var_0_10(arg_24_0)
	return (next(BackHomeCustomerCfg[arg_24_0].food_list) == nil or nil) and BackHomeCanteenFoodCfg.all
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
		for iter_25_4, iter_25_5 in pairs(var_0_10(CanteenAIFunction:GetEntityData(iter_25_3).cfgID)) do
			if var_25_0[iter_25_5] then
				var_25_1[iter_25_5] = true
			end
		end
	end

	local var_25_2 = {}

	for iter_25_6, iter_25_7 in pairs(var_25_1) do
		table.insert(var_25_2, iter_25_6)
	end

	return var_25_2
end

function var_0_0.OrderFood(arg_26_0)
	local var_26_0 = var_0_11(arg_26_0)
	local var_26_1 = {}

	if next(var_26_0) then
		if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
			for iter_26_0 = 1, math.min(DormConst.ORDER_FOOD_NUM, #var_26_0) do
				local var_26_2 = math.random(#var_26_0)

				var_26_0[#var_26_0] = var_26_0[var_26_2]
				var_26_0[var_26_2] = var_26_0[#var_26_0]

				table.insert(var_26_1, var_0_9((table.remove(var_26_0))))
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
				var_27_3 = var_27_5.taste == iter_27_3.taste and var_27_3 + 0.5 or var_27_3 - 0.5
				var_27_4 = true

				break
			end
		end

		if not var_27_4 then
			var_27_2 = var_27_2 + DormEnum.FoodQuality.low
		end

		CanteenManualData:RecordFoodDelivery(CanteenAIFunction:GetFoodManualIndex(iter_27_1), arg_27_1, var_27_0.cfgID)
	end

	if #arg_27_2 == 1 then
		var_27_2 = var_27_2 + DormEnum.FoodQuality.low
	end

	local var_27_6 = var_27_2 - 1 + math.floor(var_27_3)

	if var_27_6 < GameSetting.canteen_customer_evaluation.value[1][1] then
		var_27_6 = GameSetting.canteen_customer_evaluation.value[1][1]
	end

	if GameSetting.canteen_customer_evaluation.value[#GameSetting.canteen_customer_evaluation.value][1] < var_27_6 then
		var_27_6 = GameSetting.canteen_customer_evaluation.value[#GameSetting.canteen_customer_evaluation.value][1]
	end

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		CanteenManualData:RecordFoodQuality(arg_27_2, var_27_6)
		CanteenManualData:AddPopularityNum(var_27_6)
	end

	return var_27_6
end

function var_0_0:WaitFoodCallBack(arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in pairs(arg_28_2) do
		if iter_28_1.status ~= DormEnum.FoodState.HasServer then
			iter_28_1.status = DormEnum.FoodState.TimeOut
		end
	end

	manager.notify:Invoke(CANTEEN_CLEAR_BUBBLE_LIST, arg_28_1.tableEid)

	for iter_28_2, iter_28_3 in pairs(arg_28_1.peer) do
		self:AIChoice(iter_28_3, var_0_6)
	end

	CanteenAIFunction:StopCustomerWaitFoodTimer(arg_28_1.tableEid)
end

function var_0_0:Update()
	if self.NormalCustomerStateList then
		for iter_29_0, iter_29_1 in pairs(self.NormalCustomerStateList) do
			self:AIChoice(iter_29_0, var_0_3)
		end
	end
end

function var_0_0:DisposeEntity(arg_30_1)
	if self.NormalCustomerStateList[arg_30_1] then
		self.NormalCustomerStateList[arg_30_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_31_0)
	arg_31_0.NormalCustomerStateList = nil
end

function var_0_0:Dispose()
	self:DisposeAllEntity()
	self:RemoveListener()
end

return var_0_0
