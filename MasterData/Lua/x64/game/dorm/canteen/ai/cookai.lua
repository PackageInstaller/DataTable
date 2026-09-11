local var_0_0 = singletonClass("CookAI")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	Interact = "Interact",
	Move = "Move",
	Idle = "Idle",
	Wait = "Wait"
}

function var_0_0:Ctor()
	self.listener = EventListener.New()
	var_0_1[var_0_3.Move] = self.MoveToTarget
	var_0_1[var_0_3.Interact] = self.InteractToTarget
	var_0_1[var_0_3.Idle] = self.OnIdle
end

local var_0_4 = 0
local var_0_5 = 1
local var_0_6 = 2

function var_0_0:CurState(arg_2_1)
	return self.CookTargetList[arg_2_1].state
end

function var_0_0:SwitchState(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3 or self.CookTargetList[arg_3_1].state

	self.CookTargetList[arg_3_1].lastState = arg_3_3 or self.CookTargetList[arg_3_1].state
	self.CookTargetList[arg_3_1].state = arg_3_2

	if var_0_2[var_3_0] then
		var_0_2[var_3_0](self, arg_3_1)
	end

	if var_0_1[arg_3_2] then
		var_0_1[arg_3_2](self, arg_3_1)
	end
end

function var_0_0:Init()
	self:RegisterEvent()

	self.CookTargetList = {}
	self.passtableEID = CanteenAIFunction:GetAllEIDNameSpace((CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable)))[1]
end

function var_0_0:AIInit(arg_5_1)
	self.CookTargetList[arg_5_1] = {
		state = var_0_3.Idle
	}

	self:OnIdle(arg_5_1)
	self:AIChoice(arg_5_1)
end

function var_0_0:RegisterEvent()
	self.listener = self.listener or EventListener.New()

	self.listener:RemoveAll()

	for iter_6_0, iter_6_1 in pairs({
		[DORM_RESTAURANT_NEW_COOK] = handler(self, self.ListenGenerate),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(self, self.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.ListenInteractEvent),
		[DORM_LOGIC_TICK] = handler(self, self.Update),
		[DORM_CHARACTER_DISPOSE] = handler(self, self.DisposeEntity)
	}) do
		self.listener:Register(iter_6_0, iter_6_1)
	end
end

function var_0_0:ListenGenerate(arg_7_1)
	self:AIInit(arg_7_1)
end

function var_0_0:ListenMoveEvent(arg_8_1, arg_8_2)
	if not self.CookTargetList[arg_8_1] then
		return
	end

	self:AIChoice(arg_8_1, var_0_5, arg_8_2)
end

function var_0_0:ListenInteractEvent(arg_9_1, arg_9_2, arg_9_3, ...)
	if not self.CookTargetList[arg_9_1] then
		return
	end

	if arg_9_3 then
		self:AIChoice(arg_9_1, var_0_6, arg_9_3)
	end
end

function var_0_0:RemoveListener()
	self.listener:RemoveAll()
end

local function var_0_7(arg_11_0)
	return DormEnum.RestaurantKitchenWare[BackHomeCanteenFoodCfg[arg_11_0].cook_type]
end

local function var_0_8(arg_12_0)
	return CanteenAIFunction:GetItemAvailable(arg_12_0) and not CanteenAIFunction:GetEntityData(arg_12_0).cookComplete
end

local function var_0_9(arg_13_0)
	return CanteenAIFunction:GetItemAvailable(arg_13_0) and CanteenAIFunction:GetEntityData(arg_13_0).cookComplete
end

function var_0_0.ChooseByRestaurantOrders()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(DormEnum.RestaurantKitchenWare) do
		for iter_14_2, iter_14_3 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(iter_14_1), pairs) do
			if var_0_8(iter_14_3) then
				var_14_0[iter_14_1] = iter_14_3

				break
			end
		end
	end

	for iter_14_4, iter_14_5 in ipairs((Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, CanteenManager.orderFoodListField))) do
		local var_14_1 = var_14_0[var_0_7(iter_14_5.cfgID)]

		if iter_14_5.status == DormEnum.FoodState.Wait and var_14_1 then
			iter_14_5.status = DormEnum.FoodState.Cooking

			return iter_14_5, var_14_1
		end
	end
end

