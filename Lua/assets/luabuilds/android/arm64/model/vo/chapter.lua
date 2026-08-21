local var_0_0 = class("Chapter", import(".BaseVO"))

var_0_0.SelectFleet = 1
var_0_0.CustomFleet = 2
var_0_0.CHAPTER_STATE = {
	i18n("level_chapter_state_high_risk"),
	i18n("level_chapter_state_risk"),
	i18n("level_chapter_state_low_risk"),
	i18n("level_chapter_state_safety")
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.chapter_template
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.configId = arg_2_1.id
	arg_2_0.id = arg_2_0.configId
	arg_2_0.active = false
	arg_2_0.progress = defaultValue(arg_2_1.progress, 0)
	arg_2_0.defeatCount = arg_2_1.defeat_count or 0
	arg_2_0.passCount = arg_2_1.pass_count or 0
	arg_2_0.todayDefeatCount = arg_2_1.today_defeat_count or 0

	local var_2_0 = {
		defaultValue(arg_2_1.kill_boss_count, 0),
		defaultValue(arg_2_1.kill_enemy_count, 0),
		defaultValue(arg_2_1.take_box_count, 0)
	}

	arg_2_0.achieves = {}

	for iter_2_0 = 1, 3 do
		local var_2_1 = arg_2_0:getConfig("star_require_" .. iter_2_0)

		if var_2_1 > 0 then
			table.insert(arg_2_0.achieves, {
				type = var_2_1,
				config = arg_2_0:getConfig("num_" .. iter_2_0),
				count = var_2_0[iter_2_0]
			})
		end
	end

	arg_2_0.dropShipIdList = {}
	arg_2_0.eliteFleetList = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {},
		[FleetType.Support] = {}
	}
	arg_2_0.loopFlag = 0

	return
end

function var_0_0.getConfigMiscArg(arg_3_0, arg_3_1)
	local var_3_0 = noEmptyStr(arg_3_0:getConfig("misc_arg")) or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if arg_3_1 == iter_3_1[1] then
			return iter_3_1[2]
		end
	end

	return nil
end

function var_0_0.BuildEliteFleetInfo(arg_4_0)
	return {
		[FleetType.Normal] = var_0_0.BuildEliteTeamInfo(arg_4_0.main_team),
		[FleetType.Submarine] = var_0_0.BuildEliteTeamInfo(arg_4_0.submarine_team),
		[FleetType.Support] = var_0_0.BuildEliteTeamInfo(arg_4_0.support_team)
	}
end

function var_0_0.BuildEliteTeamInfo(arg_5_0)
	return underscore.map(arg_5_0, function(arg_6_0)
		local var_6_0 = {
			[TeamType.FormShips] = underscore.to_array(arg_6_0.ship_list)
		}

		;({})[1] = arg_6_0.commander_main or 0
		;({})[2] = arg_6_0.commander_sub or 0
		var_6_0[TeamType.FormCommander] = {}

		return var_6_0
	end)
end

function var_0_0.PackEliteFleetInfo(arg_7_0)
	return {
		id = 0,
		main_team = underscore.map(arg_7_0[FleetType.Normal], function(arg_8_0)
			return var_0_0.PackEliteTeamInfo(arg_8_0)
		end),
		submarine_team = underscore.map(arg_7_0[FleetType.Submarine], function(arg_9_0)
			return var_0_0.PackEliteTeamInfo(arg_9_0)
		end),
		support_team = underscore.map(arg_7_0[FleetType.Support], function(arg_10_0)
			return var_0_0.PackEliteTeamInfo(arg_10_0)
		end)
	}
end

function var_0_0.PackEliteTeamInfo(arg_11_0)
	({}).id = arg_11_0.id or 0
	;({}).ship_list = underscore.to_array(arg_11_0[TeamType.FormShips])
	;({}).commander_main = arg_11_0[TeamType.FormCommander][1]
	;({}).commander_sub = arg_11_0[TeamType.FormCommander][2]

	return {}
end

