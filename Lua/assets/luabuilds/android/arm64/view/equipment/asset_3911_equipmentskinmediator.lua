local EquipmentSkinMediator = class("EquipmentSkinMediator", import("..base.ContextMediator"))

EquipmentSkinMediator.ON_EQUIP = "EquipmentSkinMediator:ON_EQUIP"
EquipmentSkinMediator.ON_UNEQUIP = "EquipmentSkinMediator:ON_UNEQUIP"
EquipmentSkinMediator.ON_SELECT = "EquipmentSkinMediator:ON_SELECT"
EquipmentSkinMediator.ON_PREVIEW = "EquipmentSkinMediator:ON_PREVIEW"
EquipmentSkinMediator.ON_EQUIP_FORM_SHIP = "EquipmentSkinMediator:ON_EQUIP_FORM_SHIP"

function EquipmentSkinMediator:register()
	self:bind(EquipmentSkinMediator.ON_EQUIP, function(arg_2_0)
		self:sendNotification(EquipmentMediator.NO_UPDATE)
		self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			shipId = self.contextData.shipId,
			pos = self.contextData.pos,
			equipmentSkinId = self.contextData.skinId
		})

		return
	end)
	self:bind(EquipmentSkinMediator.ON_EQUIP_FORM_SHIP, function(arg_3_0)
		if not self.contextData.oldShipInfo then
			return
		end

		local var_3_0, var_3_1 = ShipStatus.ShipStatusCheck("onModify", getProxy(BayProxy):getShipById(self.contextData.oldShipInfo.id))

		if not var_3_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_3_1)

			return
		end

		local var_3_2 = self.contextData.oldShipInfo

		assert(self.contextData.oldShipInfo.id, "old ship id is nil")
		assert(var_3_2.pos, "old ship pos is nil")
		assert(self.contextData.shipId, "new ship id nil")
		assert(self.contextData.pos, "new ship id nil")
		self:sendNotification(EquipmentMediator.NO_UPDATE)
		self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP, {
			oldShipId = var_3_2.id,
			oldShipPos = var_3_2.pos,
			newShipId = self.contextData.shipId,
			newShipPos = self.contextData.pos
		})

		return
	end)
	self:bind(EquipmentSkinMediator.ON_UNEQUIP, function(arg_4_0)
		self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})

		return
	end)

	if self.contextData.shipId then
		local var_1_0 = getProxy(BayProxy):getShipById(self.contextData.shipId)

		self.viewComponent:setShip(var_1_0)
		self:bind(EquipmentSkinMediator.ON_SELECT, function(arg_5_0, arg_5_1)
			self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
				equipmentVOs = ShipMainMediator:getEquipmentSkins(var_1_0, arg_5_1),
				shipId = self.contextData.shipId,
				pos = arg_5_1,
				warp = StoreHouseConst.WARP_TO_WEAPON,
				mode = StoreHouseConst.SKIN
			})

			return
		end)
	end

	self:bind(EquipmentSkinMediator.ON_PREVIEW, function(arg_6_0, arg_6_1)
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

		self:addSubLayers(Context.New({
			viewComponent = EquipmentSkinPreviewWindow,
			mediator = ShipPreviewMediator,
			data = var_6_1
		}))

		return
	end)

	return
end

function EquipmentSkinMediator:listNotificationInterests()
	return {}
end

function EquipmentSkinMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	return
end

return EquipmentSkinMediator
