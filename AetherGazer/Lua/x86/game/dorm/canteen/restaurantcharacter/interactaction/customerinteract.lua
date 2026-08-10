local var_0_0 = import(".InteractUtil")
local var_0_1 = var_0_0.waitAnime.defaultWaitAnimation
local var_0_2 = var_0_0.waitAnime.handleEventWaitAnimation
local var_0_3 = var_0_0.GetEntityType
local var_0_4 = var_0_0.GetEntityBB
local var_0_5 = var_0_0.NewTask
local var_0_6 = var_0_0.NewTimer
local var_0_7 = var_0_0.IsCanteenManualMode
local var_0_8 = var_0_0.SnapToNearestInteractPoint
local var_0_9 = var_0_0.RefreshFoodContainer
local var_0_10 = var_0_0.PickFoodFromTable
local var_0_11 = var_0_0.PutFoodOnTable
local var_0_12 = var_0_0.commonAction.PickItemAction
local var_0_13 = var_0_0.commonAction.PlaceCarryingItemAction

local function var_0_14(arg_1_0)
	local var_1_0 = arg_1_0.entityID
	local var_1_1 = arg_1_0.targetID
	local var_1_2 = arg_1_0.finish
	local var_1_3 = arg_1_0.entityData

	arg_1_0.targetData.character = var_1_0

	var_0_5(function()
		Dorm.DormEntityManager.PutEntityAt(var_1_0, var_1_1, "gua_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_1_0, "sit_down", nil, 0)
	end):HandleAnimeLoop(var_0_1(var_1_0, "sit_down", function()
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
	local var_5_5 = CanteenItemManager.GetItemInteractPositions(var_5_1)
	local var_5_6 = var_5_5[math.random(1, #var_5_5)]
	local var_5_7 = Dorm.DormEntityManager.QueryForwardDir(var_5_1)

	var_5_3.sit = false

	var_0_5(function()
		Dorm.DormEntityManager.PutEntityAt(var_5_0, var_5_1, "gua_start_sit")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_5_0, "sit_up", nil, 0)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_5_0, "default")
	end):HandleAnimeLoop(var_0_1(var_5_0, "sit_up")):Then(function()
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
	local var_8_1 = var_0_4(var_8_0.tableEid)

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
	local var_11_0 = arg_11_0.foodList

	for iter_11_0 = #var_11_0, 1, -1 do
		local var_11_1 = var_11_0[iter_11_0]

		table.remove(var_11_0, iter_11_0)
		CanteenItemManager.FindAndRemoveEntity(var_11_1)
	end
end

local function var_0_18(arg_12_0)
	local var_12_0 = arg_12_0.entityID
	local var_12_1 = arg_12_0.targetID
	local var_12_2 = arg_12_0.finish

	if var_0_7() then
		CanteenManualData:RecordManualSerCustomerNum(1)
	end

	local var_12_3 = arg_12_0.entityData

	var_12_3.eat = true

	CanteenAIFunction:SetItemAvailable(var_12_3.tableEid, false)
	var_0_5(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_12_0, "sit_eat")
	end):HandleAnimeLoop(var_0_1(var_12_0, "sit_eat")):Then(function()
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
	local var_15_3 = arg_15_0.entityData

	var_0_5(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_15_1, "manners")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_15_0, "stand")
	end):WaitForSec(5):Then(function()
		var_15_2:Notify()
	end):Start()
end

return function(arg_18_0)
	local var_18_0 = arg_18_0.targetType
	local var_18_1 = arg_18_0.entityData

	if var_18_0 == DormEnum.ItemType.DinningChair then
		if not var_18_1.sit then
			var_0_14(arg_18_0)
		else
			var_0_15(arg_18_0)
		end
	elseif var_18_0 == DormEnum.ItemType.OrderFoodDummy then
		var_0_16(arg_18_0)
	elseif var_18_0 == DormEnum.ItemType.DinningTable then
		var_0_18(arg_18_0)
	elseif var_18_0 == DormEnum.CharacterType.RestaurantCashier then
		var_0_19(arg_18_0)
	else
		arg_18_0.finish:Notify(false)
		print("交互对象类型没找到")
	end
end
