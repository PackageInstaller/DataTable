local NewBattleResultDataExtender = class("NewBattleResultDataExtender")

function NewBattleResultDataExtender:NeedCloseCamera()
	return self ~= SYSTEM_BOSS_RUSH and self ~= SYSTEM_BOSS_RUSH_EX and self ~= SYSTEM_BOSS_RUSH_COLLABRATE and self ~= SYSTEM_ACT_BOSS and self ~= SYSTEM_WORLD_BOSS and self ~= SYSTEM_BOSS_SINGLE and self ~= SYSTEM_BOSS_SINGLE_VARIABLE
end

function NewBattleResultDataExtender:NeedVibrate()
	return ys.Battle.BattleState.IsAutoBotActive() and PlayerPrefs.GetInt(AUTO_BATTLE_LABEL, 0) > 0 and not self
end

function NewBattleResultDataExtender:NeedHelpMessage(arg_3_1)
	if (self == SYSTEM_SCENARIO or self == SYSTEM_ROUTINE or self == SYSTEM_SUB_ROUTINE or self == SYSTEM_DUEL) and arg_3_1 <= 0 then
		return true
	end

	return false
end

function NewBattleResultDataExtender:GetAutoSkipFlag(arg_4_1)
	if arg_4_1 == SYSTEM_SCENARIO or arg_4_1 == SYSTEM_SCENARIO_SUB_STRIKE then
		return getProxy(ChapterProxy):GetChapterAutoFlag(getProxy(ChapterProxy):getActiveChapter().id) == 1
	elseif arg_4_1 == SYSTEM_WORLD then
		return nowWorld().isAutoFight
	elseif arg_4_1 == SYSTEM_TEST then
		return tobool(InDebugBattleLoop)
	end

	return self.autoSkipFlag or false
end

function NewBattleResultDataExtender:GetExpBuffs()
	return (self == SYSTEM_SCENARIO or self == SYSTEM_ROUTINE or self == SYSTEM_ACT_BOSS or self == SYSTEM_HP_SHARE_ACT_BOSS or self == SYSTEM_SUB_ROUTINE or self == SYSTEM_WORLD or self == SYSTEM_BOSS_SINGLE or self == SYSTEM_BOSS_SINGLE_VARIABLE or nil) and _.detect(BuffHelper.GetBuffsByActivityType(ActivityConst.ACTIVITY_TYPE_BUFF), function(arg_6_0)
		return arg_6_0:getConfig("benefit_type") == "rookie_battle_exp"
	end)
end

function NewBattleResultDataExtender:GetShipBuffs()
	return (self == SYSTEM_SCENARIO or self == SYSTEM_ROUTINE or self == SYSTEM_ACT_BOSS or self == SYSTEM_HP_SHARE_ACT_BOSS or self == SYSTEM_SUB_ROUTINE or self == SYSTEM_WORLD or self == SYSTEM_BOSS_SINGLE or self == SYSTEM_BOSS_SINGLE_VARIABLE or nil) and getProxy(ActivityProxy):getBuffShipList()
end

local function var_0_1()
	local var_8_0 = {}
	local var_8_1 = getProxy(ChapterProxy):getActiveChapter()

	for iter_8_0, iter_8_1 in ipairs(var_8_1.fleet[TeamType.Main]) do
		table.insert(var_8_0, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1.fleet[TeamType.Vanguard]) do
		table.insert(var_8_0, iter_8_3)
	end

	local var_8_2 = _.detect(var_8_1.fleets, function(arg_9_0)
		return arg_9_0:getFleetType() == FleetType.Submarine
	end)

	if var_8_2 then
		for iter_8_4, iter_8_5 in ipairs((var_8_2:getShipsByTeam(TeamType.Submarine, true))) do
			table.insert(var_8_0, iter_8_5)
		end
	end

	return var_8_0
end

