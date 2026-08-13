class = var_0_10000

local var_0_0 = "FleetProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.FLEET_ADDED = "fleet added"
var_0_1.FLEET_UPDATED = "fleet updated"
var_0_1.FLEET_RENAMED = "fleet renamed"
var_0_1.PVP_FLEET_ID = 101
var_0_1.CHALLENGE_FLEET_ID = 102
var_0_1.CHALLENGE_SUB_FLEET_ID = 103

function var_0_1.register(arg_1_0)
	arg_1_0.extraFleets = {}
	arg_1_0.activityFleetData = {}

	arg_1_0:on(12101, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.data = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.group_list) do
			local var_2_1 = var_0_1.CreateFleet(iter_2_1)

			var_6.display(var_2_1, "loaded")

			arg_1_0.data[var_6.id] = var_6

			local var_2_2 = arg_1_0

			var_7.CommanderManualTaskProgressAdd(var_2_2, var_6)
		end

		local var_2_3 = 1

		FormationUI = var_2

		for iter_2_2 = var_2_3, var_2.MAX_FLEET_NUM do
			if not arg_1_0.data[iter_2_2] then
				arg_1_0.data[iter_2_2] = var_0_1.CreateFleet({
					name = "",
					id = iter_2_2,
					ship_list = {},
					commanders = {}
				})
			end
		end

		pairs = var_2_3

		for iter_2_3, iter_2_4 in var_2_3({
			[var_0_1.PVP_FLEET_ID] = "",
			[var_0_1.CHALLENGE_FLEET_ID] = "",
			[var_0_1.CHALLENGE_SUB_FLEET_ID] = ""
		}) do
			if not arg_1_0.data[iter_2_3] then
				arg_1_0.data[iter_2_3] = var_0_1.CreateFleet({
					id = iter_2_3,
					name = iter_2_4,
					ship_list = {},
					commanders = {}
				})
			end
		end

		ipairs = var_1

		for iter_2_5, iter_2_6 in var_1({
			var_0_1.CHALLENGE_FLEET_ID,
			var_0_1.CHALLENGE_SUB_FLEET_ID
		}) do
			arg_1_0.extraFleets[iter_2_6] = arg_1_0.data[iter_2_6]
			arg_1_0.data[iter_2_6] = nil
		end

		LOCK_SUBMARINE = var_1

		if var_1 then
			pairs = var_1

			for iter_2_7, iter_2_8 in var_1(arg_1_0.data) do
				if iter_2_8.id == 11 or iter_2_8.id == 12 then
					arg_1_0.data[iter_2_7] = nil
				end
			end
		end

		pg = var_1

		local var_2_4 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_2_4, "inFleet")

		pg = var_1

		local var_2_5 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_2_5, "inPvP")

		pg = var_1

		local var_2_6 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_2_6, "inChallenge")

		return
	end)
	arg_1_0:on(12106, function(arg_3_0)
		local var_3_0 = var_0_1.CreateFleet(arg_3_0.group)

		if arg_1_0.data[var_3_0.id] then
			local var_3_1 = arg_1_0

			var_2.updateFleet(var_3_1, var_3_0)
		else
			local var_3_2 = arg_1_0

			var_2.addFleet(var_3_2, var_3_0)
		end

		return
	end)

	return
end

