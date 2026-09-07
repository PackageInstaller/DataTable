local EquipmentMediator = class("EquipmentMediator", import("..base.ContextMediator"))

EquipmentMediator.ON_DESTROY = "EquipmentMediator:ON_DESTROY"
EquipmentMediator.ON_UNEQUIP_EQUIPMENT = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT"
EquipmentMediator.OPEN_DESIGN = "EquipmentMediator:OPEN_DESIGN"
EquipmentMediator.CLOSE_DESIGN_LAYER = "EquipmentMediator:CLOSE_DESIGN_LAYER"
EquipmentMediator.OPEN_SPWEAPON_DESIGN = "EquipmentMediator:OPEN_SPWEAPON_DESIGN"
EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER = "EquipmentMediator:CLOSE_SPWEAPON_DESIGN_LAYER"
EquipmentMediator.BATCHDESTROY_MODE = "EquipmentMediator:BATCHDESTROY_MODE"
EquipmentMediator.SWITCH_TO_SPWEAPON_PAGE = "EquipmentMediator:SWITCH_TO_SPWEAPON_PAGE"
EquipmentMediator.ON_EQUIPMENT_SKIN_INFO = "EquipmentMediator:ON_EQUIPMENT_SKIN_INFO"
EquipmentMediator.ON_UNEQUIP_EQUIPMENT_SKIN = "EquipmentMediator:ON_UNEQUIP_EQUIPMENT_SKIN"
EquipmentMediator.ON_USE_ITEM = "EquipmentMediator:ON_USE_ITEM"
EquipmentMediator.NO_UPDATE = "EquipmentMediator:NO_UPDATE"
EquipmentMediator.ITEM_GO_SCENE = "item go scene"
EquipmentMediator.ITEM_ADD_LAYER = "EquipmentMediator.ITEM_ADD_LAYER"
EquipmentMediator.OPEN_EQUIPSKIN_INDEX_LAYER = "EquipmentMediator:OPEN_EQUIPSKIN_INDEX_LAYER"
EquipmentMediator.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"
EquipmentMediator.DESIGN_FILTER_CHANGED = "EquipmentMediator:DESIGN_FILTER_CHANGED"

