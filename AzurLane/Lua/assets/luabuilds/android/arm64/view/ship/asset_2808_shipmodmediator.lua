class = var_0_10000

local var_0_0 = "ShipModMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_SELECT_MATERIAL_SHIPS = "ShipModMediator:ON_SELECT_MATERIAL_SHIPS"
var_0_1.ON_AUTO_SELECT_SHIP = "ShipModMediator:ON_AUTO_SELECT_SHIP"
var_0_1.MOD_SHIP = "ShipModMediator:MOD_SHIP"
var_0_1.ON_SKILL = "ShipModMediator:ON_SKILL"
var_0_1.LOADEND = "ShipModMediator:LOADEND"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getRawData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setShipVOs(var_1_2, var_1_1)

	local var_1_3 = var_1:getShipById(arg_1_0.contextData.shipId)
	local var_1_4 = arg_1_0.viewComponent

	var_4.setShip(var_1_4, var_1_3)
	arg_1_0:bind(var_0_1.ON_SELECT_MATERIAL_SHIPS, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.ShipFlagMgr.GetInstance()
		local var_2_1 = var_1.FilterShips

		ShipStatus = var_2_10004

		local var_2_2 = var_2_1(var_2_0, var_2_10004.FILTER_SHIPS_FLAGS_1)

		table = var_2_10002

		var_2_10002.insert(var_2_2, 1, arg_1_0.contextData.shipId)

		local var_2_3 = arg_1_0
		local var_2_4 = var_2.sendNotification

		GAME = var_5

		local var_2_5 = var_5.GO_SCENE

		SCENE = var_6

		local var_2_6 = var_6.DOCKYARD
		local var_2_7 = {
			selectedMin = 0,
			blockLock = true,
			destroyCheck = true,
			selectedMax = 12
		}

		i18n = var_2_10008
		var_2_7.leftTopInfo = var_2_10008("word_equipment_intensify")
		DockyardScene = var_8
		var_2_7.mode = var_8.MODE_MOD
		ShipStatus = var_8
		var_2_7.onShip = var_8.canDestroyShip
		var_2_7.ignoredIds = var_2_2
		var_2_7.selectedIds = arg_1_0.contextData.materialShipIds

		function var_2_7.onSelected(arg_3_0)
			arg_1_0.contextData.materialShipIds = arg_3_0

			return
		end

		var_2_7.sortData = {
			Asc = true,
			sort = 1
		}
		ShipStatus = var_8
		var_2_7.hideTagFlags = var_8.TAG_HIDE_DESTROY

		var_2_4(var_2_3, var_2_5, var_2_6, var_2_7)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO_SELECT_SHIP, function(arg_4_0)
		local var_4_0 = var_0
		local var_4_1 = var_1.getModRecommendShip
		local var_4_2 = arg_1_0.viewComponent.shipVO
		local var_4_3

		if not arg_1_0.contextData.materialShipIds then
			var_4_3 = {}
		end

		local var_4_4

		if #var_4_1(var_4_0, var_4_2, var_4_3) > 0 then
			var_4_4 = arg_1_0.contextData
			var_4_4.materialShipIds = var_1

			local var_4_5 = arg_1_0.viewComponent

			var_4_4.initSelectedShips(var_4_5)

			local var_4_6 = arg_1_0.viewComponent

			var_4_4.initAttrs(var_4_6)
		else
			pg = var_4_4

			local var_4_7 = var_4_4.TipsMgr.GetInstance()
			local var_4_8 = var_2.ShowTips

			i18n = var_4_3

			var_4_8(var_4_7, var_4_3("without_selected_ship"))
		end

		return
	end)
	arg_1_0:bind(var_0_1.MOD_SHIP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.MOD_SHIP, {
			shipId = arg_5_1,
			shipIds = arg_1_0.contextData.materialShipIds
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKILL, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_6_2 = var_2_10006.New
		local var_6_3 = {}

		SkillInfoMediator = var_2_10009
		var_6_3.mediator = var_2_10009
		SkillInfoLayer = var_2_10009
		var_6_3.viewComponent = var_2_10009
		var_6_3.data = {
			skillOnShip = arg_6_2,
			skillId = arg_6_1
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.LOADEND, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0

		var_2.sendNotification(var_7_0, var_0_1.LOADEND, arg_7_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.MOD_SHIP_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getName(var_9_0)
	local var_9_2 = arg_9_1:getBody()

	GAME = var_9_0

	if var_9_1 == var_9_0.MOD_SHIP_DONE then
		arg_9_0.contextData.materialShipIds = nil

		local var_9_3 = arg_9_0.viewComponent

		var_4.setShip(var_9_3, var_9_2.newShip)

		local var_9_4 = arg_9_0.viewComponent

		var_4.modAttrAnim(var_9_4, var_9_2.newShip, var_9_2.oldShip)

		pg = var_4

		local var_9_5 = var_4.TipsMgr.GetInstance()
		local var_9_6 = var_4.ShowTips

		i18n = var_7

		var_9_6(var_9_5, var_7("ship_shipModLayer_modSuccess"))

		table = var_9_6

		local var_9_7 = var_9_6.getCount(var_9_2.equipments)

		if 0 < var_9_7 then
			local var_9_8 = {}

			pairs = var_5

			for iter_9_0, iter_9_1 in var_5(var_9_2.equipments) do
				table = var_1_10010

				var_1_10010.insert(var_9_8, iter_9_1)
			end

			local var_9_9 = arg_9_0
			local var_9_10 = arg_9_0.addSubLayers

			Context = iter_9_0

			local var_9_11 = iter_9_0.New
			local var_9_12 = {}

			ResolveEquipmentLayer = var_1_10011
			var_9_12.viewComponent = var_1_10011
			ResolveEquipmentMediator = var_1_10011
			var_9_12.mediator = var_1_10011
			var_9_12.data = {
				Equipments = var_9_8
			}

			var_9_10(var_9_9, var_9_11(var_9_12))
		end
	end

	return
end

return var_0_1
