local InteractUtil = import(".InteractUtil")
local var_0_3 = InteractUtil.GetEntityBB
local var_0_4 = InteractUtil.NewTask
local var_0_5 = InteractUtil.NewTimer
local var_0_6 = InteractUtil.IsCanteenManualMode
local var_0_7 = InteractUtil.SnapToNearestInteractPoint
local var_0_8 = InteractUtil.RefreshFoodContainer
local var_0_9 = InteractUtil.PickFoodFromTable
local var_0_10 = InteractUtil.PutFoodOnTable
local var_0_11 = InteractUtil.commonAction.PickItemAction
local var_0_12 = InteractUtil.commonAction.PlaceCarryingItemAction

local function var_0_13(arg_1_0)
	return arg_1_0 == DormEnum.ItemType.Pan or arg_1_0 == DormEnum.ItemType.Oven or arg_1_0 == DormEnum.ItemType.Pot or arg_1_0 == DormEnum.ItemType.Steamer
end

local var_0_14 = InteractUtil.IsCustomer

local function var_0_15(arg_2_0)
	arg_2_0:Notify(false)
end

local function var_0_16(arg_3_0)
	local var_3_0 = arg_3_0.targetID
	local var_3_1 = arg_3_0.finish
	local var_3_2 = var_0_3(arg_3_0.entityID)

	var_0_12(arg_3_0.entityID, arg_3_0.targetID, function(arg_4_0)
		var_0_10(arg_4_0, var_3_0)
		var_0_8(var_3_0)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_3_0)

		if var_3_2.selectedOrder then
			var_3_2.selectedOrder.status = DormEnum.FoodState.HasCook
		end
	end):Then(function()
		var_3_2.selectedOrder = nil

		var_3_1:Notify()
	end):Start()
end

local function var_0_17(arg_6_0)
	local var_6_0 = arg_6_0.targetID
	local var_6_1 = arg_6_0.finish
	local var_6_2 = arg_6_0.entityData

	if arg_6_0.entityData.isControlledByPlayer then
		JumpTools.OpenPageByJump("pickFoodView", {
			playerEID = arg_6_0.entityID,
			onSelect = function()
				var_6_2.target = var_0_9(var_6_2.target, var_6_0)
			end,
			onCanceled = function()
				var_0_15(var_6_1)
			end
		})
	end

	var_0_11(arg_6_0.entityID, arg_6_0.targetID, function(arg_9_0)
		var_0_8(var_6_0)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, var_6_0)
	end):Then(function()
		var_6_1:Notify()
	end):Start()
end

local function var_0_18(arg_11_0)
	local var_11_0 = arg_11_0.targetID
	local var_11_1 = arg_11_0.finish
	local var_11_2 = arg_11_0.targetData
	local var_11_3 = CanteenItemManager.GetInstance():GenerateFood(arg_11_0.targetData.curCooking.cfgID, arg_11_0.targetData.curCooking)

	if arg_11_0.targetData.curCookingFoodOrder then
		arg_11_0.targetData.curCookingFoodOrder.foodEID = var_11_3
	end

	arg_11_0.entityData.pick = var_11_3

	Dorm.DormEntityManager.AttachToEntityCMD(var_11_3, arg_11_0.entityID, "gua_R_hand_bone")

	arg_11_0.entityData.target = var_11_3
	arg_11_0.entityData.selectedOrder = arg_11_0.targetData.curCookingFoodOrder
	arg_11_0.targetData.curCookingFoodOrder = nil

	var_0_11(arg_11_0.entityID, arg_11_0.targetID):Then(function()
		CanteenAIFunction:SetItemAvailable(var_11_0, true)

		var_11_2.curCooking = nil
		var_11_2.cookComplete = nil

		if var_0_6() then
			CanteenManualData:RecordCookFood(CanteenAIFunction:GetFoodManualIndex(var_11_3), var_11_3)
		end

		var_11_1:Notify()
	end):Start()
end