function EquipmentMediator:register()
	self.contextData.warp = self.contextData.warp or getProxy(SettingsProxy):getEquipSceneIndex()

	self:bind(EquipmentMediator.DESIGN_FILTER_CHANGED, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TOGGLE_ALL_DESIGN_EQUIPMENT, arg_2_1)

		return
	end)
	self:bind(EquipmentMediator.ITEM_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, arg_3_2)

		return
	end)
	self:bind(EquipmentMediator.ITEM_ADD_LAYER, function(arg_4_0, arg_4_1)
		self:addSubLayers(arg_4_1)

		return
	end)
	self:bind(EquipmentMediator.ON_USE_ITEM, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_5_1,
			count = arg_5_2,
			arg = arg_5_3
		})

		return
	end)
	self:bind(EquipmentMediator.ON_DESTROY, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.DESTROY_EQUIPMENTS, {
			equipments = arg_6_1
		})

		return
	end)
	self:bind(EquipmentMediator.ON_UNEQUIP_EQUIPMENT, function(arg_7_0)
		self.canUpdate = false

		self:sendNotification(GAME.UNEQUIP_FROM_SHIP, {
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})

		return
	end)
	self:bind(EquipmentMediator.OPEN_DESIGN, function(arg_8_0)
		if getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator) then
			return
		end

		self:addSubLayers(Context.New({
			viewComponent = EquipmentDesignLayer,
			mediator = EquipmentDesignMediator,
			data = {
				groupName = self.viewComponent:getGroupName(),
				isShowAllDesign = self.viewComponent.isShowAllDesign
			}
		}))

		return
	end)
	self:bind(EquipmentMediator.CLOSE_DESIGN_LAYER, function(arg_9_0)
		local var_9_0 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(EquipmentDesignMediator)

		if var_9_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_9_0
			})
		end

		return
	end)
	self:bind(EquipmentMediator.OPEN_SPWEAPON_DESIGN, function(arg_10_0)
		if getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponDesignMediator) then
			return
		end

		self:addSubLayers(Context.New({
			viewComponent = SpWeaponDesignLayer,
			mediator = SpWeaponDesignMediator,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(EquipmentMediator.CLOSE_SPWEAPON_DESIGN_LAYER, function(arg_11_0)
		local var_11_0 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponDesignMediator)

		if var_11_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_11_0
			})
		end

		return
	end)
	self:bind(EquipmentMediator.ON_EQUIPMENT_SKIN_INFO, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = {
			mediator = EquipmentSkinMediator,
			viewComponent = EquipmentSkinLayer
		}
		local var_12_1 = {
			skinId = arg_12_1,
			shipId = self.contextData.shipId
		}

		if self.contextData.shipId then
			var_12_1.mode = EquipmentSkinLayer.REPLACE or EquipmentSkinLayer.DISPLAY
		end

		var_12_1.oldShipInfo = arg_12_3
		var_12_1.pos = arg_12_2
		var_12_0.data = var_12_1

		self:addSubLayers(Context.New(var_12_0))

		return
	end)
	self:bind(EquipmentMediator.ON_UNEQUIP_EQUIPMENT_SKIN, function(arg_13_0)
		self.canUpdate = false

		self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
			equipmentSkinId = 0,
			shipId = self.contextData.shipId,
			pos = self.contextData.pos
		})

		return
	end)
	self:bind(EquipmentMediator.OPEN_EQUIPSKIN_INDEX_LAYER, function(arg_14_0, arg_14_1)
		self:addSubLayers(Context.New({
			mediator = IndexMediator,
			viewComponent = IndexLayer,
			data = arg_14_1
		}))

		return
	end)
	self:bind(EquipmentMediator.OPEN_EQUIPMENT_INDEX, function(arg_15_0, arg_15_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_15_1
		}))

		return
	end)

	self.canUpdate = true

	local var_1_0 = getProxy(BayProxy)
	local var_1_1 = var_1_0:getShipById(self.contextData.shipId)

	self.viewComponent:setShip(var_1_1)

	if var_1_1 then
		if self.contextData.mode == StoreHouseConst.EQUIPMENT then
			self.contextData.qiutBtn = defaultValue(var_1_1:getEquip(self.contextData.pos), nil)
		elseif self.contextData.mode == StoreHouseConst.SKIN then
			self.contextData.qiutBtn = var_1_1:getEquipSkin(self.contextData.pos) ~= 0
		end
	end

	self.equipmentProxy = getProxy(EquipmentProxy)

	local var_1_2

	if self.contextData.equipmentVOs then
		var_1_2 = self.contextData.equipmentVOs
	else
		var_1_2 = self.equipmentProxy:getEquipments(true)

		for iter_1_0, iter_1_1 in ipairs(var_1_0:getEquipsInShips()) do
			table.insert(var_1_2, iter_1_1)
		end

		for iter_1_2, iter_1_3 in pairs(self.equipmentProxy:getEquipmentSkins()) do
			table.insert(var_1_2, {
				isSkin = true,
				id = iter_1_3.id,
				count = iter_1_3.count
			})
		end

		for iter_1_4, iter_1_5 in pairs(var_1_0:getEquipmentSkinInShips()) do
			table.insert(var_1_2, {
				isSkin = true,
				count = 1,
				id = iter_1_5.id,
				shipId = iter_1_5.shipId,
				shipPos = iter_1_5.shipPos
			})
		end
	end

	self.viewComponent:setEquipments(var_1_2)
	self.viewComponent:setCapacity(self.equipmentProxy:getCapacity())
	self:UpdateSpWeapons()
	self.viewComponent:setItems((getProxy(BagProxy):getItemsByExclude()))
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function EquipmentMediator:UpdateSpWeapons()
	local var_16_0 = getProxy(BayProxy):RawGetShipById(self.contextData.shipId)
	local var_16_1 = getProxy(BayProxy):GetSpWeaponsInShips(var_16_0)

	for iter_16_0, iter_16_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		if not var_16_0 or not var_16_0:IsSpWeaponForbidden(iter_16_1) then
			table.insert(var_16_1, iter_16_1)
		end
	end

	self.viewComponent:SetSpWeapons(var_16_1)

	return
end

function EquipmentMediator:listNotificationInterests()
	return {
		EquipmentProxy.EQUIPMENT_UPDATED,
		BayProxy.SHIP_EQUIPMENT_ADDED,
		BayProxy.SHIP_EQUIPMENT_REMOVED,
		BayProxy.SHIP_UPDATED,
		PlayerProxy.UPDATED,
		GAME.USE_ITEM_DONE,
		GAME.DESTROY_EQUIPMENTS_DONE,
		BagProxy.ITEM_UPDATED,
		EquipmentMediator.BATCHDESTROY_MODE,
		EquipmentMediator.SWITCH_TO_SPWEAPON_PAGE,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.REVERT_EQUIPMENT_DONE,
		EquipmentProxy.EQUIPMENT_SKIN_UPDATED,
		GAME.UNEQUIP_FROM_SHIP_DONE,
		GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE,
		GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE,
		EquipmentMediator.NO_UPDATE,
		GAME.FRAG_SELL_DONE,
		GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED,
		EquipmentProxy.SPWEAPONS_UPDATED,
		GAME.LOVE_ITEM_MAIL_REPAIR_DONE,
		GAME.SELL_ITEM_DONE
	}
