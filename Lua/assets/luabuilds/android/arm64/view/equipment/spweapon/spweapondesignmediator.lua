local var_0_0 = class("SpWeaponDesignMediator", import("view.base.ContextMediator"))

var_0_0.ON_COMPOSITE = "SpWeaponDesignMediator:ON_COMPOSITE"
var_0_0.OPEN_EQUIPMENTDESIGN_INDEX = "SpWeaponDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0.viewComponent:setItems(getProxy(BagProxy):getRawData())

	local var_1_0 = getProxy(EquipmentProxy)
	local var_1_1 = {}

	_.each(SpWeapon.bindConfigTable().all, function(arg_2_0)
		local var_2_0 = SpWeapon.New({
			id = arg_2_0
		})

		if var_2_0:IsCraftable() then
			table.insert(var_1_1, var_2_0)
		end

		return
	end)
	arg_1_0.viewComponent:SetCraftList({})
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	local var_1_2 = arg_1_0:getFacade():retrieveMediator(EquipmentMediator.__cname):getViewComponent()

	arg_1_0.viewComponent:SetParentTF(var_1_2._tf)
	arg_1_0.viewComponent:SetTopContainer(var_1_2.topPanel)
	arg_1_0.viewComponent:SetTopItems(var_1_2.topItems)
	arg_1_0:UpdateSpWeapons()

	return
end

function var_0_0.BindEvent(arg_3_0)
	arg_3_0:bind(var_0_0.ON_COMPOSITE, function(arg_4_0, arg_4_1)
		arg_3_0:addSubLayers(Context.New({
			mediator = SpWeaponUpgradeMediator,
			viewComponent = SpWeaponUpgradeLayer,
			data = {
				spWeaponConfigId = arg_4_1
			}
		}))

		return
	end)
	arg_3_0:bind(var_0_0.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_5_0, arg_5_1)
		arg_3_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_5_1
		}))

		return
	end)

	return
end

function var_0_0.UpdateSpWeapons(arg_6_0)
	local var_6_0 = getProxy(BayProxy):GetSpWeaponsInShips()

	for iter_6_0, iter_6_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		table.insert(var_6_0, iter_6_1)
	end

	arg_6_0.viewComponent:SetSpWeapons(var_6_0)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		GAME.COMPOSITE_SPWEAPON_DONE,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE,
		EquipmentProxy.SPWEAPONS_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == BagProxy.ITEM_UPDATED then
		arg_8_0.viewComponent:setItems(getProxy(BagProxy):getRawData())
	elseif var_8_0 == PlayerProxy.UPDATED then
		arg_8_0.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	elseif var_8_0 == GAME.COMPOSITE_SPWEAPON_DONE then
		local var_8_2 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponUpgradeMediator)

		if var_8_2 then
			arg_8_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_8_2
			})
		end
	elseif var_8_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE or var_8_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		arg_8_0:UpdateSpWeapons()
		arg_8_0.viewComponent:filter()
	end

	return
end

return var_0_0