function var_0_0.getMaxCount(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("risk_levels")

	if #var_12_0 == 0 then
		return 0
	end

	return var_12_0[1][1]
end

function var_0_0.hasMitigation(arg_13_0)
	if not LOCK_MITIGATION then
		return arg_13_0:getConfig("mitigation_level") > 0
	else
		return false
	end

	return
end

function var_0_0.getRemainPassCount(arg_14_0)
	return math.max(arg_14_0:getMaxCount() - arg_14_0.passCount, 0)
end

function var_0_0.getRiskLevel(arg_15_0)
	local var_15_0 = arg_15_0:getRemainPassCount()

	for iter_15_0, iter_15_1 in ipairs((arg_15_0:getConfig("risk_levels"))) do
		if var_15_0 <= iter_15_1[1] and var_15_0 >= iter_15_1[2] then
			return iter_15_0
		end
	end

	assert(false, "index can not be nil")

	return
end

function var_0_0.getMitigationRate(arg_16_0)
	return math.min(arg_16_0.passCount, (arg_16_0:getMaxCount())) * (LOCK_MITIGATION and 0 or arg_16_0:getConfig("mitigation_rate"))
end

function var_0_0.getRepressInfo(arg_17_0)
	local var_17_0 = {
		repressMax = arg_17_0:getMaxCount(),
		repressCount = arg_17_0.passCount,
		repressReduce = arg_17_0:getMitigationRate()
	}

	var_17_0.repressLevel = LOCK_MITIGATION and 0 or arg_17_0:getRemainPassCount() > 0 and 0 or arg_17_0:getConfig("mitigation_level") or 0
	var_17_0.repressEnemyHpRant = 1 - arg_17_0:getStageCell(arg_17_0.fleet.line.row, arg_17_0.fleet.line.column).data / 16

	return var_17_0
end

function var_0_0.getChapterState(arg_18_0)
	local var_18_0 = arg_18_0:getRiskLevel()

	assert(var_0_0.CHAPTER_STATE[var_18_0], "state desc is nil")

	return var_0_0.CHAPTER_STATE[var_18_0]
end

function var_0_0.getPlayType(arg_19_0)
	return arg_19_0:getConfig("model")
end

function var_0_0.isTypeDefence(arg_20_0)
	return arg_20_0:getPlayType() == ChapterConst.TypeDefence
end

function var_0_0.IsSpChapter(arg_21_0)
	return arg_21_0:isTriesLimit()
end

function var_0_0.IsEXChapter(arg_22_0)
	return arg_22_0:getPlayType() == ChapterConst.TypeExtra
end

function var_0_0.getConfig(arg_23_0, arg_23_1)
	if arg_23_0:isLoop() then
		assert(pg.chapter_template_loop[arg_23_0.id], "chapter_template_loop not exist: " .. arg_23_0.id)

		if pg.chapter_template_loop[arg_23_0.id][arg_23_1] ~= nil and pg.chapter_template_loop[arg_23_0.id][arg_23_1] ~= "&&" then
			return pg.chapter_template_loop[arg_23_0.id][arg_23_1]
		end

		if (arg_23_1 == "air_dominance" or arg_23_1 == "best_air_dominance") and pg.chapter_template_loop[arg_23_0.id].air_dominance_loop_rate ~= nil then
			return math.floor(arg_23_0:getConfigTable()[arg_23_1] * (pg.chapter_template_loop[arg_23_0.id].air_dominance_loop_rate * 0.01))
		end
	end

	return var_0_0.super.getConfig(arg_23_0, arg_23_1)
end

function var_0_0.existLoop(arg_24_0)
	return pg.chapter_template_loop[arg_24_0.id] ~= nil
end

function var_0_0.canActivateLoop(arg_25_0)
	return arg_25_0.progress == 100
end

function var_0_0.isLoop(arg_26_0)
	return arg_26_0.loopFlag == 1
end

function var_0_0.existAmbush(arg_27_0)
	return arg_27_0:getConfig("is_ambush") == 1 or arg_27_0:getConfig("is_air_attack") == 1
end

function var_0_0.isUnlock(arg_28_0)
	return arg_28_0:IsCleanPrevChapter() and arg_28_0:IsCleanPrevStory()
end

function var_0_0.IsCleanPrevChapter(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0:getConfig("pre_chapter")) do
		if _.all(iter_29_1, function(arg_30_0)
			if arg_30_0 == 0 then
				return true
			end

			return getProxy(ChapterProxy):GetChapterItemById(arg_30_0):isClear()
		end) then
			return true
		end
	end

	return false
end

function var_0_0.IsCleanPrevStory(arg_31_0)
	local var_31_0 = arg_31_0:getConfig("pre_story")

	if var_31_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_31_0):isClear()
end

function var_0_0.isPlayerLVUnlock(arg_32_0)
	local var_32_0 = getProxy(PlayerProxy)

	return var_32_0:getRawData().level >= arg_32_0:getConfig("unlocklevel")
end

function var_0_0.isClear(arg_33_0)
	return arg_33_0.progress >= 100
end

function var_0_0.ifNeedHide(arg_34_0)
	if table.contains(pg.chapter_setting.all, arg_34_0.id) and pg.chapter_setting[arg_34_0.id].hide == 1 then
		return arg_34_0:isClear()
	end

	return
end

