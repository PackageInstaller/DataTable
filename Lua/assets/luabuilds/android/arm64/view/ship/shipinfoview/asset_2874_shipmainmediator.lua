local ShipMainMediator = class("ShipMainMediator", import("...base.ContextMediator"))

ShipMainMediator.ON_LOCK = "ShipMainMediator:ON_LOCK"
ShipMainMediator.ON_TAG = "ShipMainMediator:ON_TAG"
ShipMainMediator.ON_UPGRADE = "ShipMainMediator:ON_UPGRADE"
ShipMainMediator.ON_MOD = "ShipMainMediator:ON_MOD"
ShipMainMediator.ON_SKILL = "ShipMainMediator:ON_SKILL"
ShipMainMediator.OPEN_INTENSIFY = "ShipMainMediator:OPEN_INTENSIFY"
ShipMainMediator.CLOSE_INTENSIFY = "ShipMainMediator:CLOSE_INTENSIFY"
ShipMainMediator.OPEN_EVALUATION = "ShipMainMediator:OPEN_EVALUATION"
ShipMainMediator.CLOSE_UPGRADE = "ShipMainMediator:CLOSE_UPGRADE"
ShipMainMediator.CHANGE_SKIN = "ShipMainMediator:CHANGE_SKIN"
ShipMainMediator.BUY_ITEM = "ShipMainMediator:BUY_ITEM"
ShipMainMediator.UNEQUIP_FROM_SHIP_ALL = "ShipMainMediator:UNEQUIP_FROM_SHIP_ALL"
ShipMainMediator.UNEQUIP_FROM_SHIP = "ShipMainMediator:UNEQUIP_FROM_SHIP"
ShipMainMediator.NEXTSHIP = "ShipMainMediator:NEXTSHIP"
ShipMainMediator.ON_NEXTSHIP_PREPARE = "ShipMainMediator:ON_NEXTSHIP_PREPARE"
ShipMainMediator.OPEN_ACTIVITY = "ShipMainMediator:OPEN_ACTIVITY"
ShipMainMediator.PROPOSE = "ShipMainMediator:PROPOSE"
ShipMainMediator.RENAME_SHIP = "ShipMainMediator:RENAME_SHIP"
ShipMainMediator.OPEN_REMOULD = "ShipMainMediator:OPEN_REMOULD"
ShipMainMediator.CLOSE_REMOULD = "ShipMainMediator:CLOSE_REMOULD"
ShipMainMediator.ON_RECORD_EQUIPMENT = "ShipMainMediator:ON_RECORD_EQUIPMENT"
ShipMainMediator.ON_SELECT_EQUIPMENT = "ShipMainMediator:ON_SELECT_EQUIPMENT"
ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN = "ShipMainMediator:ON_SELECT_EQUIPMENT_SKIN"
ShipMainMediator.ON_SKIN_INFO = "ShipMainMediator:ON_SKIN_INFO"
ShipMainMediator.ON_UPGRADE_MAX_LEVEL = "ShipMainMediator:ON_UPGRADE_MAX_LEVEL"
ShipMainMediator.ON_TECHNOLOGY = "ShipMainMediator:ON_TECHNOLOGY"
ShipMainMediator.OPEN_SHIPPROFILE = "ShipMainMediator:OPEN_SHIPPROFILE"
ShipMainMediator.ON_META = "ShipMainMediator:ON_META"
ShipMainMediator.ON_SEL_COMMANDER = "ShipMainMediator:ON_SEL_COMMANDER"
ShipMainMediator.OPEN_EQUIP_UPGRADE = "ShipMainMediator:OPEN_EQUIP_UPGRADE"
ShipMainMediator.BUY_ITEM_BY_ACT = "ShipMainMediator:BUY_ITEM_BY_ACT"
ShipMainMediator.ON_ADD_SHIP_EXP = "ShipMainMediator:ON_ADD_SHIP_EXP"
ShipMainMediator.OPEN_EQUIPMENT_INDEX = "ShipMainMediator:OPEN_EQUIPMENT_INDEX"
ShipMainMediator.EQUIP_CHANGE_NOTICE = "ShipMainMediator:EQUIP_CHANGE_NOTICE"
ShipMainMediator.ON_SELECT_SPWEAPON = "ShipMainMediator:ON_SELECT_SPWEAPON"
ShipMainMediator.OPEN_EQUIP_CODE = "ShipMainMediator:OPEN_EQUIP_CODE"
ShipMainMediator.OPEN_EQUIP_CODE_SHARE = "ShipMainMediator:OPEN_EQUIP_CODE_SHARE"
ShipMainMediator.CHANGE_RANDOM_FLAG = "ShipMainMediator.CHANGE_RANDOM_FLAG"
ShipMainMediator.OPEN_PHANTOM_LAYER = "ShipMainMediator.OPEN_PHANTOM_LAYER"

