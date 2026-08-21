local var_0_0 = singletonClass("CashierAI")

function var_0_0.Init(arg_1_0)
	arg_1_0:RegisterEvent()

	arg_1_0.CashierState = {
		CashierGotoCounter = "CashierGotoCounter",
		CashierTakeBill = "CashierTakeBill",
		CashierEnterScene = "CashierEnterScene",
		CashierIdle = "CashierIdle"
	}
	arg_1_0.CashierStateList = {}
end

function var_0_0.AIInit(arg_2_0, arg_2_1)
	if arg_2_1 == nil or arg_2_0.CashierStateList[arg_2_1] then
		error("传入参数为空或实体对象id重复")

		return
	end

	arg_2_0.cashierData = CanteenAIFunction:GetEntityData(arg_2_1)
	arg_2_0.cashierData.cashierObject = nil
	arg_2_0.CashierStateList[arg_2_1] = {
		state = arg_2_0.CashierState.CashierEnterScene,
		lastState = {}
	}
	arg_2_0.cashierEID = arg_2_1

	arg_2_0:AIChoice(arg_2_1)
end

function var_0_0.RegisterEvent(arg_3_0)
	arg_3_0.listener = arg_3_0.listener or EventListener.New()

	arg_3_0.listener:RemoveAll()

	local var_3_0 = {
		[DORM_RESTAURANT_NEW_CASHIER] = handler(arg_3_0, arg_3_0.AIInit),
		[ON_DORM_CHARACTER_MOVE_FINISH] = handler(arg_3_0, arg_3_0.ListenMoveEvent),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(arg_3_0, arg_3_0.ListenInteractEvent),
		[DORM_CHARACTER_DISPOSE] = handler(arg_3_0, arg_3_0.DisposeEntity)
	}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		arg_3_0.listener:Register(iter_3_0, iter_3_1)
	end
end

function var_0_0.RemoveListener(arg_4_0)
	arg_4_0.listener:RemoveAll()
end

function var_0_0.ListenMoveEvent(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.CashierStateList[arg_5_1] then
		return
	end

	if arg_5_2 then
		arg_5_0:AIChoice(arg_5_1)
	end
end

function var_0_0.ListenInteractEvent(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.CashierStateList[arg_6_1] then
		return
	end

	if arg_6_2 then
		arg_6_0:AIChoice(arg_6_1)
	end
end

function var_0_0.AIChoice(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.CashierStateList[arg_7_1].state

	if var_7_0 == nil then
		return
	end

	local var_7_1 = CanteenAIFunction:GetEntityData(arg_7_1)

	if var_7_0 == arg_7_0.CashierState.CashierEnterScene then
		CanteenAIFunction:SetCharacterBusy(arg_7_1, false)

		local var_7_2 = CanteenAIFunction:GetNameSpace(DormEnum.ItemType.CashierTable)
		local var_7_3 = CanteenAIFunction:GetAllEIDNameSpace(var_7_2)[1]
		local var_7_4 = CanteenItemManager.GetItemInteractPositions(var_7_3)
		local var_7_5 = CanteenAIFunction:GetNearestPoint(arg_7_1, var_7_4)

		arg_7_0.CashierStateList[arg_7_1].lastState = arg_7_0.CashierState.CashierEnterScene
		arg_7_0.CashierStateList[arg_7_1].state = arg_7_0.CashierState.CashierGotoCounter

		DormEventInvoke(DORM_CHARACTER_MOVE_LOOK_AT, arg_7_0.CashierState.CashierGotoCounter, arg_7_1, var_7_5, Dorm.DormEntityManager.QueryPosition(var_7_3), false)
	elseif var_7_0 == arg_7_0.CashierState.CashierGotoCounter then
		if CanteenAIFunction:GetCharacterBusy(arg_7_1) == false then
			arg_7_0.CashierStateList[arg_7_1].lastState = arg_7_0.CashierState.CashierGotoCounter
			arg_7_0.CashierStateList[arg_7_1].state = arg_7_0.CashierState.CashierIdle
		else
			return
		end
	elseif var_7_0 == arg_7_0.CashierState.CashierIdle then
		CanteenAIFunction:SetCharacterBusy(arg_7_1, true)
	end
end

function var_0_0.RePlaneAI(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		arg_8_0:AIChoice(arg_8_1)
	else
		arg_8_0.CashierStateList[arg_8_1].state = arg_8_0.CashierStateList[arg_8_1].lastState
		arg_8_0.CashierStateList[arg_8_1].lastState = nil

		arg_8_0:AIChoice(arg_8_1)
	end
end

function var_0_0.DisposeEntity(arg_9_0, arg_9_1)
	if arg_9_0.CashierStateList[arg_9_1] then
		arg_9_0.CashierStateList[arg_9_1] = nil
	end
end

function var_0_0.DisposeAllEntity(arg_10_0)
	arg_10_0.CashierStateList = nil
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:DisposeAllEntity()
	arg_11_0:RemoveListener()
end

return var_0_0
