local var_0_0 = class("WorldInventoryMediator", import("..base.ContextMediator"))

var_0_0.OnUseItem = "WorldInventoryMediator.OnUseItem"
var_0_0.OnMap = "WorldInventoryMediator.OnMap"
var_0_0.OnOpenAllocateLayer = "WorldInventoryMediator.OnOpenAllocateLayer"
var_0_0.OPEN_MODULEINFO_LAYER = "WorldInventoryMediator:OPEN_MODULEINFO_LAYER"
var_0_0.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnUseItem, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.WORLD_ITEM_USE, {
			itemID = arg_2_1,
			count = arg_2_2 or 1,
			args = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnMap, function(arg_3_0, arg_3_1)
		local var_3_0 = nowWorld():FindTreasureEntrance(arg_3_1)
		local var_3_1

		for iter_3_0, iter_3_1 in ipairs(var_3_0.config.teasure_chapter) do
			if arg_3_1 == iter_3_1[1] then
				var_3_1 = iter_3_1[2]

				break
			end
		end

		arg_1_0:sendNotification(var_0_0.OnMap, {
			entrance = var_3_0,
			mapId = var_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnOpenAllocateLayer, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = WorldAllocateMediator,
			viewComponent = WorldAllocateLayer,
			data = arg_4_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_MODULEINFO_LAYER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)

	local var_1_0 = nowWorld()

	arg_1_0.viewComponent:setInventoryProxy(var_1_0:GetInventoryProxy())
	arg_1_0.viewComponent:setWorldFleet(var_1_0:GetFleets())

	local var_1_1 = getProxy(EquipmentProxy):getEquipments(true)

	for iter_1_0, iter_1_1 in ipairs(getProxy(BayProxy):getEquipsInShips()) do
		table.insert(var_1_1, iter_1_1)
	end

	arg_1_0.viewComponent:setEquipments(var_1_1)
	arg_1_0.viewComponent:SetMaterials((getProxy(BagProxy):GetItemsByCondition({
		is_world = 1
	})))

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.USE_ITEM_DONE,
		GAME.DESTROY_EQUIPMENTS_DONE,
		BagProxy.ITEM_UPDATED,
		var_0_0.BATCHDESTROY_MODE,
		GAME.REVERT_EQUIPMENT_DONE,
		GAME.FRAG_SELL_DONE,
		GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		arg_8_0.viewComponent:setEquipment(var_8_1)
	elseif var_8_0 == GAME.USE_ITEM_DONE then
		if #var_8_1.drops ~= 0 then
			arg_8_0.viewComponent:emit(BaseUI.ON_AWARD, {
				animation = true,
				items = var_8_1.drops
			})
		end
	elseif var_8_0 == GAME.FRAG_SELL_DONE then
		arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
	elseif var_8_0 == GAME.DESTROY_EQUIPMENTS_DONE then
		if table.getCount(var_8_1) ~= 0 then
			arg_8_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_8_1
			})
		end
	elseif var_8_0 == BagProxy.ITEM_UPDATED then
		if arg_8_0.canUpdate then
			arg_8_0.viewComponent:SetMaterials((getProxy(BagProxy):GetItemsByCondition({
				is_world = 1
			})))
		end
	elseif var_8_0 == GAME.REVERT_EQUIPMENT_DONE then
		if table.getCount(var_8_1.awards) > 0 then
			arg_8_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_8_1.awards
			})
		end
	elseif var_8_0 == GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED then
		arg_8_0:getViewComponent():Scroll2Equip(var_8_1.newEquip)
	end

	return
end

return var_0_0