function var_0_1.CreateFleet(arg_4_0)
	local var_4_0 = arg_4_0.id

	CreateShell = var_1_10002

	local var_4_1 = var_1_10002(arg_4_0)

	FleetType = var_1_10003
	var_4_1.fleetType = var_1_10003.Normal
	Fleet = var_3

	local var_4_2

	if var_3.REGULAR_FLEET_ID <= var_4_0 then
		Fleet = var_4_2
		var_4_2 = var_4_2.REGULAR_FLEET_ID
		Fleet = var_4

		if var_4_0 < var_4_2 + var_4.REGULAR_FLEET_NUMS then
			Fleet = var_4_2

			if var_4_0 == var_4_2.REGULAR_FLEET_ID then
				var_4_1.saveLastShipFlag = true
			end

			goto label_4_0
		end
	end

	Fleet = var_4_2

	if var_4_2.SUBMARINE_FLEET_ID <= var_4_0 then
		Fleet = var_4_2
		var_4_2 = var_4_2.SUBMARINE_FLEET_ID
		Fleet = var_4

		if var_4_0 < var_4_2 + var_4.SUBMARINE_FLEET_NUMS then
			FleetType = var_4_2
			var_4_1.fleetType = var_4_2.Submarine

			goto label_4_0
		end
	end

	FleetProxy = var_4_2

	if var_4_0 == var_4_2.PVP_FLEET_ID then
		var_4_1.saveLastShipFlag = true
	else
		FleetProxy = var_4_2

		if var_4_0 == var_4_2.CHALLENGE_FLEET_ID then
			-- block empty
		else
			FleetProxy = var_4_2

			if var_4_0 == var_4_2.CHALLENGE_SUB_FLEET_ID then
				FleetType = var_4_2
				var_4_1.fleetType = var_4_2.Submarine
			end
		end
	end

	::label_4_0::

	TypedFleet = var_4_2

	return (var_4_2.New(var_4_1))
end

function var_0_1.addFleet(arg_5_0, arg_5_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_5_0 = arg_5_1

	Fleet = var_1_10007

	var_1_10002(var_1_10004(var_5_0, var_1_10007), "should be an instance of Fleet")

	assert = var_1_10002

	var_1_10002(arg_5_0.data[arg_5_1.id] == nil, "fleet already exist, use updateFleet() instead")

	arg_5_0.data[arg_5_1.id] = arg_5_1:clone()

	local var_5_1 = arg_5_0.data[arg_5_1.id]

	var_2.display(var_5_1, "added")

	pg = var_2

	local var_5_2 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_5_2, "inFleet")

	pg = var_2

	local var_5_3 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_5_3, "inPvP")

	local var_5_4 = arg_5_0.facade

	var_2.sendNotification(var_5_4, var_0_1.FLEET_ADDED, arg_5_1:clone())

	return
end

function var_0_1.updateFleet(arg_6_0, arg_6_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_6_0 = arg_6_1

	Fleet = var_1_10007

	var_1_10002(var_1_10004(var_6_0, var_1_10007), "should be an instance of Fleet")

	if arg_6_0.data[arg_6_1.id] ~= nil then
		arg_6_0.data[arg_6_1.id] = arg_6_1:clone()

		local var_6_1 = arg_6_0.data[arg_6_1.id]

		var_2.display(var_6_1, "updated")

		pg = var_2

		local var_6_2 = var_2.ShipFlagMgr.GetInstance()

		var_2.UpdateFlagShips(var_6_2, "inFleet")

		pg = var_2

		local var_6_3 = var_2.ShipFlagMgr.GetInstance()

		var_2.UpdateFlagShips(var_6_3, "inPvP")
		arg_6_0:CommanderManualTaskProgressAdd(arg_6_1)
	else
		local var_6_4

		if arg_6_0.extraFleets[arg_6_1.id] ~= nil then
			var_6_4 = arg_6_0.extraFleets
			var_6_4[arg_6_1.id] = arg_6_1

			local var_6_5 = arg_6_0.extraFleets[arg_6_1.id]

			var_6_4.display(var_6_5, "updated")

			pg = var_6_4

			local var_6_6 = var_6_4.ShipFlagMgr.GetInstance()

			var_6_4.UpdateFlagShips(var_6_6, "inChallenge")
		else
			assert = var_6_4

			var_6_4(false, "fleet should exist")
		end
	end

	local var_6_7 = arg_6_0.facade

	var_2.sendNotification(var_6_7, var_0_1.FLEET_UPDATED, arg_6_1.id)

	return
end

function var_0_1.saveEdittingFleet(arg_7_0)
	if arg_7_0.editSrcCache == nil then
		Clone = var_1
		arg_7_0.editSrcCache = var_1(arg_7_0.data)
	end

	if arg_7_0.EdittingFleet ~= nil then
		local var_7_0 = arg_7_0.data

		var_7_0[arg_7_0.EdittingFleet.id] = arg_7_0.EdittingFleet
		pg = var_7_0

		local var_7_1 = var_7_0.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_7_1, "inFleet")

		pg = var_1

		local var_7_2 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_7_2, "inPvP")
	end

	return
