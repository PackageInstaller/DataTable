class = var_0_10000

local var_0_0 = var_0_10000("NewBattleResultDataExtender")

function var_0_0.NeedCloseCamera(arg_1_0)
	SYSTEM_BOSS_RUSH = var_1_10001

	if arg_1_0 ~= var_1_10001 then
		SYSTEM_BOSS_RUSH_EX = var_1_10001

		if arg_1_0 ~= var_1_10001 then
			SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10001

			if arg_1_0 ~= var_1_10001 then
				SYSTEM_ACT_BOSS = var_1_10001

				if arg_1_0 ~= var_1_10001 then
					SYSTEM_WORLD_BOSS = var_1_10001

					if arg_1_0 ~= var_1_10001 then
						SYSTEM_BOSS_SINGLE = var_1_10001

						if arg_1_0 ~= var_1_10001 then
							SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10001

							local var_1_0

							if arg_1_0 == var_1_10001 then
								var_1_0 = false
							else
								var_1_0 = true
							end

							return var_1_0
						end
					end
				end
			end
		end
	end
end

function var_0_0.NeedVibrate(arg_2_0)
	PlayerPrefs = var_1_10001

	local var_2_0 = var_1_10001.GetInt

	AUTO_BATTLE_LABEL = var_1_10003

	local var_2_1 = var_2_0(var_1_10003, 0)
	local var_2_2 = 0 < var_2_1

	ys = var_2

	return var_2.Battle.BattleState.IsAutoBotActive() and var_2_2 and not arg_2_0
end

function var_0_0.NeedHelpMessage(arg_3_0, arg_3_1)
	SYSTEM_SCENARIO = var_1_10002

	if arg_3_0 ~= var_1_10002 then
		SYSTEM_ROUTINE = var_1_10002

		if arg_3_0 ~= var_1_10002 then
			SYSTEM_SUB_ROUTINE = var_1_10002

			if arg_3_0 ~= var_1_10002 then
				SYSTEM_DUEL = var_1_10002

				if arg_3_0 == var_1_10002 then
					if arg_3_1 <= 0 then
						return true
					end
				end

				return false
			end
		end
	end
end

function var_0_0.GetAutoSkipFlag(arg_4_0, arg_4_1)
	SYSTEM_SCENARIO = var_1_10002

	if arg_4_1 ~= var_1_10002 then
		SYSTEM_SCENARIO_SUB_STRIKE = var_1_10002

		if arg_4_1 == var_1_10002 then
			getProxy = var_1_10002
			ChapterProxy = var_1_10004

			local var_4_0 = var_1_10002(var_1_10004)

			var_1_10002 = var_1_10002.getActiveChapter(var_4_0)
			getProxy = var_1_10003
			ChapterProxy = var_1_10005

			local var_4_1 = var_1_10003(var_1_10005)

			var_1_10003 = var_1_10003.GetChapterAutoFlag(var_4_1, var_1_10002.id) == 1

			return var_1_10003
		else
			SYSTEM_WORLD = var_1_10002

			if arg_4_1 == var_1_10002 then
				nowWorld = var_1_10002

				return var_1_10002().isAutoFight
			else
				SYSTEM_TEST = var_1_10002

				if arg_4_1 == var_1_10002 then
					InDebugBattleLoop = var_1_10002
					tobool = var_1_10003

					return var_1_10003(var_1_10002)
				end
			end
		end

		local var_4_2

		if not arg_4_0.autoSkipFlag then
			var_4_2 = false
		end

		return var_4_2
	end
end

