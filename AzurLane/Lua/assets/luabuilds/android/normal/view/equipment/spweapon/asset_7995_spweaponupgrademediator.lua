class = var_0_10000

local var_0_0 = "SpWeaponUpgradeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.EQUIPMENT_UPGRADE = "SpWeaponUpgradeMediator:EQUIPMENT_UPGRADE"
var_0_1.EQUIPMENT_COMPOSITE = "SpWeaponUpgradeMediator:EQUIPMENT_COMPOSITE"
var_0_1.OPEN_EQUIPMENT_INDEX = "SpWeaponUpgradeMediator:OPEN_EQUIPMENT_INDEX"
var_0_1.ON_SKILLINFO = "SpWeaponUpgradeMediator:ON_SKILLINFO"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	BagProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setItems(var_1_3, var_1_2)

	getProxy = var_3
	PlayerProxy = var_1_3

	local var_1_4 = var_3(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_4.updateRes(var_1_5, var_1_4:getData())

	EquipmentProxy = var_4

	local var_1_6 = var_4.StaticGetSpWeapon(arg_1_0.contextData.shipId, arg_1_0.contextData.spWeaponUid)

	if arg_1_0.contextData.spWeaponConfigId then
		SpWeapon = var_5
		var_1_6 = var_5.New({
			id = arg_1_0.contextData.spWeaponConfigId
		})
	end

	local var_1_7 = arg_1_0.viewComponent

	var_5.SetSpWeapon(var_1_7, var_1_6)
	arg_1_0:UpdateSpWeapons()

	return
end

function var_0_1.UpdateSpWeapons(arg_2_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.GetSpWeaponsInShips(var_2_0)

	_ = var_2_0

	local var_2_2 = var_2_0.values

	getProxy = var_1_10003
	EquipmentProxy = var_1_10004

	local var_2_3 = var_1_10003(var_1_10004)
	local var_2_4 = var_2_2(var_3.GetSpWeapons(var_2_3))

	ipairs = var_3

	for iter_2_0, iter_2_1 in var_3(var_2_4) do
		table = var_1_10008

		var_1_10008.insert(var_2_1, iter_2_1)
	end

	local var_2_5 = arg_2_0.viewComponent

	var_3.SetSpWeaponList(var_2_5, var_2_1)

	return
end

function var_0_1.BindEvent(arg_3_0)
	arg_3_0:bind(var_0_1.EQUIPMENT_UPGRADE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_3_0
		local var_4_1 = var_4.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.UPGRADE_SPWEAPON, {
			shipId = arg_3_0.contextData.shipId,
			uid = arg_4_1,
			items = arg_4_2,
			consumes = arg_4_3
		})

		return
	end)
	arg_3_0:bind(var_0_1.EQUIPMENT_COMPOSITE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_3_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.COMPOSITE_SPWEAPON, {
			id = arg_5_1,
			consumeItems = arg_5_2,
			consumeSpweapons = arg_5_3
		})

		return
	end)
	arg_3_0:bind(var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		CustomIndexLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		var_6_3.data = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_3_0:bind(var_0_1.ON_SKILLINFO, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = arg_3_0
		local var_7_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_7_2 = var_2_10006.New
		local var_7_3 = {}

		SkillInfoMediator = var_2_10008
		var_7_3.mediator = var_2_10008
		SpWeaponSkillInfoLayer = var_2_10008
		var_7_3.viewComponent = var_2_10008
		var_7_3.data = {
			unlock = arg_7_2,
			skillId = arg_7_1,
			skillOnShip = {
				level = arg_7_3
			}
		}

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	BagProxy = var_1_10002
	var_8_0[1] = var_1_10002.ITEM_UPDATED
	PlayerProxy = var_2
	var_8_0[2] = var_2.UPDATED
	EquipmentProxy = var_2
	var_8_0[3] = var_2.SPWEAPONS_UPDATED
	GAME = var_2
	var_8_0[4] = var_2.COMPOSITE_SPWEAPON_DONE
	GAME = var_2
	var_8_0[5] = var_2.UPGRADE_SPWEAPON_DONE
	GAME = var_2
	var_8_0[6] = var_2.EQUIP_SPWEAPON_TO_SHIP_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	GAME = var_9_1

	local var_9_7

	if var_9_0 == var_9_1.COMPOSITE_SPWEAPON_DONE then
		local var_9_3 = arg_9_0.viewComponent

		var_9_7.SetSpWeapon(var_9_3, var_9_2)

		local var_9_4 = arg_9_0.viewComponent

		var_9_7.ClearSelectMaterials(var_9_4)

		local var_9_5 = arg_9_0.viewComponent

		var_9_7.UpdateAll(var_9_5)

		if arg_9_0.contextData.shipId and arg_9_0.contextData.shipId > 0 then
			local var_9_6 = arg_9_0

			var_9_7 = arg_9_0.sendNotification
			GAME = var_1_10006

			var_9_7(var_9_6, var_1_10006.EQUIP_SPWEAPON_TO_SHIP, {
				spWeaponUid = var_9_2:GetUID(),
				shipId = arg_9_0.contextData.shipId
			})
		end
	else
		GAME = var_9_7

		local var_9_9

		if var_9_0 == var_9_7.EQUIP_SPWEAPON_TO_SHIP_DONE then
			local var_9_8 = arg_9_0.viewComponent

			var_9_9 = var_9_9.emit
			BaseUI = var_1_10006

			var_9_9(var_9_8, var_1_10006.ON_BACK)
		else
			GAME = var_9_9

			if var_9_0 == var_9_9.UPGRADE_SPWEAPON_DONE then
				local var_9_10 = arg_9_0.viewComponent

				var_4.SetSpWeapon(var_9_10, var_9_2)

				local var_9_11 = arg_9_0.viewComponent

				var_4.ClearSelectMaterials(var_9_11)

				local var_9_12 = arg_9_0.viewComponent

				var_4.UpdateAll(var_9_12)
			else
				BagProxy = var_4

				local var_9_14

				if var_9_0 == var_4.ITEM_UPDATED then
					local var_9_13 = arg_9_0.viewComponent

					var_9_14 = var_9_14.setItems
					getProxy = var_1_10006
					BagProxy = var_1_10007
					var_1_10007 = var_1_10006(var_1_10007)

					var_9_14(var_9_13, var_1_10006.getData(var_1_10007))
				else
					PlayerProxy = var_9_14

					local var_9_16

					if var_9_0 == var_9_14.UPDATED then
						local var_9_15 = arg_9_0.viewComponent

						var_9_16 = var_9_16.updateRes
						getProxy = var_1_10006
						PlayerProxy = var_1_10007

						local var_9_17 = var_1_10006(var_1_10007)

						var_9_16(var_9_15, var_6.getData(var_9_17))
					else
						EquipmentProxy = var_9_16

						if var_9_0 == var_9_16.SPWEAPONS_UPDATED then
							arg_9_0:UpdateSpWeapons()

							local var_9_18 = arg_9_0.viewComponent

							var_4.UpdateCraftTargetCount(var_9_18)
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
