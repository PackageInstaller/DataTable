local var_0_0 = singletonClass("DormCharacterActionExecute")
local InteractUtil = import(".InteractAction.InteractUtil")

function var_0_0:Ctor()
	self.listen = {
		[ON_DORM_CHARACTER_INTERACT] = handler(self, self.Interact),
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.OnInteractFin)
	}
end

var_0_0.GetEntityBB = InteractUtil.GetEntityBB
var_0_0.GetEntityType = InteractUtil.GetEntityType

function var_0_0:Init()
	self:RegisterEvents()
end

function var_0_0:Reset()
	self:RemoveEvents()
end

function var_0_0:RegisterEvents()
	for iter_6_0, iter_6_1 in pairs(self.listen) do
		manager.notify:RegistListener(iter_6_0, iter_6_1)
	end
end

function var_0_0:RemoveEvents()
	for iter_7_0, iter_7_1 in pairs(self.listen) do
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
		entityType = InteractUtil.GetEntityType(arg_9_1),
		targetType = InteractUtil.GetEntityType(arg_9_2),
		entityData = InteractUtil.GetEntityBB(arg_9_1),
		targetData = InteractUtil.GetEntityBB(arg_9_2)
	}
	local CashierInteract

	if var_9_0.entityType == DormEnum.CharacterType.RestaurantCashier then
		CashierInteract = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CashierInteract")
	elseif var_9_0.entityType == DormEnum.CharacterType.RestaurantCook then
		CashierInteract = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CookInteract")
	elseif var_9_0.entityType == DormEnum.CharacterType.RestaurantWaiter then
		CashierInteract = require("game.dorm.canteen.RestaurantCharacter.InteractAction.WaiterInteract")
	elseif InteractUtil.IsCustomer(var_9_0.entityType) then
		CashierInteract = require("game.dorm.canteen.RestaurantCharacter.InteractAction.CustomerInteract")
	end

	if CashierInteract then
		var_9_0.entityData.isDuringInteract = true

		CashierInteract(var_9_0)
	end
end

function var_0_0:FindAllItemGroup(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(arg_10_1), pairs) do
		if self.GetEntityBB(iter_10_1).group == arg_10_2 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

return var_0_0
