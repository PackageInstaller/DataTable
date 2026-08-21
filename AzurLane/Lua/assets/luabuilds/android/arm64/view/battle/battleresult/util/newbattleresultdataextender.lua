local var_0_0 = class("NewBattleResultDataExtender")

function var_0_0.NeedCloseCamera(arg_1_0)
	return arg_1_0 ~= SYSTEM_BOSS_RUSH and arg_1_0 ~= SYSTEM_BOSS_RUSH_EX and arg_1_0 ~= SYSTEM_BOSS_RUSH_COLLABRATE and arg_1_0 ~= SYSTEM_ACT_BOSS and arg_1_0 ~= SYSTEM_WORLD_BOSS and arg_1_0 ~= SYSTEM_BOSS_SINGLE and arg_1_0 ~= SYSTEM_BOSS_SINGLE_VARIABLE
end

function var_0_0.NeedVibrate(arg_2_0)
	local var_2_0 = PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0

	return ys.Battle.BattleState.IsAutoBotActive() and var_2_0 and not arg_2_0
end

function var_0_0.NeedHelpMessage(arg_3_0, arg_3_1)
	if (arg_3_0 == SYSTEM_SCENARIO or arg_3_0 == SYSTEM_ROUTINE or arg_3_0 == SYSTEM_SUB_ROUTINE or arg_3_0 == SYSTEM_DUEL) and arg_3_1 <= 0 then
		return true
	end

	return false
end

function var_0_0.GetAutoSkipFlag(arg_4_0, arg_4_1)
	if arg_4_1 == SYSTEM_SCENARIO or arg_4_1 == SYSTEM_SCENARIO_SUB_STRIKE then
		local var_4_0 = getProxy(ChapterProxy)
		local var_4_1 = getProxy(ChapterProxy)

		return var_4_1:GetChapterAutoFlag(var_4_0:getActiveChapter().id) == 1
	elseif arg_4_1 == SYSTEM_WORLD then
		return nowWorld().isAutoFight
	elseif arg_4_1 == SYSTEM_TEST then
		return tobool(InDebugBattleLoop)
	end

	return arg_4_0.autoSkipFlag or false
end

function var_0_0.GetExpBuffs(arg_5_0)
	local var_5_0

	if arg_5_0 == SYSTEM_SCENARIO or arg_5_0 == SYSTEM_ROUTINE or arg_5_0 == SYSTEM_ACT_BOSS or arg_5_0 == SYSTEM_HP_SHARE_ACT_BOSS or arg_5_0 == SYSTEM_SUB_ROUTINE or arg_5_0 == SYSTEM_WORLD or arg_5_0 == SYSTEM_BOSS_SINGLE or arg_5_0 == SYSTEM_BOSS_SINGLE_VARIABLE then
		var_5_0 = _.detect(BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF), function(arg_6_0)
			return arg_6_0:getConfig("benefit_type") == "rookie_battle_exp"
		end)
	end

	return var_5_0
end

function var_0_0.GetShipBuffs(arg_7_0)
	local var_7_0

	if arg_7_0 == SYSTEM_SCENARIO or arg_7_0 == SYSTEM_ROUTINE or arg_7_0 == SYSTEM_ACT_BOSS or arg_7_0 == SYSTEM_HP_SHARE_ACT_BOSS or arg_7_0 == SYSTEM_SUB_ROUTINE or arg_7_0 == SYSTEM_WORLD or arg_7_0 == SYSTEM_BOSS_SINGLE or arg_7_0 == SYSTEM_BOSS_SINGLE_VARIABLE then
		var_7_0 = getProxy(ActivityProxy):getBuffShipList()
	end

	return var_7_0
end

local function var_0_1()
	local var_8_0 = getProxy(ChapterProxy):getActiveChapter()

	for iter_8_0, iter_8_1 in ipairs(var_8_0.fleet[TeamType.Main]) do
		table.insert({}, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0.fleet[TeamType.Vanguard]) do
		table.insert({}, iter_8_3)
	end

	local var_8_1 = _.detect(var_8_0.fleets, function(arg_9_0)
		return arg_9_0:getFleetType() == FleetType.Submarine
	end)

	if var_8_1 then
		for iter_8_4, iter_8_5 in ipairs((var_8_1:getShipsByTeam(TeamType.Submarine, true))) do
			table.insert({}, iter_8_5)
		end
	end

	return {}
end

