pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ShipFlagMgr = var_0_10001("ShipFlagMgr")

local var_0_1 = var_0.ShipFlagMgr

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.flagDic = {}
	arg_1_0.extraInfo = {}
	ipairs = var_2
	ShipStatus = var_1_10004

	for iter_1_0, iter_1_1 in var_2(var_1_10004.flagList) do
		arg_1_0.flagDic[iter_1_1] = {}
	end

	print = var_2

	var_2("initializing ShipFlagMgr manager...")
	arg_1_1()

	return
end

local var_0_2 = {
	inChapter = function()
		getProxy = var_1_10000
		ChapterProxy = var_1_10002

		local var_2_0 = var_1_10000(var_1_10002)

		if var_0.getActiveChapter(var_2_0) then
			_ = var_1_10002

			local var_2_1

			if not var_1_10002.map(var_1:getShips(), function(arg_3_0)
				return arg_3_0.id
			end) then
				var_2_1 = {}
			end

			return var_2_1
		end
	end,
	inFleet = function()
		getProxy = var_1_10000
		FleetProxy = var_1_10002

		local var_4_0 = var_1_10000(var_1_10002)

		return var_0.getAllShipIds(var_4_0, true)
	end,
	inElite = function()
		local var_5_0 = {}

		getProxy = var_1_10001
		ChapterProxy = var_1_10003

		local var_5_1 = var_1_10001(var_1_10003)

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_5_2 = var_1_10002(var_1_10004)

		if not var_5_1.mapEliteFleetCache then
			return {}, {}
		end

		pairs = var_3

		for iter_5_0, iter_5_1 in var_3(var_5_1.mapEliteFleetCache) do
			checkExist = var_1_10008
			ChapterProxy = var_1_10010

			if not (var_1_10008(var_1_10010.FormationToChapters[iter_5_0], {
				1
			}) and var_0.chapter_template[var_1_10008].map) then
				goto label_5_0
			end

			if not var_0.expedition_data_by_map[var_9].on_activity then
				var_1_10010 = 0
			end

			if var_1_10010 ~= 0 then
				checkExist = var_11
				iter_5_2 = var_5_2

				if var_11(var_5_2.getActivityById(iter_5_2, var_1_10010), {
					"isEnd"
				}) == false then
					local var_5_3 = {}

					ipairs = var_1_10012

					local var_5_4 = {}

					FleetType = iter_5_2
					var_5_4[1] = iter_5_1[iter_5_2.Normal]
					FleetType = iter_5_2
					var_5_4[2] = iter_5_1[iter_5_2.Submarine]

					for iter_5_2, iter_5_3 in var_1_10012(var_5_4) do
						ipairs = var_1_10017

						for iter_5_4, iter_5_5 in var_1_10017(iter_5_3) do
							table = var_1_10022
							var_1_10022 = var_1_10022.insertto

							local var_5_5 = var_5_3

							TeamType = var_1_10025

							var_1_10022(var_5_5, iter_5_5[var_1_10025.FormShips])
						end
					end

					var_5_0[iter_5_0] = var_5_3
				end

				::label_5_0::
			end
		end

		_ = var_3

		local var_5_6 = var_3.flatten

		_ = var_5

		return var_5_6(var_5.values(var_5_0)), var_5_0
	end,
	inSupport = function()
		local var_6_0 = {}

		getProxy = var_1_10001
		ChapterProxy = var_1_10003

		local var_6_1 = var_1_10001(var_1_10003)

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_6_2 = var_1_10002(var_1_10004)

		if not var_6_1.mapEliteFleetCache then
			return {}, {}
		end

		pairs = var_3

		for iter_6_0, iter_6_1 in var_3(var_6_1.mapEliteFleetCache) do
			checkExist = var_1_10008
			ChapterProxy = var_1_10010

			if not (var_1_10008(var_1_10010.FormationToChapters[iter_6_0], {
				1
			}) and var_0.chapter_template[var_1_10008].map) then
				goto label_6_0
			end

			if not var_0.expedition_data_by_map[var_9].on_activity then
				var_1_10010 = 0
			end

			if var_1_10010 ~= 0 then
				checkExist = var_11

				if var_11(var_6_2:getActivityById(var_1_10010), {
					"isEnd"
				}) == false then
					local var_6_3 = {}

					ipairs = var_1_10012
					FleetType = var_1_10014

					for iter_6_2, iter_6_3 in var_1_10012(iter_6_1[var_1_10014.Support]) do
						table = var_1_10017
						var_1_10017 = var_1_10017.insertto

						local var_6_4 = var_6_3

						TeamType = var_1_10020

						var_1_10017(var_6_4, iter_6_3[var_1_10020.FormShips])
					end

					var_6_0[iter_6_0] = var_6_3
				end

				::label_6_0::
			end
		end

		_ = var_3

		local var_6_5 = var_3.flatten

		_ = var_5

		return var_6_5(var_5.values(var_6_0)), var_6_0
	end,
	inActivity = function()
		local var_7_0 = {}

		getProxy = var_1_10001
		FleetProxy = var_1_10003

		local var_7_1 = var_1_10001(var_1_10003)

		pairs = var_1_10002

		for iter_7_0, iter_7_1 in var_1_10002(var_7_1:getActivityFleets()) do
			_ = var_1_10007
			var_1_10007 = var_1_10007.flatten
			_ = var_1_10009
			var_1_10009 = var_1_10009.map
			_ = var_1_10011
			var_7_0[iter_7_0] = var_1_10007(var_1_10009(var_1_10011.values(iter_7_1), function(arg_8_0)
				return arg_8_0.ships
			end))
		end

		_ = var_2

		local var_7_2 = var_2.flatten

		_ = var_4

		return var_7_2(var_4.values(var_7_0)), var_7_0
	end,
	inPvP = function()
		getProxy = var_1_10000
		FleetProxy = var_1_10002

		local var_9_0 = var_1_10000(var_1_10002)
		local var_9_1 = var_0.getFleetById

		FleetProxy = var_1_10004

		local var_9_2

		if not var_9_1(var_9_0, var_1_10004.PVP_FLEET_ID) or not var_1:getShipIds() then
			var_9_2 = {}
		end

		return var_9_2
	end,
	inChallenge = function()
		getProxy = var_1_10000
		FleetProxy = var_1_10002

		local var_10_0 = var_1_10000(var_1_10002)
		local var_10_1 = var_0.getFleetById

		FleetProxy = var_1_10004

		local var_10_2 = var_10_1(var_10_0, var_1_10004.CHALLENGE_FLEET_ID)
		local var_10_3 = var_0
		local var_10_4 = var_0.getFleetById

		FleetProxy = var_1_10005

		local var_10_5 = var_10_4(var_10_3, var_1_10005.CHALLENGE_SUB_FLEET_ID)
		local var_10_6 = var_10_2:getShipIds()

		table = var_10_3

		var_10_3.insertto(var_10_6, var_10_5:getShipIds())

		return var_10_6
	end,
	inExercise = function()
		getProxy = var_1_10000
		MilitaryExerciseProxy = var_1_10002

		local var_11_0 = var_1_10000(var_1_10002)
		local var_11_1 = var_0.getExerciseFleet(var_11_0)

		return var_1.getShipIds(var_11_1)
	end,
	inEvent = function()
		getProxy = var_1_10000
		EventProxy = var_1_10002

		local var_12_0 = var_1_10000(var_1_10002)

		return var_0.getActiveShipIds(var_12_0)
	end,
	inClass = function()
		getProxy = var_1_10000
		NavalAcademyProxy = var_1_10002

		local var_13_0 = var_1_10000(var_1_10002)

		return var_0.GetShipIDs(var_13_0)
	end,
	inTactics = function()
		getProxy = var_1_10000
		NavalAcademyProxy = var_1_10002

		local var_14_0 = var_1_10000(var_1_10002)
		local var_14_1 = var_0.getStudents(var_14_0)

		_ = var_1_10002

		local var_14_2 = var_1_10002.map

		underscore = var_1_10004

		return var_14_2(var_1_10004.values(var_14_1), function(arg_15_0)
			return arg_15_0 and arg_15_0.shipId
		end)
	end,
	inBackyard = function()
		getProxy = var_1_10000
		DormProxy = var_1_10002

		local var_16_0 = var_1_10000(var_1_10002)
		local var_16_1 = var_0.getRawData(var_16_0)

		return var_1.GetShipIds(var_16_1)
	end,
	inAdmiral = function()
		getProxy = var_1_10000
		PlayerProxy = var_1_10002

		local var_17_0 = var_1_10000(var_1_10002)

		return var_0.getRawData(var_17_0).characters
	end,
	inWorld = function()
		nowWorld = var_1_10000

		local var_18_0 = var_1_10000().type

		World = var_1_10002

		if var_18_0 == var_1_10002.TypeBase then
			underscore = var_18_0

			return var_18_0.rest(var_0.baseShipIds, 1)
		else
			_ = var_18_0

			return var_18_0.map(var_0:GetShips(), function(arg_19_0)
				return arg_19_0.id
			end)
		end

		return
	end,
	isActivityNpc = function()
		getProxy = var_1_10000
		BayProxy = var_1_10002

		return var_1_10000(var_1_10002).activityNPCShipIds
	end,
	inGuildEvent = function()
		getProxy = var_1_10000
		GuildProxy = var_1_10002

		local var_21_0 = var_1_10000(var_1_10002)

		if var_0.getRawData(var_21_0) then
			return var_0:GetMissionAndAssultFleetShips()
		else
			return {}
		end

		return
	end,
	inGuildBossEvent = function()
		getProxy = var_1_10000
		GuildProxy = var_1_10002

		local var_22_0 = var_1_10000(var_1_10002)

		if var_0.getRawData(var_22_0) then
			return var_0:GetBossMissionShips()
		else
			return {}
		end

		return
	end
}

