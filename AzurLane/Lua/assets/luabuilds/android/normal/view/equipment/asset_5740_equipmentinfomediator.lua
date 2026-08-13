class = var_0_10000

local var_0_0 = "EquipmentInfoMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.TYPE_DEFAULT = 1
var_0_1.TYPE_SHIP = 2
var_0_1.TYPE_REPLACE = 3
var_0_1.TYPE_DISPLAY = 4
var_0_1.SHOW_UNIQUE = {
	1,
	2,
	3,
	4
}
var_0_1.ON_DESTROY = "EquipmentInfoMediator:ON_DESTROY"
var_0_1.ON_EQUIP = "EquipmentInfoMediator:ON_EQUIP"
var_0_1.ON_INTENSIFY = "EquipmentInfoMediator.ON_INTENSIFY"
var_0_1.ON_CHANGE = "EquipmentInfoMediator.ON_CHANGE"
var_0_1.ON_UNEQUIP = "EquipmentInfoMediator:ON_UNEQUIP"
var_0_1.ON_REVERT = "EquipmentInfoMediator:ON_REVERT"
var_0_1.ON_MOVE = "EquipmentInfoMediator:ON_MOVE"
var_0_1.OPEN_LAYER = "OPEN LAYER"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getCurrentContext(var_1_0).scene

	SCENE = var_1_10004

	if var_1_1 == var_1_10004.EQUIPSCENE then
		arg_1_0.viewComponent.fromEquipmentView = true
	end

	arg_1_0:bind(var_0_1.ON_DESTROY, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.DESTROY_EQUIPMENTS, {
			equipments = {
				{
					arg_1_0.contextData.equipmentId,
					arg_2_1
				}
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EQUIP, function(arg_3_0)
		if arg_1_0.contextData.oldShipId then
			getProxy = var_1
			BayProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_3_0 = var_1.getShipById(var_2_10003, arg_1_0.contextData.oldShipId)

			ShipStatus = var_2_10003

			local var_3_1

			var_2_10003, var_3_1 = var_2_10003.ShipStatusCheck("onModify", var_3_0)

			if not var_2_10003 then
				pg = var_5

				local var_3_2 = var_5.TipsMgr.GetInstance()

				var_5.ShowTips(var_3_2, var_3_1)
			else
				if arg_1_0.viewComponent.fromEquipmentView then
					local var_3_3 = arg_1_0
					local var_3_4 = var_5.sendNotification

					EquipmentMediator = var_2_10007

					var_3_4(var_3_3, var_2_10007.NO_UPDATE)
				end

				local var_3_5 = arg_1_0
				local var_3_6 = var_5.sendNotification

				GAME = var_2_10007

				var_3_6(var_3_5, var_2_10007.EQUIP_FROM_SHIP, {
					equipmentId = arg_1_0.contextData.equipmentId,
					shipId = arg_1_0.contextData.shipId,
					pos = arg_1_0.contextData.pos,
					oldShipId = arg_1_0.contextData.oldShipId,
					oldPos = arg_1_0.contextData.oldPos
				})
			end
		else
			if arg_1_0.viewComponent.fromEquipmentView then
				local var_3_7 = arg_1_0
				local var_3_8 = var_1.sendNotification

				EquipmentMediator = var_2_10003

				var_3_8(var_3_7, var_2_10003.NO_UPDATE)
			end

			local var_3_9 = arg_1_0
			local var_3_10 = var_1.sendNotification

			GAME = var_2_10003

			var_3_10(var_3_9, var_2_10003.EQUIP_TO_SHIP, {
				equipmentId = arg_1_0.contextData.equipmentId,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_1_0.contextData.pos
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNEQUIP, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.UNEQUIP_FROM_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		local var_4_2 = arg_1_0.viewComponent
		local var_4_3 = var_1.emit

		BaseUI = var_3

		var_4_3(var_4_2, var_3.ON_CLOSE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_INTENSIFY, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_5_2 = var_2_10003.New
		local var_5_3 = {}

		EquipUpgradeMediator = var_2_10005
		var_5_3.mediator = var_2_10005
		EquipUpgradeLayer = var_2_10005
		var_5_3.viewComponent = var_2_10005
		var_5_3.data = {
			equipmentId = arg_1_0.contextData.equipmentId,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		}

		var_5_1(var_5_0, var_5_2(var_5_3), true, function()
			local var_6_0 = arg_1_0.viewComponent
			local var_6_1 = var_0.emit

			BaseUI = var_3_10002

			var_6_1(var_6_0, var_3_10002.ON_CLOSE)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHANGE, function(arg_7_0)
		getProxy = var_2_10001
		BayProxy = var_2_10002

		local var_7_0 = var_2_10001(var_2_10002)
		local var_7_1 = var_1.getShipById(var_7_0, arg_1_0.contextData.shipId)

		getProxy = var_7_0
		EquipmentProxy = var_4

		local var_7_2 = var_7_0(var_4)
		local var_7_3 = var_3.getEquipments(var_7_2, true)
		local var_7_4 = var_1
		local var_7_5 = var_1.getEquipsInShips(var_7_4, function(arg_8_0, arg_8_1)
			local var_8_1

			if var_7_1.id ~= arg_8_1 then
				local var_8_0 = var_7_1

				var_8_1 = not var_2.isForbiddenAtPos(var_8_0, arg_8_0, arg_1_0.contextData.pos)
			else
				var_8_1 = false
			end

			if false then
				var_8_1 = true
			end

			return var_8_1
		end)

		ipairs = var_7_4

		for iter_7_0, iter_7_1 in var_7_4(var_7_3) do
			if not var_7_1:isForbiddenAtPos(iter_7_1, arg_1_0.contextData.pos) then
				table = var_11

				var_11.insert(var_7_5, iter_7_1)
			end
		end

		_ = var_6

		var_6.each(var_7_5, function(arg_9_0)
			local var_9_0 = var_7_1

			if not var_1.canEquipAtPos(var_9_0, arg_9_0, arg_1_0.contextData.pos) then
				arg_9_0.mask = true
			end

			return
		end)

		local var_7_6 = arg_1_0.viewComponent
		local var_7_7 = var_6.emit

		BaseUI = var_8

		var_7_7(var_7_6, var_8.ON_CLOSE)

		local var_7_8 = arg_1_0
		local var_7_9 = var_6.sendNotification

		GAME = var_8

		local var_7_10 = var_8.GO_SCENE

		SCENE = iter_7_0

		local var_7_11 = iter_7_0.EQUIPSCENE
		local var_7_12 = {
			lock = true,
			equipmentVOs = var_7_5,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		}

		StoreHouseConst = var_11
		var_7_12.warp = var_11.WARP_TO_WEAPON
		StoreHouseConst = var_11
		var_7_12.mode = var_11.EQUIPMENT

		var_7_9(var_7_8, var_7_10, var_7_11, var_7_12)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REVERT, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.REVERT_EQUIPMENT, {
			id = arg_10_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MOVE, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0.viewComponent
		local var_11_1 = var_2.emit

		BaseUI = var_2_10004

		var_11_1(var_11_0, var_2_10004.ON_CLOSE)

		local var_11_2 = arg_1_0
		local var_11_3 = var_2.sendNotification

		GAME = var_4

		local var_11_4 = var_4.GO_SCENE

		SCENE = var_2_10005

		var_11_3(var_11_2, var_11_4, var_2_10005.SHIPINFO, {
			page = 2,
			shipId = arg_11_1
		})

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.OPEN_LAYER, function(arg_12_0, ...)
		local var_12_0 = arg_1_0

		var_1.addSubLayers(var_12_0, ...)

		return
	end)

	if arg_1_0.contextData.equipment then
		var_1_2 = arg_1_0.viewComponent

		var_1_3.setEquipment(var_1_2, arg_1_0.contextData.equipment)

		goto label_1_1
	end

	getProxy = var_1_3
	EquipmentProxy = var_1_2

	local var_1_3 = var_1_3(var_1_2)

	var_1_2 = arg_1_0.contextData.equipmentId

	if not var_1_3:getEquipmentById(var_1_2) then
		if var_1_2 and 0 < var_1_2 then
			Equipment = var_6

			do
				local var_1_4

				if not var_6.New({
					id = var_1_2
				}) then
					::label_1_0::

					var_1_4 = nil
				end

				local var_1_5 = arg_1_0.viewComponent

				var_6.setEquipment(var_1_5, var_1_4)
			end

			::label_1_1::

			getProxy = var_1_3
			BayProxy = var_1_2

			local var_1_6 = var_1_3(var_1_2)
			local var_1_7

			if not arg_1_0.contextData.shipVO then
				var_1_7 = var_1_6:getShipById(arg_1_0.contextData.shipId)
			end

			local var_1_8

			if not arg_1_0.contextData.oldShipId or not var_1_6:getShipById(arg_1_0.contextData.oldShipId) then
				var_1_8 = nil
			end

			local var_1_9 = arg_1_0.viewComponent

			var_6.setShip(var_1_9, var_1_7, var_1_8)

			getProxy = var_6
			PlayerProxy = var_1_9

			local var_1_10 = var_6(var_1_9)
			local var_1_11 = var_6.getData(var_1_10)
			local var_1_12 = arg_1_0.viewComponent

			var_8.setPlayer(var_1_12, var_1_11)

			return
		end
	end
end

function var_0_1.listNotificationInterests(arg_13_0)
	local var_13_0 = {}

	GAME = var_1_10002
	var_13_0[1] = var_1_10002.DESTROY_EQUIPMENTS_DONE
	GAME = var_2
	var_13_0[2] = var_2.EQUIP_TO_SHIP_DONE
	GAME = var_2
	var_13_0[3] = var_2.REVERT_EQUIPMENT_DONE

	return var_13_0
end

function var_0_1.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.getBody(var_14_1)

	GAME = var_14_1

	if var_14_0 ~= var_14_1.DESTROY_EQUIPMENTS_DONE then
		GAME = var_4

		if var_14_0 ~= var_4.EQUIP_TO_SHIP_DONE then
			GAME = var_4

			if var_14_0 == var_4.REVERT_EQUIPMENT_DONE then
				local var_14_3 = arg_14_0.viewComponent
				local var_14_4 = var_4.emit

				BaseUI = var_1_10006

				var_14_4(var_14_3, var_1_10006.ON_CLOSE)
			end

			return
		end
	end
end

return var_0_1