end

function var_0_1.commitEdittingFleet(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_0.EdittingFleet ~= nil then
		table = var_3

		var_3.insert(var_8_0, function(arg_9_0)
			local var_9_0 = arg_8_0.facade
			local var_9_1 = var_1.sendNotification

			GAME = var_2_10004

			var_9_1(var_9_0, var_2_10004.UPDATE_FLEET, {
				fleet = arg_8_0.EdittingFleet,
				callback = function()
					arg_8_0.editSrcCache = nil
					arg_8_0.EdittingFleet = nil

					arg_9_0()

					return
				end
			})

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_8_0, function()
		if arg_8_1 then
			arg_8_1()
		end

		return
	end)

	return
end

function var_0_1.abortEditting(arg_12_0)
	if arg_12_0.editSrcCache then
		arg_12_0.data = arg_12_0.editSrcCache
		arg_12_0.editSrcCache = nil
	end

	arg_12_0.EdittingFleet = nil

	return
end

function var_0_1.syncFleet(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.data) do
		local var_13_0 = arg_13_0.facade
		local var_13_1 = var_6.sendNotification

		GAME = var_1_10009

		var_13_1(var_13_0, var_1_10009.UPDATE_FLEET, {
			fleet = iter_13_1
		})
	end

	return
end

function var_0_1.getCount(arg_14_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_14_0.data)
end

function var_0_1.getFleetById(arg_15_0, arg_15_1)
	if arg_15_0.data[arg_15_1] ~= nil then
		local var_15_0 = arg_15_0.data[arg_15_1]

		return var_2.clone(var_15_0)
	end

	if arg_15_0.extraFleets[arg_15_1] then
		return arg_15_0.extraFleets[arg_15_1]
	end

	return nil
end

function var_0_1.getAllShipIds(arg_16_0, arg_16_1)
	local var_16_0 = {}

	pairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(arg_16_0.data) do
		if arg_16_1 and not iter_16_1:isRegularFleet() then
			-- block empty
		else
			ipairs = var_1_10008

			for iter_16_2, iter_16_3 in var_1_10008(iter_16_1.ships) do
				table = var_1_10013

				var_1_10013.insert(var_16_0, iter_16_3)
			end
		end
	end

	return var_16_0
end

function var_0_1.getFirstFleetShipCount(arg_17_0)
	local var_17_0 = 0

	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.data[1].ships) do
		var_17_0 = var_17_0 + 1
	end

	return var_17_0
end

function var_0_1.GetRegularFleets(arg_18_0)
	local var_18_0 = {}

	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.data) do
		if iter_18_1:isRegularFleet() then
			Clone = var_7
			var_18_0[iter_18_0] = var_7(iter_18_1)
		end
	end

	return var_18_0
end

