class = var_0_10000

local var_0_0 = "Chapter"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.SelectFleet = 1
var_0_1.CustomFleet = 2

local var_0_2 = {}

i18n = var_0_0
var_0_2[1] = var_0_0("level_chapter_state_high_risk")
i18n = var_2
var_0_2[2] = var_2("level_chapter_state_risk")
i18n = var_2
var_0_2[3] = var_2("level_chapter_state_low_risk")
i18n = var_2
var_0_2[4] = var_2("level_chapter_state_safety")
var_0_1.CHAPTER_STATE = var_0_2

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.chapter_template
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.configId = arg_2_1.id
	arg_2_0.id = arg_2_0.configId
	arg_2_0.active = false
	defaultValue = var_2
	arg_2_0.progress = var_2(arg_2_1.progress, 0)

	local var_2_0

	if not arg_2_1.defeat_count then
		var_2_0 = 0
	end

	arg_2_0.defeatCount = var_2_0

	local var_2_1

	if not arg_2_1.pass_count then
		var_2_1 = 0
	end

	arg_2_0.passCount = var_2_1

	local var_2_2

	if not arg_2_1.today_defeat_count then
		var_2_2 = 0
	end

	arg_2_0.todayDefeatCount = var_2_2

	local var_2_3 = {}

	defaultValue = var_1_10003
	var_2_3[1] = var_1_10003(arg_2_1.kill_boss_count, 0)
	defaultValue = var_3
	var_2_3[2] = var_3(arg_2_1.kill_enemy_count, 0)
	defaultValue = var_3
	var_2_3[3] = var_3(arg_2_1.take_box_count, 0)
	arg_2_0.achieves = {}

	for iter_2_0 = 1, 3 do
		local var_2_4 = arg_2_0:getConfig("star_require_" .. iter_2_0)

		if 0 < var_2_4 then
			table = var_8

			var_8.insert(arg_2_0.achieves, {
				type = var_2_4,
				config = arg_2_0:getConfig("num_" .. iter_2_0),
				count = var_2_3[iter_2_0]
			})
		end
	end

	arg_2_0.dropShipIdList = {}

	local var_2_5 = {}

	FleetType = var_4
	var_2_5[var_4.Normal] = {}
	FleetType = var_4
	var_2_5[var_4.Submarine] = {}
	FleetType = var_4
	var_2_5[var_4.Support] = {}
	arg_2_0.eliteFleetList = var_2_5
	arg_2_0.loopFlag = 0

	return
end

function var_0_1.getConfigMiscArg(arg_3_0, arg_3_1)
	ipairs = var_1_10002
	noEmptyStr = var_1_10004

	local var_3_0

	if not var_1_10004(arg_3_0:getConfig("misc_arg")) then
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in var_1_10002(var_3_0) do
		if arg_3_1 == iter_3_1[1] then
			return iter_3_1[2]
		end
	end

	return nil
end

function var_0_1.BuildEliteFleetInfo(arg_4_0)
	local var_4_0 = {}

	FleetType = var_1_10002
	var_4_0[var_1_10002.Normal] = var_0_1.BuildEliteTeamInfo(arg_4_0.main_team)
	FleetType = var_2
	var_4_0[var_2.Submarine] = var_0_1.BuildEliteTeamInfo(arg_4_0.submarine_team)
	FleetType = var_2
	var_4_0[var_2.Support] = var_0_1.BuildEliteTeamInfo(arg_4_0.support_team)

	return var_4_0
end

function var_0_1.BuildEliteTeamInfo(arg_5_0)
	underscore = var_1_10001

	return var_1_10001.map(arg_5_0, function(arg_6_0)
		local var_6_0 = {}

		TeamType = var_2_10002

		local var_6_1 = var_2_10002.FormShips

		underscore = var_2_10003
		var_6_0[var_6_1] = var_2_10003.to_array(arg_6_0.ship_list)
		TeamType = var_6_1

		local var_6_2 = var_6_1.FormCommander
		local var_6_3 = {}
		local var_6_4

		if not arg_6_0.commander_main then
			var_6_4 = 0
		end

		var_6_3[1] = var_6_4

		local var_6_5

		if not arg_6_0.commander_sub then
			var_6_5 = 0
		end

		var_6_3[2] = var_6_5
		var_6_0[var_6_2] = var_6_3

		return var_6_0
	end)
end

function var_0_1.PackEliteFleetInfo(arg_7_0)
	local var_7_0 = {
		id = 0
	}

	underscore = var_1_10002

	local var_7_1 = var_1_10002.map

	FleetType = var_1_10004
	var_7_0.main_team = var_7_1(arg_7_0[var_1_10004.Normal], function(arg_8_0)
		return var_0_1.PackEliteTeamInfo(arg_8_0)
	end)
	underscore = var_2

	local var_7_2 = var_2.map

	FleetType = var_4
	var_7_0.submarine_team = var_7_2(arg_7_0[var_4.Submarine], function(arg_9_0)
		return var_0_1.PackEliteTeamInfo(arg_9_0)
	end)
	underscore = var_2

	local var_7_3 = var_2.map

	FleetType = var_4
	var_7_0.support_team = var_7_3(arg_7_0[var_4.Support], function(arg_10_0)
		return var_0_1.PackEliteTeamInfo(arg_10_0)
	end)

	return var_7_0
end

function var_0_1.PackEliteTeamInfo(arg_11_0)
	local var_11_0 = {}
	local var_11_1

	if not arg_11_0.id then
		var_11_1 = 0
	end

	var_11_0.id = var_11_1
	underscore = var_11_1

	local var_11_2 = var_11_1.to_array

	TeamType = var_1_10004
	var_11_0.ship_list = var_11_2(arg_11_0[var_1_10004.FormShips])
	TeamType = var_2
	var_11_0.commander_main = arg_11_0[var_2.FormCommander][1]
	TeamType = var_2
	var_11_0.commander_sub = arg_11_0[var_2.FormCommander][2]

	return var_11_0
end

function var_0_1.getMaxCount(arg_12_0)
	if #arg_12_0:getConfig("risk_levels") == 0 then
		return 0
	end

	return var_1[1][1]
end

function var_0_1.hasMitigation(arg_13_0)
	LOCK_MITIGATION = var_1_10001

	if not var_1_10001 then
		return arg_13_0:getConfig("mitigation_level") > 0
	else
		return false
	end

	return
end

function var_0_1.getRemainPassCount(arg_14_0)
	local var_14_0 = arg_14_0:getMaxCount()

	math = var_1_10002

	return var_1_10002.max(var_14_0 - arg_14_0.passCount, 0)
end

