class = var_0_10000

local var_0_0 = "ShipMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_LOCK = "ShipMainMediator:ON_LOCK"
var_0_1.ON_TAG = "ShipMainMediator:ON_TAG"
var_0_1.ON_UPGRADE = "ShipMainMediator:ON_UPGRADE"
var_0_1.ON_MOD = "ShipMainMediator:ON_MOD"
var_0_1.ON_SKILL = "ShipMainMediator:ON_SKILL"
var_0_1.OPEN_INTENSIFY = "ShipMainMediator:OPEN_INTENSIFY"
var_0_1.CLOSE_INTENSIFY = "ShipMainMediator:CLOSE_INTENSIFY"
var_0_1.OPEN_EVALUATION = "ShipMainMediator:OPEN_EVALUATION"
var_0_1.CLOSE_UPGRADE = "ShipMainMediator:CLOSE_UPGRADE"
var_0_1.CHANGE_SKIN = "ShipMainMediator:CHANGE_SKIN"
var_0_1.BUY_ITEM = "ShipMainMediator:BUY_ITEM"
var_0_1.UNEQUIP_FROM_SHIP_ALL = "ShipMainMediator:UNEQUIP_FROM_SHIP_ALL"
var_0_1.UNEQUIP_FROM_SHIP = "ShipMainMediator:UNEQUIP_FROM_SHIP"
var_0_1.NEXTSHIP = "ShipMainMediator:NEXTSHIP"
var_0_1.ON_NEXTSHIP_PREPARE = "ShipMainMediator:ON_NEXTSHIP_PREPARE"
var_0_1.OPEN_ACTIVITY = "ShipMainMediator:OPEN_ACTIVITY"
var_0_1.PROPOSE = "ShipMainMediator:PROPOSE"
var_0_1.RENAME_SHIP = "ShipMainMediator:RENAME_SHIP"
var_0_1.OPEN_REMOULD = "ShipMainMediator:OPEN_REMOULD"
var_0_1.CLOSE_REMOULD = "ShipMainMediator:CLOSE_REMOULD"
var_0_1.ON_RECORD_EQUIPMENT = "ShipMainMediator:ON_RECORD_EQUIPMENT"
var_0_1.ON_SELECT_EQUIPMENT = "ShipMainMediator:ON_SELECT_EQUIPMENT"
var_0_1.ON_SELECT_EQUIPMENT_SKIN = "ShipMainMediator:ON_SELECT_EQUIPMENT_SKIN"
var_0_1.ON_SKIN_INFO = "ShipMainMediator:ON_SKIN_INFO"
var_0_1.ON_UPGRADE_MAX_LEVEL = "ShipMainMediator:ON_UPGRADE_MAX_LEVEL"
var_0_1.ON_TECHNOLOGY = "ShipMainMediator:ON_TECHNOLOGY"
var_0_1.OPEN_SHIPPROFILE = "ShipMainMediator:OPEN_SHIPPROFILE"
var_0_1.ON_META = "ShipMainMediator:ON_META"
var_0_1.ON_SEL_COMMANDER = "ShipMainMediator:ON_SEL_COMMANDER"
var_0_1.OPEN_EQUIP_UPGRADE = "ShipMainMediator:OPEN_EQUIP_UPGRADE"
var_0_1.BUY_ITEM_BY_ACT = "ShipMainMediator:BUY_ITEM_BY_ACT"
var_0_1.ON_ADD_SHIP_EXP = "ShipMainMediator:ON_ADD_SHIP_EXP"
var_0_1.OPEN_EQUIPMENT_INDEX = "ShipMainMediator:OPEN_EQUIPMENT_INDEX"
var_0_1.EQUIP_CHANGE_NOTICE = "ShipMainMediator:EQUIP_CHANGE_NOTICE"
var_0_1.ON_SELECT_SPWEAPON = "ShipMainMediator:ON_SELECT_SPWEAPON"
var_0_1.OPEN_EQUIP_CODE = "ShipMainMediator:OPEN_EQUIP_CODE"
var_0_1.OPEN_EQUIP_CODE_SHARE = "ShipMainMediator:OPEN_EQUIP_CODE_SHARE"
var_0_1.CHANGE_RANDOM_FLAG = "ShipMainMediator.CHANGE_RANDOM_FLAG"
var_0_1.OPEN_PHANTOM_LAYER = "ShipMainMediator.OPEN_PHANTOM_LAYER"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003
	arg_1_0.bayProxy = var_1_10001(var_1_10003)

	local var_1_0 = arg_1_0.contextData
	local var_1_1

	if not arg_1_0.contextData.shipVOs then
		var_1_1 = {}
	end

	var_1_0.shipVOs = var_1_1
	_ = var_1_0

	local var_1_2 = var_1_0.detect(arg_1_0.contextData.shipVOs, function(arg_2_0)
		return arg_1_0.contextData.shipId == arg_2_0.id
	end)
	local var_1_3 = arg_1_0.bayProxy
	local var_1_4 = var_2.getShipById(var_1_3, arg_1_0.contextData.shipId)
	local var_1_5 = arg_1_0.contextData

	if var_1_2 then
		table = var_1_3

		local var_1_6

		if not var_1_3.indexof(arg_1_0.contextData.shipVOs, var_1_2) then
			var_1_6 = 1
		end

		var_1_5.index = var_1_6

		local var_1_7 = arg_1_0.viewComponent

		var_3.setShipList(var_1_7, arg_1_0.contextData.shipVOs)

		local var_1_8 = arg_1_0.viewComponent
		local var_1_9 = var_3.setSkinList

		getProxy = var_6
		ShipSkinProxy = var_1_10008

		local var_1_10 = var_6(var_1_10008)

		var_1_9(var_1_8, var_6.getSkinList(var_1_10))

		local var_1_11 = arg_1_0.viewComponent

		var_3.setShip(var_1_11, var_1_4)

		if arg_1_0.contextData.selectContextData then
			arg_1_0.contextData.selectContextData.infoShipId = arg_1_0.contextData.shipId
		end

		local var_1_12 = var_1_4

		arg_1_0.showTrans = var_1_4.isRemoulded(var_1_12)
		getProxy = var_3
		PlayerProxy = var_1_12

		local var_1_13 = var_3(var_1_12)
		local var_1_14 = var_3.getData(var_1_13)
		local var_1_15 = arg_1_0.viewComponent

		var_5.setPlayer(var_1_15, var_1_14)

		getProxy = var_5
		ContextProxy = var_1_15

		local var_1_16 = var_5(var_1_15)

		arg_1_0:bind(var_0_1.ON_ADD_SHIP_EXP, function(arg_3_0, arg_3_1, arg_3_2)
			local var_3_0 = arg_1_0
			local var_3_1 = var_3.sendNotification

			GAME = var_2_10006

			var_3_1(var_3_0, var_2_10006.USE_ADD_SHIPEXP_ITEM, {
				id = arg_3_1,
				items = arg_3_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.BUY_ITEM_BY_ACT, function(arg_4_0, arg_4_1, arg_4_2)
			local var_4_0 = arg_1_0
			local var_4_1 = var_3.sendNotification

			GAME = var_2_10006

			var_4_1(var_4_0, var_2_10006.SKIN_COUPON_SHOPPING, {
				shopId = arg_4_1,
				cnt = arg_4_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_SHIPPROFILE, function(arg_5_0, arg_5_1, arg_5_2)
			local var_5_0 = arg_1_0
			local var_5_1 = var_3.sendNotification

			GAME = var_2_10006

			local var_5_2 = var_2_10006.GO_SCENE

			SCENE = var_2_10007

			var_5_1(var_5_0, var_5_2, var_2_10007.SHIP_PROFILE, {
				showTrans = arg_5_2,
				groupId = arg_5_1
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
			local var_6_0 = arg_1_0
			local var_6_1 = var_2.addSubLayers

			Context = var_2_10005

			local var_6_2 = var_2_10005.New
			local var_6_3 = {}

			CustomIndexLayer = var_2_10008
			var_6_3.viewComponent = var_2_10008
			CustomIndexMediator = var_2_10008
			var_6_3.mediator = var_2_10008
			var_6_3.data = arg_6_1

			var_6_1(var_6_0, var_6_2(var_6_3))

			return
		end)
		arg_1_0:bind(var_0_1.EQUIP_CHANGE_NOTICE, function(arg_7_0, arg_7_1)
			local var_7_0 = arg_1_0

			var_2.sendNotification(var_7_0, arg_7_1.notice, arg_7_1.data)

			return
		end)
		arg_1_0:bind(var_0_1.ON_SKIN_INFO, function(arg_8_0, arg_8_1, arg_8_2)
			local var_8_0 = arg_1_0
			local var_8_1 = var_3.addSubLayers

			Context = var_2_10006

			local var_8_2 = var_2_10006.New
			local var_8_3 = {}

			EquipmentSkinLayer = var_2_10009
			var_8_3.viewComponent = var_2_10009
			EquipmentSkinMediator = var_2_10009
			var_8_3.mediator = var_2_10009

			local var_8_4 = {
				shipId = arg_1_0.contextData.shipId,
				pos = arg_8_1
			}

			EquipmentSkinLayer = var_10
			var_8_4.mode = var_10.DISPLAY
			var_8_4.skinId = arg_8_2
			var_8_3.data = var_8_4

			var_8_1(var_8_0, var_8_2(var_8_3))

			return
		end)
		arg_1_0:bind(var_0_1.ON_RECORD_EQUIPMENT, function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
			local var_9_0 = arg_1_0
			local var_9_1 = var_4.sendNotification

			GAME = var_2_10007

			var_9_1(var_9_0, var_2_10007.RECORD_SHIP_EQUIPMENT, {
				shipId = arg_9_1,
				index = arg_9_2,
				type = arg_9_3
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_EVALUATION, function(arg_10_0, arg_10_1, arg_10_2)
			if arg_10_2 then
				pg = var_2_10003

				local var_10_0 = var_2_10003.TipsMgr.GetInstance()
				local var_10_1 = var_3.ShowTips

				i18n = var_2_10006

				var_10_1(var_10_0, var_2_10006("npc_evaluation_tip"))

				return
			end

			local var_10_2 = arg_1_0
			local var_10_3 = var_3.sendNotification

			GAME = var_2_10006

			var_10_3(var_10_2, var_2_10006.FETCH_EVALUATION, arg_10_1)

			return
		end)
		arg_1_0:bind(var_0_1.ON_SELECT_EQUIPMENT_SKIN, function(arg_11_0, arg_11_1)
			local var_11_0 = var_0_1
			local var_11_1 = var_2.getEquipmentSkins(var_11_0, arg_1_0.viewComponent.shipVO, arg_11_1)
			local var_11_2 = arg_1_0
			local var_11_3 = var_3.sendNotification

			GAME = var_6

			local var_11_4 = var_6.GO_SCENE

			SCENE = var_2_10007

			local var_11_5 = var_2_10007.EQUIPSCENE
			local var_11_6 = {
				equipmentVOs = var_11_1,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_11_1
			}

			StoreHouseConst = var_9
			var_11_6.warp = var_9.WARP_TO_WEAPON
			StoreHouseConst = var_9
			var_11_6.mode = var_9.SKIN

			var_11_3(var_11_2, var_11_4, var_11_5, var_11_6)

			return
		end)
		arg_1_0:bind(var_0_1.ON_SELECT_EQUIPMENT, function(arg_12_0, arg_12_1)
			getProxy = var_2_10002
			EquipmentProxy = var_2_10004

			local var_12_0 = var_2_10002(var_2_10004)
			local var_12_1 = var_2.getEquipments(var_12_0, true)

			getProxy = var_2_10004
			BayProxy = var_6

			local var_12_2 = var_2_10004(var_6)
			local var_12_3 = var_4.getShipById(var_12_2, arg_1_0.contextData.shipId)
			local var_12_4 = var_4:getEquipsInShips(function(arg_13_0, arg_13_1)
				local var_13_1

				if var_12_3.id ~= arg_13_1 then
					local var_13_0 = var_12_3

					var_13_1 = not var_2.isForbiddenAtPos(var_13_0, arg_13_0, arg_12_1)
				else
					var_13_1 = false
				end

				if false then
					var_13_1 = true
				end

				return var_13_1
			end)

			ipairs = var_12_2

			for iter_12_0, iter_12_1 in var_12_2(var_12_1) do
				if not var_12_3:isForbiddenAtPos(iter_12_1, arg_12_1) then
					table = var_12

					var_12.insert(var_12_4, iter_12_1)
				end
			end

			_ = var_7

			var_7.each(var_12_4, function(arg_14_0)
				local var_14_0 = var_12_3

				if not var_1.canEquipAtPos(var_14_0, arg_14_0, arg_12_1) then
					arg_14_0.mask = true
				end

				return
			end)

			local var_12_5 = arg_1_0
			local var_12_6 = var_7.sendNotification

			GAME = var_10

			local var_12_7 = var_10.GO_SCENE

			SCENE = iter_12_1

			local var_12_8 = iter_12_1.EQUIPSCENE
			local var_12_9 = {
				lock = true,
				equipmentVOs = var_12_4,
				shipId = arg_1_0.contextData.shipId,
				pos = arg_12_1
			}

			StoreHouseConst = var_13
			var_12_9.warp = var_13.WARP_TO_WEAPON
			StoreHouseConst = var_13
			var_12_9.mode = var_13.EQUIPMENT

			var_12_6(var_12_5, var_12_7, var_12_8, var_12_9)

			return
		end)
		arg_1_0:bind(var_0_1.ON_SELECT_SPWEAPON, function(arg_15_0)
			local var_15_0 = arg_1_0
			local var_15_1 = var_1.sendNotification

			GAME = var_2_10004

			local var_15_2 = var_2_10004.GO_SCENE

			SCENE = var_2_10005

			local var_15_3 = var_2_10005.SPWEAPON_STOREHOUSE
			local var_15_4 = {
				lock = true,
				shipId = arg_1_0.contextData.shipId
			}

			StoreHouseConst = var_7
			var_15_4.warp = var_7.WARP_TO_WEAPON
			StoreHouseConst = var_7
			var_15_4.mode = var_7.EQUIPMENT

			var_15_1(var_15_0, var_15_2, var_15_3, var_15_4)

			return
		end)
		arg_1_0:bind(var_0_1.ON_UPGRADE, function(arg_16_0, arg_16_1)
			local var_16_0 = arg_1_0

			var_2.openUpgrade(var_16_0)

			return
		end)
		arg_1_0:bind(var_0_1.CLOSE_UPGRADE, function(arg_17_0)
			local var_17_0 = arg_1_0

			var_1.closeUpgrade(var_17_0)

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_INTENSIFY, function(arg_18_0)
			local var_18_0 = arg_1_0

			var_1.openIntensify(var_18_0)

			return
		end)
		arg_1_0:bind(var_0_1.CLOSE_INTENSIFY, function(arg_19_0)
			local var_19_0 = arg_1_0

			var_1.closeIntensify(var_19_0)

			return
		end)
		arg_1_0:bind(var_0_1.ON_LOCK, function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = arg_1_0
			local var_20_1 = var_3.sendNotification

			GAME = var_2_10006

			var_20_1(var_20_0, var_2_10006.UPDATE_LOCK, {
				ship_id_list = arg_20_1,
				is_locked = arg_20_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.ON_TAG, function(arg_21_0, arg_21_1, arg_21_2)
			local var_21_0 = arg_1_0
			local var_21_1 = var_3.sendNotification

			GAME = var_2_10006

			var_21_1(var_21_0, var_2_10006.UPDATE_PREFERENCE, {
				shipId = arg_21_1,
				tag = arg_21_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.ON_SKILL, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
			local var_22_0 = arg_1_0
			local var_22_1 = var_4.addSubLayers

			Context = var_2_10007

			local var_22_2 = var_2_10007.New
			local var_22_3 = {}

			SkillInfoMediator = var_2_10010
			var_22_3.mediator = var_2_10010
			SkillInfoLayer = var_2_10010
			var_22_3.viewComponent = var_2_10010
			var_22_3.data = {
				skillOnShip = arg_22_2,
				skillId = arg_22_1,
				shipId = arg_1_0.contextData.shipId,
				index = arg_22_3
			}

			var_22_1(var_22_0, var_22_2(var_22_3))

			return
		end)
		arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_23_0, arg_23_1, arg_23_2)
			local var_23_0 = arg_1_0
			local var_23_1 = var_3.sendNotification

			GAME = var_2_10006

			var_23_1(var_23_0, var_2_10006.SET_SHIP_SKIN, {
				phantomId = 0,
				shipId = arg_23_1,
				skinId = arg_23_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_24_0, arg_24_1, arg_24_2)
			local var_24_0 = arg_1_0
			local var_24_1 = var_3.sendNotification

			GAME = var_2_10006

			var_24_1(var_24_0, var_2_10006.SKIN_SHOPPIGN, {
				id = arg_24_1,
				count = arg_24_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.UNEQUIP_FROM_SHIP_ALL, function(arg_25_0, arg_25_1)
			local var_25_0 = arg_1_0
			local var_25_1 = var_2.sendNotification

			GAME = var_2_10005

			var_25_1(var_25_0, var_2_10005.UNEQUIP_FROM_SHIP_ALL, {
				shipId = arg_25_1
			})

			return
		end)
		arg_1_0:bind(var_0_1.UNEQUIP_FROM_SHIP, function(arg_26_0, arg_26_1)
			local var_26_0 = arg_1_0
			local var_26_1 = var_2.sendNotification

			GAME = var_2_10005

			var_26_1(var_26_0, var_2_10005.UNEQUIP_FROM_SHIP, arg_26_1)

			return
		end)
		arg_1_0:bind(var_0_1.NEXTSHIP, function(arg_27_0, arg_27_1)
			local var_27_0 = arg_1_0

			var_2.nextPage(var_27_0, arg_27_1)

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_ACTIVITY, function(arg_28_0, arg_28_1)
			local var_28_0 = arg_1_0
			local var_28_1 = var_2.sendNotification

			GAME = var_2_10005

			local var_28_2 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			var_28_1(var_28_0, var_28_2, var_2_10006.ACTIVITY, {
				id = arg_28_1
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_REMOULD, function(arg_29_0)
			local var_29_0 = arg_1_0

			var_1.openRemould(var_29_0)

			return
		end)
		arg_1_0:bind(var_0_1.CLOSE_REMOULD, function(arg_30_0)
			local var_30_0 = arg_1_0

			var_1.closeRemould(var_30_0)

			return
		end)
		arg_1_0:bind(var_0_1.PROPOSE, function(arg_31_0, arg_31_1, arg_31_2)
			local var_31_0 = arg_1_0
			local var_31_1 = var_3.addSubLayers

			Context = var_2_10006

			local var_31_2 = var_2_10006.New
			local var_31_3 = {}

			ProposeMediator = var_2_10009
			var_31_3.mediator = var_2_10009
			ProposeUI = var_2_10009
			var_31_3.viewComponent = var_2_10009
			var_31_3.data = {
				shipId = arg_31_1,
				callback = arg_31_2
			}

			var_31_1(var_31_0, var_31_2(var_31_3))

			return
		end)
		arg_1_0:bind(var_0_1.RENAME_SHIP, function(arg_32_0, arg_32_1, arg_32_2)
			local var_32_0 = arg_1_0
			local var_32_1 = var_3.sendNotification

			GAME = var_2_10006

			var_32_1(var_32_0, var_2_10006.RENAME_SHIP, {
				shipId = arg_32_1,
				name = arg_32_2
			})

			return
		end)
		arg_1_0:bind(var_0_1.ON_SEL_COMMANDER, function(arg_33_0)
			getProxy = var_2_10001
			BayProxy = var_2_10003

			local var_33_0 = var_2_10001(var_2_10003)
			local var_33_1 = var_1.getShipById(var_33_0, arg_1_0.contextData.shipId)
			local var_33_2 = arg_1_0
			local var_33_3 = var_2.sendNotification

			GAME = var_2_10005

			local var_33_4 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			local var_33_5 = var_2_10006.COMMANDPOST
			local var_33_6 = {
				selectedMin = 1,
				selectedMax = 1
			}

			CommanderCatScene = var_2_10008
			var_33_6.mode = var_2_10008.MODE_SELECT

			function var_33_6.onShip(arg_34_0)
				if arg_34_0.shipId == arg_1_0.contextData.shipId then
					local var_34_0 = false

					i18n = var_2

					local var_34_1 = var_2("commander_ship_already_equip")

					return
				end

				return true
			end

			function var_33_6.onSelected(arg_35_0)
				if #arg_35_0 == 0 then
					arg_1_0.contextData.unequipCommander = true
				else
					arg_1_0.contextData.selectedId = arg_35_0[1]
				end

				return
			end

			var_33_6.quitTeam = var_33_1:hasCommander()

			var_33_3(var_33_2, var_33_4, var_33_5, var_33_6)

			return
		end)
		arg_1_0:bind(var_0_1.ON_UPGRADE_MAX_LEVEL, function(arg_36_0, arg_36_1)
			local var_36_0 = arg_1_0
			local var_36_1 = var_2.sendNotification

			GAME = var_2_10005

			var_36_1(var_36_0, var_2_10005.UPGRADE_MAX_LEVEL, {
				shipId = arg_36_1
			})

			return
		end)
		arg_1_0:bind(var_0_1.ON_TECHNOLOGY, function(arg_37_0, arg_37_1)
			local var_37_0 = arg_1_0
			local var_37_1 = var_2.sendNotification

			GAME = var_2_10005

			local var_37_2 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			var_37_1(var_37_0, var_37_2, var_2_10006.SHIPBLUEPRINT, {
				shipId = arg_37_1.id
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_EQUIP_UPGRADE, function(arg_38_0, arg_38_1)
			local var_38_0 = arg_1_0
			local var_38_1 = var_2.addSubLayers

			Context = var_2_10005

			local var_38_2 = var_2_10005.New
			local var_38_3 = {}

			EquipUpgradeMediator = var_2_10008
			var_38_3.mediator = var_2_10008
			EquipUpgradeLayer = var_2_10008
			var_38_3.viewComponent = var_2_10008
			var_38_3.data = {
				shipId = arg_38_1
			}

			var_38_1(var_38_0, var_38_2(var_38_3))

			return
		end)
		arg_1_0:bind(var_0_1.ON_META, function(arg_39_0, arg_39_1)
			local var_39_0 = arg_1_0
			local var_39_1 = var_2.sendNotification

			GAME = var_2_10005

			local var_39_2 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			var_39_1(var_39_0, var_39_2, var_2_10006.METACHARACTER, {
				autoOpenShipConfigID = arg_39_1.configId
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_EQUIP_CODE, function(arg_40_0, arg_40_1)
			local var_40_0 = arg_1_0
			local var_40_1 = var_2.sendNotification

			GAME = var_2_10005

			local var_40_2 = var_2_10005.GO_SCENE

			SCENE = var_2_10006

			var_40_1(var_40_0, var_40_2, var_2_10006.EQUIP_CODE, {
				shipId = arg_1_0.contextData.shipId,
				code = arg_40_1.code
			})

			return
		end)
		arg_1_0:bind(var_0_1.OPEN_EQUIP_CODE_SHARE, function(arg_41_0, arg_41_1, arg_41_2)
			local var_41_0 = arg_1_0
			local var_41_1 = var_3.addSubLayers

			Context = var_2_10006

			local var_41_2 = var_2_10006.New
			local var_41_3 = {}

			EquipCodeShareMediator = var_2_10009
			var_41_3.mediator = var_2_10009
			EquipCodeShareLayer = var_2_10009
			var_41_3.viewComponent = var_2_10009
			var_41_3.data = {
				shipId = arg_41_1,
				shipGroupId = arg_41_2
			}

			var_41_1(var_41_0, var_41_2(var_41_3))

			return
		end)
		arg_1_0:bind(var_0_1.CHANGE_RANDOM_FLAG, function(arg_42_0, arg_42_1, arg_42_2)
			local var_42_0 = arg_1_0
			local var_42_1 = var_3.sendNotification

			GAME = var_2_10006

			local var_42_2 = var_2_10006.CHANGE_RANDOM_SHIPS
			local var_42_3 = {}
			local var_42_4

			if not arg_42_2 or not {
				arg_42_1
			} then
				var_42_4 = {}
			end

			var_42_3.addList = var_42_4

			local var_42_5

			if arg_42_2 or not {
				arg_42_1
			} then
				var_42_5 = {}
			end

			var_42_3.deleteList = var_42_5

			var_42_1(var_42_0, var_42_2, var_42_3)

			return
		end)

		local var_1_17 = arg_1_0

		arg_1_0.bind(var_1_17, var_0_1.OPEN_PHANTOM_LAYER, function(arg_43_0, arg_43_1)
			local var_43_0 = arg_1_0
			local var_43_1 = var_2.addSubLayers

			Context = var_2_10005

			local var_43_2 = var_2_10005.New
			local var_43_3 = {}

			DockyardMediator = var_2_10008
			var_43_3.mediator = var_2_10008
			DockyardScene = var_2_10008
			var_43_3.viewComponent = var_2_10008

			local var_43_4 = {}

			DockyardScene = var_2_10009
			var_43_4.mode = var_2_10009.MODE_SHIP_PHANTOM
			var_43_4.techVersion = arg_43_1
			var_43_3.data = var_43_4

			function var_43_3.onRemoved()
				local var_44_0 = arg_1_0.viewComponent

				var_0.changePaintingSortLayer(var_44_0, true)

				return
			end

			var_43_1(var_43_0, var_43_2(var_43_3))

			local var_43_5 = arg_1_0.viewComponent

			var_2.changePaintingSortLayer(var_43_5, false)

			return
		end)

		local var_1_18

		if arg_1_0.contextData.selectedId then
			var_1_17 = arg_1_0
			var_1_18 = arg_1_0.sendNotification
			GAME = var_9

			var_1_18(var_1_17, var_9.COMMANDER_EQUIP_TO_SHIP, {
				shipId = arg_1_0.contextData.shipId,
				commanderId = arg_1_0.contextData.selectedId
			})

			var_1_18 = arg_1_0.contextData
			var_1_18.selectedId = nil
		elseif arg_1_0.contextData.unequipCommander then
			var_1_18 = arg_1_0.contextData
			var_1_18.unequipCommander = nil
			var_1_17 = arg_1_0
			var_1_18 = arg_1_0.sendNotification
			GAME = var_9

			var_1_18(var_1_17, var_9.COMMANDER_EQUIP_TO_SHIP, {
				commanderId = 0,
				shipId = arg_1_0.contextData.shipId
			})
		end

		getProxy = var_1_18
		SettingsProxy = var_1_17

		local var_1_19 = var_1_18(var_1_17)
		local var_1_20 = var_6.getMaxLevelHelp(var_1_19)
		local var_1_21 = arg_1_0.viewComponent

		var_7.setMaxLevelHelpFlag(var_1_21, var_1_20)

		return
	end
end

function var_0_1.getEquipmentSkins(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 then
		return {}
	end

	local var_45_0 = arg_45_1

	if arg_45_1.getEquip(var_45_0, arg_45_2) then
		local var_45_1 = {}

		var_1_10007 = var_3
		var_45_1[1] = var_3.getType(var_1_10007)

		local var_45_2

		if not var_45_1 then
			var_45_2 = arg_45_1
			var_45_1 = arg_45_1.getSkinTypes(var_45_2, arg_45_2)
		end

		getProxy = var_45_0
		EquipmentProxy = var_1_10007

		local var_45_3 = var_45_0(var_1_10007)
		local var_45_4 = var_5.getSkinsByTypes(var_45_3, var_45_1)

		getProxy = var_45_2
		BayProxy = var_8

		local var_45_5 = var_45_2(var_8)
		local var_45_6 = var_6.getEquipmentSkinInShips(var_45_5, arg_45_1, var_45_1)

		_ = var_45_3

		local var_45_7 = var_45_3.map(var_45_6, function(arg_46_0)
			return {
				isSkin = true,
				count = 1,
				id = arg_46_0.id,
				shipId = arg_46_0.shipId,
				shipPos = arg_46_0.shipPos
			}
		end)

		_ = var_45_5

		local var_45_8 = var_45_5.map(var_45_4, function(arg_47_0)
			return {
				isSkin = true,
				id = arg_47_0.id,
				count = arg_47_0.count
			}
		end)

		ipairs = var_9

		for iter_45_0, iter_45_1 in var_9(var_45_7 or {}) do
			table = var_1_10014

			var_1_10014.insert(var_45_8, iter_45_1)
		end

		return var_45_8
	end
end

function var_0_1.nextPage(arg_48_0, arg_48_1, arg_48_2)
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
			local var_48_4 = arg_48_0.bayProxy

			if var_12.getShipById(var_48_4, var_11.id) then
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

		local var_48_5 = arg_48_0.contextData.shipVOs[arg_48_0.contextData.index]
		local var_48_6 = arg_48_0.bayProxy

		var_48_3 = var_8.getShipById(var_48_6, var_48_5.id)
		arg_48_0.contextData.shipId = var_48_3.id
	end

	if var_48_3 then
		local var_48_7 = arg_48_0.viewComponent

		var_7.emit(var_48_7, var_0_1.ON_NEXTSHIP_PREPARE, var_48_3)

		local var_48_8 = arg_48_0.viewComponent

		var_7.setPreOrNext(var_48_8, arg_48_1, var_48_3)

		arg_48_0.viewComponent.fashionGroup = 0
		arg_48_0.viewComponent.fashionSkinId = 0

		local var_48_9 = arg_48_0.viewComponent

		var_7.setShip(var_48_9, var_48_3)

		if arg_48_0.contextData.selectContextData then
			arg_48_0.contextData.selectContextData.infoShipId = var_48_3.id
		end

		local var_48_10 = arg_48_0.viewComponent

		var_7.updatePreferenceTag(var_48_10)

		local var_48_11 = arg_48_0.viewComponent

		var_7.displayShipWord(var_48_11, "detail", true)

		local var_48_12 = arg_48_0.viewComponent

		var_7.closeRecordPanel(var_48_12)

		ShipViewConst = var_7

		local var_48_13 = var_7.currentPage

		ShipViewConst = var_8

		if var_48_13 == var_8.PAGE.UPGRADE then
			arg_48_0:closeUpgrade()
		else
			ShipViewConst = var_8

			if var_48_13 == var_8.PAGE.INTENSIFY and not arg_48_0.intensifyContext then
				arg_48_0:closeIntensify()
			else
				ShipViewConst = var_8

				if var_48_13 == var_8.PAGE.EQUIPMENT and arg_48_0.contextData.isInEquipmentSkinPage and var_48_3:hasEquipEquipmentSkin() then
					ShipStatus = var_8

					if not var_8.ShipStatusCheck("onModify", var_48_3) then
						-- block empty
					end
				end
			end
		end

		local var_48_14 = arg_48_0.viewComponent

		if var_8.checkToggleActive(var_48_14, var_48_13) == false then
			ShipViewConst = var_8
			var_48_13 = var_8.PAGE.DETAIL
		end

		local var_48_15 = arg_48_0.viewComponent

		var_8.gotoPage(var_48_15, var_48_13)

		local var_48_16 = arg_48_0.viewComponent

		var_8.switchToPage(var_48_16, var_48_13, true)
	end

	return var_48_3
end

function var_0_1.openRemould(arg_49_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_49_0 = var_1_10001(var_1_10003)
	local var_49_1 = var_1.getCurrentContext(var_49_0)
	local var_49_2 = var_2.getContextByMediator

	ShipRemouldMediator = var_1_10006

	if var_49_2(var_49_1, var_1_10006) then
		return
	end

	local var_49_3 = arg_49_0
	local var_49_4 = arg_49_0.addSubLayers

	Context = var_1_10007

	local var_49_5 = var_1_10007.New
	local var_49_6 = {}

	ShipRemouldLayer = var_1_10010
	var_49_6.viewComponent = var_1_10010
	ShipRemouldMediator = var_1_10010
	var_49_6.mediator = var_1_10010
	var_49_6.data = {
		shipId = arg_49_0.contextData.shipId
	}

	var_49_4(var_49_3, var_49_5(var_49_6))

	return
end

function var_0_1.closeRemould(arg_50_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_50_0 = var_1_10001(var_1_10003)
	local var_50_1 = var_1.getCurrentContext(var_50_0)
	local var_50_2 = var_2.getContextByMediator

	ShipRemouldMediator = var_1_10006

	if var_50_2(var_50_1, var_1_10006) then
		local var_50_3 = arg_50_0
		local var_50_4 = arg_50_0.sendNotification

		GAME = var_1_10007

		var_50_4(var_50_3, var_1_10007.REMOVE_LAYERS, {
			context = var_3
		})
	end

	return
end

function var_0_1.openUpgrade(arg_51_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_51_0 = var_1_10001(var_1_10003)
	local var_51_1 = var_1.getCurrentContext(var_51_0)
	local var_51_2 = var_1.getContextByMediator

	ShipUpgradeMediator2 = var_1_10005

	if var_51_2(var_51_1, var_1_10005) then
		return
	end

	local var_51_3 = arg_51_0
	local var_51_4 = arg_51_0.addSubLayers

	Context = var_1_10006

	local var_51_5 = var_1_10006.New
	local var_51_6 = {}

	ShipUpgradeMediator2 = var_1_10009
	var_51_6.mediator = var_1_10009
	ShipUpgradeLayer2 = var_1_10009
	var_51_6.viewComponent = var_1_10009
	var_51_6.data = {
		shipId = arg_51_0.contextData.shipId,
		shipVOs = arg_51_0.contextData.shipVOs,
		index = arg_51_0.contextData.index
	}

	var_51_4(var_51_3, var_51_5(var_51_6))

	return
end

function var_0_1.closeUpgrade(arg_52_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_52_0 = var_1_10001(var_1_10003)
	local var_52_1 = var_1.getCurrentContext(var_52_0)
	local var_52_2 = var_1.getContextByMediator

	ShipUpgradeMediator2 = var_1_10005

	if var_52_2(var_52_1, var_1_10005) then
		local var_52_3 = arg_52_0
		local var_52_4 = arg_52_0.sendNotification

		GAME = var_1_10006

		var_52_4(var_52_3, var_1_10006.REMOVE_LAYERS, {
			context = var_2
		})
	end

	return
end

function var_0_1.openIntensify(arg_53_0)
	local var_53_0

	if arg_53_0.intensifyContext ~= nil then
		var_53_0 = arg_53_0.intensifyContext.data
		var_53_0.shipId = arg_53_0.contextData.shipId

		return
	end

	getProxy = var_53_0
	ContextProxy = var_1_10003

	local var_53_1 = var_53_0(var_1_10003)
	local var_53_2 = var_1.getCurrentContext(var_53_1)
	local var_53_3 = var_2.getContextByMediator

	ShipModMediator = var_1_10006

	if var_53_3(var_53_2, var_1_10006) then
		return
	end

	Context = var_53_1

	local var_53_4 = var_53_1.New
	local var_53_5 = {}

	ShipModMediator = var_1_10007
	var_53_5.mediator = var_1_10007
	ShipModLayer = var_1_10007
	var_53_5.viewComponent = var_1_10007
	var_53_5.data = {
		shipId = arg_53_0.contextData.shipId
	}
	arg_53_0.intensifyContext = var_53_4(var_53_5)

	arg_53_0:addSubLayers(arg_53_0.intensifyContext, false, function()
		arg_53_0.intensifyContext = nil

		return
	end)

	return
end

function var_0_1.closeIntensify(arg_55_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_55_0 = var_1_10001(var_1_10003)
	local var_55_1 = var_1.getCurrentContext(var_55_0)
	local var_55_2 = var_2.getContextByMediator

	ShipModMediator = var_1_10006

	if var_55_2(var_55_1, var_1_10006) then
		local var_55_3 = arg_55_0
		local var_55_4 = arg_55_0.sendNotification

		GAME = var_1_10007

		var_55_4(var_55_3, var_1_10007.REMOVE_LAYERS, {
			context = var_3
		})
	end

	return
end

function var_0_1.listNotificationInterests(arg_56_0)
	local var_56_0 = {}

	GAME = var_1_10002
	var_56_0[1] = var_1_10002.DESTROY_SHIP_DONE
	BayProxy = var_2
	var_56_0[2] = var_2.SHIP_UPDATED
	GAME = var_2
	var_56_0[3] = var_2.UPDATE_LOCK_DONE
	GAME = var_2
	var_56_0[4] = var_2.UPDATE_PREFERENCE_DONE
	PlayerProxy = var_2
	var_56_0[5] = var_2.UPDATED
	GAME = var_2
	var_56_0[6] = var_2.FETCH_EVALUATION_DONE
	GAME = var_2
	var_56_0[7] = var_2.MOD_SHIP_DONE
	ShipSkinProxy = var_2
	var_56_0[8] = var_2.SHIP_SKINS_UPDATE
	ShipUpgradeMediator2 = var_2
	var_56_0[9] = var_2.NEXTSHIP
	ShipModMediator = var_2
	var_56_0[10] = var_2.LOADEND
	GAME = var_2
	var_56_0[11] = var_2.RENAME_SHIP_DONE
	GAME = var_2
	var_56_0[12] = var_2.RECORD_SHIP_EQUIPMENT_DONE
	GAME = var_2
	var_56_0[13] = var_2.SKIN_SHOPPIGN_DONE
	GAME = var_2
	var_56_0[14] = var_2.UPGRADE_MAX_LEVEL_DONE
	GAME = var_2
	var_56_0[15] = var_2.SKIN_COUPON_SHOPPING_DONE
	GAME = var_2
	var_56_0[16] = var_2.HIDE_Ship_MAIN_SCENE_WORD
	GAME = var_2
	var_56_0[17] = var_2.PROPOSE_SHIP_DONE
	GAME = var_2
	var_56_0[18] = var_2.USE_ADD_SHIPEXP_ITEM_DONE
	GAME = var_2
	var_56_0[19] = var_2.CHANGE_SKIN_UPDATE
	EquipmentProxy = var_2
	var_56_0[20] = var_2.EQUIPMENT_UPDATED
	GAME = var_2
	var_56_0[21] = var_2.WILL_LOGOUT
	PaintingGroupConst = var_2
	var_56_0[22] = var_2.NotifyPaintingDownloadFinish
	GAME = var_2
	var_56_0[23] = var_2.CHANGE_RANDOM_SHIPS_DONE

	return var_56_0
end

function var_0_1.handleNotification(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_1
	local var_57_1 = arg_57_1.getName(var_57_0)
	local var_57_2 = arg_57_1:getBody()

	BayProxy = var_57_0

	if var_57_1 == var_57_0.SHIP_UPDATED then
		if var_57_2.id == arg_57_0.contextData.shipId then
			var_1_10006 = var_57_2
			arg_57_0.showTrans = var_57_2.isRemoulded(var_1_10006)
			var_1_10006 = arg_57_0.viewComponent

			var_4.setShip(var_1_10006, var_57_2)
		end

		goto label_57_0
	end

	GAME = var_4

	local var_57_3

	if var_57_1 == var_4.CHANGE_RANDOM_SHIPS_DONE then
		var_1_10006 = arg_57_0.viewComponent
		var_57_3 = var_57_3.setShip

		local var_57_4 = arg_57_0.bayProxy

		var_57_3(var_1_10006, var_1_10007.getShipById(var_57_4, arg_57_0.contextData.shipId))

		goto label_57_0
	end

	GAME = var_57_3

	local var_57_5

	if var_57_1 == var_57_3.CHANGE_SKIN_UPDATE then
		ShipPhantom = var_57_5

		local var_57_6

		var_57_5, var_57_6 = var_57_5.UnpackMark(var_57_2)

		if var_57_5 == arg_57_0.contextData.shipId then
			var_1_10008 = arg_57_0.bayProxy

			local var_57_7 = var_1_10006.getShipById(var_1_10008, var_57_5)

			arg_57_0.showTrans = var_1_10006.isRemoulded(var_57_7)

			local var_57_8 = arg_57_0.viewComponent

			var_1_10007.setShip(var_57_8, var_1_10006)
		end

		goto label_57_0
	end

	GAME = var_57_5

	local var_57_9

	if var_57_1 == var_57_5.DESTROY_SHIP_DONE then
		pg = var_57_9
		var_1_10006 = var_57_9.TipsMgr.GetInstance()
		var_57_9 = var_57_9.ShowTips
		i18n = var_1_10007

		var_57_9(var_1_10006, var_1_10007("ship_shipInfoMediator_destory"))

		var_1_10006 = arg_57_0.viewComponent.event
		var_57_9 = var_57_9.emit
		BaseUI = var_1_10007

		var_57_9(var_1_10006, var_1_10007.ON_CLOSE)

		goto label_57_0
	end

	GAME = var_57_9

	if var_57_1 == var_57_9.UPDATE_LOCK_DONE then
		if var_57_2.id == arg_57_0.contextData.shipId then
			var_1_10006 = arg_57_0.viewComponent

			var_4.updateLock(var_1_10006)
		end

		goto label_57_0
	end

	GAME = var_4

	if var_57_1 == var_4.UPDATE_PREFERENCE_DONE then
		if var_57_2.id == arg_57_0.contextData.shipId then
			var_1_10006 = arg_57_0.viewComponent

			var_4.updatePreferenceTag(var_1_10006)
		end

		goto label_57_0
	end

	GAME = var_4

	if var_57_1 == var_4.MOD_SHIP_DONE then
		var_1_10006 = arg_57_0.viewComponent

		var_4.displayShipWord(var_1_10006, "upgrade", true)

		goto label_57_0
	end

	PlayerProxy = var_4

	if var_57_1 == var_4.UPDATED then
		getProxy = var_4
		PlayerProxy = var_1_10006
		var_1_10007 = var_4(var_1_10006)

		local var_57_10 = var_4.getData(var_1_10007)

		var_1_10008 = arg_57_0.viewComponent

		var_1_10006.setPlayer(var_1_10008, var_57_10)

		goto label_57_0
	end

	GAME = var_4

	local var_57_11

	if var_57_1 == var_4.FETCH_EVALUATION_DONE then
		var_1_10006 = arg_57_0
		var_57_11 = arg_57_0.addSubLayers
		Context = var_1_10007
		var_1_10007 = var_1_10007.New

		local var_57_12 = {}

		ShipEvaluationMediator = var_1_10010
		var_57_12.mediator = var_1_10010
		ShipEvaluationLayer = var_1_10010
		var_57_12.viewComponent = var_1_10010
		var_57_12.data = {
			groupId = var_57_2,
			showTrans = arg_57_0.showTrans
		}

		var_57_11(var_1_10006, var_1_10007(var_57_12))

		goto label_57_0
	end

	ShipSkinProxy = var_57_11

	local var_57_13

	if var_57_1 == var_57_11.SHIP_SKINS_UPDATE then
		getProxy = var_57_13
		ShipSkinProxy = var_1_10006
		var_57_13 = var_57_13(var_1_10006)
		var_1_10007 = arg_57_0.viewComponent

		var_5.setSkinList(var_1_10007, var_57_13:getSkinList())

		arg_57_0.viewComponent.fashionGroup = 0
		var_1_10007 = arg_57_0.viewComponent.shipFashionView

		var_5.UpdateFashion(var_1_10007, true)

		goto label_57_0
	end

	ShipUpgradeMediator2 = var_57_13

	local var_57_14

	if var_57_1 == var_57_13.NEXTSHIP then
		var_1_10006 = arg_57_0
		var_57_14 = arg_57_0.nextPage(var_1_10006, var_57_2, 3)

		goto label_57_0
	end

	ShipModMediator = var_57_14

	if var_57_1 == var_57_14.LOADEND then
		var_1_10006 = arg_57_0.viewComponent

		var_4.setModPanel(var_1_10006, var_57_2)

		goto label_57_0
	end

	GAME = var_4

	if var_57_1 == var_4.RENAME_SHIP_DONE then
		var_1_10006 = arg_57_0.viewComponent

		var_4.DisplayRenamePanel(var_1_10006, false)

		goto label_57_0
	end

	GAME = var_4

	if var_57_1 == var_4.RECORD_SHIP_EQUIPMENT_DONE then
		if var_57_2.shipId == arg_57_0.contextData.shipId and var_57_2.type == 1 then
			var_1_10006 = arg_57_0.viewComponent

			var_4.updateRecordEquipments(var_1_10006, var_57_2.index)
		end

		goto label_57_0
	end

	GAME = var_4

	if var_57_1 ~= var_4.SKIN_SHOPPIGN_DONE then
		GAME = var_4

		if var_57_1 == var_4.SKIN_COUPON_SHOPPING_DONE then
			pg = var_4

			if var_4.shop_template[var_57_2.id] then
				local var_57_15 = var_4.genre

				ShopArgs = var_1_10006

				if var_57_15 == var_1_10006.SkinShop then
					var_1_10007 = arg_57_0.viewComponent

					var_5.StopPreVoice(var_1_10007)

					var_1_10007 = arg_57_0

					local var_57_16 = arg_57_0.addSubLayers

					Context = var_1_10008

					local var_57_17 = var_1_10008.New
					local var_57_18 = {}

					NewSkinMediator = var_1_10011
					var_57_18.mediator = var_1_10011
					NewSkinLayer = var_1_10011
					var_57_18.viewComponent = var_1_10011
					var_57_18.data = {
						skinId = var_4.effect_args[1]
					}

					var_57_16(var_1_10007, var_57_17(var_57_18))
				end
			end
		else
			GAME = var_4

			local var_57_20

			if var_57_1 == var_4.UPGRADE_MAX_LEVEL_DONE then
				local var_57_19 = arg_57_0

				var_57_20 = arg_57_0.sendNotification
				PlayerResUI = var_1_10007

				var_57_20(var_57_19, var_1_10007.CHANGE_TOUCH_ABLE, false)

				arg_57_0.maxLevelCallback = var_57_2.callback

				local var_57_21 = arg_57_0.viewComponent

				var_57_20.doUpgradeMaxLeveAnim(var_57_21, var_57_2.oldShip, var_57_2.newShip, function()
					if arg_57_0.maxLevelCallback then
						arg_57_0.maxLevelCallback()

						arg_57_0.maxLevelCallback = nil
					end

					local var_58_0 = arg_57_0
					local var_58_1 = var_0.sendNotification

					PlayerResUI = var_2_10003

					var_58_1(var_58_0, var_2_10003.CHANGE_TOUCH_ABLE, true)

					local var_58_2 = arg_57_0.viewComponent
					local var_58_3 = var_0.showAwakenCompleteAni

					i18n = var_3

					local var_58_4 = "upgrade_to_next_maxlevel_succeed"
					local var_58_5 = var_57_2.newShip

					var_58_3(var_58_2, var_3(var_58_4, var_6.getMaxLevel(var_58_5)))

					return
				end)
			else
				GAME = var_57_20

				if var_57_1 == var_57_20.HIDE_Ship_MAIN_SCENE_WORD then
					local var_57_22 = arg_57_0.viewComponent

					var_4.hideShipWord(var_57_22)
				else
					GAME = var_4

					if var_57_1 == var_4.PROPOSE_SHIP_DONE then
						if arg_57_0.viewComponent.shipFashionView then
							var_1_10007 = var_4

							if var_4.GetLoaded(var_1_10007) then
								var_1_10007 = var_4

								var_4.UpdateAllFashion(var_1_10007, true)
							end
						end
					else
						GAME = var_4

						local var_57_24

						if var_57_1 == var_4.USE_ADD_SHIPEXP_ITEM_DONE then
							pg = var_57_24

							local var_57_23 = var_57_24.TipsMgr.GetInstance()

							var_57_24 = var_57_24.ShowTips
							i18n = var_1_10007

							var_57_24(var_57_23, var_1_10007("ship_shipModLayer_modSuccess"))

							local var_57_25 = arg_57_0.viewComponent

							var_57_24.RefreshShipExpItemUsagePage(var_57_25)
						else
							EquipmentProxy = var_57_24

							if var_57_1 == var_57_24.EQUIPMENT_UPDATED then
								local var_57_26 = arg_57_0.viewComponent

								var_4.equipmentChange(var_57_26)
							else
								GAME = var_4

								if var_57_1 == var_4.WILL_LOGOUT then
									local var_57_27 = arg_57_0.viewComponent

									var_4.OnWillLogout(var_57_27)
								else
									PaintingGroupConst = var_4

									if var_57_1 == var_4.NotifyPaintingDownloadFinish then
										local var_57_28 = arg_57_0.viewComponent

										var_4.updateFashionTag(var_57_28)
									end
								end
							end
						end
					end
				end
			end
		end

		::label_57_0::

		return
	end
end

function var_0_1.remove(arg_59_0)
	if arg_59_0.maxLevelCallback then
		arg_59_0.maxLevelCallback()

		arg_59_0.maxLevelCallback = nil

		local var_59_0 = arg_59_0
		local var_59_1 = arg_59_0.sendNotification

		PlayerResUI = var_1_10004

		var_59_1(var_59_0, var_1_10004.CHANGE_TOUCH_ABLE, true)
	end

	return
end

return var_0_1
