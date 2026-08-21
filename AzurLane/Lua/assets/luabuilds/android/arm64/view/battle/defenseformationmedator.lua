local var_0_0 = class("DefenseFormationMedator", import("..base.ContextMediator"))

var_0_0.OPEN_SHIP_INFO = "DefenseFormationMedator:OPEN_SHIP_INFO"
var_0_0.ON_CHANGE_FLEET = "DefenseFormationMedator:ON_CHANGE_FLEET"
var_0_0.CHANGE_FLEET_NAME = "DefenseFormationMedator:CHANGE_FLEET_NAME"
var_0_0.CHANGE_FLEET_SHIP = "DefenseFormationMedator:CHANGE_FLEET_SHIP"
var_0_0.REMOVE_SHIP = "DefenseFormationMedator:REMOVE_SHIP"
var_0_0.CHANGE_FLEET_FORMATION = "DefenseFormationMedator:CHANGE_FLEET_FORMATION"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "DefenseFormationMedator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.COMMIT_FLEET = "DefenseFormationMedator:COMMIT_FLEET"

function var_0_0.register(arg_1_0)
	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:setShips(arg_1_0.ships)

	local var_1_0 = getProxy(MilitaryExerciseProxy)
	local var_1_1 = getProxy(FleetProxy):getFleetById(1)

	arg_1_0.viewComponent:SetFleet((getProxy(MilitaryExerciseProxy):getExerciseFleet()))
	arg_1_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.contextData.number = arg_2_2.id
		arg_1_0.contextData.toggle = arg_2_3

		for iter_2_0, iter_2_1 in ipairs(arg_2_2:getShipIds()) do
			table.insert({}, arg_1_0.ships[iter_2_1])
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_2_1,
			shipVOs = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		arg_1_0:save(nil, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_4_0, arg_4_1)
		arg_1_0:save(arg_4_1)
		arg_1_0:refreshView()

		return
	end)
	arg_1_0:bind(var_0_0.REMOVE_SHIP, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_2:removeShip(arg_5_1)
		arg_1_0:save(arg_5_2)
		arg_1_0:refreshView()

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			local var_6_0 = arg_6_1.id or nil
			local var_6_1 = var_1_0:getSeasonInfo()
			local var_6_2 = pg.ShipFlagMgr.GetInstance():FilterShips({
				isActivityNpc = true,
				inExercise = true
			})

			for iter_6_0 = #var_6_2, 1, -1 do
				if var_6_2[iter_6_0] == var_6_0 then
					table.remove(var_6_2, iter_6_0)

					break
				end
			end

			local var_6_3, var_6_4 = arg_1_0.configDockYardFunc(arg_1_0.ships, var_6_1:getMainShipIds(), var_6_1:getVanguardShipIds(), var_6_0, arg_6_2, function(arg_7_0, arg_7_1)
				arg_1_0:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
					fleet = arg_7_0,
					callback = arg_7_1
				})

				arg_7_0 = nil

				return
			end)

			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
				callbackQuit = true,
				selectedMax = 1,
				quitTeam = arg_6_1 ~= nil,
				teamFilter = arg_6_2,
				ignoredIds = var_6_2,
				hideTagFlags = ShipStatus.TAG_HIDE_DEFENSE,
				leftTopInfo = i18n("word_formation"),
				onShip = var_6_4,
				onSelected = var_6_3
			})

			return
		end
	end)

	return
end

function var_0_0.refreshView(arg_8_0, arg_8_1)
	arg_8_0.viewComponent:UpdateFleetView(arg_8_1)

	return
end

function var_0_0.save(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		arg_9_0:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
			fleet = arg_9_1,
			callback = arg_9_2
		})
	elseif arg_9_2 then
		arg_9_2()
	end

	return
end

