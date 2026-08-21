local var_0_0 = class("SpWeaponUpgradeMediator", import("view.base.ContextMediator"))

var_0_0.EQUIPMENT_UPGRADE = "SpWeaponUpgradeMediator:EQUIPMENT_UPGRADE"
var_0_0.EQUIPMENT_COMPOSITE = "SpWeaponUpgradeMediator:EQUIPMENT_COMPOSITE"
var_0_0.OPEN_EQUIPMENT_INDEX = "SpWeaponUpgradeMediator:OPEN_EQUIPMENT_INDEX"
var_0_0.ON_SKILLINFO = "SpWeaponUpgradeMediator:ON_SKILLINFO"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0.viewComponent:setItems((getProxy(BagProxy):getData()))
	arg_1_0.viewComponent:updateRes(getProxy(PlayerProxy):getData())

	local var_1_0 = EquipmentProxy.StaticGetSpWeapon(arg_1_0.contextData.shipId, arg_1_0.contextData.spWeaponUid)

	if arg_1_0.contextData.spWeaponConfigId then
		var_1_0 = SpWeapon.New({
			id = arg_1_0.contextData.spWeaponConfigId
		})
	end

	arg_1_0.viewComponent:SetSpWeapon(var_1_0)
	arg_1_0:UpdateSpWeapons()

	return
end

function var_0_0.UpdateSpWeapons(arg_2_0)
	local var_2_0 = getProxy(BayProxy):GetSpWeaponsInShips()

	for iter_2_0, iter_2_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		table.insert(var_2_0, iter_2_1)
	end

	arg_2_0.viewComponent:SetSpWeaponList(var_2_0)

	return
end

function var_0_0.BindEvent(arg_3_0)
	arg_3_0:bind(var_0_0.EQUIPMENT_UPGRADE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_3_0:sendNotification(GAME.UPGRADE_SPWEAPON, {
			shipId = arg_3_0.contextData.shipId,
			uid = arg_4_1,
			items = arg_4_2,
			consumes = arg_4_3
		})

		return
	end)
	arg_3_0:bind(var_0_0.EQUIPMENT_COMPOSITE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_3_0:sendNotification(GAME.COMPOSITE_SPWEAPON, {
			id = arg_5_1,
			consumeItems = arg_5_2,
			consumeSpweapons = arg_5_3
		})

		return
	end)
	arg_3_0:bind(var_0_0.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		arg_3_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	arg_3_0:bind(var_0_0.ON_SKILLINFO, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_3_0:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SpWeaponSkillInfoLayer,
			data = {
				unlock = arg_7_2,
				skillId = arg_7_1,
				skillOnShip = {
					level = arg_7_3
				}
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		EquipmentProxy.SPWEAPONS_UPDATED,
		GAME.COMPOSITE_SPWEAPON_DONE,
		GAME.UPGRADE_SPWEAPON_DONE,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.COMPOSITE_SPWEAPON_DONE then
		arg_9_0.viewComponent:SetSpWeapon(var_9_1)
		arg_9_0.viewComponent:ClearSelectMaterials()
		arg_9_0.viewComponent:UpdateAll()

		if arg_9_0.contextData.shipId and arg_9_0.contextData.shipId > 0 then
			arg_9_0:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
				spWeaponUid = var_9_1:GetUID(),
				shipId = arg_9_0.contextData.shipId
			})
		end
	elseif var_9_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE then
		arg_9_0.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_9_0 == GAME.UPGRADE_SPWEAPON_DONE then
		arg_9_0.viewComponent:SetSpWeapon(var_9_1)
		arg_9_0.viewComponent:ClearSelectMaterials()
		arg_9_0.viewComponent:UpdateAll()
	elseif var_9_0 == BagProxy.ITEM_UPDATED then
		arg_9_0.viewComponent:setItems(getProxy(BagProxy):getData())
	elseif var_9_0 == PlayerProxy.UPDATED then
		arg_9_0.viewComponent:updateRes(getProxy(PlayerProxy):getData())
	elseif var_9_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		arg_9_0:UpdateSpWeapons()
		arg_9_0.viewComponent:UpdateCraftTargetCount()
	end

	return
end

return var_0_0
