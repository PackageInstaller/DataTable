class = var_0_10000

local var_0_0 = "EquipmentMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_DESTROY = "EquipmentMediator:ON_DESTROY"
var_0_1.ON_UNEQUIP_EQUIPMENT = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT"
var_0_1.OPEN_DESIGN = "EquipmentMediator:OPEN_DESIGN"
var_0_1.CLOSE_DESIGN_LAYER = "EquipmentMediator:CLOSE_DESIGN_LAYER"
var_0_1.OPEN_SPWEAPON_DESIGN = "EquipmentMediator:OPEN_SPWEAPON_DESIGN"
var_0_1.CLOSE_SPWEAPON_DESIGN_LAYER = "EquipmentMediator:CLOSE_SPWEAPON_DESIGN_LAYER"
var_0_1.BATCHDESTROY_MODE = "EquipmentMediator:BATCHDESTROY_MODE"
var_0_1.SWITCH_TO_SPWEAPON_PAGE = "EquipmentMediator:SWITCH_TO_SPWEAPON_PAGE"
var_0_1.ON_EQUIPMENT_SKIN_INFO = "EquipmentMediator:ON_EQUIPMENT_SKIN_INFO"
var_0_1.ON_UNEQUIP_EQUIPMENT_SKIN = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT_SKIN"
var_0_1.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"
var_0_1.NO_UPDATE = "EquipmentMediator:NO_UPDATE"
var_0_1.ITEM_GO_SCENE = "item go scene"
var_0_1.ITEM_ADD_LAYER = "EquipmentMediator.ITEM_ADD_LAYER"
var_0_1.OPEN_EQUIPSKIN_INDEX_LAYER = "EquipmentMediator:OPEN_EQUIPSKIN_INDEX_LAYER"
var_0_1.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"
var_0_1.DESIGN_FILTER_CHANGED = "EquipmentMediator:DESIGN_FILTER_CHANGED"