function ShipMainMediator:register()
	self.bayProxy = getProxy(BayProxy)
	self.contextData.shipVOs = self.contextData.shipVOs or {}

	local var_1_0 = _.detect(self.contextData.shipVOs, function(arg_2_0)
		return self.contextData.shipId == arg_2_0.id
	end)
	local var_1_1 = self.bayProxy:getShipById(self.contextData.shipId)

	self.contextData.index = var_1_0 and table.indexof(self.contextData.shipVOs, var_1_0) or 1

	self.viewComponent:setShipList(self.contextData.shipVOs)
	self.viewComponent:setSkinList(getProxy(ShipSkinProxy):getSkinList())
	self.viewComponent:setShip(var_1_1)

	if self.contextData.selectContextData then
		self.contextData.selectContextData.infoShipId = self.contextData.shipId
	end

	self.showTrans = var_1_1:isRemoulded()

	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	local var_1_3 = getProxy(ContextProxy)

	self:bind(ShipMainMediator.ON_ADD_SHIP_EXP, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.USE_ADD_SHIPEXP_ITEM, {
			id = arg_3_1,
			items = arg_3_2
		})

		return
	end)
	self:bind(ShipMainMediator.BUY_ITEM_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_4_1,
			cnt = arg_4_2
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_SHIPPROFILE, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIP_PROFILE, {
			showTrans = arg_5_2,
			groupId = arg_5_1
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	self:bind(ShipMainMediator.EQUIP_CHANGE_NOTICE, function(arg_7_0, arg_7_1)
		self:sendNotification(arg_7_1.notice, arg_7_1.data)

		return
	end)
	self:bind(ShipMainMediator.ON_SKIN_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		self:addSubLayers(Context.New({
			viewComponent = EquipmentSkinLayer,
			mediator = EquipmentSkinMediator,
			data = {
				shipId = self.contextData.shipId,
				pos = arg_8_1,
				mode = EquipmentSkinLayer.DISPLAY,
				skinId = arg_8_2
			}
		}))

		return
	end)
	self:bind(ShipMainMediator.ON_RECORD_EQUIPMENT, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self:sendNotification(GAME.RECORD_SHIP_EQUIPMENT, {
			shipId = arg_9_1,
			index = arg_9_2,
			type = arg_9_3
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_EVALUATION, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("npc_evaluation_tip"))

			return
		end

		self:sendNotification(GAME.FETCH_EVALUATION, arg_10_1)

		return
	end)
	self:bind(ShipMainMediator.ON_SELECT_EQUIPMENT_SKIN, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			equipmentVOs = ShipMainMediator:getEquipmentSkins(self.viewComponent.shipVO, arg_11_1),
			shipId = self.contextData.shipId,
			pos = arg_11_1,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.SKIN
		})

		return
	end)
	self:bind(ShipMainMediator.ON_SELECT_EQUIPMENT, function(arg_12_0, arg_12_1)
		local var_12_0 = getProxy(BayProxy)
		local var_12_1 = var_12_0:getShipById(self.contextData.shipId)
		local var_12_2 = var_12_0:getEquipsInShips(function(arg_13_0, arg_13_1)
			return var_12_1.id ~= arg_13_1 and not var_12_1:isForbiddenAtPos(arg_13_0, arg_12_1)
		end)

		for iter_12_0, iter_12_1 in ipairs((getProxy(EquipmentProxy):getEquipments(true))) do
			if not var_12_1:isForbiddenAtPos(iter_12_1, arg_12_1) then
				table.insert(var_12_2, iter_12_1)
			end
		end

		_.each(var_12_2, function(arg_14_0)
			if not var_12_1:canEquipAtPos(arg_14_0, arg_12_1) then
				arg_14_0.mask = true
			end

			return
		end)
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			lock = true,
			equipmentVOs = var_12_2,
			shipId = self.contextData.shipId,
			pos = arg_12_1,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	self:bind(ShipMainMediator.ON_SELECT_SPWEAPON, function(arg_15_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.SPWEAPON_STOREHOUSE, {
			lock = true,
			shipId = self.contextData.shipId,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	self:bind(ShipMainMediator.ON_UPGRADE, function(arg_16_0, arg_16_1)
		self:openUpgrade()

		return
	end)
	self:bind(ShipMainMediator.CLOSE_UPGRADE, function(arg_17_0)
		self:closeUpgrade()

		return
	end)
	self:bind(ShipMainMediator.OPEN_INTENSIFY, function(arg_18_0)
		self:openIntensify()

		return
	end)
	self:bind(ShipMainMediator.CLOSE_INTENSIFY, function(arg_19_0)
		self:closeIntensify()

		return
	end)
	self:bind(ShipMainMediator.ON_LOCK, function(arg_20_0, arg_20_1, arg_20_2)
		self:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_20_1,
			is_locked = arg_20_2
		})

		return
	end)
	self:bind(ShipMainMediator.ON_TAG, function(arg_21_0, arg_21_1, arg_21_2)
		self:sendNotification(GAME.UPDATE_PREFERENCE, {
			shipId = arg_21_1,
			tag = arg_21_2
		})

		return
	end)
	self:bind(ShipMainMediator.ON_SKILL, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				skillOnShip = arg_22_2,
				skillId = arg_22_1,
				shipId = self.contextData.shipId,
				index = arg_22_3
			}
		}))

		return
	end)
	self:bind(ShipMainMediator.CHANGE_SKIN, function(arg_23_0, arg_23_1, arg_23_2)
		self:sendNotification(GAME.SET_SHIP_SKIN, {
			phantomId = 0,
			shipId = arg_23_1,
			skinId = arg_23_2
		})

		return
	end)
	self:bind(ShipMainMediator.BUY_ITEM, function(arg_24_0, arg_24_1, arg_24_2)
		self:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_24_1,
			count = arg_24_2
		})

		return
	end)
	self:bind(ShipMainMediator.UNEQUIP_FROM_SHIP_ALL, function(arg_25_0, arg_25_1)
		self:sendNotification(GAME.UNEQUIP_FROM_SHIP_ALL, {
			shipId = arg_25_1
		})

		return
	end)
	self:bind(ShipMainMediator.UNEQUIP_FROM_SHIP, function(arg_26_0, arg_26_1)
		self:sendNotification(GAME.UNEQUIP_FROM_SHIP, arg_26_1)

		return
	end)
	self:bind(ShipMainMediator.NEXTSHIP, function(arg_27_0, arg_27_1)
		self:nextPage(arg_27_1)

		return
	end)
	self:bind(ShipMainMediator.OPEN_ACTIVITY, function(arg_28_0, arg_28_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_28_1
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_REMOULD, function(arg_29_0)
		self:openRemould()

		return
	end)
	self:bind(ShipMainMediator.CLOSE_REMOULD, function(arg_30_0)
		self:closeRemould()

		return
	end)
	self:bind(ShipMainMediator.PROPOSE, function(arg_31_0, arg_31_1, arg_31_2)
		self:addSubLayers(Context.New({
			mediator = ProposeMediator,
			viewComponent = ProposeUI,
			data = {
				shipId = arg_31_1,
				callback = arg_31_2
			}
		}))

		return
	end)
	self:bind(ShipMainMediator.RENAME_SHIP, function(arg_32_0, arg_32_1, arg_32_2)
		self:sendNotification(GAME.RENAME_SHIP, {
			shipId = arg_32_1,
			name = arg_32_2
		})

		return
	end)
	self:bind(ShipMainMediator.ON_SEL_COMMANDER, function(arg_33_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDPOST, {
			selectedMin = 1,
			selectedMax = 1,
			mode = CommanderCatScene.MODE_SELECT,
			onShip = function(self)
				if self.shipId == self.contextData.shipId then
					local var_34_1 = i18n("commander_ship_already_equip")

					return
				end

				return true
			end,
			onSelected = function(self)
				if #self == 0 then
					self.contextData.unequipCommander = true
				else
					self.contextData.selectedId = self[1]
				end

				return
			end,
			quitTeam = getProxy(BayProxy):getShipById(self.contextData.shipId):hasCommander()
		})

		return
	end)
	self:bind(ShipMainMediator.ON_UPGRADE_MAX_LEVEL, function(arg_36_0, arg_36_1)
		self:sendNotification(GAME.UPGRADE_MAX_LEVEL, {
			shipId = arg_36_1
		})

		return
	end)
	self:bind(ShipMainMediator.ON_TECHNOLOGY, function(arg_37_0, arg_37_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT, {
			shipId = arg_37_1.id
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_EQUIP_UPGRADE, function(arg_38_0, arg_38_1)
		self:addSubLayers(Context.New({
			mediator = EquipUpgradeMediator,
			viewComponent = EquipUpgradeLayer,
			data = {
				shipId = arg_38_1
			}
		}))

		return
	end)
	self:bind(ShipMainMediator.ON_META, function(arg_39_0, arg_39_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenShipConfigID = arg_39_1.configId
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_EQUIP_CODE, function(arg_40_0, arg_40_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIP_CODE, {
			shipId = self.contextData.shipId,
			code = arg_40_1.code
		})

		return
	end)
	self:bind(ShipMainMediator.OPEN_EQUIP_CODE_SHARE, function(arg_41_0, arg_41_1, arg_41_2)
		self:addSubLayers(Context.New({
			mediator = EquipCodeShareMediator,
			viewComponent = EquipCodeShareLayer,
			data = {
				shipId = arg_41_1,
				shipGroupId = arg_41_2
			}
		}))

		return
	end)
	self:bind(ShipMainMediator.CHANGE_RANDOM_FLAG, function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = {}

		var_42_0.addList = arg_42_2 and {
			arg_42_1
		} or {}
		var_42_0.deleteList = not arg_42_2 and {
			arg_42_1
		} or {}

		self:sendNotification(GAME.CHANGE_RANDOM_SHIPS, var_42_0)

		return
	end)
	self:bind(ShipMainMediator.OPEN_PHANTOM_LAYER, function(arg_43_0, arg_43_1)
		self:addSubLayers(Context.New({
			mediator = DockyardMediator,
			viewComponent = DockyardScene,
			data = {
				mode = DockyardScene.MODE_SHIP_PHANTOM,
				techVersion = arg_43_1
			},
			onRemoved = function()
				self.viewComponent:changePaintingSortLayer(true)

				return
			end
		}))
		self.viewComponent:changePaintingSortLayer(false)

		return
	end)

	if self.contextData.selectedId then
		self:sendNotification(GAME.COMMANDER_EQUIP_TO_SHIP, {
			shipId = self.contextData.shipId,
			commanderId = self.contextData.selectedId
		})

		self.contextData.selectedId = nil
	elseif self.contextData.unequipCommander then
		self.contextData.unequipCommander = nil

		self:sendNotification(GAME.COMMANDER_EQUIP_TO_SHIP, {
			commanderId = 0,
			shipId = self.contextData.shipId
		})
	end

	self.viewComponent:setMaxLevelHelpFlag((getProxy(SettingsProxy):getMaxLevelHelp()))

	return
end

function ShipMainMediator:getEquipmentSkins(arg_45_1, arg_45_2)
	if not arg_45_1 then
		return {}
	end

	local var_45_0 = arg_45_1:getEquip(arg_45_2)
	local var_45_1 = var_45_0 and {
		var_45_0:getType()
	} or arg_45_1:getSkinTypes(arg_45_2)
	local var_45_2 = _.map(getProxy(EquipmentProxy):getSkinsByTypes(var_45_1), function(arg_47_0)
		return {
			isSkin = true,
			id = arg_47_0.id,
			count = arg_47_0.count
		}
	end)

	for iter_45_0, iter_45_1 in ipairs(_.map(getProxy(BayProxy):getEquipmentSkinInShips(arg_45_1, var_45_1), function(arg_46_0)
		return {
			isSkin = true,
			count = 1,
			id = arg_46_0.id,
			shipId = arg_46_0.shipId,
			shipPos = arg_46_0.shipPos
		}
	end) or {}) do
		table.insert(var_45_2, iter_45_1)
	end

	return var_45_2
end

function ShipMainMediator:nextPage(arg_48_1, arg_48_2)
	if #self.contextData.shipVOs == 0 then
		return
	end

	local var_48_0 = 1
	local var_48_1 = 1
	local var_48_2 = 1

	if arg_48_1 then
		var_48_0 = self.contextData.index + 1
		var_48_1 = #self.contextData.shipVOs
	else
		var_48_0 = self.contextData.index - 1
		var_48_2 = -1
	end

	local var_48_3

	for iter_48_0 = var_48_0, var_48_1, var_48_2 do
		if self.contextData.shipVOs[iter_48_0] then
			var_48_3 = self.bayProxy:getShipById(self.contextData.shipVOs[iter_48_0].id)

			if var_48_3 then
				self.contextData.index = iter_48_0
				self.contextData.shipId = var_48_3.id

				break
			end
		end
	end

	if var_48_3 == nil then
		if arg_48_2 == nil then
			return
		end

		var_48_3 = self.bayProxy:getShipById(self.contextData.shipVOs[self.contextData.index].id)
		self.contextData.shipId = var_48_3.id
	end

	if var_48_3 then
		self.viewComponent:emit(ShipMainMediator.ON_NEXTSHIP_PREPARE, var_48_3)
		self.viewComponent:setPreOrNext(arg_48_1, var_48_3)

		self.viewComponent.fashionGroup = 0
		self.viewComponent.fashionSkinId = 0

		self.viewComponent:setShip(var_48_3)

		if self.contextData.selectContextData then
			self.contextData.selectContextData.infoShipId = var_48_3.id
		end

		self.viewComponent:updatePreferenceTag()
		self.viewComponent:displayShipWord("detail", true)
		self.viewComponent:closeRecordPanel()

		local var_48_4 = ShipViewConst.currentPage

		if ShipViewConst.currentPage == ShipViewConst.PAGE.UPGRADE then
			self:closeUpgrade()
		elseif var_48_4 == ShipViewConst.PAGE.INTENSIFY and not self.intensifyContext then
			self:closeIntensify()
		elseif var_48_4 == ShipViewConst.PAGE.EQUIPMENT and self.contextData.isInEquipmentSkinPage and var_48_3:hasEquipEquipmentSkin() and not ShipStatus.ShipStatusCheck("onModify", var_48_3) then
			-- block empty
		end

		if self.viewComponent:checkToggleActive(var_48_4) == false then
			var_48_4 = ShipViewConst.PAGE.DETAIL
		end

		self.viewComponent:gotoPage(var_48_4)
		self.viewComponent:switchToPage(var_48_4, true)
	end

	return var_48_3
end

function ShipMainMediator:openRemould()
	if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipRemouldMediator) then
		return
	end

	self:addSubLayers(Context.New({
		viewComponent = ShipRemouldLayer,
		mediator = ShipRemouldMediator,
		data = {
			shipId = self.contextData.shipId
		}
	}))

	return
end

function ShipMainMediator:closeRemould()
	local var_50_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipRemouldMediator)

	if var_50_0 then
		self:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_50_0
		})
	end

	return
