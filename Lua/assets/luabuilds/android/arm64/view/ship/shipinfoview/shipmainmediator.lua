local var_0_0 = class("ShipMainMediator", import("...base.ContextMediator"))

var_0_0.ON_LOCK = "ShipMainMediator:ON_LOCK"
var_0_0.ON_TAG = "ShipMainMediator:ON_TAG"
var_0_0.ON_UPGRADE = "ShipMainMediator:ON_UPGRADE"
var_0_0.ON_MOD = "ShipMainMediator:ON_MOD"
var_0_0.ON_SKILL = "ShipMainMediator:ON_SKILL"
var_0_0.OPEN_INTENSIFY = "ShipMainMediator:OPEN_INTENSIFY"
var_0_0.CLOSE_INTENSIFY = "ShipMainMediator:CLOSE_INTENSIFY"
var_0_0.OPEN_EVALUATION = "ShipMainMediator:OPEN_EVALUATION"
var_0_0.CLOSE_UPGRADE = "ShipMainMediator:CLOSE_UPGRADE"
var_0_0.CHANGE_SKIN = "ShipMainMediator:CHANGE_SKIN"
var_0_0.BUY_ITEM = "ShipMainMediator:BUY_ITEM"
var_0_0.UNEQUIP_FROM_SHIP_ALL = "ShipMainMediator:UNEQUIP_FROM_SHIP_ALL"
var_0_0.UNEQUIP_FROM_SHIP = "ShipMainMediator:UNEQUIP_FROM_SHIP"
var_0_0.NEXTSHIP = "ShipMainMediator:NEXTSHIP"
var_0_0.ON_NEXTSHIP_PREPARE = "ShipMainMediator:ON_NEXTSHIP_PREPARE"
var_0_0.OPEN_ACTIVITY = "ShipMainMediator:OPEN_ACTIVITY"
var_0_0.PROPOSE = "ShipMainMediator:PROPOSE"
var_0_0.RENAME_SHIP = "ShipMainMediator:RENAME_SHIP"
var_0_0.OPEN_REMOULD = "ShipMainMediator:OPEN_REMOULD"
var_0_0.CLOSE_REMOULD = "ShipMainMediator:CLOSE_REMOULD"
var_0_0.ON_RECORD_EQUIPMENT = "ShipMainMediator:ON_RECORD_EQUIPMENT"
var_0_0.ON_SELECT_EQUIPMENT = "ShipMainMediator:ON_SELECT_EQUIPMENT"
var_0_0.ON_SELECT_EQUIPMENT_SKIN = "ShipMainMediator:ON_SELECT_EQUIPMENT_SKIN"
var_0_0.ON_SKIN_INFO = "ShipMainMediator:ON_SKIN_INFO"
var_0_0.ON_UPGRADE_MAX_LEVEL = "ShipMainMediator:ON_UPGRADE_MAX_LEVEL"
var_0_0.ON_TECHNOLOGY = "ShipMainMediator:ON_TECHNOLOGY"
var_0_0.OPEN_SHIPPROFILE = "ShipMainMediator:OPEN_SHIPPROFILE"
var_0_0.ON_META = "ShipMainMediator:ON_META"
var_0_0.ON_SEL_COMMANDER = "ShipMainMediator:ON_SEL_COMMANDER"
var_0_0.OPEN_EQUIP_UPGRADE = "ShipMainMediator:OPEN_EQUIP_UPGRADE"
var_0_0.BUY_ITEM_BY_ACT = "ShipMainMediator:BUY_ITEM_BY_ACT"
var_0_0.ON_ADD_SHIP_EXP = "ShipMainMediator:ON_ADD_SHIP_EXP"
var_0_0.OPEN_EQUIPMENT_INDEX = "ShipMainMediator:OPEN_EQUIPMENT_INDEX"
var_0_0.EQUIP_CHANGE_NOTICE = "ShipMainMediator:EQUIP_CHANGE_NOTICE"
var_0_0.ON_SELECT_SPWEAPON = "ShipMainMediator:ON_SELECT_SPWEAPON"
var_0_0.OPEN_EQUIP_CODE = "ShipMainMediator:OPEN_EQUIP_CODE"
var_0_0.OPEN_EQUIP_CODE_SHARE = "ShipMainMediator:OPEN_EQUIP_CODE_SHARE"
var_0_0.CHANGE_RANDOM_FLAG = "ShipMainMediator.CHANGE_RANDOM_FLAG"
var_0_0.OPEN_PHANTOM_LAYER = "ShipMainMediator.OPEN_PHANTOM_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0.bayProxy = getProxy(BayProxy)
	arg_1_0.contextData.shipVOs = arg_1_0.contextData.shipVOs or {}

	local var_1_0 = _.detect(arg_1_0.contextData.shipVOs, function(arg_2_0)
		return arg_1_0.contextData.shipId == arg_2_0.id
	end)
	local var_1_1 = arg_1_0.bayProxy:getShipById(arg_1_0.contextData.shipId)
	local var_1_2 = arg_1_0.contextData

	var_1_2.index = var_1_0 and table.indexof(arg_1_0.contextData.shipVOs, var_1_0) or 1

	arg_1_0.viewComponent:setShipList(arg_1_0.contextData.shipVOs)
	arg_1_0.viewComponent:setSkinList(getProxy(ShipSkinProxy):getSkinList())
	arg_1_0.viewComponent:setShip(var_1_1)

	if arg_1_0.contextData.selectContextData then
		arg_1_0.contextData.selectContextData.infoShipId = arg_1_0.contextData.shipId
	end

	arg_1_0.showTrans = var_1_1:isRemoulded()

	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	local var_1_3 = getProxy(ContextProxy)

	arg_1_0:bind(var_0_0.ON_ADD_SHIP_EXP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.USE_ADD_SHIPEXP_ITEM, {
			id = arg_3_1,
			items = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_4_1,
			cnt = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHIPPROFILE, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIP_PROFILE, {
			showTrans = arg_5_2,
			groupId = arg_5_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.EQUIP_CHANGE_NOTICE, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(arg_7_1.notice, arg_7_1.data)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKIN_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EquipmentSkinLayer,
			mediator = EquipmentSkinMediator,
			data = {
				shipId = arg_1_0.contextData.shipId,
				pos = arg_8_1,
				mode = EquipmentSkinLayer.DISPLAY,
				skinId = arg_8_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_RECORD_EQUIPMENT, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_1_0:sendNotification(GAME.RECORD_SHIP_EQUIPMENT, {
			shipId = arg_9_1,
			index = arg_9_2,
			type = arg_9_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EVALUATION, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("npc_evaluation_tip"))

			return
		end

		arg_1_0:sendNotification(GAME.FETCH_EVALUATION, arg_10_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_EQUIPMENT_SKIN, function(arg_11_0, arg_11_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			equipmentVOs = var_0_0:getEquipmentSkins(arg_1_0.viewComponent.shipVO, arg_11_1),
			shipId = arg_1_0.contextData.shipId,
			pos = arg_11_1,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.SKIN
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_EQUIPMENT, function(arg_12_0, arg_12_1)
		local var_12_0 = getProxy(BayProxy)
		local var_12_1 = var_12_0:getShipById(arg_1_0.contextData.shipId)
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
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
			lock = true,
			equipmentVOs = var_12_2,
			shipId = arg_1_0.contextData.shipId,
			pos = arg_12_1,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_SPWEAPON, function(arg_15_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SPWEAPON_STOREHOUSE, {
			lock = true,
			shipId = arg_1_0.contextData.shipId,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE, function(arg_16_0, arg_16_1)
		arg_1_0:openUpgrade()

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_UPGRADE, function(arg_17_0)
		arg_1_0:closeUpgrade()

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_INTENSIFY, function(arg_18_0)
		arg_1_0:openIntensify()

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_INTENSIFY, function(arg_19_0)
		arg_1_0:closeIntensify()

		return
	end)
	arg_1_0:bind(var_0_0.ON_LOCK, function(arg_20_0, arg_20_1, arg_20_2)
		arg_1_0:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_20_1,
			is_locked = arg_20_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TAG, function(arg_21_0, arg_21_1, arg_21_2)
		arg_1_0:sendNotification(GAME.UPDATE_PREFERENCE, {
			shipId = arg_21_1,
			tag = arg_21_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SKILL, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		arg_1_0:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				skillOnShip = arg_22_2,
				skillId = arg_22_1,
				shipId = arg_1_0.contextData.shipId,
				index = arg_22_3
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_SKIN, function(arg_23_0, arg_23_1, arg_23_2)
		arg_1_0:sendNotification(GAME.SET_SHIP_SKIN, {
			phantomId = 0,
			shipId = arg_23_1,
			skinId = arg_23_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_24_0, arg_24_1, arg_24_2)
		arg_1_0:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_24_1,
			count = arg_24_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.UNEQUIP_FROM_SHIP_ALL, function(arg_25_0, arg_25_1)
		arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP_ALL, {
			shipId = arg_25_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.UNEQUIP_FROM_SHIP, function(arg_26_0, arg_26_1)
		arg_1_0:sendNotification(GAME.UNEQUIP_FROM_SHIP, arg_26_1)

		return
	end)
	arg_1_0:bind(var_0_0.NEXTSHIP, function(arg_27_0, arg_27_1)
		arg_1_0:nextPage(arg_27_1)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_ACTIVITY, function(arg_28_0, arg_28_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_28_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_REMOULD, function(arg_29_0)
		arg_1_0:openRemould()

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_REMOULD, function(arg_30_0)
		arg_1_0:closeRemould()

		return
	end)
	arg_1_0:bind(var_0_0.PROPOSE, function(arg_31_0, arg_31_1, arg_31_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = ProposeMediator,
			viewComponent = ProposeUI,
			data = {
				shipId = arg_31_1,
				callback = arg_31_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.RENAME_SHIP, function(arg_32_0, arg_32_1, arg_32_2)
		arg_1_0:sendNotification(GAME.RENAME_SHIP, {
			shipId = arg_32_1,
			name = arg_32_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SEL_COMMANDER, function(arg_33_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDPOST, {
			selectedMin = 1,
			selectedMax = 1,
			mode = CommanderCatScene.MODE_SELECT,
			onShip = function(arg_34_0)
				if arg_34_0.shipId == arg_1_0.contextData.shipId then
					local var_34_1 = i18n("commander_ship_already_equip")

					return
				end

				return true
			end,
			onSelected = function(arg_35_0)
				if #arg_35_0 == 0 then
					arg_1_0.contextData.unequipCommander = true
				else
					arg_1_0.contextData.selectedId = arg_35_0[1]
				end

				return
			end,
			quitTeam = getProxy(BayProxy):getShipById(arg_1_0.contextData.shipId):hasCommander()
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPGRADE_MAX_LEVEL, function(arg_36_0, arg_36_1)
		arg_1_0:sendNotification(GAME.UPGRADE_MAX_LEVEL, {
			shipId = arg_36_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TECHNOLOGY, function(arg_37_0, arg_37_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPBLUEPRINT, {
			shipId = arg_37_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIP_UPGRADE, function(arg_38_0, arg_38_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = EquipUpgradeMediator,
			viewComponent = EquipUpgradeLayer,
			data = {
				shipId = arg_38_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_META, function(arg_39_0, arg_39_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenShipConfigID = arg_39_1.configId
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIP_CODE, function(arg_40_0, arg_40_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIP_CODE, {
			shipId = arg_1_0.contextData.shipId,
			code = arg_40_1.code
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIP_CODE_SHARE, function(arg_41_0, arg_41_1, arg_41_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = EquipCodeShareMediator,
			viewComponent = EquipCodeShareLayer,
			data = {
				shipId = arg_41_1,
				shipGroupId = arg_41_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_RANDOM_FLAG, function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = arg_1_0
		local var_42_2 = GAME.CHANGE_RANDOM_SHIPS
		local var_42_3 = {}

		if arg_42_2 then
			local var_42_4 = {
				arg_42_1
			}

			if not {
				arg_42_1
			} then
				var_42_4 = {}
			end

			var_42_3.addList = var_42_4

			if not arg_42_2 then
				local var_42_5 = {
					arg_42_1
				}

				if not {
					arg_42_1
				} then
					var_42_5 = {}
				end

				var_42_3.deleteList = var_42_5

				var_42_1(var_42_0, var_42_2, var_42_3)

				return
			end
		end
	end)
	arg_1_0:bind(var_0_0.OPEN_PHANTOM_LAYER, function(arg_43_0, arg_43_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = DockyardMediator,
			viewComponent = DockyardScene,
			data = {
				mode = DockyardScene.MODE_SHIP_PHANTOM,
				techVersion = arg_43_1
			},
			onRemoved = function()
				arg_1_0.viewComponent:changePaintingSortLayer(true)

				return
			end
		}))
		arg_1_0.viewComponent:changePaintingSortLayer(false)

		return
	end)

	if arg_1_0.contextData.selectedId then
		arg_1_0:sendNotification(GAME.COMMANDER_EQUIP_TO_SHIP, {
			shipId = arg_1_0.contextData.shipId,
			commanderId = arg_1_0.contextData.selectedId
		})

		arg_1_0.contextData.selectedId = nil
	elseif arg_1_0.contextData.unequipCommander then
		arg_1_0.contextData.unequipCommander = nil

		arg_1_0:sendNotification(GAME.COMMANDER_EQUIP_TO_SHIP, {
			commanderId = 0,
			shipId = arg_1_0.contextData.shipId
		})
	end

	local var_1_4 = getProxy(SettingsProxy)

	arg_1_0.viewComponent:setMaxLevelHelpFlag((var_1_4:getMaxLevelHelp()))

	return
end

function var_0_0.getEquipmentSkins(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 then
		return {}
	end

	local var_45_0 = arg_45_1:getEquip(arg_45_2)
	local var_45_1 = var_45_0 and {
		var_45_0:getType()
	} or arg_45_1:getSkinTypes(arg_45_2)
	local var_45_2 = getProxy(EquipmentProxy)
	local var_45_3 = _.map(var_45_2:getSkinsByTypes(var_45_1), function(arg_47_0)
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
		table.insert(var_45_3, iter_45_1)
	end

	return var_45_3
end

function var_0_0.nextPage(arg_48_0, arg_48_1, arg_48_2)
	if #arg_48_0.contextData.shipVOs == 0 then
		return
	end

	local var_48_0 = 1
	local var_48_1 = 1
	local var_48_2 = 1

	if arg_48_1 then
		var_48_0 = arg_48_0.contextData.index + 1
		var_48_1 = #arg_48_0.contextData.shipVOs
	else
		var_48_0 = arg_48_0.contextData.index - 1
		var_48_2 = -1
	end

	local var_48_3

	for iter_48_0 = var_48_0, var_48_1, var_48_2 do
		if arg_48_0.contextData.shipVOs[iter_48_0] then
			var_48_3 = arg_48_0.bayProxy:getShipById(arg_48_0.contextData.shipVOs[iter_48_0].id)

			if var_48_3 then
				arg_48_0.contextData.index = iter_48_0
				arg_48_0.contextData.shipId = var_48_3.id

				break
			end
		end
	end

	if var_48_3 == nil then
		if arg_48_2 == nil then
			return
		end

		var_48_3 = arg_48_0.bayProxy:getShipById(arg_48_0.contextData.shipVOs[arg_48_0.contextData.index].id)
		arg_48_0.contextData.shipId = var_48_3.id
	end

	if var_48_3 then
		arg_48_0.viewComponent:emit(var_0_0.ON_NEXTSHIP_PREPARE, var_48_3)
		arg_48_0.viewComponent:setPreOrNext(arg_48_1, var_48_3)

		arg_48_0.viewComponent.fashionGroup = 0
		arg_48_0.viewComponent.fashionSkinId = 0

		arg_48_0.viewComponent:setShip(var_48_3)

		if arg_48_0.contextData.selectContextData then
			arg_48_0.contextData.selectContextData.infoShipId = var_48_3.id
		end

		arg_48_0.viewComponent:updatePreferenceTag()
		arg_48_0.viewComponent:displayShipWord("detail", true)
		arg_48_0.viewComponent:closeRecordPanel()

		local var_48_4 = ShipViewConst.currentPage

		if ShipViewConst.currentPage == ShipViewConst.PAGE.UPGRADE then
			arg_48_0:closeUpgrade()
		elseif var_48_4 == ShipViewConst.PAGE.INTENSIFY and not arg_48_0.intensifyContext then
			arg_48_0:closeIntensify()
		elseif var_48_4 == ShipViewConst.PAGE.EQUIPMENT and arg_48_0.contextData.isInEquipmentSkinPage and var_48_3:hasEquipEquipmentSkin() and not ShipStatus.ShipStatusCheck("onModify", var_48_3) then
			-- block empty
		end

		if arg_48_0.viewComponent:checkToggleActive(var_48_4) == false then
			var_48_4 = ShipViewConst.PAGE.DETAIL
		end

		arg_48_0.viewComponent:gotoPage(var_48_4)
		arg_48_0.viewComponent:switchToPage(var_48_4, true)
	end

	return var_48_3
end

function var_0_0.openRemould(arg_49_0)
	if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipRemouldMediator) then
		return
	end

	arg_49_0:addSubLayers(Context.New({
		viewComponent = ShipRemouldLayer,
		mediator = ShipRemouldMediator,
		data = {
			shipId = arg_49_0.contextData.shipId
		}
	}))

	return
end

function var_0_0.closeRemould(arg_50_0)
	local var_50_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipRemouldMediator)

	if var_50_0 then
		arg_50_0:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_50_0
		})
	end

	return
end

function var_0_0.openUpgrade(arg_51_0)
	if getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipUpgradeMediator2) then
		return
	end

	arg_51_0:addSubLayers(Context.New({
		mediator = ShipUpgradeMediator2,
		viewComponent = ShipUpgradeLayer2,
		data = {
			shipId = arg_51_0.contextData.shipId,
			shipVOs = arg_51_0.contextData.shipVOs,
			index = arg_51_0.contextData.index
		}
	}))

	return
end

function var_0_0.closeUpgrade(arg_52_0)
	local var_52_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipUpgradeMediator2)

	if var_52_0 then
		arg_52_0:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_52_0
		})
	end

	return
end

function var_0_0.openIntensify(arg_53_0)
	if arg_53_0.intensifyContext ~= nil then
		arg_53_0.intensifyContext.data.shipId = arg_53_0.contextData.shipId

		return
	end

	local var_53_0 = getProxy(ContextProxy):getCurrentContext()

	if var_53_0:getContextByMediator(ShipModMediator) then
		return
	end

	arg_53_0.intensifyContext = Context.New({
		mediator = ShipModMediator,
		viewComponent = ShipModLayer,
		data = {
			shipId = arg_53_0.contextData.shipId
		}
	})

	arg_53_0:addSubLayers(arg_53_0.intensifyContext, false, function()
		arg_53_0.intensifyContext = nil

		return
	end)

	return
end

function var_0_0.closeIntensify(arg_55_0)
	local var_55_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(ShipModMediator)

	if var_55_0 then
		arg_55_0:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_55_0
		})
	end

	return
end

function var_0_0.listNotificationInterests(arg_56_0)
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

function var_0_0.handleNotification(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_1:getName()
	local var_57_1 = arg_57_1:getBody()

	if var_57_0 == BayProxy.SHIP_UPDATED then
		if var_57_1.id == arg_57_0.contextData.shipId then
			arg_57_0.showTrans = var_57_1:isRemoulded()

			arg_57_0.viewComponent:setShip(var_57_1)
		end
	elseif var_57_0 == GAME.CHANGE_RANDOM_SHIPS_DONE then
		arg_57_0.viewComponent:setShip(arg_57_0.bayProxy:getShipById(arg_57_0.contextData.shipId))
	elseif var_57_0 == GAME.CHANGE_SKIN_UPDATE then
		local var_57_2, var_57_3 = ShipPhantom.UnpackMark(var_57_1)

		if var_57_2 == arg_57_0.contextData.shipId then
			local var_57_4 = arg_57_0.bayProxy:getShipById(var_57_2)

			arg_57_0.showTrans = var_57_4:isRemoulded()

			arg_57_0.viewComponent:setShip(var_57_4)
		end
	elseif var_57_0 == GAME.DESTROY_SHIP_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipInfoMediator_destory"))
		arg_57_0.viewComponent.event:emit(BaseUI.ON_CLOSE)
	elseif var_57_0 == GAME.UPDATE_LOCK_DONE then
		if var_57_1.id == arg_57_0.contextData.shipId then
			arg_57_0.viewComponent:updateLock()
		end
	elseif var_57_0 == GAME.UPDATE_PREFERENCE_DONE then
		if var_57_1.id == arg_57_0.contextData.shipId then
			arg_57_0.viewComponent:updatePreferenceTag()
		end
	elseif var_57_0 == GAME.MOD_SHIP_DONE then
		arg_57_0.viewComponent:displayShipWord("upgrade", true)
	elseif var_57_0 == PlayerProxy.UPDATED then
		arg_57_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	elseif var_57_0 == GAME.FETCH_EVALUATION_DONE then
		arg_57_0:addSubLayers(Context.New({
			mediator = ShipEvaluationMediator,
			viewComponent = ShipEvaluationLayer,
			data = {
				groupId = var_57_1,
				showTrans = arg_57_0.showTrans
			}
		}))
	elseif var_57_0 == ShipSkinProxy.SHIP_SKINS_UPDATE then
		arg_57_0.viewComponent:setSkinList(getProxy(ShipSkinProxy):getSkinList())

		arg_57_0.viewComponent.fashionGroup = 0

		arg_57_0.viewComponent.shipFashionView:UpdateFashion(true)
	elseif var_57_0 == ShipUpgradeMediator2.NEXTSHIP then
		local var_57_5 = arg_57_0:nextPage(var_57_1, 3)
	elseif var_57_0 == ShipModMediator.LOADEND then
		arg_57_0.viewComponent:setModPanel(var_57_1)
	elseif var_57_0 == GAME.RENAME_SHIP_DONE then
		arg_57_0.viewComponent:DisplayRenamePanel(false)
	elseif var_57_0 == GAME.RECORD_SHIP_EQUIPMENT_DONE then
		if var_57_1.shipId == arg_57_0.contextData.shipId and var_57_1.type == 1 then
			arg_57_0.viewComponent:updateRecordEquipments(var_57_1.index)
		end
	elseif var_57_0 == GAME.SKIN_SHOPPIGN_DONE or var_57_0 == GAME.SKIN_COUPON_SHOPPING_DONE then
		local var_57_6 = pg.shop_template[var_57_1.id]

		if pg.shop_template[var_57_1.id] and var_57_6.genre == ShopArgs.SkinShop then
			arg_57_0.viewComponent:StopPreVoice()
			arg_57_0:addSubLayers(Context.New({
				mediator = NewSkinMediator,
				viewComponent = NewSkinLayer,
				data = {
					skinId = var_57_6.effect_args[1]
				}
			}))
		end
	elseif var_57_0 == GAME.UPGRADE_MAX_LEVEL_DONE then
		arg_57_0:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, false)

		arg_57_0.maxLevelCallback = var_57_1.callback

		arg_57_0.viewComponent:doUpgradeMaxLeveAnim(var_57_1.oldShip, var_57_1.newShip, function()
			if arg_57_0.maxLevelCallback then
				arg_57_0.maxLevelCallback()

				arg_57_0.maxLevelCallback = nil
			end

			arg_57_0:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
			arg_57_0.viewComponent:showAwakenCompleteAni(i18n("upgrade_to_next_maxlevel_succeed", var_57_1.newShip:getMaxLevel()))

			return
		end)
	elseif var_57_0 == GAME.HIDE_Ship_MAIN_SCENE_WORD then
		arg_57_0.viewComponent:hideShipWord()
	elseif var_57_0 == GAME.PROPOSE_SHIP_DONE then
		if arg_57_0.viewComponent.shipFashionView and arg_57_0.viewComponent.shipFashionView:GetLoaded() then
			arg_57_0.viewComponent.shipFashionView:UpdateAllFashion(true)
		end
	elseif var_57_0 == GAME.USE_ADD_SHIPEXP_ITEM_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipModLayer_modSuccess"))
		arg_57_0.viewComponent:RefreshShipExpItemUsagePage()
	elseif var_57_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		arg_57_0.viewComponent:equipmentChange()
	elseif var_57_0 == GAME.WILL_LOGOUT then
		arg_57_0.viewComponent:OnWillLogout()
	elseif var_57_0 == PaintingGroupConst.NotifyPaintingDownloadFinish then
		arg_57_0.viewComponent:updateFashionTag()
	end

	return
end

function var_0_0.remove(arg_59_0)
	if arg_59_0.maxLevelCallback then
		arg_59_0.maxLevelCallback()

		arg_59_0.maxLevelCallback = nil

		arg_59_0:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
	end

	return
end

return var_0_0