function var_0_1.getRiskLevel(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.getRemainPassCount(var_15_0)
	local var_15_2 = arg_15_0:getConfig("risk_levels")

	ipairs = var_15_0

	for iter_15_0, iter_15_1 in var_15_0(var_15_2) do
		if var_15_1 <= iter_15_1[1] and var_15_1 >= iter_15_1[2] then
			return iter_15_0
		end
	end

	assert = var_3

	var_3(false, "index can not be nil")

	return
end

function var_0_1.getMitigationRate(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getMaxCount(var_16_0)

	LOCK_MITIGATION = var_1_10002

	local var_16_2 = var_1_10002 and 0 or arg_16_0:getConfig("mitigation_rate")

	math = var_16_0

	return var_16_0.min(arg_16_0.passCount, var_16_1) * var_16_2
end

function var_0_1.getRepressInfo(arg_17_0)
	local var_17_0 = {
		repressMax = arg_17_0:getMaxCount(),
		repressCount = arg_17_0.passCount,
		repressReduce = arg_17_0:getMitigationRate()
	}

	LOCK_MITIGATION = var_2

	local var_17_1

	if var_2 then
		var_17_1 = 0
	elseif arg_17_0:getRemainPassCount() > 0 then
		var_17_1 = 0
	elseif not arg_17_0:getConfig("mitigation_level") then
		var_17_1 = 0
	end

	var_17_0.repressLevel = var_17_1
	var_17_0.repressEnemyHpRant = 1 - arg_17_0:getStageCell(arg_17_0.fleet.line.row, arg_17_0.fleet.line.column).data / 16

	return var_17_0
end

function var_0_1.getChapterState(arg_18_0)
	local var_18_0 = arg_18_0:getRiskLevel()

	assert = var_1_10002

	var_1_10002(var_0_1.CHAPTER_STATE[var_18_0], "state desc is nil")

	return var_0_1.CHAPTER_STATE[var_18_0]
end

function var_0_1.getPlayType(arg_19_0)
	return arg_19_0:getConfig("model")
end

function var_0_1.isTypeDefence(arg_20_0)
	local var_20_0 = arg_20_0:getPlayType()

	ChapterConst = var_1_10002

	return var_20_0 == var_1_10002.TypeDefence
end

function var_0_1.IsSpChapter(arg_21_0)
	return arg_21_0:isTriesLimit()
end

function var_0_1.IsEXChapter(arg_22_0)
	local var_22_0 = arg_22_0:getPlayType()

	ChapterConst = var_1_10002

	return var_22_0 == var_1_10002.TypeExtra
end

function var_0_1.getConfig(arg_23_0, arg_23_1)
	if arg_23_0:isLoop() then
		pg = var_2

		local var_23_0 = var_2.chapter_template_loop[arg_23_0.id]

		assert = var_3

		var_3(var_23_0, "chapter_template_loop not exist: " .. arg_23_0.id)

		if var_23_0[arg_23_1] ~= nil and var_23_0[arg_23_1] ~= "&&" then
			return var_23_0[arg_23_1]
		end

		if (arg_23_1 == "air_dominance" or arg_23_1 == "best_air_dominance") and var_23_0.air_dominance_loop_rate ~= nil then
			local var_23_1 = arg_23_0
			local var_23_2 = arg_23_0.getConfigTable(var_23_1)
			local var_23_3 = var_23_0.air_dominance_loop_rate * 0.01

			math = var_23_1

			return var_23_1.floor(var_23_2[arg_23_1] * var_23_3)
		end
	end

	return var_0_1.super.getConfig(arg_23_0, arg_23_1)
end

function var_0_1.existLoop(arg_24_0)
	pg = var_1_10001

	return var_1_10001.chapter_template_loop[arg_24_0.id] ~= nil
end

function var_0_1.canActivateLoop(arg_25_0)
	return arg_25_0.progress == 100
end

function var_0_1.isLoop(arg_26_0)
	return arg_26_0.loopFlag == 1
end

function var_0_1.existAmbush(arg_27_0)
	return arg_27_0:getConfig("is_ambush") == 1 or arg_27_0:getConfig("is_air_attack") == 1
end

function var_0_1.isUnlock(arg_28_0)
	local var_28_0

	if arg_28_0:IsCleanPrevChapter() then
		var_28_0 = arg_28_0:IsCleanPrevStory()
	end

	return var_28_0
end

function var_0_1.IsCleanPrevChapter(arg_29_0)
	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0:getConfig("pre_chapter")) do
		_ = var_6

		if var_6.all(iter_29_1, function(arg_30_0)
			if arg_30_0 == 0 then
				return true
			end

			getProxy = var_2_10001
			ChapterProxy = var_2_10003

			local var_30_0 = var_2_10001(var_2_10003)
			local var_30_1 = var_1.GetChapterItemById(var_30_0, arg_30_0)

			return var_1.isClear(var_30_1)
		end) then
			return true
		end
	end

	return false
end

function var_0_1.IsCleanPrevStory(arg_31_0)
	if arg_31_0:getConfig("pre_story") == 0 then
		return true
	end

	getProxy = var_1_10002
	ChapterProxy = var_4

	local var_31_0 = var_1_10002(var_4)
	local var_31_1 = var_2.GetChapterItemById(var_31_0, var_1)

	return var_2.isClear(var_31_1)
end

function var_0_1.isPlayerLVUnlock(arg_32_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)

	return var_1.getRawData(var_32_0).level >= arg_32_0:getConfig("unlocklevel")
end

function var_0_1.isClear(arg_33_0)
	return arg_33_0.progress >= 100
end

function var_0_1.ifNeedHide(arg_34_0)
	table = var_1_10001

	local var_34_0 = var_1_10001.contains

	pg = var_1_10003

	if var_34_0(var_1_10003.chapter_setting.all, arg_34_0.id) then
		pg = var_1

		if var_1.chapter_setting[arg_34_0.id].hide == 1 then
			return arg_34_0:isClear()
		end
	end

	return
end

function var_0_1.existAchieve(arg_35_0)
	return #arg_35_0.achieves > 0
end

function var_0_1.isAllAchieve(arg_36_0)
	_ = var_1_10001

	return var_1_10001.all(arg_36_0.achieves, function(arg_37_0)
		ChapterConst = var_2_10001

		return var_2_10001.IsAchieved(arg_37_0)
	end)
end

function var_0_1.GetFleetTypeByIndex(arg_38_0)
	assert = var_1_10001

	var_1_10001(arg_38_0 > 0)

	switch = var_1_10001

	return var_1_10001(arg_38_0, {
		[4] = function()
			FleetType = var_2_10000

			return var_2_10000.Support, 1
		end,
		[3] = function()
			FleetType = var_2_10000

			return var_2_10000.Submarine, 1
		end
	}, function()
		FleetType = var_2_10000

		return var_2_10000.Normal, arg_38_0
	end)
end

function var_0_1.getEliteTeamByIndex(arg_42_0, arg_42_1)
	local var_42_0, var_42_1 = var_0_1.GetFleetTypeByIndex(arg_42_1)

	if not arg_42_0.eliteFleetList[var_42_0][var_42_1] then
		for iter_42_0 = #arg_42_0.eliteFleetList[var_42_0] + 1, var_42_1 do
			local var_42_2 = arg_42_0.eliteFleetList[var_42_0]
			local var_42_3 = {
				id = 0
			}

			TeamType = var_1_10010
			var_42_3[var_1_10010.FormShips] = {}
			TeamType = var_1_10010
			var_42_3[var_1_10010.FormCommander] = {
				0,
				0
			}
			var_42_2[iter_42_0] = var_42_3
		end
	end

	return arg_42_0.eliteFleetList[var_42_0][var_42_1], var_42_0
end

function var_0_1.setEliteFleetByIndex(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:getEliteTeamByIndex(arg_43_1)

	ipairs = var_1_10004

	for iter_43_0, iter_43_1 in var_1_10004(arg_43_2) do
		unpack = var_1_10009

		local var_43_1

		var_1_10009, var_43_1 = var_1_10009(iter_43_1)
		TeamType = var_11

		if var_1_10009 == var_11.FormCommander then
			var_43_0[var_1_10009][var_43_1.pos] = var_43_1.id
		else
			var_43_0[var_1_10009] = var_43_1
		end
	end

	return
end

function var_0_1.clearEliterFleetByIndex(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.setEliteFleetByIndex
	local var_44_2 = arg_44_1
	local var_44_3 = {}
	local var_44_4 = {}

	TeamType = var_1_10008
	var_44_4[1] = var_1_10008.FormShips
	var_44_4[2] = {}
	var_44_3[1] = var_44_4

	var_44_1(var_44_0, var_44_2, var_44_3)

	return
end

function var_0_1.wrapEliteFleet(arg_45_0, arg_45_1)
	local var_45_0, var_45_1 = arg_45_0:getEliteTeamByIndex(arg_45_1)
	local var_45_2 = {}

	pairs = var_5
	TeamType = var_1_10007

	for iter_45_0, iter_45_1 in var_5(var_45_0[var_1_10007.FormCommander]) do
		if iter_45_1 ~= 0 then
			table = var_1_10010

			var_1_10010.insert(var_45_2, {
				pos = iter_45_0,
				id = iter_45_1
			})
		end
	end

	TypedFleet = var_5

	local var_45_3 = var_5.New
	local var_45_4 = {
		id = arg_45_1,
		fleetType = var_45_1
	}

	underscore = iter_45_0

	local var_45_5 = iter_45_0.to_array

	TeamType = var_1_10010
	var_45_4.ship_list = var_45_5(var_45_0[var_1_10010.FormShips])
	var_45_4.commanders = var_45_2

	return var_45_3(var_45_4)
end

function var_0_1.getEliteFleetCommanders(arg_46_0)
	arg_46_0:EliteCommanderFilter()

	local var_46_0 = {}

	ipairs = var_1_10002

	for iter_46_0, iter_46_1 in var_1_10002({
		{
			arg_46_0:GetNomralFleetMaxCount(),
			0
		},
		{
			arg_46_0:GetSubmarineFleetMaxCount(),
			2
		},
		{
			arg_46_0:GetSupportFleetMaxCount(),
			3
		}
	}) do
		unpack = var_1_10007

		local var_46_1

		var_1_10007, var_46_1 = var_1_10007(iter_46_1)

		for iter_46_2 = 1, var_1_10007 do
			local var_46_2 = var_46_1 + iter_46_2
			local var_46_3 = arg_46_0:getEliteTeamByIndex(var_46_2)

			underscore = var_1_10015
			var_1_10015 = var_1_10015.to_array
			TeamType = var_17
			var_46_0[var_46_2] = var_1_10015(var_46_3[var_17.FormCommander])
		end
	end

	return var_46_0
end

function var_0_1.updateCommander(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_0
	local var_47_1 = arg_47_0.setEliteFleetByIndex
	local var_47_2 = arg_47_1
	local var_47_3 = {}
	local var_47_4 = {}

	TeamType = var_1_10010
	var_47_4[1] = var_1_10010.FormCommander
	var_47_4[2] = {
		pos = arg_47_2,
		id = arg_47_3
	}
	var_47_3[1] = var_47_4

	var_47_1(var_47_0, var_47_2, var_47_3)

	return
end

function var_0_1.getEliteFleetList(arg_48_0)
	arg_48_0:EliteShipTypeFilter()

	local var_48_0 = {}

	ipairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002({
		{
			arg_48_0:GetNomralFleetMaxCount(),
			0
		},
		{
			arg_48_0:GetSubmarineFleetMaxCount(),
			2
		},
		{
			arg_48_0:GetSupportFleetMaxCount(),
			3
		}
	}) do
		unpack = var_1_10007

		local var_48_1

		var_1_10007, var_48_1 = var_1_10007(iter_48_1)

		for iter_48_2 = 1, var_1_10007 do
			local var_48_2 = var_48_1 + iter_48_2
			local var_48_3 = arg_48_0:getEliteTeamByIndex(var_48_2)

			underscore = var_1_10015
			var_1_10015 = var_1_10015.to_array
			TeamType = var_17
			var_48_0[var_48_2] = var_1_10015(var_48_3[var_17.FormShips])
		end
	end

	return var_48_0
end

function var_0_1.setEliteFleetList(arg_49_0, arg_49_1)
	if not arg_49_1 then
		return
	end

	arg_49_0.eliteFleetList = arg_49_1

	return
end

function var_0_1.IsEliteFleetLegal(arg_50_0)
	local var_50_0 = {}

	ipairs = var_1_10002

	local var_50_1 = {}
	local var_50_2 = {
		arg_50_0:GetNomralFleetMaxCount(),
		0
	}

	FleetType = var_6
	var_50_2[3] = var_6.Normal
	var_50_1[1] = var_50_2

	local var_50_3 = {
		arg_50_0:GetSubmarineFleetMaxCount(),
		2
	}

	FleetType = var_6
	var_50_3[3] = var_6.Submarine
	var_50_1[2] = var_50_3

	local var_50_4 = {
		arg_50_0:GetSupportFleetMaxCount(),
		3
	}

	FleetType = var_6
	var_50_4[3] = var_6.Support
	var_50_1[3] = var_50_4

	for iter_50_0, iter_50_1 in var_1_10002(var_50_1) do
		unpack = var_1_10007

		local var_50_5, var_50_6

		var_1_10007, var_50_5, var_50_6 = var_1_10007(iter_50_1)

		for iter_50_2 = 1, var_1_10007 do
			local var_50_7 = var_50_5 + iter_50_2
			local var_50_8 = arg_50_0
			local var_50_9, var_50_10 = arg_50_0.singleEliteFleetVertify(var_50_8, var_50_7)

			if var_50_9 then
				defaultValue = var_50_8
				var_50_0[var_50_6] = var_50_8(var_50_0[var_50_6], 0) + 1
			elseif var_50_10 == "empty" then
				-- block empty
			else
				local var_50_11 = false

				switch = var_18

				local var_50_12 = var_18(var_50_10, {
					inEvent = function()
						i18n = var_2_10000

						return var_2_10000("elite_disable_ship_escort")
					end,
					teamCount = function()
						i18n = var_2_10000

						local var_52_0 = "elite_fleet_confirm"

						Fleet = var_2_10003

						return var_2_10000(var_52_0, var_2_10003.DEFAULT_ELITE_NAME[var_50_7])
					end,
					typeLimitation = function()
						i18n = var_2_10000

						return var_2_10000("elite_disable_formation_unsatisfied")
					end
				})

				return
			end
		end
	end

	if var_50_0 == 0 then
		local var_50_13 = false

		i18n = var_3

		local var_50_14 = var_3("elite_disable_no_fleet")

		return
	end

	local var_50_15 = arg_50_0
	local var_50_16 = arg_50_0.IsPropertyLimitationSatisfy(var_50_15)
	local var_50_17 = 1

	ipairs = var_50_15

	for iter_50_3, iter_50_4 in var_50_15(var_50_16) do
		var_50_17 = var_50_17 * iter_50_4
	end

	if var_50_17 ~= 1 then
		local var_50_18 = false

		i18n = var_5

		local var_50_19 = var_5("elite_disable_property_unsatisfied")

		return
	end

	return true
end

function var_0_1.IsPropertyLimitationSatisfy(arg_54_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_54_0 = var_1_10001(var_1_10003)
	local var_54_1 = var_1.getRawData(var_54_0)
	local var_54_2 = arg_54_0
	local var_54_3 = arg_54_0.getConfig(var_54_2, "property_limitation")
	local var_54_4 = {}

	ipairs = var_54_2

	for iter_54_0, iter_54_1 in var_54_2(var_54_3) do
		var_54_4[iter_54_1[1]] = 0
	end

	local var_54_5 = arg_54_0:getEliteFleetList()
	local var_54_6 = 0

	for iter_54_2 = 1, 2 do
		var_1_10012 = arg_54_0

		if not arg_54_0.singleEliteFleetVertify(var_1_10012, iter_54_2) then
			-- block empty
		else
			local var_54_7 = {}
			local var_54_8 = {}

			ipairs = var_1_10012

			for iter_54_3, iter_54_4 in var_1_10012(var_54_3) do
				unpack = iter_54_10

				local var_54_9

				iter_54_10, var_54_9, var_1_10019, var_1_10020 = iter_54_10(iter_54_4)
				string = var_1_10021

				if var_1_10021.sub(iter_54_10, 1, 5) == "fleet" then
					var_54_7[iter_54_10] = 0
					var_54_8[iter_54_10] = var_1_10020
				end
			end

			var_1_10012 = var_54_5[iter_54_2]
			ipairs = var_13

			for iter_54_5, iter_54_10 in var_13(var_1_10012) do
				local var_54_10 = var_54_1[iter_54_10]

				var_54_6 = var_54_6 + 1
				intProperties = var_1_10019
				var_1_10019 = var_1_10019(var_54_10:getProperties())
				pairs = var_1_10020

				for iter_54_7, iter_54_8 in var_1_10020(var_54_4) do
					string = var_1_10025

					if var_1_10025.sub(iter_54_7, 1, 5) == "fleet" then
						if iter_54_7 == "fleet_totle_level" then
							var_54_7[iter_54_7] = var_54_7[iter_54_7] + var_54_10.level
						end
					elseif iter_54_7 == "level" then
						var_54_4[iter_54_7] = iter_54_8 + var_54_10.level
					else
						var_54_4[iter_54_7] = iter_54_8 + var_1_10019[iter_54_7]
					end
				end
			end

			pairs = var_13

			for iter_54_9, iter_54_10 in var_13(var_54_7) do
				if iter_54_9 == "fleet_totle_level" and iter_54_10 > var_54_8[iter_54_9] then
					var_54_4[iter_54_9] = var_54_4[iter_54_9] + 1
				end
			end
		end
	end

	local var_54_11 = {}

	ipairs = var_7

	for iter_54_11, iter_54_12 in var_7(var_54_3) do
		unpack = var_1_10012

		local var_54_12, var_54_13

		var_1_10012, var_54_12, var_54_13 = var_1_10012(iter_54_12)

		if var_1_10012 == "level" and 0 < var_54_6 then
			math = iter_54_3
			var_54_4[var_1_10012] = iter_54_3.ceil(var_54_4[var_1_10012] / var_54_6)
		end

		AttributeType = iter_54_3
		iter_54_3 = iter_54_3.EliteConditionCompare(var_54_12, var_54_4[var_1_10012], var_54_13) and 1 or 0
		var_54_11[iter_54_11] = iter_54_3
	end

	return var_54_11, var_54_4
end

function var_0_1.GetNomralFleetMaxCount(arg_55_0)
	return arg_55_0:getConfig("group_num")
end

function var_0_1.GetSubmarineFleetMaxCount(arg_56_0)
	return arg_56_0:getConfig("submarine_num")
end

function var_0_1.GetSupportFleetMaxCount(arg_57_0)
	return arg_57_0:getConfig("support_group_num")
end

function var_0_1.EliteShipTypeFilter(arg_58_0)
	local var_58_0 = arg_58_0:getConfig("type")

	Chapter = var_1_10002

	if var_58_0 == var_1_10002.SelectFleet then
		local var_58_1 = arg_58_0.eliteFleetList

		FleetType = var_2
		var_58_1[var_2.Normal] = {}

		local var_58_2 = arg_58_0.eliteFleetList

		FleetType = var_2
		var_58_2[var_2.Submarine] = {}
	else
		local var_58_3 = arg_58_0
		local var_58_4 = arg_58_0.GetNomralFleetMaxCount(var_58_3) + 1
		local var_58_5 = arg_58_0.eliteFleetList

		FleetType = var_58_3

		for iter_58_0 = var_58_4, #var_58_5[var_58_3.Normal] do
			local var_58_6 = arg_58_0.eliteFleetList

			FleetType = var_1_10006
			var_58_6[var_1_10006.Normal][iter_58_0] = nil
		end

		local var_58_7 = arg_58_0
		local var_58_8 = arg_58_0.GetSubmarineFleetMaxCount(var_58_7) + 1
		local var_58_9 = arg_58_0.eliteFleetList

		FleetType = var_58_7

		for iter_58_1 = var_58_8, #var_58_9[var_58_7.Submarine] do
			local var_58_10 = arg_58_0.eliteFleetList

			FleetType = var_1_10006
			var_58_10[var_1_10006.Submarine][iter_58_1] = nil
		end
	end

	local var_58_11 = arg_58_0
	local var_58_12 = arg_58_0.GetSupportFleetMaxCount(var_58_11) + 1
	local var_58_13 = arg_58_0.eliteFleetList

	FleetType = var_58_11

	for iter_58_2 = var_58_12, #var_58_13[var_58_11.Support] do
		local var_58_14 = arg_58_0.eliteFleetList

		FleetType = var_1_10006
		var_58_14[var_1_10006.Support][iter_58_2] = nil
	end

	getProxy = var_58_12
	BayProxy = var_3

	local var_58_15 = var_58_12(var_3)
	local var_58_16 = var_1.getRawData(var_58_15)

	local function var_58_17(arg_59_0)
		if not arg_59_0 then
			return
		end

		for iter_59_0 = #arg_59_0, 1, -1 do
			if var_58_16[arg_59_0[iter_59_0]] == nil then
				table = var_5

				var_5.remove(arg_59_0, iter_59_0)
			end
		end

		return
	end

	ipairs = var_58_15

	for iter_58_3, iter_58_4 in var_58_15(arg_58_0.eliteFleetList) do
		ipairs = var_1_10008

		for iter_58_5, iter_58_6 in var_1_10008(iter_58_4) do
			local var_58_18 = var_58_17

			TeamType = var_1_10015

			var_58_18(iter_58_6[var_1_10015.FormShips])
		end
	end

	local function var_58_19(arg_60_0, arg_60_1)
		Clone = var_2_10002
		arg_60_1 = var_2_10002(arg_60_1)
		ChapterProxy = var_2

		var_2.SortRecommendLimitation(arg_60_1)

		local var_60_0 = 1

		while var_60_0 <= #arg_60_0 do
			local var_60_1 = arg_60_0[var_60_0]
			local var_60_2
			local var_60_3 = var_58_16[var_60_1]
			local var_60_4 = var_5.getShipType(var_60_3)

			ipairs = var_2_10006

			for iter_60_0, iter_60_1 in var_2_10006(arg_60_1) do
				ShipType = var_2_10011

				if var_2_10011.ContainInLimitBundle(iter_60_1, var_60_4) then
					var_60_2 = iter_60_0

					break
				end
			end

			if var_60_2 then
				table = var_2_10006

				var_2_10006.remove(arg_60_1, var_60_2)

				var_60_0 = var_60_0 + 1
			else
				table = var_2_10006

				var_2_10006.remove(arg_60_0, var_60_0)
			end
		end

		return
	end

	local var_58_20 = arg_58_0:getConfig("limitation")

	pairs = var_5

	for iter_58_7, iter_58_8 in var_5(arg_58_0.eliteFleetList) do
		ipairs = var_1_10010

		for iter_58_9, iter_58_10 in var_1_10010(iter_58_8) do
			switch = var_1_10015

			local var_58_21 = iter_58_7
			local var_58_22 = {}

			FleetType = var_1_10019
			var_58_22[var_1_10019.Normal] = function()
				local var_61_0 = var_58_20[iter_58_9]

				underscore = var_1

				local var_61_1 = var_1.map
				local var_61_2 = {}

				TeamType = var_2_10004
				var_61_2[1] = var_2_10004.Main
				TeamType = var_4
				var_61_2[2] = var_4.Vanguard

				local var_61_3 = var_61_1(var_61_2, function(arg_62_0)
					underscore = var_3_10001

					local var_62_0 = var_3_10001.filter
					local var_62_1 = iter_58_10

					TeamType = var_3_10004

					return var_62_0(var_62_1[var_3_10004.FormShips], function(arg_63_0)
						local var_63_0 = var_58_16[arg_63_0]

						return var_1.getTeamType(var_63_0) == arg_62_0
					end)
				end)

				var_58_19(var_61_3[1], var_61_0[1])
				var_58_19(var_61_3[2], var_61_0[2])

				local var_61_4 = iter_58_10

				TeamType = var_61_2

				local var_61_5 = var_61_2.FormShips

				table = var_4
				var_61_4[var_61_5] = var_4.mergeArray(var_61_3[1], var_61_3[2])

				return
			end
			FleetType = var_1_10019
			var_58_22[var_1_10019.Submarine] = function()
				local var_64_0 = var_58_19
				local var_64_1 = iter_58_10

				TeamType = var_2_10003

				var_64_0(var_64_1[var_2_10003.FormShips], {
					0,
					0,
					0
				})

				return
			end
			FleetType = var_1_10019
			var_58_22[var_1_10019.Support] = function()
				local var_65_0 = arg_58_0
				local var_65_1

				if not var_0.getConfigMiscArg(var_65_0, "submarine_support") or not {
					"qian",
					"qian",
					"qian"
				} then
					var_65_1 = {
						"hang",
						"hang",
						"hang"
					}
				end

				local var_65_2 = var_58_19
				local var_65_3 = iter_58_10

				TeamType = var_2_10004

				var_65_2(var_65_3[var_2_10004.FormShips], var_65_1)

				return
			end

			var_1_10015(var_58_21, var_58_22)
		end
	end

	return
end

function var_0_1.EliteCommanderFilter(arg_66_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10003

	local var_66_0 = var_1_10001(var_1_10003)

	pairs = var_1_10002

	for iter_66_0, iter_66_1 in var_1_10002(arg_66_0.eliteFleetList) do
		ipairs = var_1_10007

		for iter_66_2, iter_66_3 in var_1_10007(iter_66_1) do
			ipairs = var_1_10012
			TeamType = var_1_10014

			for iter_66_4, iter_66_5 in var_1_10012(iter_66_3[var_1_10014.FormCommander]) do
				if iter_66_5 ~= 0 and not var_66_0:RawGetCommanderById(iter_66_5) then
					TeamType = var_17
					iter_66_3[var_17.FormCommander][iter_66_4] = 0
				end
			end
		end
	end

	return
end

function var_0_1.singleEliteFleetVertify(arg_67_0, arg_67_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_67_0 = var_1_10002(var_1_10004)
	local var_67_1 = var_2.getRawData(var_67_0)
	local var_67_2 = arg_67_0
	local var_67_3, var_67_4 = arg_67_0.getEliteTeamByIndex(var_67_2, arg_67_1)

	TeamType = var_67_2

	if not var_67_3[var_67_2.FormShips] or #var_5 == 0 then
		return false, "empty"
	end

	local var_67_5 = {}

	TeamType = var_1_10007
	var_67_5[var_1_10007.Main] = 0
	TeamType = var_7
	var_67_5[var_7.Vanguard] = 0
	TeamType = var_7
	var_67_5[var_7.Submarine] = 0

	local var_67_6 = {}

	ipairs = var_8

	for iter_67_0, iter_67_1 in var_8(var_5) do
		if var_67_1[iter_67_1] then
			iter_67_3 = var_13

			if var_13.getFlag(iter_67_3, "inEvent") then
				return false, "inEvent"
			end

			iter_67_3 = var_13
			var_67_5[var_14] = var_67_5[var_13.getTeamType(iter_67_3)] + 1
			var_67_6[#var_67_6 + 1] = var_13:getShipType()
		end
	end

	FleetType = var_8

	if var_67_4 == var_8.Normal then
		TeamType = var_67_7

		local var_67_7 = var_67_5[var_67_7.Main]

		TeamType = var_9

		if not (var_9.MainMax < var_67_7) then
			TeamType = var_67_7
			var_67_7 = var_67_5[var_67_7.Vanguard]
			TeamType = var_9

			if not (var_9.VanguardMax < var_67_7) then
				TeamType = var_67_7
				var_67_7 = var_67_5[var_67_7.Main]
				TeamType = var_9

				if var_67_7 * var_67_5[var_9.Vanguard] == 0 then
					return false, "teamCount"
				end

				underscore = var_67_7
				checkExist = var_10

				local var_67_8

				if not var_10(arg_67_0:getConfig("limitation"), {
					arg_67_1
				}) then
					var_67_8 = {}
				end

				local var_67_9 = var_67_7(var_67_8)
				local var_67_10 = var_8.chain(var_67_9)
				local var_67_11 = var_8.flatten(var_67_10)
				local var_67_12 = var_8.filter(var_67_11, function(arg_68_0)
					return arg_68_0 ~= 0
				end)
				local var_67_13 = var_8.value(var_67_12)

				ChapterProxy = var_9

				var_9.SortRecommendLimitation(var_67_13)

				local var_67_14 = 1

				while var_67_14 <= #var_67_6 do
					local var_67_15 = var_67_6[var_67_14]
					local var_67_16

					ipairs = var_12

					for iter_67_2, iter_67_3 in var_12(var_67_13) do
						ShipType = var_1_10017

						if var_1_10017.ContainInLimitBundle(iter_67_3, var_67_15) then
							var_67_16 = iter_67_2

							break
						end
					end

					if var_67_16 then
						table = var_12

						var_12.remove(var_67_13, var_67_16)

						var_67_14 = var_67_14 + 1
					else
						table = var_12

						var_12.remove(var_67_6, var_67_14)
					end
				end

				FleetType = var_67_15

				if var_67_4 == var_67_15.Normal then
					local var_67_17 = {}

					ipairs = var_67_16

					for iter_67_4, iter_67_5 in var_67_16(var_67_6) do
						ShipType = iter_67_3
						var_67_17[iter_67_3.GetTeamFromShipType(iter_67_5)] = true
					end

					ipairs = var_11

					local var_67_18 = {}

					TeamType = iter_67_4
					var_67_18[1] = iter_67_4.Vanguard
					TeamType = var_14
					var_67_18[2] = var_14.Main

					for iter_67_6, iter_67_7 in var_11(var_67_18) do
						local var_67_19

						if not var_67_17[iter_67_7] then
							underscore = var_67_19
							var_67_19 = var_67_19.all(var_67_13, function(arg_69_0)
								underscore = var_2_10001

								local var_69_0 = var_2_10001.all

								ShipType = var_2_10003

								return var_69_0(var_2_10003.GetShipTypesFromLimit(arg_69_0), function(arg_70_0)
									ShipType = var_3_10001

									return var_3_10001.GetTeamFromShipType(arg_70_0) ~= iter_67_7
								end)
							end)
						end

						var_67_17[iter_67_7] = var_67_19
					end

					TeamType = var_11

					if var_67_17[var_11.Vanguard] then
						TeamType = var_11

						if var_67_17[var_11.Main] then
							do return true end

							goto label_67_0
						end
					end

					return false, "typeLimitation"
				elseif #var_67_13 == 0 or #var_67_6 > 0 then
					return true
				else
					return false, "typeLimitation"
				end

				::label_67_0::

				return
			end
		end
	end
end

function var_0_1.getSupportFleet(arg_71_0)
	arg_71_0:EliteShipTypeFilter()

	local var_71_0 = arg_71_0:getEliteTeamByIndex(4)

	underscore = var_1_10002

	local var_71_1 = var_1_10002.to_array

	TeamType = var_4

	return var_71_1(var_71_0[var_4.FormShips])
end

function var_0_1.activeAlways(arg_72_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_72_0 = var_1_10001(var_1_10003)
	local var_72_1 = var_1.getMapById(var_72_0, arg_72_0:getConfig("map"))

	if var_1.isActivity(var_72_1) then
		local var_72_2 = arg_72_0
		local var_72_3 = arg_72_0.GetBindActID(var_72_2)

		pg = var_72_0

		local var_72_4 = var_72_0.activity_template[var_72_3]

		type = var_72_2

		if var_72_2(var_72_4.config_client) == "table" then
			local var_72_5

			if not var_72_4.config_client.prevs then
				var_72_5 = {}
			end

			table = var_1_10005

			return var_1_10005.contains(var_72_5, arg_72_0.id)
		end
	end

	return false
end

function var_0_1.GetPrevChapterNames(arg_73_0)
	local var_73_0 = {}

	ipairs = var_1_10002

	for iter_73_0, iter_73_1 in var_1_10002(arg_73_0:getConfig("pre_chapter")) do
		if iter_73_1[1] ~= 0 then
			local var_73_1 = arg_73_0:bindConfigTable()[var_7].chapter_name

			table = var_1_10009

			var_1_10009.insert(var_73_0, var_73_1)
		end
	end

	return var_73_0
end

function var_0_1.CanQuickPlay(arg_74_0)
	pg = var_1_10001

	return var_1_10001.chapter_setting[arg_74_0.id] and var_1.expedite > 0
end

function var_0_1.GetQuickPlayFlag(arg_75_0)
	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt("chapter_quickPlay_flag_" .. arg_75_0.id, 0) == 1
end

function var_0_1.writeDrops(arg_76_0, arg_76_1)
	_ = var_1_10002

	var_1_10002.each(arg_76_1, function(arg_77_0)
		local var_77_0 = arg_77_0.type

		DROP_TYPE_SHIP = var_2_10002

		if var_77_0 == var_2_10002 then
			table = var_77_0

			if not var_77_0.contains(arg_76_0.dropShipIdList, arg_77_0.id) then
				table = var_1

				var_1.insert(arg_76_0.dropShipIdList, arg_77_0.id)
			end
		end

		return
	end)

	return
end

function var_0_1.UpdateDropShipList(arg_78_0, arg_78_1)
	ipairs = var_1_10002

	for iter_78_0, iter_78_1 in var_1_10002(arg_78_1) do
		table = var_1_10007

		if not var_1_10007.contains(arg_78_0.dropShipIdList, iter_78_1) then
			table = var_1_10007

			var_1_10007.insert(arg_78_0.dropShipIdList, iter_78_1)
		end
	end

	return
end

function var_0_1.GetDropShipList(arg_79_0)
	return arg_79_0.dropShipIdList
end

function var_0_1.getOniChapterInfo(arg_80_0)
	pg = var_1_10001

	return var_1_10001.chapter_capture[arg_80_0.id]
end

function var_0_1.getBombChapterInfo(arg_81_0)
	pg = var_1_10001

	return var_1_10001.chapter_boom[arg_81_0.id]
end

function var_0_1.getNpcShipByType(arg_82_0, arg_82_1)
	local var_82_0 = {}

	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_82_1 = var_1_10003(var_1_10005)

	local function var_82_2(arg_83_0)
		if arg_83_0 == 0 then
			return true
		end

		local var_83_0 = var_82_1

		return var_1.getTaskVO(var_83_0, arg_83_0) and not var_1:isFinish()
	end

	ipairs = var_1_10005

	for iter_82_0, iter_82_1 in var_1_10005(arg_82_0:getConfig("npc_data")) do
		pg = var_82_3

		local var_82_3 = var_82_3.npc_squad_template[iter_82_1]

		if not arg_82_1 or arg_82_1 == var_82_3.type and var_82_2(var_82_3.task_id) then
			ipairs = var_1_10011

			for iter_82_2, iter_82_3 in var_1_10011({
				"vanguard_list",
				"main_list"
			}) do
				ipairs = var_1_10016

				for iter_82_4, iter_82_5 in var_1_10016(var_82_3[iter_82_3]) do
					table = var_1_10021
					var_1_10021 = var_1_10021.insert

					local var_82_4 = var_82_0

					NpcShip = var_1_10024

					var_1_10021(var_82_4, var_1_10024.New({
						id = iter_82_5[1],
						configId = iter_82_5[1],
						level = iter_82_5[2]
					}))
				end
			end
		end
	end

	return var_82_0
end

function var_0_1.getTodayDefeatCount(arg_84_0)
	getProxy = var_1_10001
	DailyLevelProxy = var_1_10003

	local var_84_0 = var_1_10001(var_1_10003)

	return var_1.getChapterDefeatCount(var_84_0, arg_84_0.configId)
end

function var_0_1.isTriesLimit(arg_85_0)
	return arg_85_0:getConfig("count") and var_1 > 0
end

function var_0_1.updateTodayDefeatCount(arg_86_0)
	getProxy = var_1_10001
	DailyLevelProxy = var_1_10003

	local var_86_0 = var_1_10001(var_1_10003)

	var_1.updateChapterDefeatCount(var_86_0, arg_86_0.configId)

	return
end

function var_0_1.enoughTimes2Start(arg_87_0)
	if arg_87_0:isTriesLimit() then
		return arg_87_0:getTodayDefeatCount() < arg_87_0:getConfig("count")
	else
		return true
	end

	return
end

function var_0_1.GetRestDailyBonus(arg_88_0)
	local var_88_0 = 0

	if arg_88_0:IsRemaster() then
		return var_88_0
	end

	local var_88_1 = arg_88_0:getConfig("boss_expedition_id")

	ipairs = var_1_10003

	for iter_88_0, iter_88_1 in var_1_10003(var_88_1) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.expedition_activity_template[iter_88_1]
		math = var_1_10009
		var_1_10009 = var_1_10009.max

		local var_88_2 = var_88_0
		local var_88_3

		if not var_1_10008 or not var_1_10008.bonus_time then
			var_88_3 = 0
		end

		var_88_0 = var_1_10009(var_88_2, var_88_3)
	end

	pg = var_3

	local var_88_4

	if var_3.chapter_defense[arg_88_0.id] then
		math = var_88_4
		var_88_4 = var_88_4.max

		local var_88_5 = var_88_0
		local var_88_6

		if not var_3.bonus_time then
			var_88_6 = 0
		end

		var_88_0 = var_88_4(var_88_5, var_88_6)
	end

	math = var_88_4

	return (var_88_4.max(var_88_0 - arg_88_0.todayDefeatCount, 0))
end

function var_0_1.GetDailyBonusQuota(arg_89_0)
	return arg_89_0:GetRestDailyBonus() > 0
end

function var_0_1.GetDailyBonusRate(arg_90_0)
	local var_90_0 = 0
	local var_90_1 = arg_90_0:getConfig("boss_expedition_id")

	ipairs = var_1_10003

	for iter_90_0, iter_90_1 in var_1_10003(var_90_1) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.expedition_activity_template[iter_90_1]
		math = var_1_10009
		var_1_10009 = var_1_10009.max

		local var_90_2 = var_90_0
		local var_90_3

		if not var_1_10008 or not var_1_10008.bonus_rate then
			var_90_3 = 0
		end

		var_90_0 = var_1_10009(var_90_2, var_90_3)
	end

	pg = var_3

	if var_3.chapter_defense[arg_90_0.id] then
		math = var_4

		local var_90_4 = var_4.max
		local var_90_5 = var_90_0
		local var_90_6

		if not var_3.bonus_rate then
			var_90_6 = 0
		end

		var_90_0 = var_90_4(var_90_5, var_90_6)
	end

	return var_90_0 > 0 and var_90_0 or nil
end

function var_0_1.GetDailyBonusIconName(arg_91_0)
	local var_91_0 = arg_91_0

	if arg_91_0.GetDailyBonusRate(var_91_0) then
		local var_91_1 = "bonusX"

		tostring = var_91_0

		local var_91_2

		if not (var_91_1 .. var_91_0(var_1)) then
			var_91_2 = "bonusX5"
		end

		return var_91_2
	end
end

var_0_1.OPERATION_BUFF_TYPE_COST = "more_oil"
var_0_1.OPERATION_BUFF_TYPE_REWARD = "extra_drop"
var_0_1.OPERATION_BUFF_TYPE_EXP = "chapter_up"
var_0_1.OPERATION_BUFF_TYPE_DESC = "desc"

function var_0_1.GetSPOperationItemCacheKey(arg_92_0)
	return "specialOPItem_" .. arg_92_0
end

function var_0_1.GetSpItems(arg_93_0)
	local var_93_0 = {}

	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_93_1 = var_1_10002(var_1_10004)
	local var_93_2 = var_2.getItemsByType

	Item = var_1_10005

	local var_93_3 = var_93_2(var_93_1, var_1_10005.SPECIAL_OPERATION_TICKET)

	noEmptyStr = var_1_10003

	if var_1_10003(arg_93_0:getConfig("special_operation_list")) then
		next = var_93_1

		if not var_93_1(var_3) then
			return var_93_0
		end

		ipairs = var_93_1

		for iter_93_0, iter_93_1 in var_93_1(var_3) do
			pg = var_1_10009

			if var_1_10009.benefit_buff_template[iter_93_1] then
				local var_93_4 = var_1_10009.benefit_type

				Chapter = var_1_10011

				if var_93_4 == var_1_10011.OPERATION_BUFF_TYPE_DESC then
					ActivityBuff = var_93_4

					local var_93_5 = var_93_4.GetBenefitCondition(var_1_10009.benefit_condition)

					ipairs = var_1_10011

					for iter_93_2, iter_93_3 in var_1_10011(var_93_3) do
						assert = var_1_10016

						var_1_10016(var_93_5[1] == "item")

						if var_93_5[2] == iter_93_3.configId then
							table = var_1_10016

							var_1_10016.insert(var_93_0, iter_93_3)

							break
						end
					end
				end
			end
		end

		return var_93_0
	end
end

function var_0_1.GetSPBuffByItem(arg_94_0)
	ipairs = var_1_10001
	pg = var_1_10003

	local var_94_0 = var_1_10003.benefit_buff_template.get_id_list_by_benefit_type

	Chapter = var_1_10004

	for iter_94_0, iter_94_1 in var_1_10001(var_94_0[var_1_10004.OPERATION_BUFF_TYPE_DESC]) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.benefit_buff_template[iter_94_1]
		ActivityBuff = var_1_10007
		var_1_10007 = var_1_10007.GetBenefitCondition(var_1_10006.benefit_condition)
		assert = var_1_10008

		var_1_10008(var_1_10007[1] == "item")

		if var_1_10007[2] == arg_94_0 then
			return var_1_10006.id
		end
	end

	return
end

function var_0_1.GetActiveSPItemID(arg_95_0)
	Chapter = var_1_10001

	local var_95_0 = var_1_10001.GetSPOperationItemCacheKey(arg_95_0.id)

	PlayerPrefs = var_1_10002

	if var_1_10002.GetInt(var_95_0, 0) == 0 then
		return 0
	end

	local var_95_1 = arg_95_0

	if arg_95_0.GetRestDailyBonus(var_95_1) > 0 then
		return 0
	end

	local var_95_2 = arg_95_0:GetSpItems()

	_ = var_95_1

	if var_95_1.detect(var_95_2, function(arg_96_0)
		return arg_96_0:GetConfigID() == var_0
	end) then
		return var_2
	end

	return 0
end

function var_0_1.GetLimitOilCost(arg_97_0, arg_97_1, arg_97_2)
	if not arg_97_0:isLoop() then
		return 9999
	end

	local var_97_0

	if arg_97_1 then
		var_97_0 = 3

		goto label_97_0
	end

	pg = var_1_10004

	local var_97_1 = var_1_10004.expedition_data_template[arg_97_2].type

	ChapterConst = var_1_10006

	if var_97_1 ~= var_1_10006.ExpeditionTypeBoss then
		do
			local var_97_2 = var_4.type

			ChapterConst = var_6

			if var_97_2 == var_6.ExpeditionTypeMulBoss then
				var_97_0 = 2
			else
				var_97_0 = 1
			end

			local var_97_3
		end

		::label_97_0::

		if not arg_97_0:getConfig("use_oil_limit")[var_97_0] then
			var_97_3 = 9999
		end

		return var_97_3
	end
end

function var_0_1.IsRemaster(arg_98_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_98_0 = var_1_10001(var_1_10003)

	return var_1.getMapById(var_98_0, arg_98_0:getConfig("map")) and var_1:isRemaster()
end

function var_0_1.GetBindActID(arg_99_0)
	return arg_99_0:getConfig("act_id")
end

function var_0_1.GetMaxBattleCount(arg_100_0)
	local var_100_0 = 0

	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_100_1 = var_1_10002(var_1_10004)
	local var_100_2 = var_2.getMapById
	local var_100_3 = arg_100_0
	local var_100_4 = var_100_2(var_100_1, arg_100_0.getConfig(var_100_3, "map"))
	local var_100_5 = var_2.getMapType(var_100_4)

	Map = var_100_1

	if var_100_5 == var_100_1.ELITE then
		pg = var_100_5
		var_100_0 = var_100_5.gameset.hard_level_multiple_sorties_times.key_value
		math = var_3

		local var_100_6 = var_3.clamp
		local var_100_7 = var_100_0
		local var_100_8 = 0

		getProxy = var_100_3
		DailyLevelProxy = var_1_10009
		var_1_10009 = var_100_3(var_1_10009)
		var_100_0 = var_100_6(var_100_7, var_100_8, var_100_3.GetRestEliteCount(var_1_10009))
	elseif var_2:isRemaster() then
		pg = var_3
		var_100_0 = var_3.gameset.archives_level_multiple_sorties_times.key_value
		math = var_3

		local var_100_9 = var_3.clamp
		local var_100_10 = var_100_0
		local var_100_11 = 0

		getProxy = var_100_3
		ChapterProxy = var_1_10009
		var_100_0 = var_100_9(var_100_10, var_100_11, var_100_3(var_1_10009).remasterTickets)
	elseif var_2:isActivity() then
		pg = var_3
		var_100_0 = var_3.gameset.activity_level_multiple_sorties_times.key_value
	else
		pg = var_3
		var_100_0 = var_3.gameset.main_level_multiple_sorties_times.key_value
	end

	if arg_100_0:isTriesLimit() then
		local var_100_12 = arg_100_0:getConfig("count") - arg_100_0:getTodayDefeatCount()

		math = var_4
		var_100_0 = var_4.clamp(var_100_0, 0, var_100_12)
	end

	return var_100_0
end

function var_0_1.IsSupportSubmarineStage(arg_101_0)
	local var_101_0

	if arg_101_0:GetSupportFleetMaxCount() > 0 then
		tobool = var_1
		var_101_0 = var_1(arg_101_0:getConfigMiscArg("submarine_support"))
	else
		var_101_0 = false
	end

	if false then
		var_101_0 = true
	end

	return var_101_0
end

function var_0_1.IsFogStage(arg_102_0)
	tobool = var_1_10001

	return var_1_10001(arg_102_0:getConfigMiscArg("fog"))
end

return var_0_1