function var_0_1.inPvPFleet(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.data

	FleetProxy = var_1_10003

	local var_19_1 = var_19_0[var_1_10003.PVP_FLEET_ID]

	if var_2.containShip(var_19_1, arg_19_1) then
		return true
	end

	return false
end

function var_0_1.GetRegularFleetByShip(arg_20_0, arg_20_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_20_0 = arg_20_1

	Ship = var_1_10007

	var_1_10002(var_1_10004(var_20_0, var_1_10007), "should be an instance of Ship")

	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.data) do
		if iter_20_1:isRegularFleet() and iter_20_1:containShip(arg_20_1) then
			return iter_20_1:clone()
		end
	end

	return nil
end

function var_0_1.renameFleet(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getFleetById(arg_21_1)

	assert = var_1_10004

	var_1_10004(var_21_0 ~= nil, "fleet should exist")

	var_21_0.name = arg_21_2

	arg_21_0:updateFleet(var_21_0)

	local var_21_1 = arg_21_0.facade

	var_4.sendNotification(var_21_1, var_0_1.FLEET_RENAMED, var_21_0:clone())

	return
end

function var_0_1.getCommandersInFleet(arg_22_0)
	local var_22_0 = {}

	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.data) do
		if iter_22_1:isRegularFleet() then
			pairs = var_7

			for iter_22_2, iter_22_3 in var_7(iter_22_1:getCommanders()) do
				table = var_1_10012

				var_1_10012.insert(var_22_0, iter_22_3.id)
			end
		end
	end

	return var_22_0
end

function var_0_1.getCommanders(arg_23_0)
	local var_23_0 = {}

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.data) do
		if iter_23_1:isRegularFleet() then
			pairs = var_7

			for iter_23_2, iter_23_3 in var_7(iter_23_1:getCommanders()) do
				table = var_1_10012

				var_1_10012.insert(var_23_0, {
					fleetId = iter_23_1.id,
					pos = iter_23_2,
					commanderId = iter_23_3.id
				})
			end
		end
	end

	return var_23_0
end

function var_0_1.GetExtraCommanders(arg_24_0)
	local var_24_0 = {}

	pairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.extraFleets) do
		pairs = var_1_10007

		for iter_24_2, iter_24_3 in var_1_10007(iter_24_1:getCommanders()) do
			table = var_1_10012

			var_1_10012.insert(var_24_0, {
				fleetId = iter_24_1.id,
				pos = iter_24_2,
				commanderId = iter_24_3.id
			})
		end
	end

	return var_24_0
end

function var_0_1.getActivityFleets(arg_25_0)
	return arg_25_0.activityFleetData
end

