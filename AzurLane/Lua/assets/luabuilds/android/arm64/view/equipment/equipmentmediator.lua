local var_0_0 = class("EquipmentMediator", import("..base.ContextMediator"))

var_0_0.ON_DESTROY = "EquipmentMediator:ON_DESTROY"
var_0_0.ON_UNEQUIP_EQUIPMENT = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT"
var_0_0.OPEN_DESIGN = "EquipmentMediator:OPEN_DESIGN"
var_0_0.CLOSE_DESIGN_LAYER = "EquipmentMediator:CLOSE_DESIGN_LAYER"
var_0_0.OPEN_SPWEAPON_DESIGN = "EquipmentMediator:OPEN_SPWEAPON_DESIGN"
var_0_0.CLOSE_SPWEAPON_DESIGN_LAYER = "EquipmentMediator:CLOSE_SPWEAPON_DESIGN_LAYER"
var_0_0.BATCHDESTROY_MODE = "EquipmentMediator:BATCHDESTROY_MODE"
var_0_0.SWITCH_TO_SPWEAPON_PAGE = "EquipmentMediator:SWITCH_TO_SPWEAPON_PAGE"
var_0_0.ON_EQUIPMENT_SKIN_INFO = "EquipmentMediator:ON_EQUIPMENT_SKIN_INFO"
var_0_0.ON_UNEQUIP_EQUIPMENT_SKIN = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT_SKIN"
var_0_0.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"
var_0_0.NO_UPDATE = "EquipmentMediator:NO_UPDATE"
var_0_0.ITEM_GO_SCENE = "item go scene"
var_0_0.ITEM_ADD_LAYER = "EquipmentMediator.ITEM_ADD_LAYER"
var_0_0.OPEN_EQUIPSKIN_INDEX_LAYER = "EquipmentMediator:OPEN_EQUIPSKIN_INDEX_LAYER"
var_0_0.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"
var_0_0.DESIGN_FILTER_CHANGED = "EquipmentMediator:DESIGN_FILTER_CHANGED"

