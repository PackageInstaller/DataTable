local var_0_0 = singletonClass("SpecialCustomerAI")

function var_0_0.Init(arg_1_0)
	arg_1_0.restaurantBB = 1

	arg_1_0:RegisterEvent()

	arg_1_0.SpecialCustomerTargetList = {}
	arg_1_0.SpecialCustomerTarget = {
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

function var_0_0.AIInit(arg_2_0, arg_2_1)
	if arg_2_1 == nil or arg_2_0.SpecialCustomerTargetList[arg_2_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	arg_2_0.SpecialCustomerTargetList[arg_2_1] = {
		target = arg_2_0.SpecialCustomerTarget.SpecialCustomerEnterScene,
		interactID = {}
	}

	arg_2_0:AIChoice(arg_2_1)
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

function var_0_0.AIChoice(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.SpecialCustomerTargetList[arg_8_1].target

	if var_8_0 == nil then
		print("普通客人列表不存在该实例对象id")

		return
	end

	if var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerEnterScene then
		print(string.format("生成客人%d号", arg_8_1))

		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoTable

		local var_8_1 = arg_8_0:ChoiceEndPosition(arg_8_1)

		DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoTable, arg_8_1, var_8_1)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeSeat

		print(string.format("%d号客人抵达餐桌", arg_8_1))
		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeSeat, arg_8_1)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeSeat then
		if arg_8_0:OrderFood(arg_8_1) then
			arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitFood

			DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitFood, arg_8_1)

			arg_8_0.SpecialCustomerTargetList[arg_8_1].waitTimer = Timer.New(handlerArg1(arg_8_0, arg_8_0.WaitFoodCallBack, arg_8_1), DormData.dorm_customer_wait_food_time, 1)

			arg_8_0.SpecialCustomerTargetList[arg_8_1].waitTimer:Start()
		else
			arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
		end
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitFood then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerEatFood

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerEatFood, arg_8_1)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerEatFood then
		if DormCharacterActionManager:CheckSetRole(DormEnum.CharacterType.Cashier) then
			arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

			DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
		else
			arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitBill

			manager.notify:Invoke(DORM_RESTAURANT_CUSTOMER_WAIT_TAKE_BILL, arg_8_1)

			arg_8_0.SpecialCustomerTargetList[arg_8_1].payTimer = Timer.New(handlerArg1(arg_8_0, arg_8_0.WaitBillCallBack, arg_8_1), DormData.dorm_customer_wait_pay_time, 1)

			arg_8_0.SpecialCustomerTargetList[arg_8_1].payTimer:Start()
			DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitBill, arg_8_1)
		end
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerWaitBill then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat, arg_8_1)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat then
		if arg_8_1.eat then
			if arg_8_1.pay then
				arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit

				local var_8_2 = arg_8_0:ChoiceEndPosition(arg_8_1)

				DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, var_8_2)
			elseif arg_8_1.pay == false and cashier.has == false then
				arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit

				local var_8_3 = arg_8_0:ChoiceEndPosition(arg_8_1)

				DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, var_8_3)
			elseif arg_8_1.pay == false and cashier.has then
				arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoCashier

				local var_8_4 = arg_8_0:ChoiceEndPosition(arg_8_1)

				DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoCashier, arg_8_1, var_8_4)
			end
		else
			arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit

			local var_8_5 = arg_8_0:ChoiceEndPosition(arg_8_1)

			DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, var_8_5)
		end
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier

		manager.notify:Invoke(DORM_RESTAURANT_CASHIER_TAKE_BILL, arg_8_1)
		DormEventInvoke(DORM_CHARACTER_INTERACT, arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier, arg_8_1)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerTakeBillWithCashier then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit

		local var_8_6 = arg_8_0:ChoiceEndPosition(arg_8_1)

		DormEventInvoke(DORM_CHARACTER_MOVE, arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit, arg_8_1, var_8_6)
	elseif var_8_0 == arg_8_0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		arg_8_0.SpecialCustomerTargetList[arg_8_1].target = arg_8_0.SpecialCustomerTarget.SpecialCustomerDispose

		DormEventInvoke(DORM_CHARACTER_DISPOSE, arg_8_0.SpecialCustomerTarget.SpecialCustomerDispose, arg_8_1)
		arg_8_0:DisposeEntity(arg_8_1)
	else
		error("未找到" .. arg_8_1 .. "对象的选择")
	end
end

function var_0_0.RePlaneAI(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.SpecialCustomerTargetList[arg_9_1].target

	if var_9_0 == arg_9_0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		-- block empty
	elseif var_9_0 == arg_9_0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		-- block empty
	elseif var_9_0 == arg_9_0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		-- block empty
	end
end

function var_0_0.ChoiceEndPosition(arg_10_0, arg_10_1)
	if arg_10_0.SpecialCustomerTargetList[arg_10_1].target == arg_10_0.SpecialCustomerTarget.SpecialCustomerGotoTable then
		return buildVector3({
			10,
			0,
			3
		})
	elseif arg_10_0.SpecialCustomerTargetList[arg_10_1].target == arg_10_0.SpecialCustomerTarget.SpecialCustomerGotoCashier then
		return buildVector3({
			8,
			0,
			3
		})
	elseif arg_10_0.SpecialCustomerTargetList[arg_10_1].target == arg_10_0.SpecialCustomerTarget.SpecialCustomerGotoExit then
		return buildVector3({
			-10,
			0,
			0
		})
	end
end

function var_0_0.OrderFood(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, DormConst.ORDER_FOOD_NUM do
		local var_11_1 = 101

		if var_11_1 then
			table.insert(var_11_1)
		else
			break
		end
	end

	DormEventInvoke(DORM_ORDER_FOOD, arg_11_0.SpecialCustomerTarget.SpecialCustomerOrderFood, arg_11_1, var_11_0)

	return true
end

function var_0_0.WaitFoodCallBack(arg_12_0, arg_12_1)
	if arg_12_0.SpecialCustomerTargetList[arg_12_1].target == arg_12_0.SpecialCustomerTarget.SpecialCustomerWaitFood then
		arg_12_0.SpecialCustomerTargetList[arg_12_1].target = arg_12_0.SpecialCustomerTargetSpecialCustomerLeaveSeat

		arg_12_0.SpecialCustomerTargetList[arg_12_1].waitTimer:Stop()
		arg_12_0.AIChoice(arg_12_1)
	end
end

function var_0_0.WaitBillCallBack(arg_13_0, arg_13_1)
	if arg_13_0.SpecialCustomerTargetList[arg_13_1].target == arg_13_0.SpecialCustomerTarget.SpecialCustomerWaitBill then
		arg_13_0.SpecialCustomerTargetList[arg_13_1].target = arg_13_0.SpecialCustomerTarget.SpecialCustomerLeaveSeat

		arg_13_0.SpecialCustomerTargetList[arg_13_1].payTimer:Stop()
		arg_13_0:AIChoice(arg_13_1)
	end
end

function var_0_0.DisposeEntity(arg_14_0, arg_14_1)
	arg_14_0.SpecialCustomerTargetList[arg_14_1] = nil
end

return var_0_0
