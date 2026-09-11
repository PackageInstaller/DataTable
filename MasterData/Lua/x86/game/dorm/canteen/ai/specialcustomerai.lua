local var_0_0 = singletonClass("SpecialCustomerAI")

function var_0_0:Init()
	self.restaurantBB = 1

	self:RegisterEvent()

	self.SpecialCustomerTargetList = {}
	self.SpecialCustomerTarget = {
		SpecialCustomerEnterScene = "SpecialCustomerEnterScene",
		SpecialCustomerOrderFood = "SpecialCustomerOrderFood",
		SpecialCustomerGotoCashier = "SpecialCustomerGotoCashier",
		SpecialCustomerWaitBill = "SpecialCustomerWaitBill",
		SpecialCustomerLeaveSeat = "SpecialCustomerLeaveSeat",
		SpecialCustomerTakeBillWithCashier = "SpecialCustomerTakeBillWithCashier",
		SpecialCustomerTakeSeat = "SpecialCustomerTakeSeat",
		SpecialCustomerGotoExit = "SpecialCustomerGotoExit",
		SpecialCustomerEatFood = "SpecialCustomerEatFood",
		SpecialCustomerWaitFood = "SpecialCustomerWaitFood",
		SpecialCustomerDispose = "SpecialCustomerDispose",
		SpecialCustomerGotoTable = "SpecialCustomerGotoTable"
	}
end

function var_0_0:AIInit(arg_2_1)
	if arg_2_1 == nil or self.SpecialCustomerTargetList[arg_2_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	self.SpecialCustomerTargetList[arg_2_1] = {
		target = self.SpecialCustomerTarget.SpecialCustomerEnterScene,
		interactID = {}
	}

	self:AIChoice(arg_2_1)
end

function var_0_0.RegisterEvent(arg_3_0)
	manager.notify:RegistListener(DORM_RESTAURANT_NEW_CUSTOMER, function(arg_4_0)
		arg_3_0:AIInit(arg_4_0)
	end)
	manager.notify:RegistListener(ON_DORM_CHARACTER_MOVE_FINISH, function(arg_5_0, arg_5_1)
		if not arg_3_0.SpecialCustomerTargetList[arg_5_0] then
			return
		end

		if arg_5_1 then
			arg_3_0:AIChoice(arg_5_0)
		else
			arg_3_0:RePlaneAI(arg_5_0)
		end
	end)
	manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT_FINISH, function(arg_6_0, arg_6_1)
		if not arg_3_0.SpecialCustomerTargetList[arg_6_0] then
			return
		end

		if arg_6_1 then
			arg_3_0:AIChoice(arg_6_0)
		else
			arg_3_0:RePlaneAI(arg_6_0)
		end
	end)
	manager.notify:RegistListener(DORM_RESTAURANT_INTERACT_CUSTOMER, function(arg_7_0)
		if not arg_3_0.SpecialCustomerTargetList[arg_7_0] and arg_3_0.SpecialCustomerTargetList[arg_7_0].target == arg_3_0.SpecialCustomerTarget.SpecialCustomerWaitBill then
			arg_3_0.SpecialCustomerTargetList[arg_7_0].payTimer:Stop()
			arg_3_0:AIChoice(arg_7_0)
		end
	end)
end

