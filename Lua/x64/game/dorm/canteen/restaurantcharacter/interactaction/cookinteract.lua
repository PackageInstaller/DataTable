local var_0_0 = import(".InteractUtil")
local var_0_1 = var_0_0.waitAnime.handleEventWaitAnimation
local var_0_2 = var_0_0.GetEntityType
local var_0_3 = var_0_0.GetEntityBB
local var_0_4 = var_0_0.NewTask
local var_0_5 = var_0_0.NewTimer
local var_0_6 = var_0_0.IsCanteenManualMode
local var_0_7 = var_0_0.SnapToNearestInteractPoint
local var_0_8 = var_0_0.RefreshFoodContainer
local var_0_9 = var_0_0.PickFoodFromTable
local var_0_10 = var_0_0.PutFoodOnTable
local var_0_11 = var_0_0.commonAction.PickItemAction
local var_0_12 = var_0_0.commonAction.PlaceCarryingItemAction

local function var_0_13(arg_1_0)
	return arg_1_0 == DormEnum.ItemType.Pan or arg_1_0 == DormEnum.ItemType.Oven or arg_1_0 == DormEnum.ItemType.Pot or arg_1_0 == DormEnum.ItemType.Steamer
end

local var_0_14 = var_0_0.IsCustomer

local function var_0_15(arg_2_0)
	arg_2_0:Notify(false)
end

local function var_0_16(arg_3_0)
	local var_3_0 = arg_3_0.entityID
	local var_3_1 = arg_3_0.targetID
	local var_3_2 = arg_3_0.finish
	local var_3_3 = var_0_3(var_3_0)

	var_0_12(var_3_0, var_3_1, function(arg_4_0)
		var_0_10(arg_4_0, var_3_1)
		var_0_8(var_3_1)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_3_1)

		if var_3_3.selectedOrder then
			var_3_3.selectedOrder.status = DormEnum.FoodState.HasCook
		end
	end):Then(function()
		var_3_3.selectedOrder = nil

		var_3_2:Notify()
	end):Start()
end

local function var_0_17(arg_6_0)
	local var_6_0 = arg_6_0.entityID
	local var_6_1 = arg_6_0.targetID
	local var_6_2 = arg_6_0.finish
	local var_6_3 = arg_6_0.entityData

	if var_6_3.isControlledByPlayer then
		JumpTools.OpenPageByJump("pickFoodView", {
			playerEID = var_6_0,
			onSelect = function()
				var_6_3.target = var_0_9(var_6_3.target, var_6_1)
			end,
			onCanceled = function()
				var_0_15(var_6_2)
			end
		})
	end

	var_0_11(var_6_0, var_6_1, function(arg_9_0)
		var_0_8(var_6_1)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_6_1)
	end):Then(function()
		var_6_2:Notify()
	end):Start()
end

local function var_0_18(arg_11_0)
	local var_11_0 = arg_11_0.entityID
	local var_11_1 = arg_11_0.targetID
	local var_11_2 = arg_11_0.finish
	local var_11_3 = arg_11_0.entityData
	local var_11_4 = arg_11_0.targetData
	local var_11_5 = var_11_4.curCooking.cfgID
	local var_11_6 = var_11_4.curCooking
	local var_11_7 = CanteenItemManager.GetInstance():GenerateFood(var_11_5, var_11_6)
	local var_11_8 = var_11_4.curCookingFoodOrder

	if var_11_8 then
		var_11_8.foodEID = var_11_7
	end

	var_11_3.pick = var_11_7

	Dorm.DormEntityManager.AttachToEntityCMD(var_11_7, var_11_0, "gua_R_hand_bone")

	var_11_3.target = var_11_7
	var_11_3.selectedOrder = var_11_8
	var_11_4.curCookingFoodOrder = nil

	var_0_11(var_11_0, var_11_1):Then(function()
		CanteenAIFunction:SetItemAvailable(var_11_1, true)

		var_11_4.curCooking = nil
		var_11_4.cookComplete = nil

		if var_0_6() then
			local var_12_0 = CanteenAIFunction:GetFoodManualIndex(var_11_7)

			CanteenManualData:RecordCookFood(var_12_0, var_11_7)
		end

		var_11_2:Notify()
	end):Start()
end

local function var_0_19(arg_13_0)
	local var_13_0 = arg_13_0.entityID
	local var_13_1 = arg_13_0.targetID
	local var_13_2 = arg_13_0.finish

	JumpTools.OpenPageByJump("/cookFoodView", {
		cookEid = var_13_1,
		playerEid = var_13_0
	})

	local var_13_3 = arg_13_0.targetData

	CanteenAIFunction:SetItemAvailable(var_13_1, false)
	var_0_4():WaitUntil(function()
		return var_13_3.curCooking ~= nil
	end):Then(function()
		if var_13_3.curCooking then
			var_0_18(arg_13_0)
		else
			CanteenAIFunction:SetItemAvailable(var_13_1, true)

			var_13_3.curCooking = nil

			var_13_2:Notify()
		end
	end):Start()
end

local var_0_20 = {
	[DormEnum.ItemType.Steamer] = "steamer",
	[DormEnum.ItemType.Oven] = "oven",
	[DormEnum.ItemType.Pot] = "stew",
	[DormEnum.ItemType.Pan] = "saucepan"
}