local function var_0_2()
	local var_10_0 = nowWorld():GetActiveMap()
	local var_10_1 = var_10_0:GetFleet()

	for iter_10_0, iter_10_1 in ipairs((var_10_1:GetTeamShipVOs(TeamType.Main, true))) do
		table.insert({}, iter_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs((var_10_1:GetTeamShipVOs(TeamType.Vanguard, true))) do
		table.insert({}, iter_10_3)
	end

	local var_10_2 = var_10_0:GetSubmarineFleet()

	if var_10_2 then
		for iter_10_4, iter_10_5 in ipairs((var_10_2:GetTeamShipVOs(TeamType.Submarine, true))) do
			table.insert({}, iter_10_5)
		end
	end

	return {}
end

local function var_0_3(arg_11_0)
	return (getProxy(BayProxy):getShipsByFleet((nowWorld():GetBossProxy():GetFleet(arg_11_0.bossId))))
end

local function var_0_4(arg_12_0)
	local var_12_9000
	local var_12_0 = getProxy(FleetProxy)
	local var_12_1 = var_12_0.getActivityFleets(var_12_9000)[arg_12_0.actId]
	local var_12_2 = getProxy(BayProxy).getShipsByFleet(var_12_0, var_12_1[arg_12_0.mainFleetId])

	for iter_12_0, iter_12_1 in ipairs((getProxy(BayProxy):getShipsByFleet(var_12_1[arg_12_0.mainFleetId + 10]))) do
		table.insert(var_12_2, iter_12_1)
	end

	return var_12_2
end

local function var_0_5(arg_13_0)
	local var_13_9000
	local var_13_0 = getProxy(FleetProxy)
	local var_13_1 = var_13_0.getActivityFleets(var_13_9000)[arg_13_0.actId]
	local var_13_2 = getProxy(BayProxy).getShipsByFleet(var_13_0, var_13_1[arg_13_0.mainFleetId])

	for iter_13_0, iter_13_1 in ipairs((getProxy(BayProxy):getShipsByFleet(var_13_1[arg_13_0.mainFleetId + 100]))) do
		table.insert(var_13_2, iter_13_1)
	end

	return var_13_2
end

local function var_0_6()
	local var_14_9000
	local var_14_0 = getProxy(GuildProxy)
	local var_14_1 = var_14_0.getRawData(var_14_9000):GetActiveEvent():GetBossMission()

	for iter_14_0, iter_14_1 in ipairs(var_14_1.GetMainFleet(var_14_0):GetShips()) do
		table.insert({}, iter_14_1.ship)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_1:GetSubFleet():GetShips()) do
		table.insert({}, iter_14_3.ship)
	end

	return {}
end

local function var_0_7(arg_15_0)
	local var_15_9000
	local var_15_0 = getProxy(ActivityProxy):getActivityById(arg_15_0.actId):GetSeriesData()

	assert(var_15_0)

	local var_15_1 = getProxy(FleetProxy)

	return (getProxy(BayProxy).getShipsByFleet(var_15_1, var_15_1.getActivityFleets(var_15_9000)[arg_15_0.actId][var_15_0:GetStageFleets(var_15_0:GetMode(), (var_15_0:GetStaegLevel()))]))
end

local function var_0_8(arg_16_0)
	table.insertto({}, getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(FleetProxy.CHALLENGE_FLEET_ID))))
	table.insertto({}, getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID))))

	return {}
end

local function var_0_9(arg_17_0)
	return (getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(arg_17_0.mainFleetId))))
end

function var_0_0.GetNewMainShips(arg_18_0)
	local var_18_0 = {}

	if arg_18_0.system == SYSTEM_SCENARIO then
		var_18_0 = var_0_1()
	elseif arg_18_0.system == SYSTEM_WORLD then
		var_18_0 = var_0_2()
	elseif arg_18_0.system == SYSTEM_WORLD_BOSS then
		var_18_0 = var_0_3(arg_18_0)
	elseif arg_18_0.system == SYSTEM_HP_SHARE_ACT_BOSS or arg_18_0.system == SYSTEM_ACT_BOSS or arg_18_0.system == SYSTEM_ACT_BOSS_SP or arg_18_0.system == SYSTEM_BOSS_EXPERIMENT or arg_18_0.system == SYSTEM_BOSS_SINGLE then
		var_18_0 = var_0_4(arg_18_0)
	elseif arg_18_0.system == SYSTEM_BOSS_SINGLE_VARIABLE then
		var_18_0 = var_0_5(arg_18_0)
	elseif arg_18_0.system == SYSTEM_GUILD then
		var_18_0 = var_0_6()
	elseif arg_18_0.system == SYSTEM_BOSS_RUSH or arg_18_0.system == SYSTEM_BOSS_RUSH_COLLABRATE or arg_18_0.system == SYSTEM_BOSS_RUSH_EX then
		var_18_0 = var_0_7(arg_18_0)
	elseif arg_18_0.system == SYSTEM_DODGEM or arg_18_0.system == SYSTEM_SUBMARINE_RUN or arg_18_0.system == SYSTEM_REWARD_PERFORM or arg_18_0.system == SYSTEM_AIRFIGHT or arg_18_0.system == SYSTEM_SCENARIO_SUB_STRIKE or arg_18_0.system == SYSTEM_CARDPUZZLE or arg_18_0.system == SYSTEM_CHALLENGE then
		-- block empty
	else
		var_18_0 = arg_18_0.system == SYSTEM_LIMIT_CHALLENGE and var_0_8(arg_18_0) or var_0_9(arg_18_0)
	end

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		var_18_1[iter_18_1.id] = iter_18_1
	end

	return var_18_1
end

return var_0_0