function var_0_1.addActivityFleet(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1.id

	if not arg_26_0.activityFleetData[var_26_0] then
		arg_26_0.activityFleetData[var_26_0] = {}
	end

	local var_26_1 = arg_26_0.activityFleetData[var_26_0]

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_26_2 = var_1_10005(var_1_10007)
	local var_26_3
	local var_26_4

	pg = var_1_10008

	local var_26_5 = var_1_10008.activity_template[var_26_0]

	local function var_26_6()
		if var_26_4 then
			return var_26_4
		end

		local var_27_0 = arg_26_1
		local var_27_1 = var_0.GetActiveSeriesIds(var_27_0)
		local var_27_2 = var_26_5.type

		ActivityConst = var_27_0

		if var_27_2 == var_27_0.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
			CollabrateBossRushSeriesData = var_27_2

			if not var_27_2 then
				BossRushSeriesData = var_27_2
			end

			_ = var_2
			var_26_4 = var_2.map(var_27_1, function(arg_28_0)
				table = var_3_10001

				local var_28_0 = var_3_10001.lastof
				local var_28_1 = var_27_2.New({
					id = arg_28_0,
					actId = arg_26_1.id
				})

				return var_28_0(var_3.GetFleetIds(var_28_1))
			end)

			return var_26_4
		end
	end

	ipairs = var_1_10010

	for iter_26_4, iter_26_1 in var_1_10010(arg_26_2) do
		CreateShell = var_1_10015
		var_1_10015 = var_1_10015(iter_26_1)

		local var_26_7 = var_26_5.type

		ActivityConst = var_17

		if var_26_7 == var_17.ACTIVITY_TYPE_BOSSRUSH then
			table = var_26_7

			if var_26_7.contains(var_26_6(), iter_26_1.id) then
				FleetType = var_26_8

				local var_26_8

				if not var_26_8.Submarine then
					FleetType = var_26_8
					var_26_8 = var_26_8.Normal
				end

				var_1_10015.fleetType = var_26_8

				goto label_26_0

				var_26_7 = var_26_5.type
				ActivityConst = var_26_8

				if var_26_7 == var_26_8.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
					var_26_7 = iter_26_1.id
					Fleet = var_26_9
					var_26_7 = var_26_9.SUBMARINE_FLEET_ID <= var_26_7

					if var_26_7 then
						FleetType = var_26_9

						local var_26_9

						if not var_26_9.Submarine then
							FleetType = var_26_9
							var_26_9 = var_26_9.Normal
						end

						var_1_10015.fleetType = var_26_9

						goto label_26_0

						var_26_7 = var_26_5.type
						ActivityConst = var_26_9

						if var_26_7 == var_26_9.ACTIVITY_TYPE_BOSSSINGLE then
							var_26_7 = iter_26_1.id
							Fleet = var_26_10
							var_26_7 = var_26_10.SUBMARINE_FLEET_ID <= var_26_7

							if var_26_7 then
								FleetType = var_26_10

								local var_26_10

								if not var_26_10.Submarine then
									FleetType = var_26_10
									var_26_10 = var_26_10.Normal
								end

								var_1_10015.fleetType = var_26_10

								goto label_26_0

								var_26_7 = var_26_5.type
								ActivityConst = var_26_10

								if var_26_7 == var_26_10.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
									var_26_7 = iter_26_1.id
									Fleet = var_26_11
									var_26_7 = var_26_11.MEGA_SUBMARINE_FLEET_OFFSET <= var_26_7

									if var_26_7 then
										FleetType = var_26_11

										local var_26_11

										if not var_26_11.Submarine then
											FleetType = var_26_11
											var_26_11 = var_26_11.Normal
										end

										var_1_10015.fleetType = var_26_11

										goto label_26_0

										var_26_7 = var_26_5.type
										ActivityConst = var_26_11

										if var_26_7 == var_26_11.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
											table = var_26_7

											if var_26_7.contains(var_26_6(), iter_26_1.id) then
												FleetType = var_26_12

												local var_26_12

												if not var_26_12.Submarine then
													FleetType = var_26_12
													var_26_12 = var_26_12.Normal
												end

												var_1_10015.fleetType = var_26_12

												goto label_26_0

												var_26_7 = {
													id = iter_26_1.id
												}
												Fleet = var_17

												if var_17.isSubmarineFleet(var_26_7) then
													FleetType = var_1_10018

													if not var_1_10018.Submarine then
														FleetType = var_1_10018
														var_1_10018 = var_1_10018.Normal
													end

													var_1_10015.fleetType = var_1_10018

													::label_26_0::

													TypedFleet = var_26_7
													var_26_1[var_26_7.New(var_1_10015).id] = var_16
													ipairs = var_17

													for iter_26_2, iter_26_3 in var_17(iter_26_1.ship_list) do
														if not var_26_2:RawGetShipById(iter_26_3) then
															var_26_3 = true

															break
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local var_26_13 = var_26_5.type

	ActivityConst = var_11

	if var_26_13 == var_11.ACTIVITY_TYPE_BOSSRUSH then
		ipairs = var_26_13

		for iter_26_4, iter_26_5 in var_26_13(arg_26_1:getConfig("config_data")) do
			BossRushSeriesData = var_15

			local var_26_14 = var_15.New({
				id = iter_26_5,
				actId = arg_26_1.id
			})
			local var_26_15 = var_15.GetFleetIds(var_26_14)[1]

			if not var_15:IsSingleFight() and var_26_1[var_26_15] then
				local var_26_16 = var_26_1[var_26_15]

				if not var_17.isAllEmpty(var_26_16) then
					local var_26_17 = var_26_1[var_26_15]

					var_17.allClear(var_26_17)

					var_26_3 = true
				end
			end
		end
	end

	if var_26_3 then
		arg_26_0:commitActivityFleet(var_26_0)
	end

	local var_26_18
	local var_26_19
	local var_26_20 = var_26_5.type

	ActivityConst = iter_26_4

	if var_26_20 == iter_26_4.ACTIVITY_TYPE_CHALLENGE then
		var_26_18 = 2
		var_26_19 = 2
	else
		local var_26_21 = var_26_5.type

		ActivityConst = var_26_27

		if var_26_21 == var_26_27.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			var_26_18 = 0
			var_26_19 = 0
		else
			local var_26_22 = var_26_5.type

			ActivityConst = var_26_27

			if var_26_22 == var_26_27.ACTIVITY_TYPE_BOSSRUSH then
				var_26_18 = 0
				var_26_19 = 0
			else
				local var_26_23 = var_26_5.type

				ActivityConst = var_26_27

				if var_26_23 == var_26_27.ACTIVITY_TYPE_BOSSSINGLE then
					var_26_18 = 0
					var_26_19 = 0
				else
					local var_26_24 = var_26_5.type

					ActivityConst = var_26_27

					if var_26_24 == var_26_27.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
						var_26_18 = 0
						var_26_19 = 0
					else
						local var_26_25 = var_26_5.type

						ActivityConst = var_26_27

						if var_26_25 == var_26_27.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
							var_26_18 = 0
							var_26_19 = 0
						end
					end
				end
			end
		end
	end

	local var_26_26 = 0

	while var_26_26 < var_26_18 do
		local var_26_27

		if var_26_1[var_26_26 + 1] == nil then
			TypedFleet = var_26_27
			var_26_27 = var_26_27.New

			local var_26_28 = {
				id = var_26_26,
				ship_list = {}
			}

			FleetType = var_16
			var_26_28.fleetType = var_16.Normal
			var_26_1[var_26_26] = var_26_27(var_26_28)
		end
	end

	local var_26_29 = 0

	while var_26_29 < var_26_19 do
		Fleet = var_26_27

		if var_26_1[var_26_27.SUBMARINE_FLEET_ID + var_26_29] == nil then
			TypedFleet = var_14

			local var_26_30 = var_14.New
			local var_26_31 = {
				id = var_26_27,
				ship_list = {}
			}

			FleetType = var_17
			var_26_31.fleetType = var_17.Submarine
			var_26_1[var_26_27] = var_26_30(var_26_31)
		end

		var_26_29 = var_26_29 + 1
	end

	pg = var_26_27

	local var_26_32 = var_26_27.ShipFlagMgr.GetInstance()

	var_13.UpdateFlagShips(var_26_32, "inActivity")

	return
end

function var_0_1.updateActivityFleet(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0.activityFleetData[arg_29_1]

	var_29_0[arg_29_2] = arg_29_3
	pg = var_29_0

	local var_29_1 = var_29_0.ShipFlagMgr.GetInstance()

	var_4.UpdateFlagShips(var_29_1, "inActivity")

	return
end

function var_0_1.commitActivityFleet(arg_30_0, arg_30_1)
	arg_30_0.editSrcCache = nil
	arg_30_0.EdittingFleet = nil

	local var_30_0 = arg_30_0.facade
	local var_30_1 = var_2.sendNotification

	GAME = var_1_10005

	var_30_1(var_30_0, var_1_10005.EDIT_ACTIVITY_FLEET, {
		actID = arg_30_1,
		fleets = arg_30_0.activityFleetData[arg_30_1]
	})

	return
end

function var_0_1.checkActivityFleet(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.activityFleetData[arg_31_1]

	pairs = var_1_10003

	for iter_31_0, iter_31_1 in var_1_10003(var_31_0) do
		Fleet = var_1_10008

		if iter_31_0 < var_1_10008.SUBMARINE_FLEET_ID and iter_31_1:isLegalToFight() == true then
			return true
		end
	end

	return false
end

function var_0_1.removeActivityFleetCommander(arg_32_0, arg_32_1)
	pairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.activityFleetData) do
		pairs = var_1_10007

		for iter_32_2, iter_32_3 in var_1_10007(iter_32_1) do
			local var_32_0 = false
			local var_32_1 = iter_32_3:GetRawCommanderIds()

			pairs = var_1_10014

			for iter_32_4, iter_32_5 in var_1_10014(var_32_1) do
				if arg_32_1 == iter_32_5 then
					iter_32_3:updateCommanderByPos(iter_32_4, nil)
					iter_32_3:updateCommanderSkills()
					arg_32_0:updateActivityFleet(iter_32_0, iter_32_2, iter_32_3)
					arg_32_0:commitActivityFleet(iter_32_0)

					var_32_0 = true

					break
				end
			end

			if var_32_0 then
				break
			end
		end
	end

	return
end

function var_0_1.recommendActivityFleet(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.getActivityFleets(var_33_0)[arg_33_1][arg_33_2]

	getProxy = var_33_0
	BayProxy = var_1_10007

	local var_33_2 = var_33_0(var_1_10007)

	local function var_33_3(arg_34_0, arg_34_1)
		local var_34_0 = var_33_2
		local var_34_1 = var_2.getActivityRecommendShips(var_34_0, arg_34_0, var_33_1.ships, arg_34_1, arg_33_1)

		ipairs = var_2_10003

		for iter_34_0, iter_34_1 in var_2_10003(var_34_1) do
			local var_34_2 = var_33_1

			var_8.insertShip(var_34_2, iter_34_1, nil, iter_34_1:getTeamType())
		end

		return
	end

	local function var_33_4(arg_35_0)
		TeamType = var_2_10001

		local var_35_0 = var_2_10001.VanguardMax - #arg_35_0.vanguardShips

		TeamType = var_2

		local var_35_1 = var_2.MainMax - #arg_35_0.mainShips

		if var_35_0 > 0 then
			local var_35_2 = var_33_3

			ShipType = var_2_10005

			var_35_2(var_2_10005.VanguardShipType, var_35_0)
		end

		if var_35_1 > 0 then
			local var_35_3 = var_33_3

			ShipType = var_2_10005

			var_35_3(var_2_10005.MainShipType, var_35_1)
		end

		return
	end

	local function var_33_5(arg_36_0)
		local var_36_0 = arg_36_0

		if not arg_36_0.isFull(var_36_0) then
			local var_36_1 = var_33_3

			ShipType = var_36_0

			local var_36_2 = var_36_0.SubShipType

			TeamType = var_2_10004

			var_36_1(var_36_2, var_2_10004.SubmarineMax - #arg_36_0.subShips)
		end

		return
	end

	getProxy = var_1_10009
	ActivityProxy = var_1_10011

	local var_33_6 = var_1_10009(var_1_10011)
	local var_33_7 = var_9.getActivityById(var_33_6, arg_33_1)
	local var_33_8 = var_10.getConfig(var_33_7, "type")

	ActivityConst = var_33_6

	if var_33_8 == var_33_6.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		Fleet = var_33_8

		if var_33_8.MEGA_SUBMARINE_FLEET_OFFSET <= arg_33_2 then
			var_33_5(var_33_1)
		else
			var_33_4(var_33_1)
		end
	else
		Fleet = var_33_8

		if arg_33_2 >= var_33_8.SUBMARINE_FLEET_ID then
			var_33_5(var_33_1)
		else
			var_33_4(var_33_1)
		end
	end

	arg_33_0:updateActivityFleet(arg_33_1, arg_33_2, var_33_1)

	return
end

function var_0_1.GetBossRushFleets(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {}
	local var_37_1 = arg_37_0:getActivityFleets()[arg_37_1]

	table = var_1_10005

	var_1_10005.Foreach(arg_37_2, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0 == #arg_37_2

		if not var_37_1[arg_38_1] then
			if var_38_0 then
				FleetType = var_38_1

				local var_38_1

				if not var_38_1.Submarine then
					FleetType = var_38_1
					var_38_1 = var_38_1.Normal
				end

				local var_38_2 = var_37_1

				TypedFleet = var_2_10005
				var_38_2[arg_38_1] = var_2_10005.New({
					id = arg_38_1,
					ship_list = {},
					fleetType = var_38_1
				})

				local var_38_3 = var_37_1[arg_38_1]

				var_3.RemoveUnusedItems(var_38_3)

				var_37_0[arg_38_0] = var_3

				return
			end
		end
	end)

	return var_37_0
end

function var_0_1.IsBossRushFleetsEmpty(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getActivityFleets()[arg_39_1]

	underscore = var_1_10004

	return var_1_10004.all(arg_39_2, function(arg_40_0)
		return not var_39_0[arg_40_0]
	end)
end

function var_0_1.CommanderManualTaskProgressAdd(arg_41_0, arg_41_1)
	getProxy = var_1_10002
	CommanderManualProxy = var_1_10004

	local var_41_0 = var_1_10002(var_1_10004)
	local var_41_1 = arg_41_1

	if arg_41_1.isLegalToFight(var_41_1) == true then
		local var_41_2 = #arg_41_1.vanguardShips

		TeamType = var_41_1

		if var_41_1.VanguardMax <= var_41_2 then
			var_41_0:TaskProgressAdd(2013, 1)

			local var_41_3 = {}

			ShipType = var_41_1
			var_41_3[1] = var_41_1.QuZhu
			ShipType = var_41_1
			var_41_3[2] = var_41_1.QingXun
			ShipType = var_41_1
			var_41_3[3] = var_41_1.ZhongXun
			ipairs = var_41_1

			for iter_41_0, iter_41_1 in var_41_1(arg_41_1.vanguardShips) do
				getProxy = var_1_10010
				BayProxy = var_1_10012
				var_1_10012 = var_1_10010(var_1_10012)

				local var_41_4 = var_1_10010.getShipById(var_1_10012, iter_41_1)
				local var_41_5 = var_1_10010.getConfig(var_41_4, "type")

				table = var_1_10012

				if var_1_10012.contains(var_41_3, var_41_5) then
					table = var_1_10012

					var_1_10012.removebyvalue(var_41_3, var_41_5)
				end
			end

			if #var_41_3 == 0 then
				var_41_0:TaskProgressAdd(2014, 1)
			end
		end
	end

	if var_3 == true then
		local var_41_6 = #arg_41_1.mainShips

		TeamType = var_41_1

		if var_41_1.MainMax <= var_41_6 then
			var_41_0:TaskProgressAdd(2015, 1)

			local var_41_7 = {}

			ShipType = var_41_1
			var_41_7[1] = var_41_1.ZhengHang
			ShipType = var_41_1
			var_41_7[2] = var_41_1.ZhanLie
			ShipType = var_41_1
			var_41_7[3] = var_41_1.ZhanLie
			ipairs = var_41_1

			for iter_41_2, iter_41_3 in var_41_1(arg_41_1.mainShips) do
				getProxy = var_1_10010
				BayProxy = var_1_10012
				var_1_10012 = var_1_10010(var_1_10012)

				local var_41_8 = var_1_10010.getShipById(var_1_10012, iter_41_3)
				local var_41_9 = var_1_10010.getConfig(var_41_8, "type")

				table = var_1_10012

				if var_1_10012.contains(var_41_7, var_41_9) then
					table = var_1_10012

					var_1_10012.removebyvalue(var_41_7, var_41_9)
				end
			end

			if #var_41_7 == 0 then
				var_41_0:TaskProgressAdd(2016, 1)
			end
		end
	end

	if var_3 == true then
		local var_41_10 = arg_41_1:GetGearScoreSum()

		if 1000 < var_41_10 then
			var_41_0:TaskProgressAdd(2017, 1)
		end
	end

	if var_3 == true then
		local var_41_11 = arg_41_1:getFleetType()

		FleetType = var_41_1

		if var_41_11 == var_41_1.Submarine then
			var_41_0:TaskProgressAdd(2018, 1)
		end
	end

	if var_3 == true and not arg_41_1:isFirstFleet() and not arg_41_1:isSubmarineFleet() then
		var_41_0:TaskProgressAdd(2019, 1)
	end

	return
end

return var_0_1