end

function ShipMainMediator:openUpgrade()
	if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipUpgradeMediator2) then
		return
	end

	self:addSubLayers(Context.New({
		mediator = ShipUpgradeMediator2,
		viewComponent = ShipUpgradeLayer2,
		data = {
			shipId = self.contextData.shipId,
			shipVOs = self.contextData.shipVOs,
			index = self.contextData.index
		}
	}))

	return
end

function ShipMainMediator:closeUpgrade()
	local var_52_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipUpgradeMediator2)

	if var_52_0 then
		self:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_52_0
		})
	end

	return
end

function ShipMainMediator:openIntensify()
	if self.intensifyContext ~= nil then
		self.intensifyContext.data.shipId = self.contextData.shipId

		return
	end

	if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipModMediator) then
		return
	end

	self.intensifyContext = Context.New({
		mediator = ShipModMediator,
		viewComponent = ShipModLayer,
		data = {
			shipId = self.contextData.shipId
		}
	})

	self:addSubLayers(self.intensifyContext, false, function()
		self.intensifyContext = nil

		return
	end)

	return
end

function ShipMainMediator:closeIntensify()
	local var_55_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipModMediator)

	if var_55_0 then
		self:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_55_0
		})
	end

	return
end

function ShipMainMediator:listNotificationInterests()
	return {
		GAME.DESTROY_SHIP_DONE,
		BayProxy.SHIP_UPDATED,
		GAME.UPDATE_LOCK_DONE,
		GAME.UPDATE_PREFERENCE_DONE,
		PlayerProxy.UPDATED,
		GAME.FETCH_EVALUATION_DONE,
		GAME.MOD_SHIP_DONE,
		ShipSkinProxy.SHIP_SKINS_UPDATE,
		ShipUpgradeMediator2.NEXTSHIP,
		ShipModMediator.LOADEND,
		GAME.RENAME_SHIP_DONE,
		GAME.RECORD_SHIP_EQUIPMENT_DONE,
		GAME.SKIN_SHOPPIGN_DONE,
		GAME.UPGRADE_MAX_LEVEL_DONE,
		GAME.SKIN_COUPON_SHOPPING_DONE,
		GAME.HIDE_Ship_MAIN_SCENE_WORD,
		GAME.PROPOSE_SHIP_DONE,
		GAME.USE_ADD_SHIPEXP_ITEM_DONE,
		GAME.CHANGE_SKIN_UPDATE,
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.WILL_LOGOUT,
		PaintingGroupConst.NotifyPaintingDownloadFinish,
		GAME.CHANGE_RANDOM_SHIPS_DONE
	}
