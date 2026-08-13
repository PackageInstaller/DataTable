class = var_0_10000

local var_0_0 = "SpWeaponStoreHouseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_COMPOSITE = "SpWeaponStoreHouseMediator:ON_COMPOSITE"
var_0_1.ON_UNEQUIP = "SpWeaponStoreHouseMediator:ON_UNEQUIP"
var_0_1.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	BayProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getShipById(var_1_1, arg_1_0.contextData.shipId)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setShip(var_1_3, var_1_2)

	local var_1_6

	if var_1_2 then
		local var_1_4 = arg_1_0.contextData.mode

		StoreHouseConst = var_1_3

		if var_1_4 == var_1_3.EQUIPMENT then
			local var_1_5 = arg_1_0.contextData

			var_1_6 = var_1_2
			var_1_5.qiutBtn = var_1_2.GetSpWeapon(var_1_6)
		end
	end

	local var_1_7 = {}

	_ = var_1_3

	local var_1_8 = var_1_3.each

	SpWeapon = var_1_6

	var_1_8(var_1_6.bindConfigTable().all, function(arg_2_0)
		SpWeapon = var_2_10001

		local var_2_0 = var_2_10001.New({
			id = arg_2_0
		})

		if var_1.IsCraftable(var_2_0) then
			if var_1_2 then
				local var_2_1 = var_1_2

				if not var_2.IsSpWeaponForbidden(var_2_1, var_1) then
					table = var_2

					var_2.insert(var_1_7, var_1)
				end

				return
			end
		end
	end)

	local var_1_9 = arg_1_0.viewComponent

	var_4.SetCraftList(var_1_9, var_1_7)

	local var_1_10 = arg_1_0

	arg_1_0.UpdateSpWeapons(var_1_10)

	getProxy = var_4
	PlayerProxy = var_1_10

	local var_1_11 = var_4(var_1_10)
	local var_1_12 = var_4.getData(var_1_11)
	local var_1_13 = arg_1_0.viewComponent

	var_5.setPlayer(var_1_13, var_1_12)

	return
end

function var_0_1.UpdateSpWeapons(arg_3_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.RawGetShipById(var_3_0, arg_3_0.contextData.shipId)

	getProxy = var_3_0
	BayProxy = var_3

	local var_3_2 = var_3_0(var_3)
	local var_3_3 = var_2.GetSpWeaponsInShips(var_3_2, var_3_1)

	_ = var_3_2

	local var_3_4 = var_3_2.values

	getProxy = var_4
	EquipmentProxy = var_1_10005

	local var_3_5 = var_4(var_1_10005)
	local var_3_6 = var_3_4(var_4.GetSpWeapons(var_3_5))

	ipairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_3_6) do
		if not var_3_1 or not var_3_1:IsSpWeaponForbidden(iter_3_1) then
			table = var_1_10009

			var_1_10009.insert(var_3_3, iter_3_1)
		end
	end

	local var_3_7 = arg_3_0.viewComponent

	var_4.setEquipments(var_3_7, var_3_3)

	return
end

function var_0_1.BindEvent(arg_4_0)
	arg_4_0:bind(var_0_1.ON_UNEQUIP, function(arg_5_0)
		local var_5_0 = arg_4_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.EQUIP_SPWEAPON_TO_SHIP, {
			shipId = arg_4_0.contextData.shipId
		})

		return
	end)
	arg_4_0:bind(var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0
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
	arg_4_0:bind(var_0_1.ON_COMPOSITE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		SpWeaponUpgradeMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		SpWeaponUpgradeLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		var_7_3.data = {
			spWeaponConfigId = arg_7_1,
			shipId = arg_4_0.contextData.shipId
		}

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	PlayerProxy = var_1_10002
	var_8_0[1] = var_1_10002.UPDATED
	BayProxy = var_2
	var_8_0[2] = var_2.SHIP_UPDATED
	GAME = var_2
	var_8_0[3] = var_2.EQUIP_SPWEAPON_TO_SHIP_DONE
	EquipmentProxy = var_2
	var_8_0[4] = var_2.SPWEAPONS_UPDATED

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	BayProxy = var_9_1

	if var_9_0 == var_9_1.SHIP_UPDATED then
		if var_9_2.id == arg_9_0.contextData.shipId then
			local var_9_3 = arg_9_0.viewComponent

			var_4.setShip(var_9_3, var_9_2)
		end
	else
		PlayerProxy = var_4

		if var_9_0 == var_4.UPDATED then
			local var_9_4 = arg_9_0.viewComponent

			var_4.setPlayer(var_9_4, var_9_2)
		else
			GAME = var_4

			local var_9_6

			if var_9_0 == var_4.EQUIP_SPWEAPON_TO_SHIP_DONE then
				local var_9_5 = arg_9_0.viewComponent

				var_9_6 = var_9_6.emit
				BaseUI = var_1_10006

				var_9_6(var_9_5, var_1_10006.ON_BACK)
			else
				EquipmentProxy = var_9_6

				if var_9_0 == var_9_6.SPWEAPONS_UPDATED then
					arg_9_0:UpdateSpWeapons()

					local var_9_7 = arg_9_0.viewComponent

					var_4.setEquipmentUpdate(var_9_7)
				end
			end
		end
	end

	return
end

return var_0_1