function var_0_1.MarkShipsFlag(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(arg_23_2) do
		arg_23_0.flagDic[arg_23_1][iter_23_1] = true
	end

	if arg_23_3 then
		arg_23_0.extraInfo[arg_23_1] = arg_23_3
	end

	return
end

function var_0_1.GetShipFlag(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	defaultValue = var_1_10004
	arg_24_3 = var_1_10004(arg_24_3, true)
	type = var_4

	local var_24_0

	if var_4(arg_24_3) == "boolean" then
		var_24_0 = arg_24_0.flagDic[arg_24_2][arg_24_1] == arg_24_3

		return var_24_0
	else
		type = var_24_0

		local var_24_1

		if var_24_0(arg_24_3) == "number" then
			if arg_24_2 == "inElite" then
				if not arg_24_0.extraInfo[arg_24_2][arg_24_3] then
					var_24_1 = {}
				end

				_ = var_1_10005

				return var_1_10005.any(var_24_1, function(arg_25_0)
					return arg_25_0 == arg_24_1
				end)
			elseif arg_24_2 == "inActivity" then
				if not arg_24_0.extraInfo[arg_24_2][arg_24_3] then
					var_24_1 = {}
				end

				_ = var_1_10005

				return var_1_10005.any(var_24_1, function(arg_26_0)
					return arg_26_0 == arg_24_1
				end)
			elseif arg_24_2 == "inSupport" then
				if not arg_24_0.extraInfo[arg_24_2][arg_24_3] then
					var_24_1 = {}
				end

				_ = var_1_10005

				return var_1_10005.any(var_24_1, function(arg_27_0)
					return arg_27_0 == arg_24_1
				end)
			else
				assert = var_24_1

				var_24_1(false, "flagName:" .. arg_24_2 .. " type error")
			end
		else
			assert = var_24_1

			var_24_1(false, "info type error")
		end
	end

	return
end

function var_0_1.FilterShips(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_2 then
		underscore = var_1_10003

		local var_28_0 = var_1_10003.keys

		getProxy = var_1_10005
		BayProxy = var_1_10007

		local var_28_1 = var_1_10005(var_1_10007)

		arg_28_2 = var_28_0(var_5.getRawData(var_28_1))
	end

	local var_28_2 = {}

	ipairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(arg_28_2) do
		pairs = var_1_10009

		for iter_28_2, iter_28_3 in var_1_10009(arg_28_1) do
			if iter_28_3 and arg_28_0:GetShipFlag(iter_28_1, iter_28_2, iter_28_3) then
				var_28_2[iter_28_1] = true

				break
			end
		end
	end

	_ = var_4

	return var_4.keys(var_28_2)
end

function var_0_1.UpdateFlagShips(arg_29_0, arg_29_1)
	arg_29_0.flagDic[arg_29_1] = {}

	arg_29_0:MarkShipsFlag(arg_29_1, var_0_2[arg_29_1]())

	return
end

function var_0_1.ClearShipsFlag(arg_30_0, arg_30_1)
	arg_30_0.flagDic[arg_30_1] = {}

	return
end

function var_0_1.DebugPrint(arg_31_0, arg_31_1)
	warning = var_1_10002

	var_1_10002("id:" .. arg_31_1 .. " flags:")

	ipairs = var_1_10002
	ShipStatus = var_4

	for iter_31_0, iter_31_1 in var_1_10002(var_4.flagList) do
		if arg_31_0.flagDic[iter_31_1][arg_31_1] then
			warning = var_7

			var_7(iter_31_1)
		end
	end

	return
end

return var_0_1