function var_0_0.GetExpBuffs(arg_5_0)
	local var_5_0

	SYSTEM_SCENARIO = var_1_10002

	if arg_5_0 ~= var_1_10002 then
		SYSTEM_ROUTINE = var_1_10002

		if arg_5_0 ~= var_1_10002 then
			SYSTEM_ACT_BOSS = var_1_10002

			if arg_5_0 ~= var_1_10002 then
				SYSTEM_HP_SHARE_ACT_BOSS = var_1_10002

				if arg_5_0 ~= var_1_10002 then
					SYSTEM_SUB_ROUTINE = var_1_10002

					if arg_5_0 ~= var_1_10002 then
						SYSTEM_WORLD = var_1_10002

						if arg_5_0 ~= var_1_10002 then
							SYSTEM_BOSS_SINGLE = var_1_10002

							if arg_5_0 ~= var_1_10002 then
								SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10002

								if arg_5_0 == var_1_10002 then
									_ = var_1_10002

									local var_5_1 = var_1_10002.detect

									BuffHelper = var_1_10004

									local var_5_2 = var_1_10004.GetBuffsByActivityType

									ActivityConst = var_1_10006
									var_5_0 = var_5_1(var_5_2(var_1_10006.ACTIVITY_TYPE_BUFF), function(arg_6_0)
										return arg_6_0:getConfig("benefit_type") == "rookie_battle_exp"
									end)
								end

								return var_5_0
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.GetShipBuffs(arg_7_0)
	local var_7_0

	SYSTEM_SCENARIO = var_1_10002

	if arg_7_0 ~= var_1_10002 then
		SYSTEM_ROUTINE = var_1_10002

		if arg_7_0 ~= var_1_10002 then
			SYSTEM_ACT_BOSS = var_1_10002

			if arg_7_0 ~= var_1_10002 then
				SYSTEM_HP_SHARE_ACT_BOSS = var_1_10002

				if arg_7_0 ~= var_1_10002 then
					SYSTEM_SUB_ROUTINE = var_1_10002

					if arg_7_0 ~= var_1_10002 then
						SYSTEM_WORLD = var_1_10002

						if arg_7_0 ~= var_1_10002 then
							SYSTEM_BOSS_SINGLE = var_1_10002

							if arg_7_0 ~= var_1_10002 then
								SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10002

								if arg_7_0 == var_1_10002 then
									getProxy = var_1_10002
									ActivityProxy = var_1_10004

									local var_7_1 = var_1_10002(var_1_10004)

									var_7_0 = var_2.getBuffShipList(var_7_1)
								end

								return var_7_0
							end
						end
					end
				end
			end
		end
	end
end

local function var_0_1()
	local var_8_0 = {}

	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_8_1 = var_1_10001(var_1_10003)
	local var_8_2 = var_1.getActiveChapter(var_8_1).fleet

	TeamType = var_8_1

	local var_8_3 = var_8_2[var_8_1.Main]

	TeamType = var_1_10004

	local var_8_4 = var_8_2[var_1_10004.Vanguard]

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(var_8_3) do
		table = var_1_10010

		var_1_10010.insert(var_8_0, iter_8_1)
	end

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(var_8_4) do
		table = var_1_10010

		var_1_10010.insert(var_8_0, iter_8_3)
	end

	_ = var_5

	if var_5.detect(var_1.fleets, function(arg_9_0)
		local var_9_0 = arg_9_0:getFleetType()

		FleetType = var_2_10002

		return var_9_0 == var_2_10002.Submarine
	end) then
		local var_8_5 = var_5
		local var_8_6 = var_5.getShipsByTeam

		TeamType = iter_8_3

		local var_8_7 = var_8_6(var_8_5, iter_8_3.Submarine, true)

		ipairs = var_7

		for iter_8_4, iter_8_5 in var_7(var_8_7) do
			table = var_1_10012

			var_1_10012.insert(var_8_0, iter_8_5)
		end
	end

	return var_8_0
end

local function var_0_2()
	local var_10_0 = {}

	nowWorld = var_1_10001

	local var_10_1 = var_1_10001()
	local var_10_2 = var_1.GetActiveMap(var_10_1)
	local var_10_3 = var_2.GetFleet(var_10_2)
	local var_10_4 = var_3.GetTeamShipVOs

	TeamType = var_1_10007

	local var_10_5 = var_10_4(var_10_3, var_1_10007.Main, true)
	local var_10_6 = var_3
	local var_10_7 = var_3.GetTeamShipVOs

	TeamType = var_8

	local var_10_8 = var_10_7(var_10_6, var_8.Vanguard, true)

	ipairs = var_10_3

	for iter_10_0, iter_10_1 in var_10_3(var_10_5) do
		table = var_1_10011

		var_1_10011.insert(var_10_0, iter_10_1)
	end

	ipairs = var_6

	for iter_10_2, iter_10_3 in var_6(var_10_8) do
		table = var_1_10011

		var_1_10011.insert(var_10_0, iter_10_3)
	end

	local var_10_9 = var_2

	if var_2.GetSubmarineFleet(var_10_9) then
		local var_10_10 = var_6
		local var_10_11 = var_6.GetTeamShipVOs

		TeamType = iter_10_3

		local var_10_12 = var_10_11(var_10_10, iter_10_3.Submarine, true)

		ipairs = var_10_9

		for iter_10_4, iter_10_5 in var_10_9(var_10_12) do
			table = var_1_10013

			var_1_10013.insert(var_10_0, iter_10_5)
		end
	end

	return var_10_0
end