local function var_0_2()
	local var_10_0 = {}
	local var_10_1 = nowWorld():GetActiveMap()
	local var_10_2 = var_10_1:GetFleet()

	for iter_10_0, iter_10_1 in ipairs((var_10_2:GetTeamShipVOs(TeamType.Main, true))) do
		table.insert(var_10_0, iter_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs((var_10_2:GetTeamShipVOs(TeamType.Vanguard, true))) do
		table.insert(var_10_0, iter_10_3)
	end

	local var_10_3 = var_10_1:GetSubmarineFleet()

	if var_10_3 then
		for iter_10_4, iter_10_5 in ipairs((var_10_3:GetTeamShipVOs(TeamType.Submarine, true))) do
			table.insert(var_10_0, iter_10_5)
		end
	end

	return var_10_0
end

local function var_0_3(arg_11_0)
	return (getProxy(BayProxy):getShipsByFleet((nowWorld():GetBossProxy():GetFleet(arg_11_0.bossId))))
end

local function var_0_4(arg_12_0)
	local var_12_0 = getProxy(FleetProxy):getActivityFleets()[arg_12_0.actId]
	local var_12_1 = getProxy(BayProxy):getShipsByFleet(var_12_0[arg_12_0.mainFleetId])

	for iter_12_0, iter_12_1 in ipairs((getProxy(BayProxy):getShipsByFleet(var_12_0[arg_12_0.mainFleetId + 10]))) do
		table.insert(var_12_1, iter_12_1)
	end

	return var_12_1
end

local function var_0_5(arg_13_0)
	local var_13_0 = getProxy(FleetProxy):getActivityFleets()[arg_13_0.actId]
	local var_13_1 = getProxy(BayProxy):getShipsByFleet(var_13_0[arg_13_0.mainFleetId])

	for iter_13_0, iter_13_1 in ipairs((getProxy(BayProxy):getShipsByFleet(var_13_0[arg_13_0.mainFleetId + 100]))) do
		table.insert(var_13_1, iter_13_1)
	end

	return var_13_1
end

local function var_0_6()
	local var_14_0 = {}
	local var_14_1 = getProxy(GuildProxy)
	local var_14_2 = var_14_1:getRawData():GetActiveEvent():GetBossMission()

	for iter_14_0, iter_14_1 in ipairs(var_14_2.GetMainFleet(var_14_1):GetShips()) do
		table.insert(var_14_0, iter_14_1.ship)
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_2:GetSubFleet():GetShips()) do
		table.insert(var_14_0, iter_14_3.ship)
	end

	return var_14_0
end

local function var_0_7(arg_15_0)
	local var_15_0 = getProxy(ActivityProxy):getActivityById(arg_15_0.actId):GetSeriesData()

	assert(var_15_0)

	return (getProxy(BayProxy):getShipsByFleet(getProxy(FleetProxy):getActivityFleets()[arg_15_0.actId][var_15_0:GetStageFleets(var_15_0:GetMode(), (var_15_0:GetStaegLevel()))]))
end

local function var_0_8(arg_16_0)
	local var_16_0 = {}

	table.insertto(var_16_0, getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(FleetProxy.CHALLENGE_FLEET_ID))))
	table.insertto(var_16_0, getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(FleetProxy.CHALLENGE_SUB_FLEET_ID))))

	return var_16_0
end

local function var_0_9(arg_17_0)
	return (getProxy(BayProxy):getShipsByFleet((getProxy(FleetProxy):getFleetById(arg_17_0.mainFleetId))))
end

function NewBattleResultDataExtender:GetNewMainShips()
	local var_18_0 = {}

	if self.system == SYSTEM_SCENARIO then
		var_18_0 = var_0_1()
	elseif self.system == SYSTEM_WORLD then
		var_18_0 = var_0_2()
	elseif self.system == SYSTEM_WORLD_BOSS then
		var_18_0 = var_0_3(self)
	elseif self.system == SYSTEM_HP_SHARE_ACT_BOSS or self.system == SYSTEM_ACT_BOSS or self.system == SYSTEM_ACT_BOSS_SP or self.system == SYSTEM_BOSS_EXPERIMENT or self.system == SYSTEM_BOSS_SINGLE then
		var_18_0 = var_0_4(self)
	elseif self.system == SYSTEM_BOSS_SINGLE_VARIABLE then
		var_18_0 = var_0_5(self)
	elseif self.system == SYSTEM_GUILD then
		var_18_0 = var_0_6()
	elseif self.system == SYSTEM_BOSS_RUSH or self.system == SYSTEM_BOSS_RUSH_COLLABRATE or self.system == SYSTEM_BOSS_RUSH_EX then
		var_18_0 = var_0_7(self)
	elseif self.system == SYSTEM_DODGEM or self.system == SYSTEM_SUBMARINE_RUN or self.system == SYSTEM_REWARD_PERFORM or self.system == SYSTEM_AIRFIGHT or self.system == SYSTEM_SCENARIO_SUB_STRIKE or self.system == SYSTEM_CARDPUZZLE or self.system == SYSTEM_CHALLENGE then
		-- block empty
	else
		var_18_0 = self.system == SYSTEM_LIMIT_CHALLENGE and var_0_8(self) or var_0_9(self)
	end

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		var_18_1[iter_18_1.id] = iter_18_1
	end

	return var_18_1
end

return NewBattleResultDataExtender
