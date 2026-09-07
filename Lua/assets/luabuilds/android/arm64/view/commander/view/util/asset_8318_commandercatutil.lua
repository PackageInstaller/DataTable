local CommanderCatUtil = class("CommanderCatUtil")

local function var_0_1(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs((getProxy(FleetProxy):GetRegularFleets())) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1:getCommanders()) do
			arg_1_1[iter_1_3.id].sub = iter_1_1:isSubmarineFleet()
			arg_1_1[iter_1_3.id].fleetId = iter_1_1.id % 10
			arg_1_1[iter_1_3.id].inFleet = true
		end
	end

	return
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	assert(var_2_0 and not var_2_0:isEnd())

	for iter_2_0, iter_2_1 in pairs(getProxy(FleetProxy):getActivityFleets()[var_2_0.id]) do
		local var_2_1 = iter_2_1:isSubmarineFleet()

		for iter_2_2, iter_2_3 in pairs(iter_2_1:getCommanders()) do
			arg_2_1[iter_2_3.id].sub = var_2_1
			arg_2_1[iter_2_3.id].fleetId = iter_2_1.id % 10
			arg_2_1[iter_2_3.id].inFleet = true
		end
	end

	return
end

local function var_0_3(arg_3_0, arg_3_1)
	assert(arg_3_0.chapterId)

	for iter_3_0, iter_3_1 in pairs(getProxy(ChapterProxy):getChapterById(arg_3_0.chapterId):getEliteFleetCommanders()) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_3 ~= 0 then
				arg_3_1[iter_3_3].sub = false
				arg_3_1[iter_3_3].fleetId = iter_3_0
				arg_3_1[iter_3_3].inFleet = true
			end
		end
	end

	return
end

