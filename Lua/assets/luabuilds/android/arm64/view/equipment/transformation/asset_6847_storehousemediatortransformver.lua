local StoreHouseMediatorTransformVer = class("StoreHouseMediatorTransformVer", import("view.base.ContextMediator"))

StoreHouseMediatorTransformVer.ON_DESTROY = "EquipmentMediator:ON_DESTROY"
StoreHouseMediatorTransformVer.ON_UNEQUIP_EQUIPMENT = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT"
StoreHouseMediatorTransformVer.OPEN_DESIGN = "EquipmentMediator:OPEN_DESIGN"
StoreHouseMediatorTransformVer.CLOSE_DESIGN_LAYER = "EquipmentMediator:CLOSE_DESIGN_LAYER"
StoreHouseMediatorTransformVer.BATCHDESTROY_MODE = "EquipmentMediator:BATCHDESTROY_MODE"
StoreHouseMediatorTransformVer.ON_EQUIPMENT_SKIN_INFO = "EquipmentMediator:ON_EQUIPMENT_SKIN_INFO"
StoreHouseMediatorTransformVer.ON_UNEQUIP_EQUIPMENT_SKIN = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT_SKIN"
StoreHouseMediatorTransformVer.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"
StoreHouseMediatorTransformVer.NO_UPDATE = "EquipmentMediator:NO_UPDATE"
StoreHouseMediatorTransformVer.ITEM_GO_SCENE = "item go scene"
StoreHouseMediatorTransformVer.OPEN_EQUIPSKIN_INDEX_LAYER = "EquipmentMediator:OPEN_EQUIPSKIN_INDEX_LAYER"
StoreHouseMediatorTransformVer.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function StoreHouseMediatorTransformVer:register()
	self.contextData.warp = self.contextData.warp or getProxy(SettingsProxy):getEquipSceneIndex()

	self:bind(StoreHouseMediatorTransformVer.ITEM_GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.ON_USE_ITEM, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_3_1,
			count = arg_3_2,
			arg = arg_3_3
		})

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.ON_DESTROY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = arg_4_1
		})

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.ON_UNEQUIP_EQUIPMENT, function(arg_5_0)
		self:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.OPEN_DESIGN, function(arg_6_0)
		if getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator) then
			return
		end

		self:addSubLayers(Context.New({
			viewComponent = EquipmentDesignLayer,
			mediator = EquipmentDesignMediator,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.CLOSE_DESIGN_LAYER, function(arg_7_0)
		local var_7_0 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator)

		if var_7_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_7_0
			})
		end

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.ON_EQUIPMENT_SKIN_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = {
			mediator = EquipmentSkinMediator,
			viewComponent = EquipmentSkinLayer
		}
		local var_8_1 = {
			skinId = arg_8_1,
			shipId = self.contextData.shipId
		}

		if self.contextData.shipId then
			var_8_1.mode = EquipmentSkinLayer.REPLACE or EquipmentSkinLayer.DISPLAY
		end

		var_8_1.oldShipInfo = arg_8_3
		var_8_1.pos = arg_8_2
		var_8_0.data = var_8_1

		self:addSubLayers(Context.New(var_8_0))

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.ON_UNEQUIP_EQUIPMENT_SKIN, function(arg_9_0)
		self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.OPEN_EQUIPSKIN_INDEX_LAYER, function(arg_10_0, arg_10_1)
		self:addSubLayers(Context.New({
			mediator = IndexMediator,
			viewComponent = IndexLayer,
			data = arg_10_1
		}))

		return
	end)
	self:bind(StoreHouseMediatorTransformVer.OPEN_EQUIPMENT_INDEX, function(arg_11_0, arg_11_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_11_1
		}))

		return
	end)

	self.canUpdate = true

	self.viewComponent:OnMediatorRegister()

	self.equipmentProxy = getProxy(EquipmentProxy)

	self.viewComponent:setSources(self.contextData.sourceVOs)

	return
end

function StoreHouseMediatorTransformVer:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		StoreHouseMediatorTransformVer.NO_UPDATE
	}
end

function StoreHouseMediatorTransformVer:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getBody()

	if arg_13_1:getName() == StoreHouseMediatorTransformVer.NO_UPDATE then
		self.canUpdate = false
	end

	return
end

function StoreHouseMediatorTransformVer:remove()
	getProxy(SettingsProxy):setEquipSceneIndex(self.contextData.warp)

	return
end

return StoreHouseMediatorTransformVer