end

function EquipmentMediator:handleNotification(arg_18_1)
	local var_18_0 = arg_18_1:getName()
	local var_18_1 = arg_18_1:getBody()

	if var_18_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		self.viewComponent:setCapacity(self.equipmentProxy:getCapacity())
		self.viewComponent:setEquipment(var_18_1)

		if self.canUpdate then
			self.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_EQUIPMENT_ADDED then
		self.viewComponent:addShipEquipment(var_18_1)

		if self.canUpdate then
			self.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_EQUIPMENT_REMOVED then
		self.viewComponent:removeShipEquipment(var_18_1)

		if self.canUpdate then
			self.viewComponent:setEquipmentUpdate()
		end
	elseif var_18_0 == EquipmentProxy.EQUIPMENT_SKIN_UPDATED then
		self.viewComponent:setCapacity(self.equipmentProxy:getCapacity())
		self.viewComponent:setEquipmentSkin(var_18_1)

		if self.canUpdate then
			self.viewComponent:setEquipmentSkinUpdate()
		end
	elseif var_18_0 == BayProxy.SHIP_UPDATED then
		if var_18_1.id == self.contextData.shipId then
			self.viewComponent:setShip(var_18_1)
		end
	elseif var_18_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_18_1)
	elseif var_18_0 == GAME.USE_ITEM_DONE then
		if #var_18_1.drops > 0 then
			self.viewComponent:emit(BaseUI.ON_WORLD_ACHIEVE, {
				animation = true,
				items = var_18_1.drops,
				removeFunc = function()
					if var_18_1.isEquipBox then
						self:addSubLayers(Context.New({
							viewComponent = ResolveEquipmentLayer,
							mediator = ResolveEquipmentMediator,
							data = {
								Equipments = underscore.map(var_18_1.drops, function(arg_20_0)
									return Equipment.New({
										id = arg_20_0.id,
										count = arg_20_0.count
									})
								end)
							}
						}))
					end

					return
				end
			})
		end
	elseif var_18_0 == GAME.FRAG_SELL_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_18_1.awards)
	elseif var_18_0 == GAME.DESTROY_EQUIPMENTS_DONE then
		self.canUpdate = true

		self.viewComponent:setEquipmentUpdate()

		if #var_18_1 > 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1
			})
		end
	elseif var_18_0 == BagProxy.ITEM_UPDATED then
		if self.canUpdate then
			self.viewComponent:setItems((getProxy(BagProxy):getItemsByExclude()))
		end
	elseif var_18_0 == EquipmentMediator.BATCHDESTROY_MODE then
		self.viewComponent:SwitchToDestroy()
	elseif var_18_0 == EquipmentMediator.SWITCH_TO_SPWEAPON_PAGE then
		self.viewComponent:SwitchToSpWeaponStoreHouse()
	elseif var_18_0 == GAME.REVERT_EQUIPMENT_DONE then
		if #var_18_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1.awards
			})
		end
	elseif var_18_0 == GAME.EQUIP_TO_SHIP_DONE or var_18_0 == GAME.UNEQUIP_FROM_SHIP_DONE then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_18_0 == GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE or var_18_0 == GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_18_0 == EquipmentMediator.NO_UPDATE then
		self.canUpdate = false
	elseif var_18_0 == GAME.TRANSFORM_EQUIPMENT_AWARD_FINISHED then
		self:getViewComponent():Scroll2Equip(var_18_1.newEquip)
	elseif var_18_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		self:UpdateSpWeapons()
		self.viewComponent:SetSpWeaponUpdate()
	elseif var_18_0 == GAME.LOVE_ITEM_MAIL_REPAIR_DONE then
		if #var_18_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = var_18_1.awards
			})
		end
	elseif var_18_0 == GAME.SELL_ITEM_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_18_1.awards)
	end

	return
end

function EquipmentMediator:remove()
	getProxy(SettingsProxy):setEquipSceneIndex(self.contextData.warp)

	return
end

return EquipmentMediator