function var_0_0.existAchieve(arg_35_0)
	return #arg_35_0.achieves > 0
end

function var_0_0.isAllAchieve(arg_36_0)
	return _.all(arg_36_0.achieves, function(arg_37_0)
		return ChapterConst.IsAchieved(arg_37_0)
	end)
end

function var_0_0.GetFleetTypeByIndex(arg_38_0)
	assert(arg_38_0 > 0)

	return switch(arg_38_0, {
		[4] = function()
			return FleetType.Support, 1
		end,
		[3] = function()
			return FleetType.Submarine, 1
		end
	}, function()
		return FleetType.Normal, arg_38_0
	end)
end

function var_0_0.getEliteTeamByIndex(arg_42_0, arg_42_1)
	local var_42_0, var_42_1 = var_0_0.GetFleetTypeByIndex(arg_42_1)

	if not arg_42_0.eliteFleetList[var_42_0][var_42_1] then
		for iter_42_0 = #arg_42_0.eliteFleetList[var_42_0] + 1, var_42_1 do
			arg_42_0.eliteFleetList[var_42_0][iter_42_0] = {
				id = 0,
				[TeamType.FormShips] = {},
				[TeamType.FormCommander] = {
					0,
					0
				}
			}
		end
	end

	return arg_42_0.eliteFleetList[var_42_0][var_42_1], var_42_0
end