function var_0_0.configDockYardFunc(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	return function(arg_11_0, arg_11_1)
		local var_11_0 = {}

		local function var_11_1(arg_13_0)
			if arg_10_4 == TeamType.Main then
				local var_13_0 = var_11_0

				if arg_13_0 then
					var_13_0.mainShips = arg_11_0 or arg_10_1
					var_11_0.vanguardShips = arg_10_2

					goto label_13_0

					::label_13_0::

					if arg_10_4 == TeamType.Vanguard then
						var_11_0.mainShips = arg_10_1

						local var_13_1 = var_11_0

						if arg_13_0 then
							var_13_1.vanguardShips = arg_11_0 or arg_10_2

							if arg_10_5 then
								arg_10_5(var_11_0, arg_11_1)
							end

							return
						end
					end
				end
			end
		end

		if arg_10_4 == TeamType.Main then
			(function(arg_12_0)
				if not arg_10_3 then
					for iter_12_0, iter_12_1 in ipairs(_.reverse(arg_12_0)) do
						if not table.contains(arg_11_0, iter_12_1) then
							table.insert(arg_11_0, 1, iter_12_1)
						end
					end
				elseif arg_10_3 and table.getCount(arg_11_0) == 0 then
					for iter_12_2, iter_12_3 in ipairs(arg_12_0) do
						if iter_12_3 ~= arg_10_3 and not table.contains(arg_11_0, iter_12_3) then
							table.insert(arg_11_0, iter_12_3)
						end
					end
				elseif arg_10_3 then
					for iter_12_4, iter_12_5 in ipairs(arg_12_0) do
						if iter_12_5 == arg_10_3 then
							arg_12_0[iter_12_4] = arg_11_0[1]
						end
					end

					arg_11_0 = arg_12_0
				end

				return
			end)(arg_10_1)
		elseif arg_10_4 == TeamType.Vanguard then
			(function(arg_12_0)
				if not arg_10_3 then
					for iter_12_0, iter_12_1 in ipairs(_.reverse(arg_12_0)) do
						if not table.contains(arg_11_0, iter_12_1) then
							table.insert(arg_11_0, 1, iter_12_1)
						end
					end
				elseif arg_10_3 and table.getCount(arg_11_0) == 0 then
					for iter_12_2, iter_12_3 in ipairs(arg_12_0) do
						if iter_12_3 ~= arg_10_3 and not table.contains(arg_11_0, iter_12_3) then
							table.insert(arg_11_0, iter_12_3)
						end
					end
				elseif arg_10_3 then
					for iter_12_4, iter_12_5 in ipairs(arg_12_0) do
						if iter_12_5 == arg_10_3 then
							arg_12_0[iter_12_4] = arg_11_0[1]
						end
					end

					arg_11_0 = arg_12_0
				end

				return
			end)(arg_10_2)
		end

		local function var_11_2()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("defense_formation_tip_npc"),
				onYes = function()
					var_11_1(false)

					return
				end,
				onNo = function()
					var_11_1(false)

					return
				end
			})

			return
		end

		if #arg_11_0 > 0 then
			var_11_1(true)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("exercise_clear_fleet_tip"),
				onYes = function()
					if not getProxy(FleetProxy):getFleetById(1):ExistActNpcShip() then
						var_11_1(true)
					else
						var_11_2()
					end

					return
				end,
				onNo = function()
					var_11_1(false)

					return
				end
			})
		end

		return
	end, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = pg.ship_data_template[arg_19_0.configId].group_type

		if arg_10_4 == TeamType.Main then
			if not (function(arg_20_0)
				for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
					if (not arg_10_3 or arg_10_3 ~= iter_20_1 or pg.ship_data_template[arg_10_0[iter_20_1].configId].group_type ~= var_19_0) and pg.ship_data_template[arg_10_0[iter_20_1].configId].group_type == var_19_0 then
						return false
					end
				end

				return true
			end)(arg_10_1) then
				local var_19_2 = i18n("ship_vo_mainFleet_exist_same_ship")

				return
			end
		elseif arg_10_4 == TeamType.Vanguard and not (function(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if (not arg_10_3 or arg_10_3 ~= iter_20_1 or pg.ship_data_template[arg_10_0[iter_20_1].configId].group_type ~= var_19_0) and pg.ship_data_template[arg_10_0[iter_20_1].configId].group_type == var_19_0 then
					return false
				end
			end

			return true
		end)(arg_10_2) then
			local var_19_4 = i18n("ship_vo_vanguardFleet_exist_same_ship")

			return
		end

		return true
	end
end

function var_0_0.listNotificationInterests(arg_21_0)
	return {
		GAME.EXERCISE_FLEET_RESET
	}
end

function var_0_0.handleNotification(arg_22_0, arg_22_1)
	if GAME.EXERCISE_FLEET_RESET == arg_22_1:getName() then
		arg_22_0.viewComponent:SetFleet((arg_22_1:getBody()))
		arg_22_0.viewComponent:UpdateFleetView(true)
	end

	return
end

return var_0_0