local function var_0_21(arg_16_0, arg_16_1)
	local var_16_0 = "game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1
	local var_16_1 = package.loaded[var_16_0]

	if var_16_1 then
		if type(var_16_1) == "table" then
			return var_16_1
		end
	else
		local var_16_2 = Dorm.InteractionGrouping[var_16_0]

		if var_16_2 then
			return var_16_2[math.random(#var_16_2)]
		end
	end
end

local function var_0_22(arg_17_0)
	local var_17_0 = arg_17_0.entityID
	local var_17_1 = arg_17_0.targetID
	local var_17_2 = arg_17_0.finish
	local var_17_3 = arg_17_0.entityData
	local var_17_4 = arg_17_0.targetData
	local var_17_5 = arg_17_0.targetType
	local var_17_6 = var_0_20[var_17_5]
	local var_17_7 = var_17_3.cfgID
	local var_17_8 = nullable(BackHomeHeroSkinCfg[var_17_7], "style") or nullable(BackHomeNpcCfg[var_17_3.heroID], "style")
	local var_17_9 = var_0_21(var_17_6, var_17_8)
	local var_17_10 = DormCharacterInteractBehaviour.MakeInteractTask(var_17_9, arg_17_0) or var_0_4()

	CanteenAIFunction:SetItemAvailable(var_17_1, false)
	var_17_10:WaitUntil(function()
		return var_17_4.curCooking ~= nil
	end):Then(function()
		var_17_4.curCookingFoodOrder = var_17_3.selectedOrder
		var_17_3.selectedOrder = nil

		local var_19_0 = BackHomeCanteenFoodCfg[var_17_4.curCooking.cfgID].cook_time
		local var_19_1 = var_0_5(function()
			var_17_4.cookComplete = true
			var_17_4.curCookingTimer = nil

			CanteenAIFunction:SetItemAvailable(var_17_1, true)
		end, var_19_0, false, false)

		var_17_4.curCookingTimer = var_19_1

		var_19_1:Start()
		var_17_2:Notify()
	end):Start()
end

local function var_0_23(arg_21_0, arg_21_1)
	local var_21_0 = var_0_3(arg_21_0)
	local var_21_1 = var_0_3(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(var_21_0.curOrder) do
		if iter_21_1.status ~= DormEnum.FoodState.HasServer and var_21_1.cfgID == iter_21_1.cfgID then
			iter_21_1.status = DormEnum.FoodState.HasServer

			manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, arg_21_0)

			return
		end
	end
end

local function var_0_24(arg_22_0)
	local var_22_0 = arg_22_0.entityID
	local var_22_1 = arg_22_0.targetID
	local var_22_2 = arg_22_0.entityData

	local function var_22_3(arg_23_0)
		var_0_10(arg_23_0, var_22_1)
		var_0_8(var_22_1)

		if var_22_2.selectedOrder then
			var_22_2.selectedOrder.status = DormEnum.FoodState.HasServer
		else
			var_0_23(var_22_1, arg_23_0)
		end
	end

	var_0_12(var_22_0, var_22_1, var_22_3):Then(function(arg_24_0)
		var_22_2.selectedOrder = nil

		arg_22_0.finish:Notify()
	end):Start()
end

local function var_0_25(arg_25_0)
	if arg_25_0.entityData.pick then
		var_0_16(arg_25_0)
	else
		var_0_17(arg_25_0)
	end
end

local function var_0_26(arg_26_0)
	local var_26_0 = arg_26_0.entityID
	local var_26_1 = arg_26_0.targetID
	local var_26_2 = arg_26_0.finish

	var_0_7(var_26_0, var_26_1, Dorm.DormEntityManager.QueryForwardDir(var_26_1))

	if arg_26_0.entityData.isControlledByPlayer then
		var_0_19(arg_26_0)
	elseif arg_26_0.targetData.cookComplete then
		var_0_18(arg_26_0)
	else
		var_0_22(arg_26_0)
	end
end

local function var_0_27(arg_27_0)
	local var_27_0 = arg_27_0.entityID
	local var_27_1 = arg_27_0.targetID
	local var_27_2 = arg_27_0.finish
	local var_27_3 = arg_27_0.entityData
	local var_27_4 = arg_27_0.targetData

	if var_27_4.sit and not var_27_4.eat then
		local var_27_5 = var_27_4.tableEid
		local var_27_6 = var_0_3(var_27_5)

		for iter_27_0, iter_27_1 in ipairs(var_27_6.curOrder) do
			iter_27_1.status = DormEnum.FoodState.Canceled
		end

		if var_27_6.foodList and var_27_6.foodList[1] then
			var_27_3.target = var_0_9(var_27_6.foodList[1], var_27_5)

			var_0_7(var_27_0, var_27_5)
			var_0_11(var_27_0, var_27_5, function()
				var_0_8(var_27_5)
			end):Then(function()
				var_27_2:Notify()
			end):Start()
		else
			var_27_2:Notify()
		end

		manager.notify:Invoke(DORM_RESTAURANT_INTERACT_CUSTOMER, var_27_1, var_27_0)
	end
end

return function(arg_30_0)
	local var_30_0 = arg_30_0.targetType
	local var_30_1 = arg_30_0.finish

	if var_30_0 == DormEnum.ItemType.PassTable then
		var_0_25(arg_30_0)
	elseif var_0_13(var_30_0) then
		var_0_26(arg_30_0)
	elseif var_30_0 == DormEnum.ItemType.DinningTable then
		var_0_24(arg_30_0)
	elseif var_0_14(var_30_0) then
		var_0_27(arg_30_0)
	else
		var_30_1:Notify(false)
		error("交互类型错误，错误类型为" .. var_30_0)
	end
end
