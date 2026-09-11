local var_0_0 = singletonClass("WaiterAI")

function var_0_0:Init()
	self:RegisterEvent()

	self.WaiterStateList = {}
	self.WaiterState = {
		WaiterInteractPassTable = "WaiterInteractPassTable",
		WaiterPassFood = "WaiterPassFood",
		WaiterPlaceFood = "WaiterPlaceFood",
		WaiterIdle = "WaiterIdle",
		WaiterEnterScene = "WaiterEnterScene",
		WaiterMove = "WaiterMove"
	}
end

local function var_0_1()
	return Dorm.storage:PickData((CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)))
end

function var_0_0:AIInit(arg_3_1)
	if arg_3_1 == nil or self.WaiterStateList[arg_3_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	self.WaiterStateList[arg_3_1] = {
		state = self.WaiterState.WaiterEnterScene,
		lastState = {}
	}

	self:AIChoice(arg_3_1)
end

function var_0_0:RegisterEvent()
	self.listener = self.listener or EventListener.New()

	self.listener:RemoveAll()

	for iter_4_0, iter_4_1 in pairs({
		[DORM_RESTAURANT_NEW_WAITER] = handler(self, self.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(self, self.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.ListenInteractEvent),
		[DORM_LOGIC_TICK] = handler(self, self.Update),
		[DORM_CHARACTER_DISPOSE] = handler(self, self.DisposeEntity)
	}) do
		self.listener:Register(iter_4_0, iter_4_1)
	end
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_0:ListenMoveEvent(arg_5_1, arg_5_2)
	if not self.WaiterStateList[arg_5_1] then
		return
	end

	self:AIChoice(arg_5_1, var_0_3, arg_5_2)
end

function var_0_0:ListenInteractEvent(arg_6_1, arg_6_2)
	if not self.WaiterStateList[arg_6_1] then
		return
	end

	self:AIChoice(arg_6_1, var_0_4, arg_6_2)
end

function var_0_0:RemoveListener()
	self.listener:RemoveAll()
end

function var_0_0:SwitchState(arg_8_1, arg_8_2, arg_8_3)
	self.WaiterStateList[arg_8_1].lastState = arg_8_3 or self.WaiterStateList[arg_8_1].state
	self.WaiterStateList[arg_8_1].state = arg_8_2
end

function var_0_0:MoveToTarget(arg_9_1)
	local var_9_0, var_9_1 = self:ChoiceEndPosition(arg_9_1)

	if var_9_1 then
		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, self.WaiterStateList[arg_9_1].state, arg_9_1, var_9_0, var_9_1, false)
	else
		DormEventInvoke(DORM_CHARACTER_MOVE, self.WaiterStateList[arg_9_1].state, arg_9_1, var_9_0, false)
	end
end

function var_0_0:ShouldReturnFoodToPassTable()
	if self.pick and self.selectedOrder then
		if self.selectedOrder.status == DormEnum.FoodState.Canceled then
			return true
		end

		if NormalCustomerAI.CheckFoodServeComplete(self.selectedOrder.orderCharacterID) then
			return true
		end
	end
end

function var_0_0:AIChoice(arg_11_1, arg_11_2, ...)
	if self.WaiterStateList[arg_11_1].state == nil then
		print("服务员列表不存在该实例对象id")

		return
	end

	local var_11_0 = CanteenAIFunction:GetEntityData(arg_11_1)

	if self.WaiterStateList[arg_11_1].state == self.WaiterState.WaiterEnterScene then
		self:SwitchState(arg_11_1, self.WaiterState.WaiterMove)
		self:MoveToTarget(arg_11_1)
	elseif self.WaiterStateList[arg_11_1].state == self.WaiterState.WaiterMove then
		if self.ShouldReturnFoodToPassTable(var_11_0) then
			var_11_0.selectedOrder = nil

			Dorm.DormEntityManager.StopAllCmd(arg_11_1)
			self:MoveToTarget(arg_11_1)
		elseif arg_11_2 == var_0_3 then
			if CanteenAIFunction:GetCharacterPickItem(arg_11_1) then
				if var_11_0.selectedOrder then
					self:SwitchState(arg_11_1, self.WaiterState.WaiterPlaceFood)
					DormEventInvoke(DORM_CHARACTER_INTERACT, self.WaiterStateList[arg_11_1].state, arg_11_1, var_11_0.selectedOrder.orderTableID)
				else
					self:SwitchState(arg_11_1, self.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, self.WaiterStateList[arg_11_1].state, arg_11_1, var_0_1())
				end
			else
				self:SwitchState(arg_11_1, self.WaiterState.WaiterIdle)
				CanteenAIFunction:SetCharacterBusy(arg_11_1, false)
			end
		end
	elseif self.WaiterStateList[arg_11_1].state == self.WaiterState.WaiterIdle then
		if arg_11_2 == var_0_2 then
			for iter_11_0, iter_11_1 in ipairs(({
				...
			})[1]) do
				local var_11_1 = self:ArrangeFood(iter_11_1)

				if var_11_1 then
					CanteenAIFunction:SetCharacterBusy(arg_11_1, true)
					CanteenAIFunction:SetCharacterTarget(arg_11_1, var_11_1)

					var_11_0.selectedOrder = iter_11_1
					iter_11_1.status = DormEnum.FoodState.HasServer

					self:SwitchState(arg_11_1, self.WaiterState.WaiterInteractPassTable)
					DormEventInvoke(DORM_CHARACTER_INTERACT, self.WaiterStateList[arg_11_1].state, arg_11_1, var_0_1())
					manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, iter_11_1.orderTableID)

					break
				end
			end
		end
	elseif self.WaiterStateList[arg_11_1].state == self.WaiterState.WaiterInteractPassTable then
		if arg_11_2 == var_0_4 then
			self:SwitchState(arg_11_1, self.WaiterState.WaiterMove)
			self:MoveToTarget(arg_11_1)
		end
	elseif self.WaiterStateList[arg_11_1].state == self.WaiterState.WaiterPlaceFood then
		if arg_11_2 == var_0_4 then
			self:SwitchState(arg_11_1, self.WaiterState.WaiterMove)
			self:MoveToTarget(arg_11_1)
		end
	else
		error("未找到对应状态")
	end
