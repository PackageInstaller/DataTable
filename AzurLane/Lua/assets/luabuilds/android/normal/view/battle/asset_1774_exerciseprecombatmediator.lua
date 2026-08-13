class = var_0_10000

local var_0_0 = "ExercisePreCombatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_START = "ExercisePreCombatMediator:ON_START"
var_0_1.ON_CHANGE_FLEET = "ExercisePreCombatMediator:ON_CHANGE_FLEET"
var_0_1.ON_COMMIT_EDIT = "ExercisePreCombatMediator:ON_COMMIT_EDIT"
var_0_1.OPEN_SHIP_INFO = "ExercisePreCombatMediator:OPEN_SHIP_INFO"
var_0_1.REMOVE_SHIP = "ExercisePreCombatMediator:REMOVE_SHIP"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "ExercisePreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.CHANGE_FLEET_SHIP = "ExercisePreCombatMediator:CHANGE_FLEET_SHIP"
var_0_1.ON_AUTO = "ExercisePreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "ExercisePreCombatMediator:ON_SUB_AUTO"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.ships = var_1.getRawData(var_1_0)

	local var_1_1 = arg_1_0.viewComponent

	var_2.SetShips(var_1_1, arg_1_0.ships)

	local var_1_2 = arg_1_0.contextData.system

	getProxy = var_1_1
	FleetProxy = var_4

	local var_1_3 = var_1_1(var_4)
	local var_1_4
	local var_1_5 = var_1_3:getData()

	if arg_1_0.contextData.EdittingFleet then
		var_1_3.EdittingFleet = arg_1_0.contextData.EdittingFleet
		arg_1_0.contextData.EdittingFleet = nil
	end

	if var_1_3.EdittingFleet ~= nil then
		var_1_5[var_1_3.EdittingFleet.id] = var_1_3.EdittingFleet
	end

	local var_1_6 = arg_1_0.viewComponent

	var_5.SetFleets(var_1_6, var_1_5)

	getProxy = var_5
	PlayerProxy = var_1_6

	local var_1_7 = var_5(var_1_6)
	local var_1_8 = var_5.getData(var_1_7)
	local var_1_9 = arg_1_0.viewComponent

	var_7.SetPlayerInfo(var_1_9, var_1_8)

	local var_1_10 = arg_1_0.viewComponent
	local var_1_11 = var_7.SetCurrentFleet

	FleetProxy = var_9

	var_1_11(var_1_10, var_9.PVP_FLEET_ID)
	arg_1_0:bind(var_0_1.ON_CHANGE_FLEET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.changeFleet(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.onAutoBtn(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUB_AUTO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.onAutoSubBtn(var_4_0, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0

		var_2.refreshEdit(var_5_0, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_SHIP, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_6_2

		arg_6_2.removeShip(var_6_0, arg_6_1)

		getProxy = var_3
		FleetProxy = var_6_0
		var_3(var_6_0).EdittingFleet = arg_6_2

		local var_6_1 = arg_1_0

		var_3.refreshEdit(var_6_1, arg_6_2)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0.contextData

		ExercisePreCombatLayer = var_2_10004
		var_7_0.form = var_2_10004.FORM_EDIT

		local var_7_1 = {}

		ipairs = var_4

		for iter_7_0, iter_7_1 in var_4(arg_7_2:getShipIds()) do
			table = var_2_10009

			var_2_10009.insert(var_7_1, arg_1_0.ships[iter_7_1])
		end

		local var_7_2 = arg_1_0
		local var_7_3 = var_4.sendNotification

		GAME = var_6

		local var_7_4 = var_6.GO_SCENE

		SCENE = iter_7_0

		var_7_3(var_7_2, var_7_4, iter_7_0.SHIPINFO, {
			shipId = arg_7_1,
			shipVOs = var_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		assert = var_2_10004

		local var_8_0 = arg_8_2.id

		FleetProxy = var_2_10006

		var_2_10004(var_8_0 == var_2_10006.PVP_FLEET_ID, "fleet type error")

		local var_8_1 = arg_1_0.contextData

		ExercisePreCombatLayer = var_5
		var_8_1.form = var_5.FORM_EDIT
		FormationMediator = var_8_1

		var_8_1.saveEdit()

		local var_8_2 = var_1_2

		SYSTEM_DUEL = var_8_3

		if var_8_2 == var_8_3 then
			ShipStatus = var_8_3

			local var_8_3

			if not var_8_3.TAG_HIDE_PVP then
				ShipStatus = var_8_3
				var_8_3 = var_8_3.TAG_HIDE_NORMAL
			end

			if var_4 then
				ShipStatus = var_6

				local var_8_4

				if not var_6.TAG_BLOCK_PVP then
					var_8_4 = nil
				end

				local var_8_5 = arg_1_0
				local var_8_6, var_8_7, var_8_8 = var_7.getDockCallbackFuncsForExercise(var_8_5, arg_8_1, arg_8_2, arg_8_3)
				local var_8_9 = {}

				ipairs = var_11

				for iter_8_0, iter_8_1 in var_11(arg_8_2.ships) do
					if not arg_8_1 or iter_8_1 ~= arg_8_1.id then
						table = var_2_10016

						var_2_10016.insert(var_8_9, iter_8_1)
					end
				end

				local var_8_10 = arg_1_0
				local var_8_11 = var_11.sendNotification

				GAME = var_13

				local var_8_12 = var_13.GO_SCENE

				SCENE = iter_8_0

				local var_8_13 = iter_8_0.DOCKYARD
				local var_8_14 = {
					selectedMin = 0,
					useBlackBlock = true,
					selectedMax = 1,
					energyDisplay = true
				}

				pg = var_2_10016

				local var_8_15 = var_2_10016.ShipFlagMgr.GetInstance()

				var_8_14.ignoredIds = var_16.FilterShips(var_8_15, {
					isActivityNpc = true
				})
				i18n = var_16
				var_8_14.leastLimitMsg = var_16("battle_preCombatMediator_leastLimit")
				var_8_14.quitTeam = arg_8_1 ~= nil
				var_8_14.teamFilter = arg_8_3
				var_8_14.onShip = var_8_6
				var_8_14.confirmSelect = var_8_7
				var_8_14.onSelected = var_8_8
				var_8_14.hideTagFlags = var_8_3
				var_8_14.blockTagFlags = var_8_4
				var_8_14.otherSelectedIds = var_8_9

				var_8_11(var_8_10, var_8_12, var_8_13, var_8_14)

				return
			end
		end
	end)
	arg_1_0:bind(var_0_1.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0

		var_2.commitEdit(var_9_0, arg_9_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_10_0, arg_10_1)
		local var_10_0

		if arg_1_0.contextData.rivalId then
			var_10_0 = arg_1_0.contextData.rivalId
		else
			var_10_0 = arg_1_0.contextData.stageId
		end

		seriesAsync = var_3

		var_3({
			function(arg_11_0)
				if arg_1_0.contextData.OnConfirm then
					arg_1_0.contextData.OnConfirm(arg_11_0)
				else
					arg_11_0()
				end

				return
			end,
			function()
				local var_12_0 = arg_1_0
				local var_12_1 = var_0.sendNotification

				GAME = var_3_10002

				var_12_1(var_12_0, var_3_10002.BEGIN_STAGE, {
					stageId = var_10_0,
					mainFleetId = arg_10_1,
					system = arg_1_0.contextData.system,
					actId = arg_1_0.contextData.actId,
					rivalId = arg_1_0.contextData.rivalId
				})

				return
			end
		})

		return
	end)

	return
end

function var_0_1.changeFleet(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.contextData.system

	SYSTEM_SUB_ROUTINE = var_1_10003

	if var_13_0 == var_1_10003 then
		var_13_0 = arg_13_0.contextData
		var_13_0.subFleetId = arg_13_1
	else
		getProxy = var_13_0
		PlayerProxy = var_1_10003
		var_13_0(var_1_10003).combatFleetId = arg_13_1
	end

	local var_13_1 = arg_13_0.viewComponent

	var_2.SetCurrentFleet(var_13_1, arg_13_1)

	local var_13_2 = arg_13_0.viewComponent

	var_2.UpdateFleetView(var_13_2, true)

	return
end

function var_0_1.refreshEdit(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)

	var_14_0.EdittingFleet = arg_14_1

	local var_14_1 = arg_14_0.contextData.system

	SYSTEM_SUB_ROUTINE = var_1_10004

	if var_14_1 ~= var_1_10004 then
		local var_14_2 = var_14_0:getData()

		var_14_2[arg_14_1.id] = arg_14_1

		local var_14_3 = arg_14_0.viewComponent

		var_4.SetFleets(var_14_3, var_14_2)
	end

	local var_14_4 = arg_14_0.viewComponent

	var_3.UpdateFleetView(var_14_4, false)

	return
end

function var_0_1.commitEdit(arg_15_0, arg_15_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	if var_1_10002(var_1_10003).EdittingFleet == nil or var_3:isFirstFleet() or var_3:isLegalToFight() == true then
		var_2:commitEdittingFleet(arg_15_1)
	else
		local var_15_1

		if #var_3.ships == 0 then
			local var_15_0 = var_2

			var_2.commitEdittingFleet(var_15_0, arg_15_1)

			var_15_1 = arg_15_0.contextData.system
			SYSTEM_SUB_ROUTINE = var_15_0

			if var_15_1 == var_15_0 then
				-- block empty
			end
		else
			pg = var_15_1

			local var_15_2 = var_15_1.MsgboxMgr.GetInstance()
			local var_15_3 = var_4.ShowMsgBox
			local var_15_4 = {}

			i18n = var_1_10007
			var_15_4.content = var_1_10007("ship_formationMediaror_trash_warning", var_3.defaultName)

			function var_15_4.onYes()
				getProxy = var_2_10000
				BayProxy = var_2_10001

				local var_16_0 = var_2_10000(var_2_10001)
				local var_16_1 = var_0.getRawData(var_16_0)

				for iter_16_0 = #var_0.ships, 1, -1 do
					local var_16_2 = var_0

					var_7.removeShip(var_16_2, var_16_1[var_2[iter_16_0]])
				end

				local var_16_3 = var_0.id

				FleetProxy = var_4

				if var_16_3 == var_4.PVP_FLEET_ID then
					local var_16_4 = var_0

					var_3.commitEdittingFleet(var_16_4)

					local var_16_5 = arg_15_0
					local var_16_6 = var_3.changeFleet

					FleetProxy = var_5

					var_16_6(var_16_5, var_5.PVP_FLEET_ID)
				else
					local var_16_7 = var_0

					var_3.commitEdittingFleet(var_16_7, arg_15_1)
				end

				return
			end

			var_15_3(var_15_2, var_15_4)
		end
	end

	return
end

function var_0_1.onAutoBtn(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.isOn
	local var_17_1 = arg_17_1.toggle
	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.sendNotification

	GAME = var_1_10006

	var_17_3(var_17_2, var_1_10006.AUTO_BOT, {
		isActiveBot = var_17_0,
		toggle = var_17_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.isOn
	local var_18_1 = arg_18_1.toggle
	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.sendNotification

	GAME = var_1_10006

	var_18_3(var_18_2, var_1_10006.AUTO_SUB, {
		isActiveSub = var_18_0,
		toggle = var_18_1
	})

	return
end

function var_0_1.listNotificationInterests(arg_19_0)
	local var_19_0 = {}

	GAME = var_1_10002
	var_19_0[1] = var_1_10002.BEGIN_STAGE_DONE
	PlayerProxy = var_2
	var_19_0[2] = var_2.UPDATED
	GAME = var_2
	var_19_0[3] = var_2.BEGIN_STAGE_ERRO

	return var_19_0
end

function var_0_1.handleNotification(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1:getName()
	local var_20_1 = arg_20_1
	local var_20_2 = arg_20_1.getBody(var_20_1)

	GAME = var_20_1

	local var_20_4

	if var_20_0 == var_20_1.BEGIN_STAGE_DONE then
		local var_20_3 = arg_20_0

		var_20_4 = arg_20_0.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		SCENE = var_1_10007

		var_20_4(var_20_3, var_1_10006, var_1_10007.COMBATLOAD, var_20_2)
	else
		PlayerProxy = var_20_4

		local var_20_6

		if var_20_0 == var_20_4.UPDATED then
			local var_20_5 = arg_20_0.viewComponent

			var_20_6 = var_20_6.SetPlayerInfo
			getProxy = var_1_10006
			PlayerProxy = var_1_10007
			var_1_10007 = var_1_10006(var_1_10007)

			var_20_6(var_20_5, var_6.getData(var_1_10007))
		else
			GAME = var_20_6

			if var_20_0 == var_20_6.BEGIN_STAGE_ERRO and var_20_2 == 3 then
				pg = var_4

				local var_20_7 = var_4.MsgboxMgr.GetInstance()
				local var_20_8 = var_4.ShowMsgBox
				local var_20_9 = {
					hideNo = true
				}

				i18n = var_1_10007
				var_20_9.content = var_1_10007("battle_preCombatMediator_timeout")

				function var_20_9.onYes()
					local var_21_0 = arg_20_0.viewComponent
					local var_21_1 = var_0.emit

					BaseUI = var_2_10002

					var_21_1(var_21_0, var_2_10002.ON_CLOSE)

					return
				end

				var_20_8(var_20_7, var_20_9)
			end
		end
	end

	return
end

function var_0_1.getDockCallbackFuncsForExercise(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_22_0 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_22_1 = var_1_10005(var_1_10006)

	local function var_22_2(arg_23_0, arg_23_1)
		ShipStatus = var_2_10002

		local var_23_0, var_23_1 = var_2_10002.ShipStatusCheck("inFleet", arg_23_0, arg_23_1)

		if not var_23_0 then
			return var_23_0, var_23_1
		end

		FormationMediator = var_4

		local var_23_2, var_23_3 = var_4.checkChangeShip(arg_22_2, arg_22_1, arg_23_0)

		if not var_23_2 then
			return false, var_23_3
		end

		return true
	end

	local function var_22_3(arg_24_0, arg_24_1, arg_24_2)
		arg_24_1()

		return
	end

	local function var_22_4(arg_25_0)
		local var_25_0 = var_22_1
		local var_25_1 = var_1.getShipById(var_25_0, arg_25_0[1])
		local var_25_2 = arg_22_2
		local var_25_3

		if not var_2.getShipPos(var_25_2, arg_22_1) then
			var_25_3 = -1
		end

		if var_25_3 > 0 then
			local var_25_4 = arg_22_2

			var_3.removeShip(var_25_4, arg_22_1)
		end

		local var_25_5 = arg_22_2
		local var_25_6

		if not var_3.getShipPos(var_25_5, var_25_1) then
			var_25_6 = -1
		end

		if var_25_6 > 0 then
			local var_25_7 = arg_22_2

			var_4.removeShip(var_25_7, var_25_1)
		end

		local var_25_8 = {}

		if arg_22_1 and 0 < var_25_6 then
			table = var_5

			var_5.insert(var_25_8, {
				var_25_6,
				arg_22_1
			})
		end

		if var_25_1 then
			table = var_5

			var_5.insert(var_25_8, {
				var_25_3,
				var_25_1
			})
		end

		table = var_5

		var_5.sort(var_25_8, function(arg_26_0, arg_26_1)
			return arg_26_0[1] < arg_26_1[1]
		end)

		ipairs = var_5

		for iter_25_0, iter_25_1 in var_5(var_25_8) do
			local var_25_9

			if not (iter_25_1[1] > 0) or not iter_25_1[1] then
				var_25_9 = nil
			end

			local var_25_10 = iter_25_1[2]
			local var_25_11 = arg_22_2

			var_12.insertShip(var_25_11, var_25_10, var_25_9, arg_22_3)
		end

		var_22_0.EdittingFleet = arg_22_2

		return
	end

	return var_22_2, var_22_3, var_22_4
end

return var_0_1