function var_0_0:AIChoice(arg_15_1, arg_15_2, ...)
	if self.CookTargetList[arg_15_1].state == nil then
		print("厨圣列表不存在该实例对象id")

		return
	end

	if self.CookTargetList[arg_15_1].state == var_0_3.Idle then
		if CanteenAIFunction:GetEntityData(arg_15_1).pick then
			self:SetAITarget(arg_15_1, self.passtableEID)
		else
			local var_15_0 = self:PickFood()

			if var_15_0 then
				self:SetAITarget(arg_15_1, var_15_0)
			else
				local var_15_1 = self:CookFood(arg_15_1)

				if var_15_1 then
					self:SetAITarget(arg_15_1, var_15_1)
				end
			end
		end

		if self:HasAITarget(arg_15_1) then
			self:SwitchState(arg_15_1, var_0_3.Move)
		end
	elseif self.CookTargetList[arg_15_1].state == var_0_3.Move then
		if arg_15_2 == var_0_5 then
			self:SwitchState(arg_15_1, var_0_3.Wait)
		end
	elseif self.CookTargetList[arg_15_1].state == var_0_3.Wait then
		if CanteenAIFunction:GetItemAvailable(self.CookTargetList[arg_15_1].targetItem) then
			self:SwitchState(arg_15_1, var_0_3.Interact)
		end
	elseif self.CookTargetList[arg_15_1].state == var_0_3.Interact and arg_15_2 == var_0_6 then
		self:SwitchState(arg_15_1, var_0_3.Idle)
	end
end

local function var_0_10(arg_16_0)
	return {
		cfgID = arg_16_0,
		quality = DormEnum.FoodQuality.normal
	}
end

function var_0_0:CookFood(arg_17_1)
	local var_17_0 = CanteenAIFunction:GetEntityData(arg_17_1)
	local var_17_1, var_17_2 = self.ChooseByRestaurantOrders()

	if var_17_1 then
		CanteenAIFunction:SetCharacterBusy(arg_17_1, true)

		var_17_0.selectedOrder = var_17_1
		CanteenAIFunction:GetEntityData(var_17_2).curCooking = var_0_10(var_17_0.selectedOrder.cfgID)

		return var_17_2
	end
end

function var_0_0.PickFood(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(DormEnum.RestaurantKitchenWare) do
		for iter_18_2, iter_18_3 in Dorm.storage:ForeachData(CanteenAIFunction:GetNameSpace(iter_18_1), pairs) do
			if var_0_9(iter_18_3) then
				return iter_18_3
			end
		end
	end
end

function var_0_0.ToTargetPos(arg_19_0, arg_19_1, arg_19_2)
	return CanteenAIFunction:GetNearestPoint(arg_19_1, (CanteenItemManager.GetItemInteractPositions(arg_19_2)))
end

function var_0_0:Move(arg_20_1, arg_20_2)
	DormEventInvoke(DORM_CHARACTER_MOVE, self:CurState(arg_20_1), arg_20_1, arg_20_2)
end

function var_0_0:MoveLookToDir(arg_21_1, arg_21_2, arg_21_3)
	DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_TO_DIR, self:CurState(arg_21_1), arg_21_1, arg_21_2, arg_21_3)
end

function var_0_0:MoveToTarget(arg_22_1)
	local var_22_0 = self:ToTargetPos(arg_22_1, self.CookTargetList[arg_22_1].targetItem)

	if self.CookTargetList[arg_22_1].targetItem == self.passtableEID then
		self:Move(arg_22_1, var_22_0)
	else
		self:MoveLookToDir(arg_22_1, var_22_0, (Dorm.DormEntityManager.QueryForwardDir(self.CookTargetList[arg_22_1].targetItem)))
	end
end

function var_0_0:InteractToTarget(arg_23_1)
	DormEventInvoke(DORM_CHARACTER_INTERACT, self:CurState(arg_23_1), arg_23_1, self.CookTargetList[arg_23_1].targetItem)
end

function var_0_0:HasAITarget(arg_24_1)
	return self.CookTargetList[arg_24_1].targetItem ~= nil
end

function var_0_0:SetAITarget(arg_25_1, arg_25_2)
	self.CookTargetList[arg_25_1].targetItem = arg_25_2
end

function var_0_0:OnIdle(arg_26_1)
	self.CookTargetList[arg_26_1].targetItem = nil

	CanteenAIFunction:SetCharacterBusy(arg_26_1, false)
end

function var_0_0:DisposeEntity(arg_27_1)
	self.CookTargetList[arg_27_1] = nil
end

function var_0_0.DisposeAllEntity(arg_28_0)
	arg_28_0.CookTargetList = nil
end

function var_0_0:Dispose()
	self:RemoveListener()
	self:DisposeAllEntity()
end

function var_0_0:Update()
	for iter_30_0, iter_30_1 in pairs(self.CookTargetList) do
		self:AIChoice(iter_30_0, var_0_4)
	end
end

return var_0_0