function var_0_0.setEliteFleetByIndex(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:getEliteTeamByIndex(arg_43_1)

	for iter_43_0, iter_43_1 in ipairs(arg_43_2) do
		local var_43_1, var_43_2 = unpack(iter_43_1)

		if var_43_1 == TeamType.FormCommander then
			var_43_0[var_43_1][var_43_2.pos] = var_43_2.id
		else
			var_43_0[var_43_1] = var_43_2
		end
	end

	return
end

function var_0_0.clearEliterFleetByIndex(arg_44_0, arg_44_1)
	arg_44_0:setEliteFleetByIndex(arg_44_1, {
		{
			TeamType.FormShips,
			{}
		}
	})

	return
end

function var_0_0.wrapEliteFleet(arg_45_0, arg_45_1)
	local var_45_0, var_45_1 = arg_45_0:getEliteTeamByIndex(arg_45_1)

	for iter_45_0, iter_45_1 in pairs(var_45_0[TeamType.FormCommander]) do
		if iter_45_1 ~= 0 then
			table.insert({}, {
				pos = iter_45_0,
				id = iter_45_1
			})
		end
	end

	return TypedFleet.New({
		id = arg_45_1,
		fleetType = var_45_1,
		ship_list = underscore.to_array(var_45_0[TeamType.FormShips]),
		commanders = {}
	})
end

function var_0_0.getEliteFleetCommanders(arg_46_0)
	arg_46_0:EliteCommanderFilter()

	for iter_46_0, iter_46_1 in ipairs({
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
		local var_46_0, var_46_1 = unpack(iter_46_1)

		for iter_46_2 = 1, var_46_0 do
			({})[var_46_1 + iter_46_2] = underscore.to_array(arg_46_0:getEliteTeamByIndex(var_46_1 + iter_46_2)[TeamType.FormCommander])
		end
	end

	return {}
end

function var_0_0.updateCommander(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0:setEliteFleetByIndex(arg_47_1, {
		{
			TeamType.FormCommander,
			{
				pos = arg_47_2,
				id = arg_47_3
			}
		}
	})

	return
end

function var_0_0.getEliteFleetList(arg_48_0)
	arg_48_0:EliteShipTypeFilter()

	for iter_48_0, iter_48_1 in ipairs({
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
		local var_48_0, var_48_1 = unpack(iter_48_1)

		for iter_48_2 = 1, var_48_0 do
			({})[var_48_1 + iter_48_2] = underscore.to_array(arg_48_0:getEliteTeamByIndex(var_48_1 + iter_48_2)[TeamType.FormShips])
		end
	end

	return {}
end

function var_0_0.setEliteFleetList(arg_49_0, arg_49_1)
	if not arg_49_1 then
		return
	end

	arg_49_0.eliteFleetList = arg_49_1

	return
end

function var_0_0.IsEliteFleetLegal(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs({
		{
			arg_50_0:GetNomralFleetMaxCount(),
			0,
			FleetType.Normal
		},
		{
			arg_50_0:GetSubmarineFleetMaxCount(),
			2,
			FleetType.Submarine
		},
		{
			arg_50_0:GetSupportFleetMaxCount(),
			3,
			FleetType.Support
		}
	}) do
		local var_50_0, var_50_1, var_50_2 = unpack(iter_50_1)

		for iter_50_2 = 1, var_50_0 do
			local var_50_3, var_50_4 = arg_50_0:singleEliteFleetVertify(var_50_1 + iter_50_2)

			if var_50_3 then
				({})[var_50_2] = defaultValue(({})[var_50_2], 0) + 1
			elseif var_50_4 == "empty" then
				-- block empty
			else
				local var_50_6 = switch(var_50_4, {
					inEvent = function()
						return i18n("elite_disable_ship_escort")
					end,
					teamCount = function()
						return i18n("elite_fleet_confirm", Fleet.DEFAULT_ELITE_NAME[var_0])
					end,
					typeLimitation = function()
						return i18n("elite_disable_formation_unsatisfied")
					end
				})

				return
			end
		end
	end

	local var_50_9

	if {} == 0 then
		local var_50_8 = i18n("elite_disable_no_fleet")

		do return end

		var_50_9 = 1
	end

	for iter_50_3, iter_50_4 in ipairs((arg_50_0:IsPropertyLimitationSatisfy())) do
		var_50_9 = var_50_9 * iter_50_4
	end

	if var_50_9 ~= 1 then
		local var_50_11 = i18n("elite_disable_property_unsatisfied")

		return
	end

	return true
end

function var_0_0.IsPropertyLimitationSatisfy(arg_54_0)
	local var_54_0 = getProxy(BayProxy):getRawData()
	local var_54_1 = arg_54_0:getConfig("property_limitation")
	local var_54_2 = {}

	for iter_54_0, iter_54_1 in ipairs(var_54_1) do
		var_54_2[iter_54_1[1]] = 0
	end

	local var_54_3 = arg_54_0:getEliteFleetList()
	local var_54_4 = 0

	for iter_54_2 = 1, 2 do
		if not arg_54_0:singleEliteFleetVertify(iter_54_2) then
			-- block empty
		else
			local var_54_5 = {}

			for iter_54_3, iter_54_4 in ipairs(var_54_1) do
				local var_54_6, var_54_7, var_54_8, var_54_9 = unpack(iter_54_4)

				if string.sub(var_54_6, 1, 5) == "fleet" then
					var_54_5[var_54_6] = 0
					;({})[var_54_6] = var_54_9
				end
			end

			for iter_54_5, iter_54_6 in ipairs(var_54_3[iter_54_2]) do
				var_54_4 = var_54_4 + 1

				local var_54_10 = intProperties(var_54_0[iter_54_6]:getProperties())

				for iter_54_7, iter_54_8 in pairs(var_54_2) do
					if string.sub(iter_54_7, 1, 5) == "fleet" then
						if iter_54_7 == "fleet_totle_level" then
							var_54_5[iter_54_7] = var_54_5[iter_54_7] + var_54_0[iter_54_6].level
						end
					else
						var_54_2[iter_54_7] = iter_54_7 == "level" and iter_54_8 + var_54_0[iter_54_6].level or iter_54_8 + var_54_10[iter_54_7]
					end
				end
			end

			for iter_54_9, iter_54_10 in pairs(var_54_5) do
				if iter_54_9 == "fleet_totle_level" and iter_54_10 > ({})[iter_54_9] then
					var_54_2[iter_54_9] = var_54_2[iter_54_9] + 1
				end
			end
		end
	end

	local var_54_11 = {}

	for iter_54_11, iter_54_12 in ipairs(var_54_1) do
		local var_54_12, var_54_13, var_54_14 = unpack(iter_54_12)

		if var_54_12 == "level" and var_54_4 > 0 then
			var_54_2[var_54_12] = math.ceil(var_54_2[var_54_12] / var_54_4)
		end

		var_54_11[iter_54_11] = AttributeType.EliteConditionCompare(var_54_13, var_54_2[var_54_12], var_54_14) and 1 or 0
	end

	return var_54_11, var_54_2
end

function var_0_0.GetNomralFleetMaxCount(arg_55_0)
	return arg_55_0:getConfig("group_num")
end

function var_0_0.GetSubmarineFleetMaxCount(arg_56_0)
	return arg_56_0:getConfig("submarine_num")
end

function var_0_0.GetSupportFleetMaxCount(arg_57_0)
	return arg_57_0:getConfig("support_group_num")
end

function var_0_0.EliteShipTypeFilter(arg_58_0)
	if arg_58_0:getConfig("type") == Chapter.SelectFleet then
		arg_58_0.eliteFleetList[FleetType.Normal] = {}
		arg_58_0.eliteFleetList[FleetType.Submarine] = {}
	else
		for iter_58_0 = arg_58_0:GetNomralFleetMaxCount() + 1, #arg_58_0.eliteFleetList[FleetType.Normal] do
			arg_58_0.eliteFleetList[FleetType.Normal][iter_58_0] = nil
		end

		for iter_58_1 = arg_58_0:GetSubmarineFleetMaxCount() + 1, #arg_58_0.eliteFleetList[FleetType.Submarine] do
			arg_58_0.eliteFleetList[FleetType.Submarine][iter_58_1] = nil
		end
	end

	for iter_58_2 = arg_58_0:GetSupportFleetMaxCount() + 1, #arg_58_0.eliteFleetList[FleetType.Support] do
		arg_58_0.eliteFleetList[FleetType.Support][iter_58_2] = nil
	end

	local var_58_0 = getProxy(BayProxy):getRawData()

	for iter_58_3, iter_58_4 in ipairs(arg_58_0.eliteFleetList) do
		for iter_58_5, iter_58_6 in ipairs(iter_58_4) do
			(function(arg_59_0)
				if not arg_59_0 then
					return
				end

				for iter_59_0 = #arg_59_0, 1, -1 do
					if var_58_0[arg_59_0[iter_59_0]] == nil then
						table.remove(arg_59_0, iter_59_0)
					end
				end

				return
			end)(iter_58_6[TeamType.FormShips])
		end
	end

	local function var_58_1(arg_60_0, arg_60_1)
		arg_60_1 = Clone(arg_60_1)

		ChapterProxy.SortRecommendLimitation(arg_60_1)

		local var_60_0 = 1

		while var_60_0 <= #arg_60_0 do
			local var_60_1
			local var_60_2 = var_58_0[arg_60_0[var_60_0]]:getShipType()

			for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
				if ShipType.ContainInLimitBundle(iter_60_1, var_60_2) then
					var_60_1 = iter_60_0

					break
				end
			end

			if var_60_1 then
				table.remove(arg_60_1, var_60_1)

				var_60_0 = var_60_0 + 1
			else
				table.remove(arg_60_0, var_60_0)
			end
		end

		return
	end

	local var_58_2 = arg_58_0:getConfig("limitation")

	for iter_58_7, iter_58_8 in pairs(arg_58_0.eliteFleetList) do
		for iter_58_9, iter_58_10 in ipairs(iter_58_8) do
			switch(iter_58_7, {
				[FleetType.Normal] = function()
					local var_61_0 = underscore.map({
						TeamType.Main,
						TeamType.Vanguard
					}, function(arg_62_0)
						return underscore.filter(iter_58_10[TeamType.FormShips], function(arg_63_0)
							return var_58_0[arg_63_0]:getTeamType() == arg_62_0
						end)
					end)

					var_58_1(var_61_0[1], var_58_2[iter_58_9][1])
					var_58_1(var_61_0[2], var_58_2[iter_58_9][2])

					iter_58_10[TeamType.FormShips] = table.mergeArray(var_61_0[1], var_61_0[2])

					return
				end,
				[FleetType.Submarine] = function()
					var_58_1(iter_58_10[TeamType.FormShips], {
						0,
						0,
						0
					})

					return
				end,
				[FleetType.Support] = function()
					if arg_58_0:getConfigMiscArg("submarine_support") then
						local var_65_0 = {
							"qian",
							"qian",
							"qian"
						}

						if not {
							"qian",
							"qian",
							"qian"
						} then
							var_65_0 = {
								"hang",
								"hang",
								"hang"
							}
						end

						var_58_1(iter_58_10[TeamType.FormShips], var_65_0)

						return
					end
				end
			})
		end
	end

	return
end

function var_0_0.EliteCommanderFilter(arg_66_0)
	local var_66_0 = getProxy(CommanderProxy)

	for iter_66_0, iter_66_1 in pairs(arg_66_0.eliteFleetList) do
		for iter_66_2, iter_66_3 in ipairs(iter_66_1) do
			for iter_66_4, iter_66_5 in ipairs(iter_66_3[TeamType.FormCommander]) do
				if iter_66_5 ~= 0 and not var_66_0:RawGetCommanderById(iter_66_5) then
					iter_66_3[TeamType.FormCommander][iter_66_4] = 0
				end
			end
		end
	end

	return
end

function var_0_0.singleEliteFleetVertify(arg_67_0, arg_67_1)
	local var_67_0 = getProxy(BayProxy):getRawData()
	local var_67_1, var_67_2 = arg_67_0:getEliteTeamByIndex(arg_67_1)

	if not var_67_1[TeamType.FormShips] or #var_67_1[TeamType.FormShips] == 0 then
		return false, "empty"
	end

	local var_67_3 = {
		[TeamType.Main] = 0,
		[TeamType.Vanguard] = 0,
		[TeamType.Submarine] = 0
	}

	for iter_67_0, iter_67_1 in ipairs(var_67_1[TeamType.FormShips]) do
		if var_67_0[iter_67_1] then
			if var_67_0[iter_67_1]:getFlag("inEvent") then
				return false, "inEvent"
			end

			local var_67_4 = var_67_0[iter_67_1]:getTeamType()

			var_67_3[var_67_4] = var_67_3[var_67_4] + 1
			;({})[#{} + 1] = var_67_0[iter_67_1]:getShipType()
		end
	end

	local var_67_5

	if var_67_2 == FleetType.Normal and (var_67_3[TeamType.Main] > TeamType.MainMax or var_67_3[TeamType.Vanguard] > TeamType.VanguardMax or var_67_3[TeamType.Main] * var_67_3[TeamType.Vanguard] == 0) then
		do return false, "teamCount" end

		var_67_5 = checkExist(arg_67_0:getConfig("limitation"), {
			arg_67_1
		}) or {}
	end

	local var_67_6 = underscore(var_67_5):chain():flatten():filter(function(arg_68_0)
		return arg_68_0 ~= 0
	end):value()

	ChapterProxy.SortRecommendLimitation(var_67_6)

	local var_67_7 = 1

	while var_67_7 <= #{} do
		local var_67_8

		for iter_67_2, iter_67_3 in ipairs(var_67_6) do
			if ShipType.ContainInLimitBundle(iter_67_3, ({})[var_67_7]) then
				var_67_8 = iter_67_2

				break
			end
		end

		if var_67_8 then
			table.remove(var_67_6, var_67_8)

			var_67_7 = var_67_7 + 1
		else
			table.remove({}, var_67_7)
		end
	end

	if var_67_2 == FleetType.Normal then
		for iter_67_4, iter_67_5 in ipairs({}) do
			({})[ShipType.GetTeamFromShipType(iter_67_5)] = true
		end

		for iter_67_6, iter_67_7 in ipairs({
			TeamType.Vanguard,
			TeamType.Main
		}) do
			local var_67_9 = ({})[iter_67_7]

			if not ({})[iter_67_7] then
				var_67_9 = underscore.all(var_67_6, function(arg_69_0)
					return underscore.all(ShipType.GetShipTypesFromLimit(arg_69_0), function(arg_70_0)
						return ShipType.GetTeamFromShipType(arg_70_0) ~= iter_67_7
					end)
				end)
			end

			;({})[iter_67_7] = var_67_9
		end

		if ({})[TeamType.Vanguard] and ({})[TeamType.Main] then
			return true
		else
			return false, "typeLimitation"
		end
	elseif #var_67_6 == 0 or #{} > 0 then
		return true
	else
		return false, "typeLimitation"
	end

	return
end

function var_0_0.getSupportFleet(arg_71_0)
	arg_71_0:EliteShipTypeFilter()

	return underscore.to_array(arg_71_0:getEliteTeamByIndex(4)[TeamType.FormShips])
end

function var_0_0.activeAlways(arg_72_0)
	if getProxy(ChapterProxy):getMapById(arg_72_0:getConfig("map")):isActivity() then
		local var_72_0 = pg.activity_template[arg_72_0:GetBindActID()]

		if type(var_72_0.config_client) == "table" then
			local var_72_1 = var_72_0.config_client.prevs or {}

			return table.contains(var_72_1, arg_72_0.id)
		end
	end

	return false
end

function var_0_0.GetPrevChapterNames(arg_73_0)
	for iter_73_0, iter_73_1 in ipairs(arg_73_0:getConfig("pre_chapter")) do
		if iter_73_1[1] ~= 0 then
			table.insert({}, arg_73_0:bindConfigTable()[iter_73_1[1]].chapter_name)
		end
	end

	return {}
end

function var_0_0.CanQuickPlay(arg_74_0)
	return pg.chapter_setting[arg_74_0.id] and pg.chapter_setting[arg_74_0.id].expedite > 0
end

function var_0_0.GetQuickPlayFlag(arg_75_0)
	return PlayerPrefs.GetInt("chapter_quickPlay_flag_" .. arg_75_0.id, 0) == 1
end

function var_0_0.writeDrops(arg_76_0, arg_76_1)
	_.each(arg_76_1, function(arg_77_0)
		if arg_77_0.type == DROP_TYPE_SHIP and not table.contains(arg_76_0.dropShipIdList, arg_77_0.id) then
			table.insert(arg_76_0.dropShipIdList, arg_77_0.id)
		end

		return
	end)

	return
end

function var_0_0.UpdateDropShipList(arg_78_0, arg_78_1)
	for iter_78_0, iter_78_1 in ipairs(arg_78_1) do
		if not table.contains(arg_78_0.dropShipIdList, iter_78_1) then
			table.insert(arg_78_0.dropShipIdList, iter_78_1)
		end
	end

	return
end

function var_0_0.GetDropShipList(arg_79_0)
	return arg_79_0.dropShipIdList
end

function var_0_0.getOniChapterInfo(arg_80_0)
	return pg.chapter_capture[arg_80_0.id]
end

function var_0_0.getBombChapterInfo(arg_81_0)
	return pg.chapter_boom[arg_81_0.id]
end

function var_0_0.getNpcShipByType(arg_82_0, arg_82_1)
	local var_82_0 = getProxy(TaskProxy)

	for iter_82_0, iter_82_1 in ipairs(arg_82_0:getConfig("npc_data")) do
		if not arg_82_1 or arg_82_1 == pg.npc_squad_template[iter_82_1].type and (function(arg_83_0)
			if arg_83_0 == 0 then
				return true
			end

			local var_83_0 = var_82_0:getTaskVO(arg_83_0)

			return var_83_0 and not var_83_0:isFinish()
		end)(pg.npc_squad_template[iter_82_1].task_id) then
			for iter_82_2, iter_82_3 in ipairs({
				"vanguard_list",
				"main_list"
			}) do
				for iter_82_4, iter_82_5 in ipairs(pg.npc_squad_template[iter_82_1][iter_82_3]) do
					table.insert({}, NpcShip.New({
						id = iter_82_5[1],
						configId = iter_82_5[1],
						level = iter_82_5[2]
					}))
				end
			end
		end
	end

	return {}
end

function var_0_0.getTodayDefeatCount(arg_84_0)
	return getProxy(DailyLevelProxy):getChapterDefeatCount(arg_84_0.configId)
end

function var_0_0.isTriesLimit(arg_85_0)
	local var_85_0 = arg_85_0:getConfig("count")

	return var_85_0 and var_85_0 > 0
end

function var_0_0.updateTodayDefeatCount(arg_86_0)
	getProxy(DailyLevelProxy):updateChapterDefeatCount(arg_86_0.configId)

	return
end

function var_0_0.enoughTimes2Start(arg_87_0)
	if arg_87_0:isTriesLimit() then
		return arg_87_0:getTodayDefeatCount() < arg_87_0:getConfig("count")
	else
		return true
	end

	return
end

function var_0_0.GetRestDailyBonus(arg_88_0)
	local var_88_0 = 0

	if arg_88_0:IsRemaster() then
		return var_88_0
	end

	for iter_88_0, iter_88_1 in ipairs((arg_88_0:getConfig("boss_expedition_id"))) do
		local var_88_2 = var_88_0

		if pg.expedition_activity_template[iter_88_1] then
			local var_88_3 = pg.expedition_activity_template[iter_88_1].bonus_time or 0

			var_88_0 = var_88_1(var_88_2, var_88_3)
		end
	end

	if pg.chapter_defense[arg_88_0.id] then
		local var_88_4 = pg.chapter_defense[arg_88_0.id].bonus_time or 0

		var_88_0 = math.max(var_88_0, var_88_4)
	end

	return (math.max(var_88_0 - arg_88_0.todayDefeatCount, 0))
end

function var_0_0.GetDailyBonusQuota(arg_89_0)
	return arg_89_0:GetRestDailyBonus() > 0
end

function var_0_0.GetDailyBonusRate(arg_90_0)
	local var_90_0 = 0

	for iter_90_0, iter_90_1 in ipairs((arg_90_0:getConfig("boss_expedition_id"))) do
		local var_90_2 = var_90_0

		if pg.expedition_activity_template[iter_90_1] then
			local var_90_3 = pg.expedition_activity_template[iter_90_1].bonus_rate or 0

			var_90_0 = var_90_1(var_90_2, var_90_3)
		end
	end

	if pg.chapter_defense[arg_90_0.id] then
		local var_90_4 = pg.chapter_defense[arg_90_0.id].bonus_rate or 0

		var_90_0 = math.max(var_90_0, var_90_4)
	end

	return var_90_0 > 0 and var_90_0 or nil
end

function var_0_0.GetDailyBonusIconName(arg_91_0)
	local var_91_0 = arg_91_0:GetDailyBonusRate()

	return var_91_0 and "bonusX" .. tostring(var_91_0) or "bonusX5"
end

var_0_0.OPERATION_BUFF_TYPE_COST = "more_oil"
var_0_0.OPERATION_BUFF_TYPE_REWARD = "extra_drop"
var_0_0.OPERATION_BUFF_TYPE_EXP = "chapter_up"
var_0_0.OPERATION_BUFF_TYPE_DESC = "desc"

function var_0_0.GetSPOperationItemCacheKey(arg_92_0)
	return "specialOPItem_" .. arg_92_0
end

function var_0_0.GetSpItems(arg_93_0)
	local var_93_0 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)
	local var_93_1 = noEmptyStr(arg_93_0:getConfig("special_operation_list"))

	if not var_93_1 or not next(var_93_1) then
		return {}
	end

	for iter_93_0, iter_93_1 in ipairs(var_93_1) do
		if pg.benefit_buff_template[iter_93_1] and pg.benefit_buff_template[iter_93_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			local var_93_2 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[iter_93_1].benefit_condition)

			for iter_93_2, iter_93_3 in ipairs(var_93_0) do
				assert(var_93_2[1] == "item")

				if var_93_2[2] == iter_93_3.configId then
					table.insert({}, iter_93_3)

					break
				end
			end
		end
	end

	return {}
end

function var_0_0.GetSPBuffByItem(arg_94_0)
	for iter_94_0, iter_94_1 in ipairs(pg.benefit_buff_template.get_id_list_by_benefit_type[Chapter.OPERATION_BUFF_TYPE_DESC]) do
		local var_94_0 = pg.benefit_buff_template[iter_94_1]
		local var_94_1 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[iter_94_1].benefit_condition)

		assert(var_94_1[1] == "item")

		if var_94_1[2] == arg_94_0 then
			return var_94_0.id
		end
	end

	return
end

function var_0_0.GetActiveSPItemID(arg_95_0)
	local var_95_0 = PlayerPrefs.GetInt(Chapter.GetSPOperationItemCacheKey(arg_95_0.id), 0)

	if var_95_0 == 0 then
		return 0
	end

	if arg_95_0:GetRestDailyBonus() > 0 then
		return 0
	end

	if _.detect(arg_95_0:GetSpItems(), function(arg_96_0)
		return arg_96_0:GetConfigID() == var_95_0
	end) then
		return var_95_0
	end

	return 0
end

function var_0_0.GetLimitOilCost(arg_97_0, arg_97_1, arg_97_2)
	if not arg_97_0:isLoop() then
		return 9999
	end

	local var_97_1

	if arg_97_1 then
		var_97_1 = 3
	else
		local var_97_2 = pg.expedition_data_template[arg_97_2]

		var_97_1 = (pg.expedition_data_template[arg_97_2].type == ChapterConst.ExpeditionTypeBoss or var_97_2.type == ChapterConst.ExpeditionTypeMulBoss) and 2 or 1
	end

	return arg_97_0:getConfig("use_oil_limit")[var_97_1] or 9999
end

function var_0_0.IsRemaster(arg_98_0)
	local var_98_0 = getProxy(ChapterProxy):getMapById(arg_98_0:getConfig("map"))

	return var_98_0 and var_98_0:isRemaster()
end

function var_0_0.GetBindActID(arg_99_0)
	return arg_99_0:getConfig("act_id")
end

function var_0_0.GetMaxBattleCount(arg_100_0)
	local var_100_0 = 0
	local var_100_1 = getProxy(ChapterProxy):getMapById(arg_100_0:getConfig("map"))

	if var_100_1:getMapType() == Map.ELITE then
		var_100_0 = pg.gameset.hard_level_multiple_sorties_times.key_value
		var_100_0 = math.clamp(pg.gameset.hard_level_multiple_sorties_times.key_value, 0, getProxy(DailyLevelProxy):GetRestEliteCount())
	elseif var_100_1:isRemaster() then
		var_100_0 = pg.gameset.archives_level_multiple_sorties_times.key_value
		var_100_0 = math.clamp(pg.gameset.archives_level_multiple_sorties_times.key_value, 0, getProxy(ChapterProxy).remasterTickets)
	else
		var_100_0 = var_100_1:isActivity() and pg.gameset.activity_level_multiple_sorties_times.key_value or pg.gameset.main_level_multiple_sorties_times.key_value
	end

	if arg_100_0:isTriesLimit() then
		var_100_0 = math.clamp(var_100_0, 0, arg_100_0:getConfig("count") - arg_100_0:getTodayDefeatCount())
	end

	return var_100_0
end

function var_0_0.IsSupportSubmarineStage(arg_101_0)
	return arg_101_0:GetSupportFleetMaxCount() > 0 and tobool(arg_101_0:getConfigMiscArg("submarine_support"))
end

function var_0_0.IsFogStage(arg_102_0)
	return tobool(arg_102_0:getConfigMiscArg("fog"))
end

return var_0_0
