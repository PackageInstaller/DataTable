local var_0_0 = singletonClass("DormCharacterActionExecute")
local var_0_1 = import(".InteractAction.InteractUtil")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listen = {
		[ON_DORM_CHARACTER_INTERACT] = handler(arg_1_0, arg_1_0.Interact),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(arg_1_0, arg_1_0.OnInteractFin)
	}
end

local var_0_2 = {
	NewTask = function(arg_2_0, arg_2_1)
		return DormCharacterActionManager.taskRunner:NewTask():Then(arg_2_0)
	end,
	NewTimer = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		return DormCharacterActionManager.taskRunner:NewTimer(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	end
}

var_0_0.GetEntityBB = var_0_1.GetEntityBB
var_0_0.GetEntityType = var_0_1.GetEntityType

function var_0_0.Init(arg_4_0)
	arg_4_0:RegisterEvents()
end

function var_0_0.Reset(arg_5_0)
	arg_5_0:RemoveEvents()
end

function var_0_0.RegisterEvents(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.listen) do
		manager.notify:RegistListener(iter_6_0, iter_6_1)
	end
end

function var_0_0.RemoveEvents(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.listen) do
		manager.notify:RemoveListener(iter_7_0, iter_7_1)
	end
end

function var_0_0.OnInteractFin(arg_8_0, arg_8_1)
	DormUtils.GetEntityData(arg_8_1).isDuringInteract = false
end

function var_0_0.Interact(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {
		entityID = arg_9_1,
		targetID = arg_9_2,
		finish = arg_9_3,
		entityType = var_0_1.GetEntityType(arg_9_1),
		targetType = var_0_1.GetEntityType(arg_9_2),
		entityData = var_0_1.GetEntityBB(arg_9_1),
		targetData = var_0_1.GetEntityBB(arg_9_2)
	}
	local var_9_1 = var_9_0.entityType
	local var_9_2

	if var_9_1 == DormEnum.CharacterType.RestaurantCashier then
		var_9_2 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CashierInteract")
	elseif var_9_1 == DormEnum.CharacterType.RestaurantCook then
		var_9_2 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CookInteract")
	elseif var_9_1 == DormEnum.CharacterType.RestaurantWaiter then
		var_9_2 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.WaiterInteract")
	elseif var_0_1.IsCustomer(var_9_1) then
		var_9_2 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CustomerInteract")
	end

	if var_9_2 then
		var_9_0.entityData.isDuringInteract = true

		var_9_2(var_9_0)
	end
end

function var_0_0.FindAllItemGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = CanteenItemManager.ItemEIdNamespace(arg_10_1)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in Dorm.storage:ForeachData(var_10_0, pairs) do
		if arg_10_0.GetEntityBB(iter_10_1).group == arg_10_2 then
			table.insert(var_10_1, iter_10_1)
		end
	end

	return var_10_1
end

local function var_0_3(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		iter_11_1.statue = DormEnum.FoodState.HasServer
	end
end

return var_0_0
