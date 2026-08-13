class = var_0_10000

local var_0_0 = "DefenseFormationMedator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEN_SHIP_INFO = "DefenseFormationMedator:OPEN_SHIP_INFO"
var_0_1.ON_CHANGE_FLEET = "DefenseFormationMedator:ON_CHANGE_FLEET"
var_0_1.CHANGE_FLEET_NAME = "DefenseFormationMedator:CHANGE_FLEET_NAME"
var_0_1.CHANGE_FLEET_SHIP = "DefenseFormationMedator:CHANGE_FLEET_SHIP"
var_0_1.REMOVE_SHIP = "DefenseFormationMedator:REMOVE_SHIP"
var_0_1.CHANGE_FLEET_FORMATION = "DefenseFormationMedator:CHANGE_FLEET_FORMATION"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "DefenseFormationMedator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.COMMIT_FLEET = "DefenseFormationMedator:COMMIT_FLEET"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.ships = var_1.getRawData(var_1_0)

	local var_1_1 = arg_1_0.viewComponent

	var_2.setShips(var_1_1, arg_1_0.ships)

	getProxy = var_2
	MilitaryExerciseProxy = var_1_1

	local var_1_2 = var_2(var_1_1)
	local var_1_3 = var_2.getExerciseFleet(var_1_2)

	getProxy = var_1_2
	FleetProxy = var_1_10005

	local var_1_4 = var_1_2(var_1_10005)
	local var_1_5 = var_4.getFleetById(var_1_4, 1)
	local var_1_6 = arg_1_0.viewComponent

	var_6.SetFleet(var_1_6, var_1_3)
	arg_1_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.contextData.number = arg_2_2.id
		arg_1_0.contextData.toggle = arg_2_3

		local var_2_0 = {}

		ipairs = var_5

		for iter_2_0, iter_2_1 in var_5(arg_2_2:getShipIds()) do
			table = var_2_10010

			var_2_10010.insert(var_2_0, arg_1_0.ships[iter_2_1])
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_5.sendNotification

		GAME = var_7

		local var_2_3 = var_7.GO_SCENE

		SCENE = iter_2_0

		var_2_2(var_2_1, var_2_3, iter_2_0.SHIPINFO, {
			shipId = arg_2_1,
			shipVOs = var_2_0
		})

		return
	end)
	arg_1_0:bind(var_0_1.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.save(var_3_0, nil, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.save(var_4_0, arg_4_1)

		local var_4_1 = arg_1_0

		var_2.refreshView(var_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_SHIP, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_2:removeShip(arg_5_1)

		local var_5_0 = arg_1_0

		var_3.save(var_5_0, arg_5_2)

		local var_5_1 = arg_1_0

		var_3.refreshView(var_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0

		if not arg_6_1 or not arg_6_1.id then
			var_6_0 = nil
		end

		local var_6_1 = var_0
		local var_6_2 = var_4.getSeasonInfo(var_6_1)
		local var_6_3 = var_4.getMainShipIds(var_6_2)
		local var_6_4 = var_4
		local var_6_5 = var_4.getVanguardShipIds(var_6_4)

		pg = var_6_4

		local var_6_6 = var_6_4.ShipFlagMgr.GetInstance()

		for iter_6_0 = #var_7.FilterShips(var_6_6, {
			isActivityNpc = true,
			inExercise = true
		}), 1, -1 do
			if var_7[iter_6_0] == var_6_0 then
				table = var_12

				var_12.remove(var_7, iter_6_0)

				break
			end
		end

		local var_6_7, var_6_8 = arg_1_0.configDockYardFunc(arg_1_0.ships, var_6_3, var_6_5, var_6_0, arg_6_2, function(arg_7_0, arg_7_1)
			local var_7_0 = arg_1_0
			local var_7_1 = var_2.sendNotification

			GAME = var_3_10004

			var_7_1(var_7_0, var_3_10004.UPDATE_EXERCISE_FLEET, {
				fleet = arg_7_0,
				callback = arg_7_1
			})

			arg_7_0 = nil

			return
		end)
		local var_6_9 = arg_1_0
		local var_6_10 = var_10.sendNotification

		GAME = var_12

		local var_6_11 = var_12.GO_SCENE

		SCENE = var_13

		local var_6_12 = var_13.DOCKYARD
		local var_6_13 = {
			callbackQuit = true,
			selectedMax = 1,
			quitTeam = arg_6_1 ~= nil,
			teamFilter = arg_6_2,
			ignoredIds = var_7
		}

		ShipStatus = var_15
		var_6_13.hideTagFlags = var_15.TAG_HIDE_DEFENSE
		i18n = var_15
		var_6_13.leftTopInfo = var_15("word_formation")
		var_6_13.onShip = var_6_8
		var_6_13.onSelected = var_6_7

		var_6_10(var_6_9, var_6_11, var_6_12, var_6_13)

		return
	end)

	return
end

function var_0_1.refreshView(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.viewComponent

	var_2.UpdateFleetView(var_8_0, arg_8_1)

	return
end

function var_0_1.save(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.sendNotification

		GAME = var_1_10005

		var_9_1(var_9_0, var_1_10005.UPDATE_EXERCISE_FLEET, {
			fleet = arg_9_1,
			callback = arg_9_2
		})
	elseif arg_9_2 then
		arg_9_2()
	end

	return
end

function var_0_1.configDockYardFunc(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local function var_10_0(arg_11_0, arg_11_1)
		local var_11_0 = {}

		local function var_11_1(arg_12_0)
			if not arg_10_3 then
				ipairs = var_1
				_ = var_3_10002

				for iter_12_0, iter_12_1 in var_1(var_3_10002.reverse(arg_12_0)) do
					table = var_3_10006

					if not var_3_10006.contains(arg_11_0, iter_12_1) then
						table = var_3_10006

						var_3_10006.insert(arg_11_0, 1, iter_12_1)
					end
				end
			else
				if arg_10_3 then
					table = var_1

					if var_1.getCount(arg_11_0) == 0 then
						ipairs = var_1

						for iter_12_2, iter_12_3 in var_1(arg_12_0) do
							if iter_12_3 ~= arg_10_3 then
								table = var_6

								if not var_6.contains(arg_11_0, iter_12_3) then
									table = var_6

									var_6.insert(arg_11_0, iter_12_3)
								end
							end
						end

						goto label_12_0
					end
				end

				if arg_10_3 then
					ipairs = var_1

					for iter_12_4, iter_12_5 in var_1(arg_12_0) do
						if iter_12_5 == arg_10_3 then
							arg_12_0[iter_12_4] = arg_11_0[1]
						end
					end

					arg_11_0 = arg_12_0
				end
			end

			::label_12_0::

			return
		end

		local function var_11_2(arg_13_0)
			local var_13_0 = arg_10_4

			TeamType = var_3_10002

			local var_13_2

			if var_13_0 == var_3_10002.Main then
				local var_13_1 = var_11_0

				if not arg_13_0 or not arg_11_0 then
					var_13_2 = arg_10_1
				end

				var_13_1.mainShips = var_13_2
				var_11_0.vanguardShips = arg_10_2
			else
				local var_13_3 = arg_10_4

				TeamType = var_13_2

				if var_13_3 == var_13_2.Vanguard then
					var_11_0.mainShips = arg_10_1

					local var_13_4 = var_11_0
					local var_13_5

					if not arg_13_0 or not arg_11_0 then
						var_13_5 = arg_10_2
					end

					var_13_4.vanguardShips = var_13_5
				end
			end

			if arg_10_5 then
				arg_10_5(var_11_0, arg_11_1)
			end

			return
		end

		local var_11_3 = arg_10_4

		TeamType = var_2_10006

		if var_11_3 == var_2_10006.Main then
			var_11_1(arg_10_1)
		else
			local var_11_4 = arg_10_4

			TeamType = var_6

			if var_11_4 == var_6.Vanguard then
				var_11_1(arg_10_2)
			end
		end

		local function var_11_5()
			pg = var_3_10000

			local var_14_0 = var_3_10000.MsgboxMgr.GetInstance()
			local var_14_1 = var_0.ShowMsgBox
			local var_14_2 = {}

			i18n = var_3_10003
			var_14_2.content = var_3_10003("defense_formation_tip_npc")

			function var_14_2.onYes()
				var_11_2(false)

				return
			end

			function var_14_2.onNo()
				var_11_2(false)

				return
			end

			var_14_1(var_14_0, var_14_2)

			return
		end

		if #arg_11_0 > 0 then
			var_11_2(true)
		else
			pg = var_6

			local var_11_6 = var_6.MsgboxMgr.GetInstance()
			local var_11_7 = var_6.ShowMsgBox
			local var_11_8 = {}

			i18n = var_2_10009
			var_11_8.content = var_2_10009("exercise_clear_fleet_tip")

			function var_11_8.onYes()
				getProxy = var_3_10000
				FleetProxy = var_3_10001

				local var_17_0 = var_3_10000(var_3_10001)
				local var_17_1 = var_0.getFleetById(var_17_0, 1)

				if not var_0.ExistActNpcShip(var_17_1) then
					var_11_2(true)
				else
					var_11_5()
				end

				return
			end

			function var_11_8.onNo()
				var_11_2(false)

				return
			end

			var_11_7(var_11_6, var_11_8)
		end

		return
	end

	local function var_10_1(arg_19_0, arg_19_1, arg_19_2)
		pg = var_2_10003

		local var_19_0 = var_2_10003.ship_data_template[arg_19_0.configId].group_type

		local function var_19_1(arg_20_0)
			ipairs = var_3_10001

			for iter_20_0, iter_20_1 in var_3_10001(arg_20_0) do
				pg = var_3_10006
				var_3_10006 = var_3_10006.ship_data_template[arg_10_0[iter_20_1].configId].group_type

				if (not arg_10_3 or arg_10_3 ~= iter_20_1 or var_3_10006 ~= var_19_0) and var_3_10006 == var_19_0 then
					return false
				end
			end

			return true
		end

		local var_19_2 = arg_10_4

		TeamType = var_2_10006

		local var_19_4

		if var_19_2 == var_2_10006.Main then
			if not var_19_1(arg_10_1) then
				local var_19_3 = false

				i18n = var_19_4
				var_19_4 = var_19_4("ship_vo_mainFleet_exist_same_ship")

				return
			end
		else
			local var_19_5 = arg_10_4

			TeamType = var_19_4

			if var_19_5 == var_19_4.Vanguard and not var_19_1(arg_10_2) then
				local var_19_6 = false

				i18n = var_6

				local var_19_7 = var_6("ship_vo_vanguardFleet_exist_same_ship")

				return
			end
		end

		return true
	end

	return var_10_0, var_10_1
end

function var_0_1.listNotificationInterests(arg_21_0)
	local var_21_0 = {}

	GAME = var_1_10002
	var_21_0[1] = var_1_10002.EXERCISE_FLEET_RESET

	return var_21_0
end

function var_0_1.handleNotification(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getName()
	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.getBody(var_22_1)

	GAME = var_22_1

	if var_22_1.EXERCISE_FLEET_RESET == var_22_0 then
		local var_22_3 = arg_22_0.viewComponent

		var_4.SetFleet(var_22_3, var_22_2)

		local var_22_4 = arg_22_0.viewComponent

		var_4.UpdateFleetView(var_22_4, true)
	end

	return
end

return var_0_1