local function var_0_19(arg_13_0)
	local var_13_0 = arg_13_0.targetID
	local var_13_1 = arg_13_0.finish

	JumpTools.OpenPageByJump("/cookFoodView", {
		cookEid = arg_13_0.targetID,
		playerEid = arg_13_0.entityID
	})

	local var_13_2 = arg_13_0.targetData

	CanteenAIFunction:SetItemAvailable(arg_13_0.targetID, false)
	var_0_4():WaitUntil(function()
		return var_13_2.curCooking ~= nil
	end):Then(function()
		if var_13_2.curCooking then
			var_0_18(arg_13_0)
		else
			CanteenAIFunction:SetItemAvailable(var_13_0, true)

			var_13_2.curCooking = nil

			var_13_1:Notify()
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
	if package.loaded["game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1] then
		if type(package.loaded["game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1]) == "table" then
			return package.loaded["game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1]
		end
	else
		local var_16_0 = Dorm.InteractionGrouping["game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1]

		if Dorm.InteractionGrouping["game.dorm.interacts.canteen.cook_" .. arg_16_0 .. "_" .. arg_16_1] then
			return var_16_0[math.random(#var_16_0)]
		end
	end
end

local function var_0_22(arg_17_0)
	local var_17_1 = arg_17_0.targetID
	local var_17_2 = arg_17_0.finish
	local var_17_3 = arg_17_0.entityData
	local var_17_4 = arg_17_0.targetData
	local var_17_5 = DormCharacterInteractBehaviour.MakeInteractTask(var_0_21(var_0_20[arg_17_0.targetType], nullable(BackHomeHeroSkinCfg[arg_17_0.entityData.cfgID], "style") or nullable(BackHomeNpcCfg[arg_17_0.entityData.heroID], "style")), arg_17_0) or var_0_4()

	CanteenAIFunction:SetItemAvailable(arg_17_0.targetID, false)
	var_17_5:WaitUntil(function()
		return var_17_4.curCooking ~= nil
	end):Then(function()
		var_17_4.curCookingFoodOrder = var_17_3.selectedOrder
		var_17_3.selectedOrder = nil

		local var_19_0 = var_0_5(function()
			var_17_4.cookComplete = true
			var_17_4.curCookingTimer = nil

			CanteenAIFunction:SetItemAvailable(var_17_1, true)
		end, BackHomeCanteenFoodCfg[var_17_4.curCooking.cfgID].cook_time, false, false)

		var_17_4.curCookingTimer = var_19_0

		var_19_0:Start()
		var_17_2:Notify()
	end):Start()
end

local function var_0_23(arg_21_0, arg_21_1)
	local var_21_0 = var_0_3(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(var_0_3(arg_21_0).curOrder) do
		if iter_21_1.status ~= DormEnum.FoodState.HasServer and var_21_0.cfgID == iter_21_1.cfgID then
			iter_21_1.status = DormEnum.FoodState.HasServer

			manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, arg_21_0)

			return
		end
	end
end

local function var_0_24(arg_22_0)
	local var_22_0 = arg_22_0.targetID
	local var_22_1 = arg_22_0.entityData

	var_0_12(arg_22_0.entityID, arg_22_0.targetID, function(arg_23_0)
		var_0_10(arg_23_0, var_22_0)
		var_0_8(var_22_0)

		if var_22_1.selectedOrder then
			var_22_1.selectedOrder.status = DormEnum.FoodState.HasServer
		else
			var_0_23(var_22_0, arg_23_0)
		end
	end):Then(function(arg_24_0)
		var_22_1.selectedOrder = nil

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
	var_0_7(arg_26_0.entityID, arg_26_0.targetID, Dorm.DormEntityManager.QueryForwardDir(arg_26_0.targetID))

	if arg_26_0.entityData.isControlledByPlayer then
		var_0_19(arg_26_0)
	elseif arg_26_0.targetData.cookComplete then
		var_0_18(arg_26_0)
	else
		var_0_22(arg_26_0)
	end
end

local function var_0_27(arg_27_0)
	local var_27_0 = arg_27_0.finish

	if arg_27_0.targetData.sit and not arg_27_0.targetData.eat then
		local var_27_1 = arg_27_0.targetData.tableEid
		local var_27_2 = var_0_3(arg_27_0.targetData.tableEid)

		for iter_27_0, iter_27_1 in ipairs(var_27_2.curOrder) do
			iter_27_1.status = DormEnum.FoodState.Canceled
		end

		if var_27_2.foodList and var_27_2.foodList[1] then
			arg_27_0.entityData.target = var_0_9(var_27_2.foodList[1], arg_27_0.targetData.tableEid)

			var_0_7(arg_27_0.entityID, arg_27_0.targetData.tableEid)
			var_0_11(arg_27_0.entityID, arg_27_0.targetData.tableEid, function()
				var_0_8(var_27_1)
			end):Then(function()
				var_27_0:Notify()
			end):Start()
		else
			arg_27_0.finish:Notify()
		end

		manager.notify:Invoke(DORM_RESTAURANT_INTERACT_CUSTOMER, arg_27_0.targetID, arg_27_0.entityID)
	end
end

return function(arg_30_0)
	if arg_30_0.targetType == DormEnum.ItemType.PassTable then
		var_0_25(arg_30_0)
	elseif var_0_13(arg_30_0.targetType) then
		var_0_26(arg_30_0)
	elseif arg_30_0.targetType == DormEnum.ItemType.DinningTable then
		var_0_24(arg_30_0)
	elseif var_0_14(arg_30_0.targetType) then
		var_0_27(arg_30_0)
	else
		arg_30_0.finish:Notify(false)
		error("交互类型错误，错误类型为" .. arg_30_0.targetType)
	end
end