local function var_0_3(arg_11_0)
	nowWorld = var_1_10001

	local var_11_0 = var_1_10001()
	local var_11_1 = var_1.GetBossProxy(var_11_0)
	local var_11_2 = var_2.GetFleet(var_11_1, arg_11_0.bossId)

	getProxy = var_11_0
	BayProxy = var_6

	local var_11_3 = var_11_0(var_6)

	return (var_4.getShipsByFleet(var_11_3, var_11_2))
end

local function var_0_4(arg_12_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getActivityFleets(var_12_0)[arg_12_0.actId][arg_12_0.mainFleetId]

	getProxy = var_12_0
	BayProxy = var_1_10005

	local var_12_2 = var_12_0(var_1_10005)
	local var_12_3 = var_3.getShipsByFleet(var_12_2, var_12_1)
	local var_12_4 = var_1[arg_12_0.mainFleetId + 10]

	getProxy = var_12_2
	BayProxy = var_1_10007

	local var_12_5 = var_12_2(var_1_10007)
	local var_12_6 = var_5.getShipsByFleet(var_12_5, var_12_4)

	ipairs = var_6

	for iter_12_0, iter_12_1 in var_6(var_12_6) do
		table = var_1_10011

		var_1_10011.insert(var_12_3, iter_12_1)
	end

	return var_12_3
end

local function var_0_5(arg_13_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getActivityFleets(var_13_0)[arg_13_0.actId][arg_13_0.mainFleetId]

	getProxy = var_13_0
	BayProxy = var_1_10005

	local var_13_2 = var_13_0(var_1_10005)
	local var_13_3 = var_3.getShipsByFleet(var_13_2, var_13_1)
	local var_13_4 = var_1[arg_13_0.mainFleetId + 100]

	getProxy = var_13_2
	BayProxy = var_1_10007

	local var_13_5 = var_13_2(var_1_10007)
	local var_13_6 = var_5.getShipsByFleet(var_13_5, var_13_4)

	ipairs = var_6

	for iter_13_0, iter_13_1 in var_6(var_13_6) do
		table = var_1_10011

		var_1_10011.insert(var_13_3, iter_13_1)
	end

	return var_13_3
end

local function var_0_6()
	local var_14_0 = {}

	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_14_1 = var_1_10001(var_1_10003)
	local var_14_2 = var_1.getRawData(var_14_1)
	local var_14_3 = var_1.GetActiveEvent(var_14_2)
	local var_14_4 = var_2.GetBossMission(var_14_3)
	local var_14_5 = var_3.GetMainFleet(var_14_4)

	ipairs = var_14_3

	for iter_14_0, iter_14_1 in var_14_3(var_14_5:GetShips()) do
		table = var_1_10010

		var_1_10010.insert(var_14_0, iter_14_1.ship)
	end

	local var_14_6 = var_3:GetSubFleet()

	ipairs = var_6

	for iter_14_2, iter_14_3 in var_6(var_14_6:GetShips()) do
		table = var_1_10011

		var_1_10011.insert(var_14_0, iter_14_3.ship)
	end

	return var_14_0
end

local function var_0_7(arg_15_0)
	local var_15_0 = arg_15_0.actId

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_15_1 = var_1_10002(var_1_10004)
	local var_15_2 = var_2.getActivityById(var_15_1, var_15_0)
	local var_15_3 = var_2.GetSeriesData(var_15_2)

	assert = var_15_1

	var_15_1(var_15_3)

	local var_15_4 = var_15_3
	local var_15_5 = var_15_3.GetStaegLevel(var_15_4)
	local var_15_6 = var_15_3
	local var_15_7 = var_15_3.GetStageFleets
	local var_15_8 = var_15_3
	local var_15_9 = var_15_7(var_15_6, var_15_3.GetMode(var_15_8), var_15_5)

	getProxy = var_15_4
	FleetProxy = var_8

	local var_15_10 = var_15_4(var_8)
	local var_15_11 = var_6.getActivityFleets(var_15_10)[var_15_0][var_15_9]

	getProxy = var_15_10
	BayProxy = var_15_8

	local var_15_12 = var_15_10(var_15_8)

	return (var_8.getShipsByFleet(var_15_12, var_15_11))
end

local function var_0_8(arg_16_0)
	local var_16_0 = {}

	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_16_1 = var_1_10002(var_1_10004)
	local var_16_2 = var_2.getFleetById

	FleetProxy = var_1_10005

	local var_16_3 = var_16_2(var_16_1, var_1_10005.CHALLENGE_FLEET_ID)

	table = var_1_10003

	local var_16_4 = var_1_10003.insertto
	local var_16_5 = var_16_0

	getProxy = var_1_10006
	BayProxy = var_1_10008

	local var_16_6 = var_1_10006(var_1_10008)

	var_16_4(var_16_5, var_6.getShipsByFleet(var_16_6, var_16_3))

	getProxy = var_16_4
	FleetProxy = var_16_5

	local var_16_7 = var_16_4(var_16_5)
	local var_16_8 = var_3.getFleetById

	FleetProxy = var_6

	local var_16_9 = var_16_8(var_16_7, var_6.CHALLENGE_SUB_FLEET_ID)

	table = var_16_1

	local var_16_10 = var_16_1.insertto
	local var_16_11 = var_16_0

	getProxy = var_1_10007
	BayProxy = var_9

	local var_16_12 = var_1_10007(var_9)

	var_16_10(var_16_11, var_7.getShipsByFleet(var_16_12, var_16_9))

	return var_16_0
end

local function var_0_9(arg_17_0)
	local var_17_0 = arg_17_0.mainFleetId

	getProxy = var_1_10002
	FleetProxy = var_1_10004

	local var_17_1 = var_1_10002(var_1_10004)
	local var_17_2 = var_2.getFleetById(var_17_1, var_17_0)

	getProxy = var_1_10003
	BayProxy = var_5

	local var_17_3 = var_1_10003(var_5)

	return (var_3.getShipsByFleet(var_17_3, var_17_2))
end

function var_0_0.GetNewMainShips(arg_18_0)
	local var_18_0 = arg_18_0.system
	local var_18_1 = {}

	SYSTEM_SCENARIO = var_1_10003

	if var_18_0 == var_1_10003 then
		var_18_1 = var_0_1()

		goto label_18_0
	end

	SYSTEM_WORLD = var_1_10003

	if var_18_0 == var_1_10003 then
		var_18_1 = var_0_2()

		goto label_18_0
	end

	SYSTEM_WORLD_BOSS = var_1_10003

	if var_18_0 == var_1_10003 then
		var_18_1 = var_0_3(arg_18_0)

		goto label_18_0
	end

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003

	if var_18_0 ~= var_1_10003 then
		SYSTEM_ACT_BOSS = var_1_10003

		if var_18_0 ~= var_1_10003 then
			SYSTEM_ACT_BOSS_SP = var_1_10003

			if var_18_0 ~= var_1_10003 then
				SYSTEM_BOSS_EXPERIMENT = var_1_10003

				if var_18_0 ~= var_1_10003 then
					SYSTEM_BOSS_SINGLE = var_1_10003

					if var_18_0 == var_1_10003 then
						var_18_1 = var_0_4(arg_18_0)

						goto label_18_0
					end

					SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10003

					if var_18_0 == var_1_10003 then
						var_18_1 = var_0_5(arg_18_0)

						goto label_18_0
					end

					SYSTEM_GUILD = var_1_10003

					if var_18_0 == var_1_10003 then
						var_18_1 = var_0_6()

						goto label_18_0
					end

					SYSTEM_BOSS_RUSH = var_1_10003

					if var_18_0 ~= var_1_10003 then
						SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10003

						if var_18_0 ~= var_1_10003 then
							SYSTEM_BOSS_RUSH_EX = var_1_10003

							if var_18_0 == var_1_10003 then
								var_18_1 = var_0_7(arg_18_0)
							else
								SYSTEM_DODGEM = var_1_10003

								if var_18_0 ~= var_1_10003 then
									SYSTEM_SUBMARINE_RUN = var_1_10003

									if var_18_0 ~= var_1_10003 then
										SYSTEM_REWARD_PERFORM = var_1_10003

										if var_18_0 ~= var_1_10003 then
											SYSTEM_AIRFIGHT = var_1_10003

											if var_18_0 ~= var_1_10003 then
												SYSTEM_SCENARIO_SUB_STRIKE = var_1_10003

												if var_18_0 ~= var_1_10003 then
													SYSTEM_CARDPUZZLE = var_1_10003

													if var_18_0 ~= var_1_10003 then
														SYSTEM_CHALLENGE = var_1_10003

														if var_18_0 == var_1_10003 then
															-- block empty
														else
															SYSTEM_LIMIT_CHALLENGE = var_1_10003

															if var_18_0 == var_1_10003 then
																var_18_1 = var_0_8(arg_18_0)
															else
																var_18_1 = var_0_9(arg_18_0)
															end
														end
													end
												end
											end
										end
									end
								end
							end

							::label_18_0::

							local var_18_2 = {}

							ipairs = var_1_10004

							for iter_18_0, iter_18_1 in var_1_10004(var_18_1) do
								var_18_2[iter_18_1.id] = iter_18_1
							end

							return var_18_2
						end
					end
				end
			end
		end
	end
end

return var_0_0