function var_0_0.register(arg_1_0)
	arg_1_0.contextData.warp = arg_1_0.contextData.warp or getProxy(SettingsProxy):getEquipSceneIndex()

	arg_1_0:bind(var_0_0.DESIGN_FILTER_CHANGED, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TOGGLE_ALL_DESIGN_EQUIPMENT, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ITEM_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.ITEM_ADD_LAYER, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_USE_ITEM, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_1_0:sendNotification(GAME.USE_ITEM, {
			id = arg_5_1,
			count = arg_5_2,
			arg = arg_5_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DESTROY, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNEQUIP_EQUIPMENT, function(arg_7_0)
		arg_1_0.canUpdate = false

		arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_DESIGN, function(arg_8_0)
		if getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator) then
			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = EquipmentDesignLayer,
			mediator = EquipmentDesignMediator,
			data = {
				groupName = arg_1_0.viewComponent:getGroupName(),
				isShowAllDesign = arg_1_0.viewComponent.isShowAllDesign
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_DESIGN_LAYER, function(arg_9_0)
		local var_9_0 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator)

		if var_9_0 then
			arg_1_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_9_0
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SPWEAPON_DESIGN, function(arg_10_0)
		if getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponDesignMediator) then
			return
		end

		arg_1_0:addSubLayers(Context.New({
			viewComponent = SpWeaponDesignLayer,
			mediator = SpWeaponDesignMediator,
			data = {
				groupName = arg_1_0.viewComponent:getGroupName()
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_SPWEAPON_DESIGN_LAYER, function(arg_11_0)
		local var_11_0 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponDesignMediator)

		if var_11_0 then
			arg_1_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_11_0
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_EQUIPMENT_SKIN_INFO, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_1_0
		local var_12_3 = {
			mediator = EquipmentSkinMediator,
			viewComponent = EquipmentSkinLayer
		}
		local var_12_4 = {
			skinId = arg_12_1,
			shipId = arg_1_0.contextData.shipId
		}

		if arg_1_0.contextData.shipId then
			var_12_4.mode = EquipmentSkinLayer.REPLACE or EquipmentSkinLayer.DISPLAY
			var_12_4.oldShipInfo = arg_12_3
			var_12_4.pos = arg_12_2
			var_12_3.data = var_12_4

			var_12_1(var_12_0, var_12_2(var_12_3))

			return
		end
	end)
	arg_1_0:bind(var_0_0.ON_UNEQUIP_EQUIPMENT_SKIN, function(arg_13_0)
		arg_1_0.canUpdate = false

		arg_1_0:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIPSKIN_INDEX_LAYER, function(arg_14_0, arg_14_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = IndexMediator,
			viewComponent = IndexLayer,
			data = arg_14_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIPMENT_INDEX, function(arg_15_0, arg_15_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_15_1
		}))

		return
	end)

	arg_1_0.canUpdate = true

	local var_1_0 = getProxy(BayProxy)
	local var_1_1 = var_1_0:getShipById(arg_1_0.contextData.shipId)

	arg_1_0.viewComponent:setShip(var_1_1)

	if var_1_1 then
		if arg_1_0.contextData.mode == StoreHouseConst.EQUIPMENT then
			arg_1_0.contextData.qiutBtn = defaultValue(var_1_1:getEquip(arg_1_0.contextData.pos), nil)
		elseif arg_1_0.contextData.mode == StoreHouseConst.SKIN then
			arg_1_0.contextData.qiutBtn = var_1_1:getEquipSkin(arg_1_0.contextData.pos) ~= 0
		end
	end

	arg_1_0.equipmentProxy = getProxy(EquipmentProxy)

	local var_1_2

	if arg_1_0.contextData.equipmentVOs then
		var_1_2 = arg_1_0.contextData.equipmentVOs
	else
		var_1_2 = arg_1_0.equipmentProxy:getEquipments(true)

		for iter_1_0, iter_1_1 in ipairs(var_1_0:getEquipsInShips()) do
			table.insert(var_1_2, iter_1_1)
		end

		for iter_1_2, iter_1_3 in pairs(arg_1_0.equipmentProxy:getEquipmentSkins()) do
			table.insert(var_1_2, {
				isSkin = true,
				id = iter_1_3.id,
				count = iter_1_3.count
			})
		end

		for iter_1_4, iter_1_5 in pairs(var_1_0:getEquipmentSkinInShips()) do
			table.insert(var_1_2, {
				isSkin = true,
				count = 1,
				id = iter_1_5.id,
				shipId = iter_1_5.shipId,
				shipPos = iter_1_5.shipPos
			})
		end
	end

	arg_1_0.viewComponent:setEquipments(var_1_2)
	arg_1_0.viewComponent:setCapacity(arg_1_0.equipmentProxy:getCapacity())
	arg_1_0:UpdateSpWeapons()
	arg_1_0.viewComponent:setItems((getProxy(BagProxy):getItemsByExclude()))
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.UpdateSpWeapons(arg_16_0)
	local var_16_0 = getProxy(BayProxy):RawGetShipById(arg_16_0.contextData.shipId)
	local var_16_1 = getProxy(BayProxy):GetSpWeaponsInShips(var_16_0)

	for iter_16_0, iter_16_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		if not var_16_0 or not var_16_0:IsSpWeaponForbidden(iter_16_1) then
			table.insert(var_16_1, iter_16_1)
		end
	end

	arg_16_0.viewComponent:SetSpWeapons(var_16_1)

	return
end

function var_0_0.listNotificationInterests(arg_17_0)
	return {
		EquipmentProxy.EQUIPMENT_UPDATED,
		BayProxy.SHIP_EQUIPMENT_ADDED,
		BayProxy.SHIP_EQUIPMENT_REMOVED,
		BayProxy.SHIP_UPDATED,
		PlayerProxy.UPDATED,
		GAME.USE_ITEM_DONE,
		GAME.DESTROY_EQUIPMENTS_DONE,
		BagProxy.ITEM_UPDATED,
		var_0_0.BATCHDESTROY_MODE,
		var_0_0.SWITCH_TO_SPWEAPON_PAGE,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.REVERT_EQUIPMENT_DONE,
		EquipmentProxy.EQUIPMENT_SKIN_UPDATED,
		GAME.UNEQUIP_FROM_SHIP_DONE,
		GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE,
		GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE,
		var_0_0.NO_UPDATE,
		GAME.FRAG_SELL_DONE,
		GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED,
		EquipmentProxy.SPWEAPONS_UPDATED,
		GAME.LOVE_ITEM_MAIL_REPAIR_DONE,
		GAME.SELL_ITEM_DONE
	}
end

function var_0_0.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		arg_18_0.viewComponent:setCapacity(arg_18_0.equipmentProxy:getCapacity())
		arg_18_0.viewComponent:setEquipment(var_18_1)

		if arg_18_0.canUpdate then
			arg_18_0.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_EQUIPMENT_ADDED then
		arg_18_0.viewComponent:addShipEquipment(var_18_1)

		if arg_18_0.canUpdate then
			arg_18_0.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_EQUIPMENT_REMOVED then
		arg_18_0.viewComponent:removeShipEquipment(var_18_1)

		if arg_18_0.canUpdate then
			arg_18_0.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == EquipmentProxy.EQUIPMENT_SKIN_UPDATED then
		arg_18_0.viewComponent:setCapacity(arg_18_0.equipmentProxy:getCapacity())
		arg_18_0.viewComponent:setEquipmentSkin(var_18_1)

		if arg_18_0.canUpdate then
			arg_18_0.viewComponent:setEquipmentSkinUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_UPDATED then
		if var_18_1.id == arg_18_0.contextData.shipId then
			arg_18_0.viewComponent:setShip(var_18_1)
		end
	elseif var_18_0 == PlayerProxy.UPDATED then
		arg_18_0.viewComponent:setPlayer(var_18_1)
	elseif var_18_0 == GAME.USE_ITEM_DONE then
		if #var_18_1.drops > 0 then
			arg_18_0.viewComponent:emit(BaseUI.ON_WORLD_ACHIEVE, {
				animation = true,
				items = var_18_1.drops,
				removeFunc = function()
					if var_18_1.isEquipBox then
						arg_18_0:addSubLayers(Context.New({
							viewComponent = ResolveEquipmentLayer,
							mediator = ResolveEquipmentMediator,
							data = {
								Equipments = underscore.map(var_18_1.drops, function(arg_20_0)
									return Equipment.New({
										id = arg_20_0.id,
										count = arg_20_0.count
									})
								end)
							}
						}))
					end

					return
				end
			})
		end
	elseif var_18_0 == GAME.FRAG_SELL_DONE then
		arg_18_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_18_1.awards)
	elseif var_18_0 == GAME.DESTROY_EQUIPMENTS_DONE then
		arg_18_0.canUpdate = true

		arg_18_0.viewComponent:setEquipmentUpdate()

		if #var_18_1 > 0 then
			arg_18_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1
			})
		end
	elseif var_18_0 == BagProxy.ITEM_UPDATED then
		if arg_18_0.canUpdate then
			arg_18_0.viewComponent:setItems((getProxy(BagProxy):getItemsByExclude()))
		end
	elseif var_18_0 == var_0_0.BATCHDESTROY_MODE then
		arg_18_0.viewComponent:SwitchToDestroy()
	elseif var_18_0 == var_0_0.SWITCH_TO_SPWEAPON_PAGE then
		arg_18_0.viewComponent:SwitchToSpWeaponStoreHouse()
	elseif var_18_0 == GAME.REVERT_EQUIPMENT_DONE then
		if #var_18_1.awards > 0 then
			arg_18_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1.awards
			})
		end
	elseif var_18_0 == GAME.EQUIP_TO_SHIP_DONE or var_18_0 == GAME.UNEQUIP_FROM_SHIP_DONE then
		arg_18_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_18_0 == GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE or var_18_0 == GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE then
		arg_18_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_18_0 == var_0_0.NO_UPDATE then
		arg_18_0.canUpdate = false
	elseif var_18_0 == GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED then
		arg_18_0:getViewComponent():Scroll2Equip(var_18_1.newEquip)
	elseif var_18_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		arg_18_0:UpdateSpWeapons()
		arg_18_0.viewComponent:SetSpWeaponUpdate()
	elseif var_18_0 == GAME.LOVE_ITEM_MAIL_REPAIR_DONE then
		if #var_18_1.awards > 0 then
			arg_18_0.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1.awards
			})
		end
	elseif var_18_0 == GAME.SELL_ITEM_DONE then
		arg_18_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_18_1.awards)
	end

	return
end

function var_0_0.remove(arg_21_0)
	getProxy(SettingsProxy):setEquipSceneIndex(arg_21_0.contextData.warp)

	return
end

return var_0_0
