local var_0_0 = singletonClass("CashierAI")

function var_0_0:Init()
	self:RegisterEvent()

	self.CashierState = {
		CashierGotoCounter = "CashierGotoCounter",
		CashierTakeBill = "CashierTakeBill",
		CashierEnterScene = "CashierEnterScene",
		CashierIdle = "CashierIdle"
	}
	self.CashierStateList = {}
end

function var_0_0:AIInit(arg_2_1)
	if arg_2_1 == nil or self.CashierStateList[arg_2_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	self.cashierData = CanteenAIFunction:GetEntityData(arg_2_1)
	self.cashierData.cashierObject = nil
	self.CashierStateList[arg_2_1] = {
		state = self.CashierState.CashierEnterScene,
		lastState = {}
	}
	self.cashierEID = arg_2_1

	self:AIChoice(arg_2_1)
end

function var_0_0:RegisterEvent()
	self.listener = self.listener or EventListener.New()

	self.listener:RemoveAll()

	for iter_3_0, iter_3_1 in pairs({
		[DORM_RESTAURANT_NEW_CASHIER] = handler(self, self.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(self, self.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.ListenInteractEvent),
		[DORM_CHARACTER_DISPOSE] = handler(self, self.DisposeEntity)
	}) do
		self.listener:Register(iter_3_0, iter_3_1)
	end
end

function var_0_0:RemoveListener()
	self.listener:RemoveAll()
end

function var_0_0:ListenMoveEvent(arg_5_1, arg_5_2)
	if not self.CashierStateList[arg_5_1] then
		return
	end

	if arg_5_2 then
		self:AIChoice(arg_5_1)
	end
end

function var_0_0:ListenInteractEvent(arg_6_1, arg_6_2)
	if not self.CashierStateList[arg_6_1] then
		return
	end

	if arg_6_2 then
		self:AIChoice(arg_6_1)
	end
end

function var_0_0:AIChoice(arg_7_1)
	if self.CashierStateList[arg_7_1].state == nil then
		return
	end

	local var_7_0 = CanteenAIFunction:GetEntityData(arg_7_1)

	if self.CashierStateList[arg_7_1].state == self.CashierState.CashierEnterScene then
		CanteenAIFunction:SetCharacterBusy(arg_7_1, false)

		local var_7_1 = CanteenAIFunction:GetAllEIDNameSpace((CanteenAIFunction:GetNameSpace(DormEnum.ItemType.CashierTable)))[1]

		self.CashierStateList[arg_7_1].lastState = self.CashierState.CashierEnterScene
		self.CashierStateList[arg_7_1].state = self.CashierState.CashierGotoCounter

		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, self.CashierState.CashierGotoCounter, arg_7_1, CanteenAIFunction:GetNearestPoint(arg_7_1, (CanteenItemManager.GetItemInteractPositions(var_7_1))), Dorm.DormEntityManager.QueryPosition(var_7_1), false)
	elseif self.CashierStateList[arg_7_1].state == self.CashierState.CashierGotoCounter then
		if CanteenAIFunction:GetCharacterBusy(arg_7_1) == false then
			self.CashierStateList[arg_7_1].lastState = self.CashierState.CashierGotoCounter
			self.CashierStateList[arg_7_1].state = self.CashierState.CashierIdle
		else
			return
		end
	elseif self.CashierStateList[arg_7_1].state == self.CashierState.CashierIdle then
		CanteenAIFunction:SetCharacterBusy(arg_7_1, true)
	end
end

function var_0_0:RePlaneAI(arg_8_1, arg_8_2)
	if arg_8_2 then
		self:AIChoice(arg_8_1)
	else
		self.CashierStateList[arg_8_1].state = self.CashierStateList[arg_8_1].lastState
		self.CashierStateList[arg_8_1].lastState = nil

		self:AIChoice(arg_8_1)
	end
end

function var_0_0:DisposeEntity(arg_9_1)
	if self.CashierStateList[arg_9_1] then
		self.CashierStateList[arg_9_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_10_0)
	arg_10_0.CashierStateList = nil
end

function var_0_0:Dispose()
	self:DisposeAllEntity()
	self:RemoveListener()
end

return var_0_0
