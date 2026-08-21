local var_0_0 = {
	GetEntityBB = function(arg_1_0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_1_0)
	end,
	GetEntityType = function(arg_2_0)
		return Dorm.storage:GetData(DormEnum.Namespace.EntityType, arg_2_0)
	end,
	NewTask = function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = DormCharacterActionManager.taskRunner:NewTask(arg_3_2):SetCancellationSrc(arg_3_1)

		if arg_3_0 then
			var_3_0:Then(arg_3_0)
		end

		return var_3_0
	end,
	NewTimer = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		return DormCharacterActionManager.taskRunner:NewTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	end,
	IsCanteenManualMode = function(arg_5_0)
		return CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual
	end,
	IsCanteenAutoMode = function(arg_6_0)
		return CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto
	end,
	IsCanteenStopBusiness = function(arg_7_0)
		return CanteenData:GetCanteenState() == nil
	end,
	SnapToNearestInteractPoint = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = Dorm.DormEntityManager.QueryPosition(arg_8_1)
		local var_8_1 = CanteenItemManager.GetItemInteractPositions(arg_8_1)
		local var_8_2 = CanteenAIFunction:GetNearestPoint(arg_8_0, var_8_1)

		arg_8_2 = arg_8_2 or var_8_0 - var_8_2

		Dorm.DormEntityManager.PutEntityLookToDir(arg_8_0, var_8_2, arg_8_2)
	end
}

function var_0_0.RefreshFoodContainer(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.GetEntityType(arg_9_0)
	local var_9_1

	if var_9_0 == DormEnum.ItemType.DinningTable then
		var_9_1 = {
			"gua_food01",
			"gua_food02"
		}
	elseif var_9_0 == DormEnum.ItemType.PassTable then
		var_9_1 = {
			"gua_serve01",
			"gua_serve02",
			"gua_serve03"
		}
	end

	local var_9_2 = var_9_1 and #var_9_1 or 0
	local var_9_3 = var_0_0.GetEntityBB(arg_9_0)

	arg_9_1 = arg_9_1 or var_9_3.foodList

	local var_9_4 = var_9_3.foodList and #var_9_3.foodList or 0

	for iter_9_0 = 1, var_9_4 do
		local var_9_5 = arg_9_1[iter_9_0]

		if iter_9_0 <= var_9_2 then
			Dorm.DormEntityManager.PutEntityAt(var_9_5, arg_9_0, var_9_1[iter_9_0])
			Dorm.DormEntityManager.SetEntityVisible(var_9_5, true)
		else
			Dorm.DormEntityManager.SetEntityVisible(var_9_5, false)
		end
	end
end

local var_0_1 = Dorm.DormEntityManager.IsSameAnimeAction

local function var_0_2(arg_10_0, arg_10_1)
	return arg_10_0 == arg_10_1
end

function var_0_0.PutFoodOnTable(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.GetEntityBB(arg_11_1)

	if var_11_0.foodList == nil then
		var_11_0.foodList = {}
	end

	local var_11_1 = var_11_0.foodList

	table.insert(var_11_1, arg_11_0)

	if CanteenAIFunction:GetCurCanteenMode() == DormEnum.RestaurantMode.RestaurantManual then
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, arg_11_1)
	end
end

function var_0_0.PickFoodFromTable(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.GetEntityBB(arg_12_1)

	if var_12_0.foodList then
		for iter_12_0, iter_12_1 in ipairs(var_12_0.foodList) do
			if iter_12_1 == arg_12_0 then
				Dorm.DormEntityManager.SetEntityVisible(arg_12_0, true)

				return table.remove(var_12_0.foodList, iter_12_0)
			end
		end
	end
end

function var_0_0.IsCustomer(arg_13_0)
	return arg_13_0 == DormEnum.CharacterType.RestaurantNormalCustomer or arg_13_0 == DormEnum.CharacterType.RestaurantSpecialCustomer
end

var_0_0.waitAnime = {}

local function var_0_3(arg_14_0)
	return function(arg_15_0, arg_15_1, arg_15_2)
		return function(arg_16_0, arg_16_1, arg_16_2)
			if arg_15_0 ~= arg_16_0 then
				return false
			end

			if arg_16_1 == "end" and arg_14_0(arg_16_2, arg_15_1) or arg_16_1 == "end_play_once" and arg_14_0(arg_16_2, arg_15_1) or arg_16_1 == "start" and not arg_14_0(arg_16_2, arg_15_1) then
				if arg_15_2 then
					arg_15_2(arg_16_0)
				end

				return true
			end
		end
	end
end

local function var_0_4(arg_17_0)
	return function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		return function(arg_19_0, arg_19_1, arg_19_2)
			if arg_18_0 ~= arg_19_0 then
				return false
			end

			if arg_18_2 and arg_18_2[arg_19_1] then
				arg_18_2[arg_19_1](arg_19_0, arg_19_1)
			end

			if arg_19_1 == "end" and arg_17_0(arg_19_2, arg_18_1) or arg_19_1 == "end_play_once" and arg_17_0(arg_19_2, arg_18_1) or arg_19_1 == "start" and not arg_17_0(arg_19_2, arg_18_1) then
				if arg_18_3 then
					arg_18_3(arg_19_0)
				end

				return true
			end
		end
	end
end

var_0_0.waitAnime.waitAnimeFunc = var_0_3
var_0_0.waitAnime.defaultWaitAnimation = var_0_3(var_0_1)
var_0_0.waitAnime.defaultWaitExactAnimation = var_0_3(var_0_2)
var_0_0.waitAnime.handleEventWaitAnimation = var_0_4(var_0_1)
var_0_0.waitAnime.handleEventWaitExactAnimation = var_0_4(var_0_2)
var_0_0.commonAction = {}

function var_0_0.commonAction.PlaceCarryingItemAction(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_0.GetEntityBB(arg_20_0)
	local var_20_1 = var_20_0.pick

	local function var_20_2()
		var_20_0.pick = nil
	end

	local var_20_3 = {
		release = function()
			Dorm.DormEntityManager.DetachFromEntityCMD(var_20_1)

			if arg_20_2 then
				arg_20_2(var_20_1)
			end
		end
	}
	local var_20_4 = var_0_0.waitAnime.handleEventWaitExactAnimation

	return var_0_0.NewTask(function()
		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_20_0, "serve", "02")
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_20_0, "default")
	end):HandleAnimeLoop(var_20_4(arg_20_0, "serve02", var_20_3, var_20_2))
end

function var_0_0.commonAction.PickItemAction(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = var_0_0.GetEntityBB(arg_24_0)
	local var_24_1 = {
		grab = function()
			Dorm.DormEntityManager.SetEntityVisible(var_24_0.pick, true)
			Dorm.DormEntityManager.AttachToEntityCMD(var_24_0.pick, arg_24_0, "gua_R_hand_bone")
		end
	}
	local var_24_2 = var_0_0.waitAnime.handleEventWaitExactAnimation
	local var_24_3 = var_0_0.NewTask():WaitUntil(function()
		return var_24_0.target ~= nil
	end):Then(function()
		if arg_24_2 then
			arg_24_2(var_24_0.target)
		end

		var_24_0.pick, var_24_0.target = var_24_0.target

		Dorm.DormEntityManager.PlayAnimeDuringInteract(arg_24_0, "serve", "01")
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(arg_24_0, "carry")
	end):HandleAnimeLoop(var_24_2(arg_24_0, "serve01", var_24_1))

	manager.notify:Invoke(DORM_CHARACTER_WAIT_PICK_ITEM, arg_24_0, arg_24_1)

	return var_24_3
end

return var_0_0