end

function ShipMainMediator:handleNotification(arg_57_1)
	local var_57_0 = arg_57_1:getName()
	local var_57_1 = arg_57_1:getBody()

	if var_57_0 == BayProxy.SHIP_UPDATED then
		if var_57_1.id == self.contextData.shipId then
			self.showTrans = var_57_1:isRemoulded()

			self.viewComponent:setShip(var_57_1)
		end
	elseif var_57_0 == GAME.CHANGE_RANDOM_SHIPS_DONE then
		self.viewComponent:setShip(self.bayProxy:getShipById(self.contextData.shipId))
	elseif var_57_0 == GAME.CHANGE_SKIN_UPDATE then
		local var_57_2, var_57_3 = ShipPhantom.UnpackMark(var_57_1)

		if var_57_2 == self.contextData.shipId then
			local var_57_4 = self.bayProxy:getShipById(var_57_2)

			self.showTrans = var_57_4:isRemoulded()

			self.viewComponent:setShip(var_57_4)
		end
	elseif var_57_0 == GAME.DESTROY_SHIP_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipInfoMediator_destory"))
		self.viewComponent.event:emit(BaseUI.ON_CLOSE)
	elseif var_57_0 == GAME.UPDATE_LOCK_DONE then
		if var_57_1.id == self.contextData.shipId then
			self.viewComponent:updateLock()
		end
	elseif var_57_0 == GAME.UPDATE_PREFERENCE_DONE then
		if var_57_1.id == self.contextData.shipId then
			self.viewComponent:updatePreferenceTag()
		end
	elseif var_57_0 == GAME.MOD_SHIP_DONE then
		self.viewComponent:displayShipWord("upgrade", true)
	elseif var_57_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	elseif var_57_0 == GAME.FETCH_EVALUATION_DONE then
		self:addSubLayers(Context.New({
			mediator = ShipEvaluationMediator,
			viewComponent = ShipEvaluationLayer,
			data = {
				groupId = var_57_1,
				showTrans = self.showTrans
			}
		}))
	elseif var_57_0 == ShipSkinProxy.SHIP_SKINS_UPDATE then
		self.viewComponent:setSkinList(getProxy(ShipSkinProxy):getSkinList())

		self.viewComponent.fashionGroup = 0

		self.viewComponent.shipFashionView:UpdateFashion(true)
	elseif var_57_0 == ShipUpgradeMediator2.NEXTSHIP then
		local var_57_5 = self:nextPage(var_57_1, 3)
	elseif var_57_0 == ShipModMediator.LOADEND then
		self.viewComponent:setModPanel(var_57_1)
	elseif var_57_0 == GAME.RENAME_SHIP_DONE then
		self.viewComponent:DisplayRenamePanel(false)
	elseif var_57_0 == GAME.RECORD_SHIP_EQUIPMENT_DONE then
		if var_57_1.shipId == self.contextData.shipId and var_57_1.type == 1 then
			self.viewComponent:updateRecordEquipments(var_57_1.index)
		end
	elseif var_57_0 == GAME.SKIN_SHOPPIGN_DONE or var_57_0 == GAME.SKIN_COUPON_SHOPPING_DONE then
		local var_57_6 = pg.shop_template[var_57_1.id]

		if pg.shop_template[var_57_1.id] and var_57_6.genre == ShopArgs.SkinShop then
			self.viewComponent:StopPreVoice()
			self:addSubLayers(Context.New({
				mediator = NewSkinMediator,
				viewComponent = NewSkinLayer,
				data = {
					skinId = var_57_6.effect_args[1]
				}
			}))
		end
	elseif var_57_0 == GAME.UPGRADE_MAX_LEVEL_DONE then
		self:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, false)

		self.maxLevelCallback = var_57_1.callback

		self.viewComponent:doUpgradeMaxLeveAnim(var_57_1.oldShip, var_57_1.newShip, function()
			if self.maxLevelCallback then
				self.maxLevelCallback()

				self.maxLevelCallback = nil
			end

			self:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
			self.viewComponent:showAwakenCompleteAni(i18n("upgrade_to_next_maxlevel_succeed", var_57_1.newShip:getMaxLevel()))

			return
		end)
	elseif var_57_0 == GAME.HIDE_Ship_MAIN_SCENE_WORD then
		self.viewComponent:hideShipWord()
	elseif var_57_0 == GAME.PROPOSE_SHIP_DONE then
		if self.viewComponent.shipFashionView and self.viewComponent.shipFashionView:GetLoaded() then
			self.viewComponent.shipFashionView:UpdateAllFashion(true)
		end
	elseif var_57_0 == GAME.USE_ADD_SHIPEXP_ITEM_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipModLayer_modSuccess"))
		self.viewComponent:RefreshShipExpItemUsagePage()
	elseif var_57_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		self.viewComponent:equipmentChange()
	elseif var_57_0 == GAME.WILL_LOGOUT then
		self.viewComponent:OnWillLogout()
	elseif var_57_0 == PaintingGroupConst.NotifyPaintingDownloadFinish then
		self.viewComponent:updateFashionTag()
	end

	return
end

function ShipMainMediator:remove()
	if self.maxLevelCallback then
		self.maxLevelCallback()

		self.maxLevelCallback = nil

		self:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
	end

	return
end

return ShipMainMediator
