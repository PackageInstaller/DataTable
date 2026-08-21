local var_0_0 = class("EquipmentSkinMediator", import("..base.ContextMediator"))

var_0_0.ON_EQUIP = "EquipmentSkinMediator:ON_EQUIP"
var_0_0.ON_UNEQUIP = "EquipmentSkinMediator:ON_UNEQUIP"
var_0_0.ON_SELECT = "EquipmentSkinMediator:ON_SELECT"
var_0_0.ON_PREVIEW = "EquipmentSkinMediator:ON_PREVIEW"
var_0_0.ON_EQUIP_FORM_SHIP = "EquipmentSkinMediator:ON_EQUIP_FORM_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_EQUIP, function(arg_2_0)
		arg_1_0:sendNotification(EquipmentMediator.NO_UPDATE)
		arg_1_0:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos,
			equipmentSkinId = arg_1_0.contextData.skinId
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_EQUIP_FORM_SHIP, function(arg_3_0)
		if not arg_1_0.contextData.oldShipInfo then
			return
		end

		local var_3_0, var_3_1 = ShipStatus.ShipStatusCheck("onModify", getProxy(BayProxy):getShipById(arg_1_0.contextData.oldShipInfo.id))

		if not var_3_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_3_1)

			return
		end

		local var_3_2 = arg_1_0.contextData.oldShipInfo

		assert(arg_1_0.contextData.oldShipInfo.id, "old ship id is nil")
		assert(var_3_2.pos, "old ship pos is nil")
		assert(arg_1_0.contextData.shipId, "new ship id nil")
		assert(arg_1_0.contextData.pos, "new ship id nil")
		arg_1_0:sendNotification(EquipmentMediator.NO_UPDATE)
		arg_1_0:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP, {
			oldShipId = var_3_2.id,
			oldShipPos = var_3_2.pos,
			newShipId = arg_1_0.contextData.shipId,
			newShipPos = arg_1_0.contextData.pos
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UNEQUIP, function(arg_4_0)
		arg_1_0:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_1_0.contextData.pos
		})

		return
	end)

	if arg_1_0.contextData.shipId then
		arg_1_0.viewComponent:setShip((getProxy(BayProxy):getShipById(arg_1_0.contextData.shipId)))
		arg_1_0:bind(var_0_0.ON_SELECT, function(arg_5_0, arg_5_1)
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
				equipmentVOs = ShipMainMediator:getEquipmentSkins(var_0, arg_5_1),
				shipId = arg_1_0.contextData.shipId,
				pos = arg_5_1,
				warp = StoreHouseConst.WARP_TO_WEAPON,
				mode = StoreHouseConst.SKIN
			})

			return
		end)
	end

	arg_1_0:bind(var_0_0.ON_PREVIEW, function(arg_6_0, arg_6_1)
		local var_6_0 = Ship.New({
			id = pg.equip_skin_template[arg_6_1].ship_config_id,
			configId = pg.equip_skin_template[arg_6_1].ship_config_id,
			skin_id = pg.equip_skin_template[arg_6_1].ship_skin_id
		})
		local var_6_1 = {}

		var_6_1 = pg.equip_skin_template[arg_6_1].ship_skin_id ~= 0 and {
			equipSkinId = 0,
			shipVO = var_6_0,
			weaponIds = {}
		} or {
			shipVO = var_6_0,
			weaponIds = Clone(pg.equip_skin_template[arg_6_1].weapon_ids),
			equipSkinId = arg_6_1
		}

		arg_1_0:addSubLayers(Context.New({
			viewComponent = EquipmentSkinPreviewWindow,
			mediator = ShipPreviewMediator,
			data = var_6_1
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	return
end

return var_0_0
