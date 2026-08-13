class = var_0_10000

local var_0_0 = "EquipmentSkinMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_EQUIP = "EquipmentSkinMediator:ON_EQUIP"
var_0_1.ON_UNEQUIP = "EquipmentSkinMediator:ON_UNEQUIP"
var_0_1.ON_SELECT = "EquipmentSkinMediator:ON_SELECT"
var_0_1.ON_PREVIEW = "EquipmentSkinMediator:ON_PREVIEW"
var_0_1.ON_EQUIP_FORM_SHIP = "EquipmentSkinMediator:ON_EQUIP_FORM_SHIP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_EQUIP, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		EquipmentMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.NO_UPDATE)

		local var_2_2 = arg_1_0
		local var_2_3 = var_1.sendNotification

		GAME = var_3

		var_2_3(var_2_2, var_3.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos,
			equipmentSkinId = arg_1_0.contextData.skinId
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EQUIP_FORM_SHIP, function(arg_3_0)
		if not arg_1_0.contextData.oldShipInfo then
			return
		end

		local var_3_0 = arg_1_0.contextData.oldShipInfo.id

		ShipStatus = var_2_10002

		local var_3_1 = var_2_10002.ShipStatusCheck
		local var_3_2 = "onModify"

		getProxy = var_2_10004
		BayProxy = var_2_10005

		local var_3_3 = var_2_10004(var_2_10005)
		local var_3_4, var_3_5 = var_3_1(var_3_2, var_4.getShipById(var_3_3, var_3_0))

		if not var_3_4 then
			pg = var_4
			var_3_3 = var_4.TipsMgr.GetInstance()

			var_4.ShowTips(var_3_3, var_3_5)

			return
		end

		local var_3_6 = arg_1_0.contextData.oldShipInfo

		assert = var_3_3

		var_3_3(var_3_6.id, "old ship id is nil")

		assert = var_3_3

		var_3_3(var_3_6.pos, "old ship pos is nil")

		assert = var_3_3

		var_3_3(arg_1_0.contextData.shipId, "new ship id nil")

		assert = var_3_3

		var_3_3(arg_1_0.contextData.pos, "new ship id nil")

		local var_3_7 = arg_1_0
		local var_3_8 = var_5.sendNotification

		EquipmentMediator = var_7

		var_3_8(var_3_7, var_7.NO_UPDATE)

		local var_3_9 = arg_1_0
		local var_3_10 = var_5.sendNotification

		GAME = var_7

		var_3_10(var_3_9, var_7.EQUIP_EQUIPMENTSKIN_FROM_SHIP, {
			oldShipId = var_3_6.id,
			oldShipPos = var_3_6.pos,
			newShipId = arg_1_0.contextData.shipId,
			newShipPos = arg_1_0.contextData.pos
		})

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_UNEQUIP, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)

	if arg_1_0.contextData.shipId then
		getProxy = var_1
		BayProxy = var_1_0

		local var_1_1 = var_1(var_1_0)
		local var_1_2 = var_1.getShipById(var_1_1, arg_1_0.contextData.shipId)
		local var_1_3 = arg_1_0.viewComponent

		var_2.setShip(var_1_3, var_1_2)
		arg_1_0:bind(var_0_1.ON_SELECT, function(arg_5_0, arg_5_1)
			ShipMainMediator = var_2_10002

			local var_5_0 = var_2_10002:getEquipmentSkins(var_1_2, arg_5_1)
			local var_5_1 = arg_1_0
			local var_5_2 = var_3.sendNotification

			GAME = var_5

			local var_5_3 = var_5.GO_SCENE

			SCENE = var_2_10006

			local var_5_4 = var_2_10006.EQUIPSCENE
			local var_5_5 = {
				equipmentVOs = var_5_0,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_5_1
			}

			StoreHouseConst = var_8
			var_5_5.warp = var_8.WARP_TO_WEAPON
			StoreHouseConst = var_8
			var_5_5.mode = var_8.SKIN

			var_5_2(var_5_1, var_5_3, var_5_4, var_5_5)

			return
		end)
	end

	arg_1_0:bind(var_0_1.ON_PREVIEW, function(arg_6_0, arg_6_1)
		pg = var_2_10002

		local var_6_0 = var_2_10002.equip_skin_template[arg_6_1]

		Ship = var_2_10003

		local var_6_1 = var_2_10003.New({
			id = var_6_0.ship_config_id,
			configId = var_6_0.ship_config_id,
			skin_id = var_6_0.ship_skin_id
		})
		local var_6_2 = {}

		if var_6_0.ship_skin_id ~= 0 then
			var_6_2 = {
				equipSkinId = 0,
				shipVO = var_6_1,
				weaponIds = {}
			}
		else
			local var_6_3 = {
				shipVO = var_6_1
			}

			Clone = var_2_10006
			var_6_3.weaponIds = var_2_10006(var_6_0.weapon_ids)
			var_6_3.equipSkinId = arg_6_1
			var_6_2 = var_6_3
		end

		local var_6_4 = arg_1_0
		local var_6_5 = var_5.addSubLayers

		Context = var_2_10007

		local var_6_6 = var_2_10007.New
		local var_6_7 = {}

		EquipmentSkinPreviewWindow = var_2_10009
		var_6_7.viewComponent = var_2_10009
		ShipPreviewMediator = var_2_10009
		var_6_7.mediator = var_2_10009
		var_6_7.data = var_6_2

		var_6_5(var_6_4, var_6_6(var_6_7))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	return {}
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	return
end

return var_0_1