end

function var_0_0:ChoiceEndPosition(arg_12_1)
	local var_12_0 = CanteenAIFunction:GetEntityData(arg_12_1)

	if var_12_0.pick and var_12_0.selectedOrder ~= nil and not self.ShouldReturnFoodToPassTable(var_12_0) then
		return CanteenAIFunction:GetNearestPoint(arg_12_1, (CanteenItemManager.GetItemInteractPositions(var_12_0.selectedOrder.orderTableID))), Dorm.DormEntityManager.QueryPosition(var_12_0.selectedOrder.orderTableID)
	else
		return CanteenAIFunction:GetNearestPoint(arg_12_1, (CanteenItemManager.GetItemInteractPositions(var_0_1())))
	end
end

local function var_0_5()
	return Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField)
end

function var_0_0:Update()
	local var_14_0 = var_0_5()

	for iter_14_0, iter_14_1 in pairs(self.WaiterStateList) do
		self:AIChoice(iter_14_0, var_0_2, var_14_0)
	end
end

function var_0_0.FindFood(arg_15_0, arg_15_1)
	local var_15_0 = nullable(CanteenAIFunction:GetEntityData(var_0_1()), "foodList")

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if arg_15_1 == CanteenAIFunction:GetEntityData(iter_15_1).cfgID then
				return iter_15_1
			end
		end
	end
end

function var_0_0:ArrangeFood(arg_16_1)
	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		if arg_16_1.status == DormEnum.FoodState.Wait then
			local var_16_0 = self:FindFood(arg_16_1.cfgID)

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

function var_0_0:AnyFreeWaiter()
	for iter_17_0, iter_17_1 in pairs(self.WaiterStateList) do
		if not CanteenAIFunction:GetCharacterBusy(iter_17_0) then
			return iter_17_0
		end
	end
end

function var_0_0:DisposeEntity(arg_18_1)
	if self.WaiterStateList[arg_18_1] then
		self.WaiterStateList[arg_18_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_19_0)
	arg_19_0.WaiterStateList = {}
end

function var_0_0:Dispose()
	self:DisposeAllEntity()
	self:RemoveListener()
end

return var_0_0
