class = var_0_10000

local var_0_0 = "StoreHouseMediatorTransformVer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_DESTROY = "EquipmentMediator:ON_DESTROY"
var_0_1.ON_UNEQUIP_EQUIPMENT = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT"
var_0_1.OPEN_DESIGN = "EquipmentMediator:OPEN_DESIGN"
var_0_1.CLOSE_DESIGN_LAYER = "EquipmentMediator:CLOSE_DESIGN_LAYER"
var_0_1.BATCHDESTROY_MODE = "EquipmentMediator:BATCHDESTROY_MODE"
var_0_1.ON_EQUIPMENT_SKIN_INFO = "EquipmentMediator:ON_EQUIPMENT_SKIN_INFO"
var_0_1.ON_UNEQUIP_EQUIPMENT_SKIN = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT_SKIN"
var_0_1.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"
var_0_1.NO_UPDATE = "EquipmentMediator:NO_UPDATE"
var_0_1.ITEM_GO_SCENE = "item go scene"
var_0_1.OPEN_EQUIPSKIN_INDEX_LAYER = "EquipmentMediator:OPEN_EQUIPSKIN_INDEX_LAYER"
var_0_1.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function var_0_1.register(arg_1_0)
	if not arg_1_0.contextData.warp then
		getProxy = var_1
		SettingsProxy = var_1_10003

		local var_1_0 = var_1(var_1_10003)
		local var_1_1 = var_1.getEquipSceneIndex(var_1_0)

		arg_1_0.contextData.warp = var_1_1
	end

	arg_1_0:bind(var_0_1.ITEM_GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_USE_ITEM, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		var_3_1(var_3_0, var_2_10007.USE_ITEM, {
			id = arg_3_1,
			count = arg_3_2,
			arg = arg_3_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_DESTROY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.DESTROY_EQUIPMENTS, {
			equipments = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNEQUIP_EQUIPMENT, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.UNEQUIP_FROM_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DESIGN, function(arg_6_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)
		local var_6_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10005

		local var_6_2 = var_6_1(var_6_0, var_2_10005)
		local var_6_3 = var_2.getContextByMediator

		EquipmentDesignMediator = var_2_10006

		if var_6_3(var_6_2, var_2_10006) then
			return
		end

		local var_6_4 = arg_1_0
		local var_6_5 = var_4.addSubLayers

		Context = var_2_10007

		local var_6_6 = var_2_10007.New
		local var_6_7 = {}

		EquipmentDesignLayer = var_2_10010
		var_6_7.viewComponent = var_2_10010
		EquipmentDesignMediator = var_2_10010
		var_6_7.mediator = var_2_10010

		local var_6_8 = {}
		local var_6_9 = arg_1_0.viewComponent

		var_6_8.groupName = var_11.getGroupName(var_6_9)
		var_6_7.data = var_6_8

		var_6_5(var_6_4, var_6_6(var_6_7))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_DESIGN_LAYER, function(arg_7_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_7_0 = var_2_10001(var_2_10003)
		local var_7_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10005

		local var_7_2 = var_7_1(var_7_0, var_2_10005)
		local var_7_3 = var_2.getContextByMediator

		EquipmentDesignMediator = var_2_10006

		if var_7_3(var_7_2, var_2_10006) then
			local var_7_4 = arg_1_0
			local var_7_5 = var_4.sendNotification

			GAME = var_2_10007

			var_7_5(var_7_4, var_2_10007.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_EQUIPMENT_SKIN_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_1_0
		local var_8_1 = var_4.addSubLayers

		Context = var_2_10007

		local var_8_2 = var_2_10007.New
		local var_8_3 = {}

		EquipmentSkinMediator = var_2_10010
		var_8_3.mediator = var_2_10010
		EquipmentSkinLayer = var_2_10010
		var_8_3.viewComponent = var_2_10010

		local var_8_4 = {
			skinId = arg_8_1,
			shipId = arg_1_0.contextData.shipId
		}

		if arg_1_0.contextData.shipId then
			EquipmentSkinLayer = var_8_5

			local var_8_5

			if not var_8_5.REPLACE then
				EquipmentSkinLayer = var_8_5
				var_8_5 = var_8_5.DISPLAY
			end

			var_8_4.mode = var_8_5
			var_8_4.oldShipInfo = arg_8_3
			var_8_4.pos = arg_8_2
			var_8_3.data = var_8_4

			var_8_1(var_8_0, var_8_2(var_8_3))

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_UNEQUIP_EQUIPMENT_SKIN, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIPSKIN_INDEX_LAYER, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_10_2 = var_2_10005.New
		local var_10_3 = {}

		IndexMediator = var_2_10008
		var_10_3.mediator = var_2_10008
		IndexLayer = var_2_10008
		var_10_3.viewComponent = var_2_10008
		var_10_3.data = arg_10_1

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_11_2 = var_2_10005.New
		local var_11_3 = {}

		CustomIndexLayer = var_2_10008
		var_11_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_11_3.mediator = var_2_10008
		var_11_3.data = arg_11_1

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)

	arg_1_0.canUpdate = true

	local var_1_2 = arg_1_0.viewComponent

	var_1.OnMediatorRegister(var_1_2)

	getProxy = var_1
	EquipmentProxy = var_1_2
	arg_1_0.equipmentProxy = var_1(var_1_2)

	local var_1_3 = arg_1_0.contextData.sourceVOs
	local var_1_4 = arg_1_0.viewComponent

	var_2.setSources(var_1_4, var_1_3)

	return
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	PlayerProxy = var_1_10002
	var_12_0[1] = var_1_10002.UPDATED
	var_12_0[2] = var_0_1.NO_UPDATE

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == var_0_1.NO_UPDATE then
		arg_13_0.canUpdate = false
	end

	return
end

function var_0_1.remove(arg_14_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	var_1.setEquipSceneIndex(var_14_0, arg_14_0.contextData.warp)

	return
end

return var_0_1
