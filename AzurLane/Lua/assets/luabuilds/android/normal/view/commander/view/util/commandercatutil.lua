class = var_0_10000

local var_0_0 = var_0_10000("CommanderCatUtil")

local function var_0_1(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.GetRegularFleets(var_1_0)

	pairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(var_1_1) do
		pairs = var_1_10009

		for iter_1_2, iter_1_3 in var_1_10009(iter_1_1:getCommanders()) do
			local var_1_2 = iter_1_1.id % 10

			arg_1_1[iter_1_3.id].sub = iter_1_1:isSubmarineFleet()
			arg_1_1[iter_1_3.id].fleetId = var_1_2
			arg_1_1[iter_1_3.id].inFleet = true
		end
	end

	return
end

local function var_0_2(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_2_1 = var_1_10003(var_1_10004)
	local var_2_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_2_3 = var_2_2(var_2_1, var_1_10005.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	assert = var_2_1

	var_2_1(var_2_3 and not var_2_3:isEnd())

	local var_2_4 = var_2_0:getActivityFleets()[var_2_3.id]

	pairs = var_5

	for iter_2_0, iter_2_1 in var_5(var_2_4) do
		local var_2_5 = iter_2_1:isSubmarineFleet()
		local var_2_6 = iter_2_1.id % 10

		pairs = var_1_10012

		for iter_2_2, iter_2_3 in var_1_10012(iter_2_1:getCommanders()) do
			arg_2_1[iter_2_3.id].sub = var_2_5
			arg_2_1[iter_2_3.id].fleetId = var_2_6
			arg_2_1[iter_2_3.id].inFleet = true
		end
	end

	return
end

local function var_0_3(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_0.chapterId)

	getProxy = var_1_10002
	ChapterProxy = var_3

	local var_3_0 = var_1_10002(var_3)
	local var_3_1 = var_2.getChapterById(var_3_0, arg_3_0.chapterId)

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1:getEliteFleetCommanders()) do
		pairs = var_1_10009

		for iter_3_2, iter_3_3 in var_1_10009(iter_3_1) do
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
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_4_1 = var_1_10003(var_1_10004)
	local var_4_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_4_3 = var_4_2(var_4_1, var_1_10005.ACTIVITY_TYPE_CHALLENGE)

	assert = var_4_1

	var_4_1(var_4_3 and not var_4_3:isEnd())

	local var_4_4 = var_4_0:getActivityFleets()[var_4_3.id]

	pairs = var_5

	for iter_4_0, iter_4_1 in var_5(var_4_4) do
		local var_4_5 = iter_4_1:isSubmarineFleet()
		local var_4_6 = iter_4_1.id % 10

		pairs = var_1_10012

		for iter_4_2, iter_4_3 in var_1_10012(iter_4_1:getCommanders()) do
			arg_4_1[iter_4_3.id].sub = var_4_5
			arg_4_1[iter_4_3.id].fleetId = var_4_6
			arg_4_1[iter_4_3.id].inFleet = true
		end
	end

	return
end

local function var_0_5(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.getRawData(var_5_0)
	local var_5_2 = var_2.GetActiveEvent(var_5_1)

	assert = var_5_1

	var_5_1(var_5_2)

	local var_5_3 = var_5_2:GetBossMission()
	local var_5_4 = var_4.GetFleets(var_5_3)

	pairs = var_5_3

	for iter_5_0, iter_5_1 in var_5_3(var_5_4) do
		local var_5_5

		if not arg_5_0.fleets[iter_5_0] then
			var_5_5 = iter_5_1
		end

		local var_5_6 = var_5_5
		local var_5_7 = not var_5_5.IsMainFleet(var_5_6)

		pairs = var_5_6

		for iter_5_2, iter_5_3 in var_5_6(var_5_5:getCommanders()) do
			arg_5_1[iter_5_3.id].sub = var_5_7
			arg_5_1[iter_5_3.id].fleetId = 1
			arg_5_1[iter_5_3.id].inFleet = true
		end
	end

	return
end

local function var_0_6(arg_6_0, arg_6_1)
	nowWorld = var_1_10002

	local var_6_0 = var_1_10002()
	local var_6_1, var_6_2 = var_2.BuildFormationIds(var_6_0)

	if arg_6_0.fleets then
		var_6_2 = arg_6_0.fleets
	end

	pairs = var_4

	for iter_6_0, iter_6_1 in var_4(var_6_2) do
		FleetType = var_1_10009
		var_1_10009 = var_1_10009.Submarine == iter_6_0
		pairs = var_1_10010

		for iter_6_2, iter_6_3 in var_1_10010(iter_6_1) do
			Fleet = var_1_10015
			var_1_10015 = var_1_10015.New({
				ship_list = {},
				commanders = iter_6_3.commanders
			})
			pairs = var_16

			for iter_6_4, iter_6_5 in var_16(var_1_10015:getCommanders()) do
				arg_6_1[iter_6_5.id].sub = var_1_10009
				arg_6_1[iter_6_5.id].fleetId = iter_6_2
				arg_6_1[iter_6_5.id].inFleet = true
			end
		end
	end

	return
end

local function var_0_7(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.fleets

	assert = var_1_10003

	var_1_10003(var_7_0)

	pairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(var_7_0) do
		local var_7_1 = iter_7_0 == #var_7_0

		pairs = var_1_10009

		for iter_7_2, iter_7_3 in var_1_10009(iter_7_1:getCommanders()) do
			arg_7_1[iter_7_3.id].sub = var_7_1
			arg_7_1[iter_7_3.id].fleetId = iter_7_1.id
			arg_7_1[iter_7_3.id].inFleet = true
		end
	end

	return
end

local function var_0_8(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_8_0 = var_1_10002(var_1_10003)

	_ = var_1_10003

	local var_8_1 = var_1_10003.map
	local var_8_2 = {}

	FleetProxy = var_1_10005
	var_8_2[1] = var_1_10005.CHALLENGE_FLEET_ID
	FleetProxy = var_5
	var_8_2[2] = var_5.CHALLENGE_SUB_FLEET_ID

	local var_8_3 = var_8_1(var_8_2, function(arg_9_0)
		local var_9_0 = var_8_0

		return var_1.getFleetById(var_9_0, arg_9_0)
	end)

	pairs = var_8_2

	for iter_8_0, iter_8_1 in var_8_2(var_8_3) do
		local var_8_4 = iter_8_1:isSubmarineFleet()
		local var_8_5 = iter_8_1.id

		pairs = var_1_10011

		for iter_8_2, iter_8_3 in var_1_10011(iter_8_1:getCommanders()) do
			arg_8_1[iter_8_3.id].sub = var_8_4
			arg_8_1[iter_8_3.id].fleetId = var_8_5
			arg_8_1[iter_8_3.id].inFleet = true
		end
	end

	return
end

local function var_0_9(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_10_1 = var_1_10003(var_1_10004)
	local var_10_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_10_3 = var_10_2(var_10_1, var_1_10005.ACTIVITY_TYPE_BOSSSINGLE)

	assert = var_10_1

	var_10_1(var_10_3 and not var_10_3:isEnd())

	local var_10_4 = var_10_0:getActivityFleets()[var_10_3.id]

	pairs = var_5

	for iter_10_0, iter_10_1 in var_5(var_10_4) do
		local var_10_5 = iter_10_1:isSubmarineFleet()
		local var_10_6 = iter_10_1.id % 10

		pairs = var_1_10012

		for iter_10_2, iter_10_3 in var_1_10012(iter_10_1:getCommanders()) do
			arg_10_1[iter_10_3.id].sub = var_10_5
			arg_10_1[iter_10_3.id].fleetId = var_10_6
			arg_10_1[iter_10_3.id].inFleet = true
		end
	end

	return
end

local function var_0_10(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_11_1 = var_1_10003(var_1_10004)
	local var_11_2 = var_3.getActivityByType

	ActivityConst = var_1_10005

	local var_11_3 = var_11_2(var_11_1, var_1_10005.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE)

	assert = var_11_1

	var_11_1(var_11_3 and not var_11_3:isEnd())

	local var_11_4 = var_11_0:getActivityFleets()[var_11_3.id]

	pairs = var_5

	for iter_11_0, iter_11_1 in var_5(var_11_4) do
		local var_11_5 = iter_11_1:isSubmarineFleet()
		local var_11_6 = iter_11_1.id % 10

		pairs = var_1_10012

		for iter_11_2, iter_11_3 in var_1_10012(iter_11_1:getCommanders()) do
			arg_11_1[iter_11_3.id].sub = var_11_5
			arg_11_1[iter_11_3.id].fleetId = var_11_6
			arg_11_1[iter_11_3.id].inFleet = true
		end
	end

	return
end

function var_0_0.GetCommanderList(arg_12_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getData(var_12_0)

	CommanderCatScene = var_12_0

	if var_12_0.FLEET_TYPE_COMMON == arg_12_0.fleetType then
		var_0_1(arg_12_0, var_12_1)
	else
		CommanderCatScene = var_3

		if var_3.FLEET_TYPE_ACTBOSS == arg_12_0.fleetType then
			var_0_2(arg_12_0, var_12_1)
		else
			CommanderCatScene = var_3

			if var_3.FLEET_TYPE_HARD_CHAPTER == arg_12_0.fleetType then
				var_0_3(arg_12_0, var_12_1)
			else
				CommanderCatScene = var_3

				if var_3.FLEET_TYPE_CHALLENGE == arg_12_0.fleetType then
					var_0_4(arg_12_0, var_12_1)
				else
					CommanderCatScene = var_3

					if var_3.FLEET_TYPE_GUILDBOSS == arg_12_0.fleetType then
						var_0_5(arg_12_0, var_12_1)
					else
						CommanderCatScene = var_3

						if var_3.FLEET_TYPE_WORLD == arg_12_0.fleetType then
							var_0_6(arg_12_0, var_12_1)
						else
							CommanderCatScene = var_3

							if var_3.FLEET_TYPE_BOSSRUSH == arg_12_0.fleetType then
								var_0_7(arg_12_0, var_12_1)
							else
								CommanderCatScene = var_3

								if var_3.FLEET_TYPE_LIMIT_CHALLENGE == arg_12_0.fleetType then
									var_0_8(arg_12_0, var_12_1)
								else
									CommanderCatScene = var_3

									if var_3.FLEET_TYPE_BOSSSINGLE == arg_12_0.fleetType then
										var_0_9(arg_12_0, var_12_1)
									else
										CommanderCatScene = var_3

										if var_3.FLEET_TYPE_BOSSSINGLE_VARIABLE == arg_12_0.fleetType then
											var_0_10(arg_12_0, var_12_1)
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

	getProxy = var_3
	ChapterProxy = var_4

	local var_12_2 = var_3(var_4)

	if var_3.getActiveChapter(var_12_2) then
		_ = var_12_2

		var_12_2.each(var_3.fleets, function(arg_13_0)
			local var_13_0 = arg_13_0
			local var_13_1 = arg_13_0.getCommanders(var_13_0)

			pairs = var_13_0

			for iter_13_0, iter_13_1 in var_13_0(arg_13_0:getCommanders()) do
				var_12_1[iter_13_1.id].inBattle = true
			end

			return
		end)
	end

	local var_12_3 = {}

	ipairs = var_1_10005

	local var_12_4

	if not arg_12_0.ignoredIds then
		var_12_4 = {}
	end

	for iter_12_0, iter_12_1 in var_1_10005(var_12_4) do
		var_12_3[iter_12_1] = true
	end

	local var_12_5 = {}

	pairs = var_6

	for iter_12_2, iter_12_3 in var_6(var_12_1) do
		if not var_12_3[iter_12_2] then
			table = var_11

			var_11.insert(var_12_5, iter_12_3)
		end
	end

	return var_12_5
end

function var_0_0.GetSkillExpAndCommanderExp(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = 0

	getProxy = var_1_10004
	CommanderProxy = var_1_10005

	local var_14_2 = var_1_10004(var_1_10005)

	pairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(arg_14_1) do
		local var_14_3 = var_14_2:getCommanderById(iter_14_1)

		var_14_1 = var_14_1 + var_10.getDestoryedExp(var_14_3, arg_14_0.groupId)
		var_14_0 = var_14_0 + var_10:getDestoryedSkillExp(arg_14_0.groupId)
	end

	math = var_5

	local var_14_4 = var_5.floor(var_14_1)

	math = var_6

	local var_14_5 = var_6.floor(var_14_0)
end

function var_0_0.AnySSRCommander(arg_15_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	_ = var_1_10002

	if var_1_10002.any(arg_15_0, function(arg_16_0)
		local var_16_0 = var_15_0
		local var_16_1 = var_1.RawGetCommanderById(var_16_0, arg_16_0)

		return var_1.getRarity(var_16_1) >= 5
	end) then
		return true
	end

	return false
end

function var_0_0.CalcCommanderConsume(arg_17_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = 0

	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_0) do
		local var_17_2 = var_17_0
		local var_17_3 = var_17_0.RawGetCommanderById(var_17_2, iter_17_1)

		assert = var_17_2

		var_17_2(var_17_3, iter_17_1)

		var_17_1 = var_17_1 + var_17_3:getUpgradeConsume()
	end

	math = var_3

	return var_3.floor(var_17_1)
end

function var_0_0.SetActive(arg_18_0, arg_18_1)
	GetOrAddComponent = var_1_10002

	local var_18_0 = arg_18_0

	typeof = var_1_10004
	CanvasGroup = var_1_10005

	local var_18_1 = var_1_10002(var_18_0, var_1_10004(var_1_10005))

	var_18_1.alpha = arg_18_1 and 1 or 0
	var_18_1.blocksRaycasts = arg_18_1

	return
end

function var_0_0.CommanderInChapter(arg_19_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)

	if var_1.getActiveChapter(var_19_0) then
		local var_19_1 = var_1.fleets

		pairs = var_1_10003

		for iter_19_0, iter_19_1 in var_1_10003(var_19_1) do
			local var_19_2 = iter_19_1
			local var_19_3 = iter_19_1.getCommanders(var_19_2)

			_ = var_19_2

			local var_19_4 = var_19_2.any

			_ = var_1_10010

			if var_19_4(var_1_10010.values(var_19_3), function(arg_20_0)
				return arg_20_0.id == arg_19_0.id
			end) then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetAllTalentNames()
	local var_21_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10001(var_1_10002.commander_ability_group.all) do
		pg = var_1_10006

		if var_1_10006.commander_ability_group[iter_21_1].ability_list then
			local var_21_1 = #var_1_10006.ability_list

			if 0 < var_21_1 then
				local var_21_2 = var_1_10006.ability_list[1]

				pg = var_8

				local var_21_3 = var_8.commander_ability_template[var_21_2].name

				table = var_1_10009

				var_1_10009.insert(var_21_0, {
					id = var_1_10006.id,
					name = var_21_3
				})
			end
		end
	end

	return var_21_0
end

function var_0_0.ShortenString(arg_22_0, arg_22_1)
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
	local var_22_4 = #arg_22_0
	local var_22_5 = false

	while var_22_1 <= var_22_4 do
		string = var_1_10008
		var_1_10008 = var_1_10008.byte(arg_22_0, var_22_1)

		local var_22_6, var_22_7 = var_22_0(var_1_10008)

		var_22_1 = var_22_1 + var_22_6
		var_22_2 = var_22_2 + var_22_7
		math = var_1_10011

		if var_1_10011.ceil(var_22_2) == arg_22_1 - 1 then
			var_22_3 = var_22_1
		elseif arg_22_1 < var_1_10011 then
			var_22_5 = true

			break
		end
	end

	if var_22_3 == 0 or var_22_4 < var_22_3 or not var_22_5 then
		return arg_22_0
	end

	string = var_1_10008

	return var_1_10008.sub(arg_22_0, 1, var_22_3 - 1) .. ".."
end

return var_0_0
