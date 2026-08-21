local var_0_0 = class("SpWeaponStoreHouseMediator", import("view.base.ContextMediator"))

var_0_0.ON_COMPOSITE = "SpWeaponStoreHouseMediator:ON_COMPOSITE"
var_0_0.ON_UNEQUIP = "SpWeaponStoreHouseMediator:ON_UNEQUIP"
var_0_0.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0 = getProxy(BayProxy):getShipById(arg_1_0.contextData.shipId)

	arg_1_0.viewComponent:setShip(var_1_0)

	if var_1_0 and arg_1_0.contextData.mode == StoreHouseConst.EQUIPMENT then
		arg_1_0.contextData.qiutBtn = var_1_0:GetSpWeapon()
	end

	local var_1_1 = {}

	_.each(SpWeapon.bindConfigTable().all, function(arg_2_0)
		local var_2_0 = SpWeapon.New({
			id = arg_2_0
		})

		if var_2_0:IsCraftable() and (not var_1_0 or not var_1_0:IsSpWeaponForbidden(var_2_0)) then
			table.insert(var_1_1, var_2_0)
		end

		return
	end)
	arg_1_0.viewComponent:SetCraftList(var_1_1)
	arg_1_0:UpdateSpWeapons()
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.UpdateSpWeapons(arg_3_0)
	local var_3_0 = getProxy(BayProxy):RawGetShipById(arg_3_0.contextData.shipId)
	local var_3_1 = getProxy(BayProxy):GetSpWeaponsInShips(var_3_0)

	for iter_3_0, iter_3_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		if not var_3_0 or not var_3_0:IsSpWeaponForbidden(iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		end
	end

	arg_3_0.viewComponent:setEquipments(var_3_1)

	return
end

function var_0_0.BindEvent(arg_4_0)
	arg_4_0:bind(var_0_0.ON_UNEQUIP, function(arg_5_0)
		arg_4_0:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
			shipId = arg_4_0.contextData.shipId
		})

		return
	end)
	arg_4_0:bind(var_0_0.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		arg_4_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	arg_4_0:bind(var_0_0.ON_COMPOSITE, function(arg_7_0, arg_7_1)
		arg_4_0:addSubLayers(Context.New({
			mediator = SpWeaponUpgradeMediator,
			viewComponent = SpWeaponUpgradeLayer,
			data = {
				spWeaponConfigId = arg_7_1,
				shipId = arg_4_0.contextData.shipId
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		PlayerProxy.UPDATED,
		BayProxy.SHIP_UPDATED,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE,
		EquipmentProxy.SPWEAPONS_UPDATED
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == BayProxy.SHIP_UPDATED then
		if var_9_1.id == arg_9_0.contextData.shipId then
			arg_9_0.viewComponent:setShip(var_9_1)
		end
	elseif var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE then
		arg_9_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_9_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		arg_9_0:UpdateSpWeapons()
		arg_9_0.viewComponent:setEquipmentUpdate()
	end

	return
end

return var_0_0
