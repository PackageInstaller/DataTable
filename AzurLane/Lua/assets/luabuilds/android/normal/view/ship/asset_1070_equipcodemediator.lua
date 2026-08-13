class = var_0_10000

local var_0_0 = "EquipCodeMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SHARE_EQUIP_CODE = "EquipCodeMediator.SHARE_EQUIP_CODE"
var_0_1.IMPORT_SHIP_EQUIP = "EquipCodeMediator.IMPORT_SHIP_EQUIP"
var_0_1.OPEN_CUSTOM_INDEX = "EquipCodeMediator.OPEN_CUSTOM_INDEX"
var_0_1.OPEN_EQUIP_CODE_SHARE = "EquipCodeMediator.OPEN_EQUIP_CODE_SHARE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SHARE_EQUIP_CODE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EQUIP_CODE_SHARE, {
			groupId = arg_2_1,
			code = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.IMPORT_SHIP_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SHIP_EQUIP_ALL_CHANGE, {
			shipId = arg_3_1,
			equipData = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CUSTOM_INDEX, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		CustomIndexLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_EQUIP_CODE_SHARE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		EquipCodeShareMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		EquipCodeShareLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {
			shipGroupId = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	getProxy = var_1
	EquipmentProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getEquipments(var_1_1, true)

	ipairs = var_1_1
	getProxy = var_3
	BayProxy = var_4

	local var_1_3 = var_3(var_4)

	for iter_1_0, iter_1_1 in var_1_1(var_3.getEquipsInShips(var_1_3)) do
		table = var_1_10007

		var_1_10007.insert(var_1_2, iter_1_1)
	end

	underscore = var_2

	local var_1_4 = var_2.values

	getProxy = var_3
	EquipmentProxy = var_4

	local var_1_5 = var_3(var_4)
	local var_1_6 = var_1_4(var_3.GetSpWeapons(var_1_5))

	ipairs = var_3
	getProxy = var_1_5
	BayProxy = iter_1_0

	local var_1_7 = var_1_5(iter_1_0)

	for iter_1_2, iter_1_3 in var_3(var_4.GetSpWeaponsInShips(var_1_7)) do
		table = var_1_10008

		var_1_10008.insert(var_1_6, iter_1_3)
	end

	local var_1_8 = arg_1_0.viewComponent

	var_3.setEquipments(var_1_8, var_1_2, var_1_6)

	local var_1_9 = arg_1_0.viewComponent

	var_3.setShip(var_1_9, arg_1_0.contextData.shipId)

	return
end

function var_0_1.initNotificationHandleDic(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[var_1_10002.SHIP_EQUIP_ALL_CHANGE_DONE] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1
		local var_7_1 = arg_7_1.getBody(var_7_0)

		assert = var_7_0

		var_7_0(var_7_1 == arg_7_0.contextData.shipId)

		local var_7_2 = arg_7_0.viewComponent

		var_3.closeView(var_7_2)

		return
	end
	arg_6_0.handleDic = var_6_0

	return
end

return var_0_1