function var_0_0:AIChoice(arg_8_1)
	if self.SpecialCustomerTargetList[arg_8_1].target == nil then
		print("普通客人列表不存在该实例对象id")

		return
	end

	if self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerEnterScene then
		print(string.format("生成客人%d号", arg_8_1))

		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoTable

		DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoTable, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoTable then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerTakeSeat

		print(string.format("%d号客人抵达餐桌", arg_8_1))
		DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerTakeSeat, arg_8_1)
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerTakeSeat then
		if self:OrderFood(arg_8_1) then
			self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerWaitFood

			DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerWaitFood, arg_8_1)

			self.SpecialCustomerTargetList[arg_8_1].waitTimer = Timer.New(handlerArg1(self, self.WaitFoodCallBack, arg_8_1), DormData.dorm_customer_wait_food_time, 1)

			self.SpecialCustomerTargetList[arg_8_1].waitTimer:Start()
		else
			self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
		end
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerWaitFood then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerEatFood

		DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerEatFood, arg_8_1)
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerEatFood then
		if DormCharacterActionManager:CheckSetRole(DormEnum.CharacterType.Cashier) then
			self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
		else
			self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerWaitBill

			manager.notify:Invoke(DORM_RESTAURANT_CUSTOMER_WAIT_TAKE_BILL, arg_8_1)

			self.SpecialCustomerTargetList[arg_8_1].payTimer = Timer.New(handlerArg1(self, self.WaitBillCallBack, arg_8_1), DormData.dorm_customer_wait_pay_time, 1)

			self.SpecialCustomerTargetList[arg_8_1].payTimer:Start()
			DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerWaitBill, arg_8_1)
		end
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerWaitBill then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerLeaveSeat then
		if arg_8_1.eat then
			if arg_8_1.pay then
				self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoExit

				DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
			elseif arg_8_1.pay == false and cashier.has == false then
				self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoExit

				DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
			elseif arg_8_1.pay == false and cashier.has then
				self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoCashier

				DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoCashier, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
			end
		else
			self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoExit

			DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
		end
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier

		manager.notify:Invoke(DORM_RESTAURANT_CASHIER_TAKE_BILL, arg_8_1)
		DormEventInvoke(DORM_CHARACTER_INTERACT, self.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier, arg_8_1)
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerGotoExit

		DormEventInvoke(DORM_CHARACTER_MOVE, self.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, (self:ChoiceEndPosition(arg_8_1)))
	elseif self.SpecialCustomerTargetList[arg_8_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoExit then
		self.SpecialCustomerTargetList[arg_8_1].target = self.SpecialCustomerTarget.SpecialCustomerDispose

		DormEventInvoke(DORM_CHARACTER_DISPOSE, self.SpecialCustomerTarget.SpecialCustomerDispose, arg_8_1)
		self:DisposeEntity(arg_8_1)
	else
		error("未找到" .. arg_8_1 .. "对象的选择")
	end
end

function var_0_0:RePlaneAI(arg_9_1)
	if self.SpecialCustomerTargetList[arg_9_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoTable then
		-- block empty
	elseif self.SpecialCustomerTargetList[arg_9_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoExit then
		-- block empty
	elseif self.SpecialCustomerTargetList[arg_9_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		-- block empty
	end
end

function var_0_0:ChoiceEndPosition(arg_10_1)
	if self.SpecialCustomerTargetList[arg_10_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoTable then
		return buildVector3({
			10,
			0,
			3
		})
	elseif self.SpecialCustomerTargetList[arg_10_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		return buildVector3({
			8,
			0,
			3
		})
	elseif self.SpecialCustomerTargetList[arg_10_1].target == self.SpecialCustomerTarget.SpecialCustomerGotoExit then
		return buildVector3({
			-10,
			0,
			0
		})
	end
end

function var_0_0:OrderFood(arg_11_1)
	for iter_11_0 = 1, DormConst.ORDER_FOOD_NUM do
		if 101 then
			table.insert(101)
		else
			break
		end
	end

	DormEventInvoke(DORM_ORDER_FOOD, self.SpecialCustomerTarget.SpecialCustomerOrderFood, arg_11_1, {})

	return true
end

function var_0_0:WaitFoodCallBack(arg_12_1)
	if self.SpecialCustomerTargetList[arg_12_1].target == self.SpecialCustomerTarget.SpecialCustomerWaitFood then
		self.SpecialCustomerTargetList[arg_12_1].target = self.SpecialCustomerTargetSpecialCustomerLeaveSeat

		self.SpecialCustomerTargetList[arg_12_1].waitTimer:Stop()
		self.AIChoice(arg_12_1)
	end
end

function var_0_0:WaitBillCallBack(arg_13_1)
	if self.SpecialCustomerTargetList[arg_13_1].target == self.SpecialCustomerTarget.SpecialCustomerWaitBill then
		self.SpecialCustomerTargetList[arg_13_1].target = self.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		self.SpecialCustomerTargetList[arg_13_1].payTimer:Stop()
		self:AIChoice(arg_13_1)
	end
end

function var_0_0:DisposeEntity(arg_14_1)
	self.SpecialCustomerTargetList[arg_14_1] = nil
end

return var_0_0
