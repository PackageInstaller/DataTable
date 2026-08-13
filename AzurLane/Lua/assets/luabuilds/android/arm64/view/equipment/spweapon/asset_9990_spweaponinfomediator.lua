class = var_0_10000

local var_0_0 = "SpWeaponInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_DESTROY = "SpWeaponInfoMediator:ON_DESTROY"
var_0_1.ON_EQUIP = "SpWeaponInfoMediator:ON_EQUIP"
var_0_1.ON_INTENSIFY = "SpWeaponInfoMediator.ON_INTENSIFY"
var_0_1.ON_CHANGE = "SpWeaponInfoMediator.ON_CHANGE"
var_0_1.ON_UNEQUIP = "SpWeaponInfoMediator:ON_UNEQUIP"
var_0_1.ON_MOVE = "SpWeaponInfoMediator:ON_MOVE"
var_0_1.ON_MODIFY = "SpWeaponInfoMediator:ON_MODIFY"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ContextProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getCurrentContext(var_1_1).scene

	SCENE = var_1_1

	if var_1_2 == var_1_1.SPWEAPON_STOREHOUSE then
		var_1_2 = arg_1_0.viewComponent
		var_1_2.fromEquipmentView = true
	end

	getProxy = var_1_2
	BayProxy = var_1_10005

	local var_1_3 = var_1_2(var_1_10005)
	local var_1_4 = var_3.getShipById(var_1_3)

	unpack = var_1_10005

	if arg_1_0.contextData.shipVO then
		local var_1_5 = {}
		local var_1_6 = arg_1_0.contextData.shipVO

		var_1_5[1] = var_1_10008.GetSpWeapon(var_1_6)
		var_1_5[2] = arg_1_0.contextData.shipVO

		if not var_1_5 then
			var_1_5 = {}
			EquipmentProxy = var_1_10008
			var_1_5[1] = var_1_10008.StaticGetSpWeapon(arg_1_0.contextData.shipId, arg_1_0.contextData.spWeaponUid)
		end

		local var_1_7, var_1_8 = var_1_10005(var_1_5)

		if arg_1_0.contextData.spWeaponConfigId then
			SpWeapon = var_7
			var_1_7 = var_7.New({
				id = arg_1_0.contextData.spWeaponConfigId
			})
		end

		EquipmentProxy = var_7

		local var_1_9, var_1_10 = var_7.StaticGetSpWeapon(arg_1_0.contextData.oldShipId, arg_1_0.contextData.oldSpWeaponUid)
		local var_1_11 = arg_1_0.viewComponent

		var_9.setShip(var_1_11, var_1_8, var_1_10)

		local var_1_12 = arg_1_0.viewComponent

		var_9.setEquipment(var_1_12, var_1_7, var_1_9)

		getProxy = var_9
		PlayerProxy = var_1_12

		local var_1_13 = var_9(var_1_12)
		local var_1_14 = var_9.getData(var_1_13)
		local var_1_15 = arg_1_0.viewComponent

		var_11.setPlayer(var_1_15, var_1_14)

		return
	end
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_EQUIP, function(arg_3_0)
		if arg_2_0.contextData.oldShipId then
			local var_3_0 = arg_2_0
			local var_3_1 = var_1.sendNotification

			GAME = var_2_10004

			var_3_1(var_3_0, var_2_10004.EQUIP_SPWEAPON_FROM_SHIP, {
				spWeaponUid = arg_2_0.contextData.oldSpWeaponUid,
				oldShipId = arg_2_0.contextData.oldShipId,
				shipId = arg_2_0.contextData.shipId
			})
		else
			local var_3_2 = arg_2_0
			local var_3_3 = var_1.sendNotification

			GAME = var_2_10004

			var_3_3(var_3_2, var_2_10004.EQUIP_SPWEAPON_TO_SHIP, {
				spWeaponUid = arg_2_0.contextData.oldSpWeaponUid,
				shipId = arg_2_0.contextData.shipId
			})
		end

		return
	end)
	arg_2_0:bind(var_0_1.ON_UNEQUIP, function(arg_4_0)
		local var_4_0 = arg_2_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.EQUIP_SPWEAPON_TO_SHIP, {
			shipId = arg_2_0.contextData.shipId
		})

		local var_4_2 = arg_2_0.viewComponent
		local var_4_3 = var_1.emit

		BaseUI = var_4

		var_4_3(var_4_2, var_4.ON_CLOSE)

		return
	end)
	arg_2_0:bind(var_0_1.ON_MODIFY, function(arg_5_0)
		local var_5_0 = arg_2_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		SpWeaponModifyMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		SpWeaponModifyLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007
		var_5_3.data = {
			spWeaponUid = arg_2_0.contextData.spWeaponUid,
			shipId = arg_2_0.contextData.shipId
		}

		var_5_1(var_5_0, var_5_2(var_5_3), true)

		local var_5_4 = arg_2_0.viewComponent
		local var_5_5 = var_1.emit

		BaseUI = var_4

		var_5_5(var_5_4, var_4.ON_CLOSE)

		return
	end)
	arg_2_0:bind(var_0_1.ON_INTENSIFY, function(arg_6_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)

		if var_1.getShipById(var_6_0, arg_2_0.contextData.shipId) then
			ShipStatus = var_2_10003

			local var_6_1, var_6_2 = var_2_10003.ShipStatusCheck("onModify", var_2)

			if not var_6_1 then
				pg = var_5

				local var_6_3 = var_5.TipsMgr.GetInstance()

				var_5.ShowTips(var_6_3, var_6_2)

				return
			end
		end

		local var_6_4 = arg_2_0
		local var_6_5 = var_3.addSubLayers

		Context = var_2_10006

		local var_6_6 = var_2_10006.New
		local var_6_7 = {}

		SpWeaponUpgradeMediator = var_2_10009
		var_6_7.mediator = var_2_10009
		SpWeaponUpgradeLayer = var_2_10009
		var_6_7.viewComponent = var_2_10009
		var_6_7.data = {
			spWeaponUid = arg_2_0.contextData.spWeaponUid,
			shipId = arg_2_0.contextData.shipId
		}

		var_6_5(var_6_4, var_6_6(var_6_7), true, function()
			local var_7_0 = arg_2_0.viewComponent
			local var_7_1 = var_0.emit

			BaseUI = var_3_10003

			var_7_1(var_7_0, var_3_10003.ON_CLOSE)

			return
		end)

		return
	end)
	arg_2_0:bind(var_0_1.ON_CHANGE, function(arg_8_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_8_0 = var_2_10001(var_2_10003)
		local var_8_1 = var_1.getShipById(var_8_0, arg_2_0.contextData.shipId)

		ShipStatus = var_2_10003

		local var_8_2, var_8_3 = var_2_10003.ShipStatusCheck("onModify", var_8_1)

		if not var_8_2 then
			pg = var_5

			local var_8_4 = var_5.TipsMgr.GetInstance()

			var_5.ShowTips(var_8_4, var_8_3)

			return
		end

		local var_8_5 = arg_2_0.viewComponent
		local var_8_6 = var_5.emit

		BaseUI = var_2_10008

		var_8_6(var_8_5, var_2_10008.ON_CLOSE)

		local var_8_7 = arg_2_0
		local var_8_8 = var_5.sendNotification

		GAME = var_8

		local var_8_9 = var_8.GO_SCENE

		SCENE = var_2_10009

		local var_8_10 = var_2_10009.SPWEAPON_STOREHOUSE
		local var_8_11 = {
			lock = true,
			shipId = arg_2_0.contextData.shipId
		}

		StoreHouseConst = var_11
		var_8_11.warp = var_11.WARP_TO_WEAPON
		StoreHouseConst = var_11
		var_8_11.mode = var_11.EQUIPMENT

		var_8_8(var_8_7, var_8_9, var_8_10, var_8_11)

		return
	end)
	arg_2_0:bind(var_0_1.ON_MOVE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_2_0.viewComponent
		local var_9_1 = var_2.emit

		BaseUI = var_2_10005

		var_9_1(var_9_0, var_2_10005.ON_CLOSE)

		local var_9_2 = arg_2_0
		local var_9_3 = var_2.sendNotification

		GAME = var_5

		local var_9_4 = var_5.GO_SCENE

		SCENE = var_2_10006

		var_9_3(var_9_2, var_9_4, var_2_10006.SHIPINFO, {
			page = 2,
			shipId = arg_9_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.EQUIP_SPWEAPON_TO_SHIP_DONE

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getName(var_11_0)
	local var_11_2 = arg_11_1:getBody()

	GAME = var_11_0

	if var_11_1 == var_11_0.EQUIP_SPWEAPON_TO_SHIP_DONE then
		local var_11_3 = arg_11_0.viewComponent
		local var_11_4 = var_4.emit

		BaseUI = var_1_10007

		var_11_4(var_11_3, var_1_10007.ON_CLOSE)
	end

	return
end

return var_0_1
