local InteractUtil = import(".InteractUtil")
local var_0_1 = InteractUtil.waitAnime.defaultWaitAnimation
local var_0_4 = InteractUtil.GetEntityBB
local var_0_5 = InteractUtil.NewTask
local var_0_7 = InteractUtil.IsCanteenManualMode

local function var_0_14(arg_1_0)
	local var_1_0 = arg_1_0.entityID
	local var_1_1 = arg_1_0.targetID
	local var_1_2 = arg_1_0.finish
	local var_1_3 = arg_1_0.entityData

	arg_1_0.targetData.character = arg_1_0.entityID

	var_0_5(function()
		Dorm.DormEntityManager.PutEntityAt(var_1_0, var_1_1, "gua_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_1_0, "sit_down", nil, 0)
	end):HandleAnimeLoop(var_0_1(arg_1_0.entityID, "sit_down", function()
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_1_0, "sit")
		Dorm.DormEntityManager.SetEntityMobility(var_1_0, false)
	end)):Then(function()
		var_1_3.sit = true

		if var_1_3.pay then
			CanteenAIFunction:SetItemAvailable(var_1_3.tableEid, true)
		end

		var_1_2:Notify()
	end):Start()
end

local function var_0_15(arg_5_0)
	local var_5_0 = arg_5_0.entityID
	local var_5_1 = arg_5_0.targetID
	local var_5_2 = arg_5_0.finish
	local var_5_3 = arg_5_0.entityData
	local var_5_4 = arg_5_0.targetData
	local var_5_5 = CanteenItemManager.GetItemInteractPositions(arg_5_0.targetID)
	local var_5_6 = var_5_5[math.random(1, #var_5_5)]
	local var_5_7 = Dorm.DormEntityManager.QueryForwardDir(arg_5_0.targetID)

	arg_5_0.entityData.sit = false

	var_0_5(function()
		Dorm.DormEntityManager.PutEntityAt(var_5_0, var_5_1, "gua_start_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_5_0, "sit_up", nil, 0)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_5_0, "default")
	end):HandleAnimeLoop(var_0_1(arg_5_0.entityID, "sit_up")):Then(function()
		if var_5_3.pay then
			CanteenAIFunction:SetItemAvailable(var_5_3.tableEid, false)
		end

		var_5_4.character = nil

		CanteenAIFunction:SetItemAvailable(var_5_1, true)
		Dorm.DormEntityManager.SetEntityMobility(var_5_0, true)

		if var_5_3.pay then
			CanteenManager.GetInstance():OnCustomerLeave(var_5_0)
		end

		var_5_2:Notify()
	end):Start()
end

local function var_0_16(arg_8_0)
	local var_8_0 = arg_8_0.entityData
	local var_8_1 = var_0_4(arg_8_0.entityData.tableEid)

	var_0_5():WaitUntil(function()
		return var_8_0.orderInfo ~= nil
	end, true):Then(function()
		for iter_10_0, iter_10_1 in ipairs(var_8_0.orderInfo) do
			iter_10_1.orderCharacterID = arg_8_0.entityID
			iter_10_1.orderTableID = var_8_0.tableEid

			CanteenManager.AddOrder(iter_10_1)
		end

		var_8_1.curOrder = var_8_0.orderInfo
		var_8_0.eat = false

		arg_8_0.finish:Notify()
	end):Start(true)
end

local function var_0_17(arg_11_0)
	for iter_11_0 = #arg_11_0.foodList, 1, -1 do
		table.remove(arg_11_0.foodList, iter_11_0)
		CanteenItemManager.FindAndRemoveEntity(arg_11_0.foodList[iter_11_0])
	end
end

local function var_0_18(arg_12_0)
	local var_12_0 = arg_12_0.entityID
	local var_12_2 = arg_12_0.finish

	if var_0_7() then
		CanteenManualData:RecordManualSerCustomerNum(1)
	end

	local var_12_3 = arg_12_0.entityData

	var_12_3.eat = true

	CanteenAIFunction:SetItemAvailable(var_12_3.tableEid, false)
	var_0_5(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_12_0, "sit_eat")
	end):HandleAnimeLoop(var_0_1(arg_12_0.entityID, "sit_eat")):Then(function()
		if var_12_3.pay then
			var_0_17(arg_12_0.targetData)
		end

		var_12_2:Notify()
	end):Start()
end

local function var_0_19(arg_15_0)
	local var_15_0 = arg_15_0.entityID
	local var_15_1 = arg_15_0.targetID
	local var_15_2 = arg_15_0.finish

	var_0_5(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_15_1, "manners")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_15_0, "stand")
	end):WaitForSec(5):Then(function()
		var_15_2:Notify()
	end):Start()
end

return function(arg_18_0)
	if arg_18_0.targetType == DormEnum.ItemType.DinningChair then
		if not arg_18_0.entityData.sit then
			var_0_14(arg_18_0)
		else
			var_0_15(arg_18_0)
		end
	elseif arg_18_0.targetType == DormEnum.ItemType.OrderFoodDummy then
		var_0_16(arg_18_0)
	elseif arg_18_0.targetType == DormEnum.ItemType.DinningTable then
		var_0_18(arg_18_0)
	elseif arg_18_0.targetType == DormEnum.CharacterType.RestaurantCashier then
		var_0_19(arg_18_0)
	else
		arg_18_0.finish:Notify(false)
		print("交互对象类型没找到")
	end
end