local function var_0_4(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	assert(var_4_0 and not var_4_0:isEnd())

	for iter_4_0, iter_4_1 in pairs(getProxy(FleetProxy):getActivityFleets()[var_4_0.id]) do
		local var_4_1 = iter_4_1:isSubmarineFleet()

		for iter_4_2, iter_4_3 in pairs(iter_4_1:getCommanders()) do
			arg_4_1[iter_4_3.id].sub = var_4_1
			arg_4_1[iter_4_3.id].fleetId = iter_4_1.id % 10
			arg_4_1[iter_4_3.id].inFleet = true
		end
	end

	return
end

local function var_0_5(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	assert(var_5_0)

	for iter_5_0, iter_5_1 in pairs((var_5_0:GetBossMission():GetFleets())) do
		local var_5_1 = arg_5_0.fleets[iter_5_0] or iter_5_1
		local var_5_2 = not var_5_1:IsMainFleet()

		for iter_5_2, iter_5_3 in pairs(var_5_1:getCommanders()) do
			arg_5_1[iter_5_3.id].sub = var_5_2
			arg_5_1[iter_5_3.id].fleetId = 1
			arg_5_1[iter_5_3.id].inFleet = true
		end
	end

	return
end

local function var_0_6(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = nowWorld():BuildFormationIds()

	for iter_6_0, iter_6_1 in pairs((arg_6_0.fleets or nil) and arg_6_0.fleets) do
		local var_6_2 = FleetType.Submarine == iter_6_0

		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			for iter_6_4, iter_6_5 in pairs(Fleet.New({
				ship_list = {},
				commanders = iter_6_3.commanders
			}):getCommanders()) do
				arg_6_1[iter_6_5.id].sub = var_6_2
				arg_6_1[iter_6_5.id].fleetId = iter_6_2
				arg_6_1[iter_6_5.id].inFleet = true
			end
		end
	end

	return
end

local function var_0_7(arg_7_0, arg_7_1)
	assert(arg_7_0.fleets)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.fleets) do
		local var_7_0 = iter_7_0 == #arg_7_0.fleets

		for iter_7_2, iter_7_3 in pairs(iter_7_1:getCommanders()) do
			arg_7_1[iter_7_3.id].sub = var_7_0
			arg_7_1[iter_7_3.id].fleetId = iter_7_1.id
			arg_7_1[iter_7_3.id].inFleet = true
		end
	end

	return
end

local function var_0_8(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(FleetProxy)

	for iter_8_0, iter_8_1 in pairs((_.map({
		FleetProxy.CHALLENGE_FLEET_ID,
		FleetProxy.CHALLENGE_SUB_FLEET_ID
	}, function(arg_9_0)
		return var_8_0:getFleetById(arg_9_0)
	end))) do
		local var_8_1 = iter_8_1:isSubmarineFleet()

		for iter_8_2, iter_8_3 in pairs(iter_8_1:getCommanders()) do
			arg_8_1[iter_8_3.id].sub = var_8_1
			arg_8_1[iter_8_3.id].fleetId = iter_8_1.id
			arg_8_1[iter_8_3.id].inFleet = true
		end
	end

	return
end

local function var_0_9(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE)

	assert(var_10_0 and not var_10_0:isEnd())

	for iter_10_0, iter_10_1 in pairs(getProxy(FleetProxy):getActivityFleets()[var_10_0.id]) do
		local var_10_1 = iter_10_1:isSubmarineFleet()

		for iter_10_2, iter_10_3 in pairs(iter_10_1:getCommanders()) do
			arg_10_1[iter_10_3.id].sub = var_10_1
			arg_10_1[iter_10_3.id].fleetId = iter_10_1.id % 10
			arg_10_1[iter_10_3.id].inFleet = true
		end
	end

	return
end

local function var_0_10(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE)

	assert(var_11_0 and not var_11_0:isEnd())

	for iter_11_0, iter_11_1 in pairs(getProxy(FleetProxy):getActivityFleets()[var_11_0.id]) do
		local var_11_1 = iter_11_1:isSubmarineFleet()

		for iter_11_2, iter_11_3 in pairs(iter_11_1:getCommanders()) do
			arg_11_1[iter_11_3.id].sub = var_11_1
			arg_11_1[iter_11_3.id].fleetId = iter_11_1.id % 10
			arg_11_1[iter_11_3.id].inFleet = true
		end
	end

	return
end

function CommanderCatUtil:GetCommanderList()
	local var_12_0 = getProxy(CommanderProxy):getData()

	if CommanderCatScene.FLEET_TYPE_COMMON == self.fleetType then
		var_0_1(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_ACTBOSS == self.fleetType then
		var_0_2(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_HARD_CHAPTER == self.fleetType then
		var_0_3(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_CHALLENGE == self.fleetType then
		var_0_4(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_GUILDBOSS == self.fleetType then
		var_0_5(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_WORLD == self.fleetType then
		var_0_6(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_BOSSRUSH == self.fleetType then
		var_0_7(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_LIMIT_CHALLENGE == self.fleetType then
		var_0_8(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_BOSSSINGLE == self.fleetType then
		var_0_9(self, var_12_0)
	elseif CommanderCatScene.FLEET_TYPE_BOSSSINGLE_VARIABLE == self.fleetType then
		var_0_10(self, var_12_0)
	end

	local var_12_1 = getProxy(ChapterProxy):getActiveChapter()

	if var_12_1 then
		_.each(var_12_1.fleets, function(arg_13_0)
			local var_13_0 = arg_13_0:getCommanders()

			for iter_13_0, iter_13_1 in pairs(arg_13_0:getCommanders()) do
				var_12_0[iter_13_1.id].inBattle = true
			end

			return
		end)
	end

	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(self.ignoredIds or {}) do
		var_12_2[iter_12_1] = true
	end

	local var_12_3 = {}

	for iter_12_2, iter_12_3 in pairs(var_12_0) do
		if not var_12_2[iter_12_2] then
			table.insert(var_12_3, iter_12_3)
		end
	end

	return var_12_3
end

function CommanderCatUtil:GetSkillExpAndCommanderExp(arg_14_1)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = getProxy(CommanderProxy)

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		local var_14_3 = var_14_2:getCommanderById(iter_14_1)

		var_14_1 = var_14_1 + var_14_3:getDestoryedExp(self.groupId)
		var_14_0 = var_14_0 + var_14_3:getDestoryedSkillExp(self.groupId)
	end

	local var_14_4 = math.floor(var_14_1)
	local var_14_5 = math.floor(var_14_0)
end

function CommanderCatUtil:AnySSRCommander()
	local var_15_0 = getProxy(CommanderProxy)

	if _.any(self, function(arg_16_0)
		return var_15_0:RawGetCommanderById(arg_16_0):getRarity() >= 5
	end) then
		return true
	end

	return false
end

function CommanderCatUtil:CalcCommanderConsume()
	local var_17_0 = getProxy(CommanderProxy)
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in ipairs(self) do
		local var_17_2 = var_17_0:RawGetCommanderById(iter_17_1)

		assert(var_17_2, iter_17_1)

		var_17_1 = var_17_1 + var_17_2:getUpgradeConsume()
	end

	return math.floor(var_17_1)
end

function CommanderCatUtil:SetActive(arg_18_1)
	local var_18_0 = GetOrAddComponent(self, typeof(CanvasGroup))

	var_18_0.alpha = arg_18_1 and 1 or 0
	var_18_0.blocksRaycasts = arg_18_1

	return
end

function CommanderCatUtil:CommanderInChapter()
	local var_19_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_19_0 then
		for iter_19_0, iter_19_1 in pairs(var_19_0.fleets) do
			if _.any(_.values((iter_19_1:getCommanders())), function(arg_20_0)
				return arg_20_0.id == self.id
			end) then
				return true
			end
		end
	end

	return false
end

function CommanderCatUtil.GetAllTalentNames()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(pg.commander_ability_group.all) do
		if pg.commander_ability_group[iter_21_1].ability_list and #pg.commander_ability_group[iter_21_1].ability_list > 0 then
			table.insert(var_21_0, {
				id = pg.commander_ability_group[iter_21_1].id,
				name = pg.commander_ability_template[pg.commander_ability_group[iter_21_1].ability_list[1]].name
			})
		end
	end

	return var_21_0
end

function CommanderCatUtil:ShortenString(arg_22_1)
	local function var_22_0(arg_23_0)
		if not arg_23_0 then
			return 0, 1
		elseif arg_23_0 > 240 then
			return 4, 1
		elseif arg_23_0 > 225 then
			return 3, 1
		elseif arg_23_0 > 192 then
			return 2, 1
		elseif arg_23_0 < 126 then
			return 1, 0.75
		else
			return 1, 1
		end

		return
	end

	local var_22_1 = 1
	local var_22_2 = 0
	local var_22_3 = 0
	local var_22_4 = false

	while var_22_1 <= #self do
		local var_22_5, var_22_6 = var_22_0((string.byte(self, var_22_1)))

		var_22_1 = var_22_1 + var_22_5
		var_22_2 = var_22_2 + var_22_6

		local var_22_7 = math.ceil(var_22_2)

		if var_22_7 == arg_22_1 - 1 then
			var_22_3 = var_22_1
		elseif arg_22_1 < var_22_7 then
			var_22_4 = true

			break
		end
	end

	if var_22_3 == 0 or #self < var_22_3 or not var_22_4 then
		return self
	end

	return string.sub(self, 1, var_22_3 - 1) .. ".."
end

return CommanderCatUtil