function var_0_1.register(arg_1_0)
	if not arg_1_0.contextData.warp then
		getProxy = var_1
		SettingsProxy = var_1_10002

		local var_1_0 = var_1(var_1_10002)
		local var_1_1 = var_1.getEquipSceneIndex(var_1_0)

		arg_1_0.contextData.warp = var_1_1
	end

	arg_1_0:bind(var_0_1.DESIGN_FILTER_CHANGED, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.TOGGLE_ALL_DESIGN_EQUIPMENT, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ITEM_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.GO_SCENE, arg_3_1, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.ITEM_ADD_LAYER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.addSubLayers(var_4_0, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_USE_ITEM, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = arg_1_0
		local var_5_1 = var_4.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.USE_ITEM, {
			id = arg_5_1,
			count = arg_5_2,
			arg = arg_5_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_DESTROY, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.DESTROY_EQUIPMENTS, {
			equipments = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UNEQUIP_EQUIPMENT, function(arg_7_0)
		arg_1_0.canUpdate = false

		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.UNEQUIP_FROM_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DESIGN, function(arg_8_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_8_0 = var_2_10001(var_2_10002)
		local var_8_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10004

		local var_8_2 = var_8_1(var_8_0, var_2_10004)
		local var_8_3 = var_2.getContextByMediator

		EquipmentDesignMediator = var_2_10005

		if var_8_3(var_8_2, var_2_10005) then
			return
		end

		local var_8_4 = arg_1_0
		local var_8_5 = var_4.addSubLayers

		Context = var_2_10006

		local var_8_6 = var_2_10006.New
		local var_8_7 = {}

		EquipmentDesignLayer = var_2_10008
		var_8_7.viewComponent = var_2_10008
		EquipmentDesignMediator = var_2_10008
		var_8_7.mediator = var_2_10008

		local var_8_8 = {}
		local var_8_9 = arg_1_0.viewComponent

		var_8_8.groupName = var_9.getGroupName(var_8_9)
		var_8_8.isShowAllDesign = arg_1_0.viewComponent.isShowAllDesign
		var_8_7.data = var_8_8

		var_8_5(var_8_4, var_8_6(var_8_7))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_DESIGN_LAYER, function(arg_9_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_9_0 = var_2_10001(var_2_10002)
		local var_9_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10004

		local var_9_2 = var_9_1(var_9_0, var_2_10004)
		local var_9_3 = var_2.getContextByMediator

		EquipmentDesignMediator = var_2_10005

		if var_9_3(var_9_2, var_2_10005) then
			local var_9_4 = arg_1_0
			local var_9_5 = var_4.sendNotification

			GAME = var_2_10006

			var_9_5(var_9_4, var_2_10006.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SPWEAPON_DESIGN, function(arg_10_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_10_0 = var_2_10001(var_2_10002)
		local var_10_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10004

		local var_10_2 = var_10_1(var_10_0, var_2_10004)
		local var_10_3 = var_2.getContextByMediator

		SpWeaponDesignMediator = var_2_10005

		if var_10_3(var_10_2, var_2_10005) then
			return
		end

		local var_10_4 = arg_1_0
		local var_10_5 = var_4.addSubLayers

		Context = var_2_10006

		local var_10_6 = var_2_10006.New
		local var_10_7 = {}

		SpWeaponDesignLayer = var_2_10008
		var_10_7.viewComponent = var_2_10008
		SpWeaponDesignMediator = var_2_10008
		var_10_7.mediator = var_2_10008

		local var_10_8 = {}
		local var_10_9 = arg_1_0.viewComponent

		var_10_8.groupName = var_9.getGroupName(var_10_9)
		var_10_7.data = var_10_8

		var_10_5(var_10_4, var_10_6(var_10_7))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_SPWEAPON_DESIGN_LAYER, function(arg_11_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10002

		local var_11_0 = var_2_10001(var_2_10002)
		local var_11_1 = var_1.getContextByMediator

		EquipmentMediator = var_2_10004

		local var_11_2 = var_11_1(var_11_0, var_2_10004)
		local var_11_3 = var_2.getContextByMediator

		SpWeaponDesignMediator = var_2_10005

		if var_11_3(var_11_2, var_2_10005) then
			local var_11_4 = arg_1_0
			local var_11_5 = var_4.sendNotification

			GAME = var_2_10006

			var_11_5(var_11_4, var_2_10006.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_EQUIPMENT_SKIN_INFO, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_1_0
		local var_12_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_12_2 = var_2_10006.New
		local var_12_3 = {}

		EquipmentSkinMediator = var_2_10008
		var_12_3.mediator = var_2_10008
		EquipmentSkinLayer = var_2_10008
		var_12_3.viewComponent = var_2_10008

		local var_12_4 = {
			skinId = arg_12_1,
			shipId = arg_1_0.contextData.shipId
		}

		if arg_1_0.contextData.shipId then
			EquipmentSkinLayer = var_12_5

			local var_12_5

			if not var_12_5.REPLACE then
				EquipmentSkinLayer = var_12_5
				var_12_5 = var_12_5.DISPLAY
			end

			var_12_4.mode = var_12_5
			var_12_4.oldShipInfo = arg_12_3
			var_12_4.pos = arg_12_2
			var_12_3.data = var_12_4

			var_12_1(var_12_0, var_12_2(var_12_3))

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_UNEQUIP_EQUIPMENT_SKIN, function(arg_13_0)
		arg_1_0.canUpdate = false

		local var_13_0 = arg_1_0
		local var_13_1 = var_1.sendNotification

		GAME = var_2_10003

		var_13_1(var_13_0, var_2_10003.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIPSKIN_INDEX_LAYER, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_14_2 = var_2_10004.New
		local var_14_3 = {}

		IndexMediator = var_2_10006
		var_14_3.mediator = var_2_10006
		IndexLayer = var_2_10006
		var_14_3.viewComponent = var_2_10006
		var_14_3.data = arg_14_1

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)

	local var_1_2 = arg_1_0

	arg_1_0.bind(var_1_2, var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		CustomIndexLayer = var_2_10006
		var_15_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_15_3.mediator = var_2_10006
		var_15_3.data = arg_15_1

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)

	arg_1_0.canUpdate = true
	getProxy = var_1
	BayProxy = var_1_2

	local var_1_3 = var_1(var_1_2)
	local var_1_4 = var_1.getShipById(var_1_3, arg_1_0.contextData.shipId)
	local var_1_5 = arg_1_0.viewComponent

	var_3.setShip(var_1_5, var_1_4)

	local var_1_6

	if var_1_4 then
		var_1_6 = arg_1_0.contextData.mode
		StoreHouseConst = var_1_5

		if var_1_6 == var_1_5.EQUIPMENT then
			var_1_5 = var_1_4
			var_1_6 = var_1_4.getEquip(var_1_5, arg_1_0.contextData.pos)
			var_1_5 = arg_1_0.contextData
			defaultValue = var_5
			var_1_5.qiutBtn = var_5(var_1_6, nil)
		else
			var_1_6 = arg_1_0.contextData.mode
			StoreHouseConst = var_1_5

			if var_1_6 == var_1_5.SKIN then
				var_1_5 = var_1_4
				var_1_6 = var_1_4.getEquipSkin(var_1_5, arg_1_0.contextData.pos) ~= 0
				var_1_5 = arg_1_0.contextData
				var_1_5.qiutBtn = var_1_6
			end
		end
	end

	getProxy = var_1_6
	EquipmentProxy = var_1_5
	arg_1_0.equipmentProxy = var_1_6(var_1_5)

	local var_1_7

	if arg_1_0.contextData.equipmentVOs then
		var_1_7 = arg_1_0.contextData.equipmentVOs
	else
		local var_1_8 = arg_1_0.equipmentProxy

		var_1_7 = var_4.getEquipments(var_1_8, true)
		ipairs = var_4

		for iter_1_0, iter_1_1 in var_4(var_1:getEquipsInShips()) do
			table = var_1_10009

			var_1_10009.insert(var_1_7, iter_1_1)
		end

		pairs = var_4

		local var_1_9 = arg_1_0.equipmentProxy

		for iter_1_2, iter_1_3 in var_4(var_5.getEquipmentSkins(var_1_9)) do
			table = var_1_10009

			var_1_10009.insert(var_1_7, {
				isSkin = true,
				id = iter_1_3.id,
				count = iter_1_3.count
			})
		end

		pairs = var_4

		for iter_1_4, iter_1_5 in var_4(var_1:getEquipmentSkinInShips()) do
			table = var_1_10009

			var_1_10009.insert(var_1_7, {
				isSkin = true,
				count = 1,
				id = iter_1_5.id,
				shipId = iter_1_5.shipId,
				shipPos = iter_1_5.shipPos
			})
		end
	end

	local var_1_10 = arg_1_0.viewComponent

	var_4.setEquipments(var_1_10, var_1_7)

	local var_1_11 = arg_1_0.viewComponent
	local var_1_12 = var_4.setCapacity
	local var_1_13 = arg_1_0.equipmentProxy

	var_1_12(var_1_11, var_6.getCapacity(var_1_13))

	local var_1_14 = arg_1_0

	arg_1_0.UpdateSpWeapons(var_1_14)

	getProxy = var_4
	BagProxy = var_1_14

	local var_1_15 = var_4(var_1_14)
	local var_1_16 = var_4.getItemsByExclude(var_1_15)
	local var_1_17 = arg_1_0.viewComponent

	var_6.setItems(var_1_17, var_1_16)

	getProxy = var_6
	PlayerProxy = var_1_17

	local var_1_18 = var_6(var_1_17)
	local var_1_19 = var_6.getData(var_1_18)
	local var_1_20 = arg_1_0.viewComponent

	var_8.setPlayer(var_1_20, var_1_19)

	return
end

function var_0_1.UpdateSpWeapons(arg_16_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.RawGetShipById(var_16_0, arg_16_0.contextData.shipId)

	getProxy = var_16_0
	BayProxy = var_3

	local var_16_2 = var_16_0(var_3)
	local var_16_3 = var_2.GetSpWeaponsInShips(var_16_2, var_16_1)

	_ = var_16_2

	local var_16_4 = var_16_2.values

	getProxy = var_4
	EquipmentProxy = var_1_10005

	local var_16_5 = var_4(var_1_10005)
	local var_16_6 = var_16_4(var_4.GetSpWeapons(var_16_5))

	ipairs = var_4

	for iter_16_0, iter_16_1 in var_4(var_16_6) do
		if not var_16_1 or not var_16_1:IsSpWeaponForbidden(iter_16_1) then
			table = var_1_10009

			var_1_10009.insert(var_16_3, iter_16_1)
		end
	end

	local var_16_7 = arg_16_0.viewComponent

	var_4.SetSpWeapons(var_16_7, var_16_3)

	return
end

function var_0_1.listNotificationInterests(arg_17_0)
	local var_17_0 = {}

	EquipmentProxy = var_1_10002
	var_17_0[1] = var_1_10002.EQUIPMENT_UPDATED
	BayProxy = var_2
	var_17_0[2] = var_2.SHIP_EQUIPMENT_ADDED
	BayProxy = var_2
	var_17_0[3] = var_2.SHIP_EQUIPMENT_REMOVED
	BayProxy = var_2
	var_17_0[4] = var_2.SHIP_UPDATED
	PlayerProxy = var_2
	var_17_0[5] = var_2.UPDATED
	GAME = var_2
	var_17_0[6] = var_2.USE_ITEM_DONE
	GAME = var_2
	var_17_0[7] = var_2.DESTROY_EQUIPMENTS_DONE
	BagProxy = var_2
	var_17_0[8] = var_2.ITEM_UPDATED
	var_17_0[9] = var_0_1.BATCHDESTROY_MODE
	var_17_0[10] = var_0_1.SWITCH_TO_SPWEAPON_PAGE
	GAME = var_2
	var_17_0[11] = var_2.EQUIP_TO_SHIP_DONE
	GAME = var_2
	var_17_0[12] = var_2.REVERT_EQUIPMENT_DONE
	EquipmentProxy = var_2
	var_17_0[13] = var_2.EQUIPMENT_SKIN_UPDATED
	GAME = var_2
	var_17_0[14] = var_2.UNEQUIP_FROM_SHIP_DONE
	GAME = var_2
	var_17_0[15] = var_2.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE
	GAME = var_2
	var_17_0[16] = var_2.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE
	var_17_0[17] = var_0_1.NO_UPDATE
	GAME = var_2
	var_17_0[18] = var_2.FRAG_SELL_DONE
	GAME = var_2
	var_17_0[19] = var_2.TRANSFORM_EQUIPMENT_AWARD_FINISHED
	EquipmentProxy = var_2
	var_17_0[20] = var_2.SPWEAPONS_UPDATED
	GAME = var_2
	var_17_0[21] = var_2.LOVE_ITEM_MAIL_REPAIR_DONE
	GAME = var_2
	var_17_0[22] = var_2.SELL_ITEM_DONE

	return var_17_0
end

function var_0_1.handleNotification(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1
	local var_18_2 = arg_18_1.getBody(var_18_1)

	EquipmentProxy = var_18_1

	local var_18_3

	if var_18_0 == var_18_1.EQUIPMENT_UPDATED then
		var_1_10005 = arg_18_0.viewComponent
		var_18_3 = var_18_3.setCapacity

		local var_18_4 = arg_18_0.equipmentProxy

		var_18_3(var_1_10005, var_1_10006.getCapacity(var_18_4))

		var_1_10005 = arg_18_0.viewComponent

		var_18_3.setEquipment(var_1_10005, var_18_2)

		if arg_18_0.canUpdate then
			var_1_10005 = arg_18_0.viewComponent

			var_18_3.setEquipmentUpdate(var_1_10005)
		end

		goto label_18_0
	end

	BayProxy = var_18_3

	if var_18_0 == var_18_3.SHIP_EQUIPMENT_ADDED then
		var_1_10005 = arg_18_0.viewComponent

		var_4.addShipEquipment(var_1_10005, var_18_2)

		if arg_18_0.canUpdate then
			var_1_10005 = arg_18_0.viewComponent

			var_4.setEquipmentUpdate(var_1_10005)
		end

		goto label_18_0
	end

	BayProxy = var_4

	if var_18_0 == var_4.SHIP_EQUIPMENT_REMOVED then
		var_1_10005 = arg_18_0.viewComponent

		var_4.removeShipEquipment(var_1_10005, var_18_2)

		if arg_18_0.canUpdate then
			var_1_10005 = arg_18_0.viewComponent

			var_4.setEquipmentUpdate(var_1_10005)
		end

		goto label_18_0
	end

	EquipmentProxy = var_4

	local var_18_5

	if var_18_0 == var_4.EQUIPMENT_SKIN_UPDATED then
		var_1_10005 = arg_18_0.viewComponent
		var_18_5 = var_18_5.setCapacity

		local var_18_6 = arg_18_0.equipmentProxy

		var_18_5(var_1_10005, var_1_10006.getCapacity(var_18_6))

		var_1_10005 = arg_18_0.viewComponent

		var_18_5.setEquipmentSkin(var_1_10005, var_18_2)

		if arg_18_0.canUpdate then
			var_1_10005 = arg_18_0.viewComponent

			var_18_5.setEquipmentSkinUpdate(var_1_10005)
		end

		goto label_18_0
	end

	BayProxy = var_18_5

	if var_18_0 == var_18_5.SHIP_UPDATED then
		if var_18_2.id == arg_18_0.contextData.shipId then
			var_1_10005 = arg_18_0.viewComponent

			var_4.setShip(var_1_10005, var_18_2)
		end

		goto label_18_0
	end

	PlayerProxy = var_4

	if var_18_0 == var_4.UPDATED then
		var_1_10005 = arg_18_0.viewComponent

		var_4.setPlayer(var_1_10005, var_18_2)

		goto label_18_0
	end

	GAME = var_4

	local var_18_7

	if var_18_0 == var_4.USE_ITEM_DONE then
		var_18_7 = #var_18_2.drops

		if 0 < var_18_7 then
			var_1_10005 = arg_18_0.viewComponent
			var_18_7 = var_18_7.emit
			BaseUI = var_1_10006

			var_18_7(var_1_10005, var_1_10006.ON_WORLD_ACHIEVE, {
				animation = true,
				items = var_18_2.drops,
				removeFunc = function()
					if var_18_2.isEquipBox then
						underscore = var_0

						local var_19_0 = var_0.map(var_18_2.drops, function(arg_20_0)
							Equipment = var_3_10001

							return var_3_10001.New({
								id = arg_20_0.id,
								count = arg_20_0.count
							})
						end)
						local var_19_1 = arg_18_0
						local var_19_2 = var_1.addSubLayers

						Context = var_2_10003

						local var_19_3 = var_2_10003.New
						local var_19_4 = {}

						ResolveEquipmentLayer = var_2_10005
						var_19_4.viewComponent = var_2_10005
						ResolveEquipmentMediator = var_2_10005
						var_19_4.mediator = var_2_10005
						var_19_4.data = {
							Equipments = var_19_0
						}

						var_19_2(var_19_1, var_19_3(var_19_4))
					end

					return
				end
			})
		end

		goto label_18_0
	end

	GAME = var_18_7

	local var_18_8

	if var_18_0 == var_18_7.FRAG_SELL_DONE then
		var_1_10005 = arg_18_0.viewComponent
		var_18_8 = var_18_8.emit
		BaseUI = var_1_10006

		var_18_8(var_1_10005, var_1_10006.ON_ACHIEVE, var_18_2.awards)

		goto label_18_0
	end

	GAME = var_18_8

	local var_18_9

	if var_18_0 == var_18_8.DESTROY_EQUIPMENTS_DONE then
		arg_18_0.canUpdate = true
		var_1_10005 = arg_18_0.viewComponent

		var_18_9.setEquipmentUpdate(var_1_10005)

		var_18_9 = #var_18_2

		if 0 < var_18_9 then
			var_1_10005 = arg_18_0.viewComponent
			var_18_9 = var_18_9.emit
			BaseUI = var_1_10006

			var_18_9(var_1_10005, var_1_10006.ON_AWARD, {
				items = var_18_2
			})
		end

		goto label_18_0
	end

	BagProxy = var_18_9

	if var_18_0 == var_18_9.ITEM_UPDATED then
		if arg_18_0.canUpdate then
			getProxy = var_4
			BagProxy = var_1_10005
			var_1_10006 = var_4(var_1_10005)

			local var_18_10 = var_4.getItemsByExclude(var_1_10006)
			local var_18_11 = arg_18_0.viewComponent

			var_1_10006.setItems(var_18_11, var_18_10)
		end

		goto label_18_0
	end

	if var_18_0 == var_0_1.BATCHDESTROY_MODE then
		local var_18_12 = arg_18_0.viewComponent

		var_4.SwitchToDestroy(var_18_12)

		goto label_18_0
	end

	if var_18_0 == var_0_1.SWITCH_TO_SPWEAPON_PAGE then
		local var_18_13 = arg_18_0.viewComponent

		var_4.SwitchToSpWeaponStoreHouse(var_18_13)

		goto label_18_0
	end

	GAME = var_4

	local var_18_15

	if var_18_0 == var_4.REVERT_EQUIPMENT_DONE then
		if #var_18_2.awards > 0 then
			local var_18_14 = arg_18_0.viewComponent

			var_18_15 = var_18_15.emit
			BaseUI = var_1_10006

			var_18_15(var_18_14, var_1_10006.ON_AWARD, {
				items = var_18_2.awards
			})
		end

		goto label_18_0
	end

	GAME = var_18_15

	if var_18_0 ~= var_18_15.EQUIP_TO_SHIP_DONE then
		GAME = var_18_17

		local var_18_17

		if var_18_0 == var_18_17.UNEQUIP_FROM_SHIP_DONE then
			local var_18_16 = arg_18_0.viewComponent

			var_18_17 = var_18_17.emit
			BaseUI = var_1_10006

			var_18_17(var_18_16, var_1_10006.ON_BACK)

			goto label_18_0
		end

		GAME = var_18_17

		if var_18_0 ~= var_18_17.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE then
			GAME = var_4

			if var_18_0 == var_4.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE then
				local var_18_18 = arg_18_0.viewComponent
				local var_18_19 = var_4.emit

				BaseUI = var_1_10006

				var_18_19(var_18_18, var_1_10006.ON_BACK)
			elseif var_18_0 == var_0_1.NO_UPDATE then
				arg_18_0.canUpdate = false
			else
				GAME = var_4

				if var_18_0 == var_4.TRANSFORM_EQUIPMENT_AWARD_FINISHED then
					local var_18_20 = arg_18_0:getViewComponent()

					var_4.Scroll2Equip(var_18_20, var_18_2.newEquip)
				else
					EquipmentProxy = var_4

					if var_18_0 == var_4.SPWEAPONS_UPDATED then
						arg_18_0:UpdateSpWeapons()

						local var_18_21 = arg_18_0.viewComponent

						var_4.SetSpWeaponUpdate(var_18_21)
					else
						GAME = var_4

						local var_18_23

						if var_18_0 == var_4.LOVE_ITEM_MAIL_REPAIR_DONE then
							if #var_18_2.awards > 0 then
								local var_18_22 = arg_18_0.viewComponent

								var_18_23 = var_18_23.emit
								BaseUI = var_1_10006

								var_18_23(var_18_22, var_1_10006.ON_AWARD, {
									items = var_18_2.awards
								})
							end
						else
							GAME = var_18_23

							if var_18_0 == var_18_23.SELL_ITEM_DONE then
								local var_18_24 = arg_18_0.viewComponent
								local var_18_25 = var_4.emit

								BaseUI = var_1_10006

								var_18_25(var_18_24, var_1_10006.ON_ACHIEVE, var_18_2.awards)
							end
						end
					end
				end
			end

			::label_18_0::

			return
		end
	end
end

function var_0_1.remove(arg_21_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)

	var_1.setEquipSceneIndex(var_21_0, arg_21_0.contextData.warp)

	return
end

return var_0_1
