local Chapter = class("Chapter", import(".BaseVO"))

Chapter.SelectFleet = 1
Chapter.CustomFleet = 2
Chapter.CHAPTER_STATE = {
	i18n("level_chapter_state_high_risk"),
	i18n("level_chapter_state_risk"),
	i18n("level_chapter_state_low_risk"),
	i18n("level_chapter_state_safety")
}

function Chapter:bindConfigTable()
	return pg.chapter_template
end

function Chapter:Ctor(arg_2_1)
	self.configId = arg_2_1.id
	self.id = self.configId
	self.active = false
	self.progress = defaultValue(arg_2_1.progress, 0)
	self.defeatCount = arg_2_1.defeat_count or 0
	self.passCount = arg_2_1.pass_count or 0
	self.todayDefeatCount = arg_2_1.today_defeat_count or 0

	local var_2_0 = {
		defaultValue(arg_2_1.kill_boss_count, 0),
		defaultValue(arg_2_1.kill_enemy_count, 0),
		defaultValue(arg_2_1.take_box_count, 0)
	}

	self.achieves = {}

	for iter_2_0 = 1, 3 do
		local var_2_1 = self:getConfig("star_require_" .. iter_2_0)

		if var_2_1 > 0 then
			table.insert(self.achieves, {
				type = var_2_1,
				config = self:getConfig("num_" .. iter_2_0),
				count = var_2_0[iter_2_0]
			})
		end
	end

	self.dropShipIdList = {}
	self.eliteFleetList = {
		[FleetType.Normal] = {},
		[FleetType.Submarine] = {},
		[FleetType.Support] = {}
	}
	self.loopFlag = 0

	return
end

function Chapter:getConfigMiscArg(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(noEmptyStr(self:getConfig("misc_arg")) or {}) do
		if arg_3_1 == iter_3_1[1] then
			return iter_3_1[2]
		end
	end

	return nil
end

function Chapter:BuildEliteFleetInfo()
	return {
		[FleetType.Normal] = Chapter.BuildEliteTeamInfo(self.main_team),
		[FleetType.Submarine] = Chapter.BuildEliteTeamInfo(self.submarine_team),
		[FleetType.Support] = Chapter.BuildEliteTeamInfo(self.support_team)
	}
end

function Chapter:BuildEliteTeamInfo()
	return underscore.map(self, function(arg_6_0)
		local var_6_0 = {
			[TeamType.FormShips] = underscore.to_array(arg_6_0.ship_list)
		}
		local var_6_1 = {}

		var_6_1[1] = arg_6_0.commander_main or 0
		var_6_1[2] = arg_6_0.commander_sub or 0
		var_6_0[TeamType.FormCommander] = var_6_1

		return var_6_0
	end)
end

function Chapter:PackEliteFleetInfo()
	return {
		id = 0,
		main_team = underscore.map(self[FleetType.Normal], function(arg_8_0)
			return Chapter.PackEliteTeamInfo(arg_8_0)
		end),
		submarine_team = underscore.map(self[FleetType.Submarine], function(arg_9_0)
			return Chapter.PackEliteTeamInfo(arg_9_0)
		end),
		support_team = underscore.map(self[FleetType.Support], function(arg_10_0)
			return Chapter.PackEliteTeamInfo(arg_10_0)
		end)
	}
end

function Chapter:PackEliteTeamInfo()
	local var_11_0 = {}

	var_11_0.id = self.id or 0
	var_11_0.ship_list = underscore.to_array(self[TeamType.FormShips])
	var_11_0.commander_main = self[TeamType.FormCommander][1]
	var_11_0.commander_sub = self[TeamType.FormCommander][2]

	return var_11_0
end

function Chapter:getMaxCount()
	local var_12_0 = self:getConfig("risk_levels")

	if #var_12_0 == 0 then
		return 0
	end

	return var_12_0[1][1]
end

function Chapter:hasMitigation()
	if not LOCK_MITIGATION then
		return self:getConfig("mitigation_level") > 0
	else
		return false
	end

	return
end

function Chapter:getRemainPassCount()
	return math.max(self:getMaxCount() - self.passCount, 0)
end

function Chapter:getRiskLevel()
	local var_15_0 = self:getRemainPassCount()

	for iter_15_0, iter_15_1 in ipairs((self:getConfig("risk_levels"))) do
		if var_15_0 <= iter_15_1[1] and var_15_0 >= iter_15_1[2] then
			return iter_15_0
		end
	end

	assert(false, "index can not be nil")

	return
end

function Chapter:getMitigationRate()
	return math.min(self.passCount, (self:getMaxCount())) * (LOCK_MITIGATION and 0 or self:getConfig("mitigation_rate"))
end

function Chapter:getRepressInfo()
	local var_17_0 = {
		repressMax = self:getMaxCount(),
		repressCount = self.passCount,
		repressReduce = self:getMitigationRate()
	}

	var_17_0.repressLevel = LOCK_MITIGATION and 0 or self:getRemainPassCount() > 0 and 0 or self:getConfig("mitigation_level") or 0
	var_17_0.repressEnemyHpRant = 1 - self:getStageCell(self.fleet.line.row, self.fleet.line.column).data / 16

	return var_17_0
end

function Chapter:getChapterState()
	local var_18_0 = self:getRiskLevel()

	assert(Chapter.CHAPTER_STATE[var_18_0], "state desc is nil")

	return Chapter.CHAPTER_STATE[var_18_0]
end

function Chapter:getPlayType()
	return self:getConfig("model")
end

function Chapter:isTypeDefence()
	return self:getPlayType() == ChapterConst.TypeDefence
end

function Chapter:IsSpChapter()
	return self:isTriesLimit()
end

function Chapter:IsEXChapter()
	return self:getPlayType() == ChapterConst.TypeExtra
end

function Chapter:getConfig(arg_23_1)
	if self:isLoop() then
		assert(pg.chapter_template_loop[self.id], "chapter_template_loop not exist: " .. self.id)

		if pg.chapter_template_loop[self.id][arg_23_1] ~= nil and pg.chapter_template_loop[self.id][arg_23_1] ~= "&&" then
			return pg.chapter_template_loop[self.id][arg_23_1]
		end

		if (arg_23_1 == "air_dominance" or arg_23_1 == "best_air_dominance") and pg.chapter_template_loop[self.id].air_dominance_loop_rate ~= nil then
			return math.floor(self:getConfigTable()[arg_23_1] * (pg.chapter_template_loop[self.id].air_dominance_loop_rate * 0.01))
		end
	end

	return Chapter.super.getConfig(self, arg_23_1)
end

function Chapter:existLoop()
	return pg.chapter_template_loop[self.id] ~= nil
end

function Chapter:canActivateLoop()
	return self.progress == 100
end

function Chapter:isLoop()
	return self.loopFlag == 1
end

function Chapter:existAmbush()
	return self:getConfig("is_ambush") == 1 or self:getConfig("is_air_attack") == 1
end

function Chapter:isUnlock()
	return self:IsCleanPrevChapter() and self:IsCleanPrevStory()
end

function Chapter:IsCleanPrevChapter()
	for iter_29_0, iter_29_1 in ipairs(self:getConfig("pre_chapter")) do
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

function Chapter:IsCleanPrevStory()
	local var_31_0 = self:getConfig("pre_story")

	if var_31_0 == 0 then
		return true
	end

	return getProxy(ChapterProxy):GetChapterItemById(var_31_0):isClear()
end

function Chapter:isPlayerLVUnlock()
	return getProxy(PlayerProxy):getRawData().level >= self:getConfig("unlocklevel")
end

function Chapter:isClear()
	return self.progress >= 100
end

function Chapter:ifNeedHide()
	if table.contains(pg.chapter_setting.all, self.id) and pg.chapter_setting[self.id].hide == 1 then
		return self:isClear()
	end

	return
end

function Chapter:existAchieve()
	return #self.achieves > 0
end

function Chapter:isAllAchieve()
	return _.all(self.achieves, function(arg_37_0)
		return ChapterConst.IsAchieved(arg_37_0)
	end)
end

function Chapter:GetFleetTypeByIndex()
	assert(self > 0)

	return switch(self, {
		[4] = function()
			return FleetType.Support, 1
		end,
		[3] = function()
			return FleetType.Submarine, 1
		end
	}, function()
		return FleetType.Normal, self
	end)
end

function Chapter:getEliteTeamByIndex(arg_42_1)
	local var_42_0, var_42_1 = Chapter.GetFleetTypeByIndex(arg_42_1)

	if not self.eliteFleetList[var_42_0][var_42_1] then
		for iter_42_0 = #self.eliteFleetList[var_42_0] + 1, var_42_1 do
			self.eliteFleetList[var_42_0][iter_42_0] = {
				id = 0,
				[TeamType.FormShips] = {},
				[TeamType.FormCommander] = {
					0,
					0
				}
			}
		end
	end

	return self.eliteFleetList[var_42_0][var_42_1], var_42_0
end

function Chapter:setEliteFleetByIndex(arg_43_1, arg_43_2)
	local var_43_0 = self:getEliteTeamByIndex(arg_43_1)

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

function Chapter:clearEliterFleetByIndex(arg_44_1)
	self:setEliteFleetByIndex(arg_44_1, {
		{
			TeamType.FormShips,
			{}
		}
	})

	return
end

function Chapter:wrapEliteFleet(arg_45_1)
	local var_45_0, var_45_1 = self:getEliteTeamByIndex(arg_45_1)
	local var_45_2 = {}

	for iter_45_0, iter_45_1 in pairs(var_45_0[TeamType.FormCommander]) do
		if iter_45_1 ~= 0 then
			table.insert(var_45_2, {
				pos = iter_45_0,
				id = iter_45_1
			})
		end
	end

	return TypedFleet.New({
		id = arg_45_1,
		fleetType = var_45_1,
		ship_list = underscore.to_array(var_45_0[TeamType.FormShips]),
		commanders = var_45_2
	})
end

function Chapter:getEliteFleetCommanders()
	self:EliteCommanderFilter()

	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs({
		{
			self:GetNomralFleetMaxCount(),
			0
		},
		{
			self:GetSubmarineFleetMaxCount(),
			2
		},
		{
			self:GetSupportFleetMaxCount(),
			3
		}
	}) do
		local var_46_1, var_46_2 = unpack(iter_46_1)

		for iter_46_2 = 1, var_46_1 do
			var_46_0[var_46_2 + iter_46_2] = underscore.to_array(self:getEliteTeamByIndex(var_46_2 + iter_46_2)[TeamType.FormCommander])
		end
	end

	return var_46_0
end

function Chapter:updateCommander(arg_47_1, arg_47_2, arg_47_3)
	self:setEliteFleetByIndex(arg_47_1, {
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

function Chapter:getEliteFleetList()
	self:EliteShipTypeFilter()

	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs({
		{
			self:GetNomralFleetMaxCount(),
			0
		},
		{
			self:GetSubmarineFleetMaxCount(),
			2
		},
		{
			self:GetSupportFleetMaxCount(),
			3
		}
	}) do
		local var_48_1, var_48_2 = unpack(iter_48_1)

		for iter_48_2 = 1, var_48_1 do
			var_48_0[var_48_2 + iter_48_2] = underscore.to_array(self:getEliteTeamByIndex(var_48_2 + iter_48_2)[TeamType.FormShips])
		end
	end

	return var_48_0
end

function Chapter:setEliteFleetList(arg_49_1)
	if not arg_49_1 then
		return
	end

	self.eliteFleetList = arg_49_1

	return
end

function Chapter:IsEliteFleetLegal()
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in ipairs({
		{
			self:GetNomralFleetMaxCount(),
			0,
			FleetType.Normal
		},
		{
			self:GetSubmarineFleetMaxCount(),
			2,
			FleetType.Submarine
		},
		{
			self:GetSupportFleetMaxCount(),
			3,
			FleetType.Support
		}
	}) do
		local var_50_1, var_50_2, var_50_3 = unpack(iter_50_1)

		for iter_50_2 = 1, var_50_1 do
			local var_50_4 = var_50_2 + iter_50_2
			local var_50_5, var_50_6 = self:singleEliteFleetVertify(var_50_2 + iter_50_2)

			if var_50_5 then
				var_50_0[var_50_3] = defaultValue(var_50_0[var_50_3], 0) + 1
			elseif var_50_6 == "empty" then
				-- block empty
			else
				local var_50_8 = switch(var_50_6, {
					inEvent = function()
						return i18n("elite_disable_ship_escort")
					end,
					teamCount = function()
						return i18n("elite_fleet_confirm", Fleet.DEFAULT_ELITE_NAME[var_50_4])
					end,
					typeLimitation = function()
						return i18n("elite_disable_formation_unsatisfied")
					end
				})

				return
			end
		end
	end

	local var_50_11

	if var_50_0 == 0 then
		local var_50_10 = i18n("elite_disable_no_fleet")

		do return end

		var_50_11 = 1
	end

	for iter_50_3, iter_50_4 in ipairs((self:IsPropertyLimitationSatisfy())) do
		var_50_11 = var_50_11 * iter_50_4
	end

	if var_50_11 ~= 1 then
		local var_50_13 = i18n("elite_disable_property_unsatisfied")

		return
	end

	return true
end

function Chapter:IsPropertyLimitationSatisfy()
	local var_54_0 = getProxy(BayProxy):getRawData()
	local var_54_1 = self:getConfig("property_limitation")
	local var_54_2 = {}

	for iter_54_0, iter_54_1 in ipairs(var_54_1) do
		var_54_2[iter_54_1[1]] = 0
	end

	local var_54_3 = self:getEliteFleetList()
	local var_54_4 = 0

	for iter_54_2 = 1, 2 do
		if not self:singleEliteFleetVertify(iter_54_2) then
			-- block empty
		else
			local var_54_5 = {}
			local var_54_6 = {}

			for iter_54_3, iter_54_4 in ipairs(var_54_1) do
				local var_54_7, var_54_8, var_54_9, var_54_10 = unpack(iter_54_4)

				if string.sub(var_54_7, 1, 5) == "fleet" then
					var_54_5[var_54_7] = 0
					var_54_6[var_54_7] = var_54_10
				end
			end

			for iter_54_5, iter_54_6 in ipairs(var_54_3[iter_54_2]) do
				var_54_4 = var_54_4 + 1

				local var_54_11 = intProperties(var_54_0[iter_54_6]:getProperties())

				for iter_54_7, iter_54_8 in pairs(var_54_2) do
					if string.sub(iter_54_7, 1, 5) == "fleet" then
						if iter_54_7 == "fleet_totle_level" then
							var_54_5[iter_54_7] = var_54_5[iter_54_7] + var_54_0[iter_54_6].level
						end
					else
						var_54_2[iter_54_7] = iter_54_7 == "level" and iter_54_8 + var_54_0[iter_54_6].level or iter_54_8 + var_54_11[iter_54_7]
					end
				end
			end

			for iter_54_9, iter_54_10 in pairs(var_54_5) do
				if iter_54_9 == "fleet_totle_level" and iter_54_10 > var_54_6[iter_54_9] then
					var_54_2[iter_54_9] = var_54_2[iter_54_9] + 1
				end
			end
		end
	end

	local var_54_12 = {}

	for iter_54_11, iter_54_12 in ipairs(var_54_1) do
		local var_54_13, var_54_14, var_54_15 = unpack(iter_54_12)

		if var_54_13 == "level" and var_54_4 > 0 then
			var_54_2[var_54_13] = math.ceil(var_54_2[var_54_13] / var_54_4)
		end

		var_54_12[iter_54_11] = AttributeType.EliteConditionCompare(var_54_14, var_54_2[var_54_13], var_54_15) and 1 or 0
	end

	return var_54_12, var_54_2
end

function Chapter:GetNomralFleetMaxCount()
	return self:getConfig("group_num")
end

function Chapter:GetSubmarineFleetMaxCount()
	return self:getConfig("submarine_num")
end

function Chapter:GetSupportFleetMaxCount()
	return self:getConfig("support_group_num")
end

function Chapter:EliteShipTypeFilter()
	if self:getConfig("type") == Chapter.SelectFleet then
		self.eliteFleetList[FleetType.Normal] = {}
		self.eliteFleetList[FleetType.Submarine] = {}
	else
		for iter_58_0 = self:GetNomralFleetMaxCount() + 1, #self.eliteFleetList[FleetType.Normal] do
			self.eliteFleetList[FleetType.Normal][iter_58_0] = nil
		end

		for iter_58_1 = self:GetSubmarineFleetMaxCount() + 1, #self.eliteFleetList[FleetType.Submarine] do
			self.eliteFleetList[FleetType.Submarine][iter_58_1] = nil
		end
	end

	for iter_58_2 = self:GetSupportFleetMaxCount() + 1, #self.eliteFleetList[FleetType.Support] do
		self.eliteFleetList[FleetType.Support][iter_58_2] = nil
	end

	local var_58_0 = getProxy(BayProxy):getRawData()

	local function var_58_1(arg_59_0)
		if not arg_59_0 then
			return
		end

		for iter_59_0 = #arg_59_0, 1, -1 do
			if var_58_0[arg_59_0[iter_59_0]] == nil then
				table.remove(arg_59_0, iter_59_0)
			end
		end

		return
	end

	for iter_58_3, iter_58_4 in ipairs(self.eliteFleetList) do
		for iter_58_5, iter_58_6 in ipairs(iter_58_4) do
			var_58_1(iter_58_6[TeamType.FormShips])
		end
	end

	local function var_58_2(arg_60_0, arg_60_1)
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

	local var_58_3 = self:getConfig("limitation")

	for iter_58_7, iter_58_8 in pairs(self.eliteFleetList) do
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

					var_58_2(var_61_0[1], var_58_3[iter_58_9][1])
					var_58_2(var_61_0[2], var_58_3[iter_58_9][2])

					iter_58_10[TeamType.FormShips] = table.mergeArray(var_61_0[1], var_61_0[2])

					return
				end,
				[FleetType.Submarine] = function()
					var_58_2(iter_58_10[TeamType.FormShips], {
						0,
						0,
						0
					})

					return
				end,
				[FleetType.Support] = function()
					var_58_2(iter_58_10[TeamType.FormShips], self:getConfigMiscArg("submarine_support") and {
						"qian",
						"qian",
						"qian"
					} or {
						"hang",
						"hang",
						"hang"
					})

					return
				end
			})
		end
	end

	return
end

function Chapter:EliteCommanderFilter()
	local var_66_0 = getProxy(CommanderProxy)

	for iter_66_0, iter_66_1 in pairs(self.eliteFleetList) do
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

function Chapter:singleEliteFleetVertify(arg_67_1)
	local var_67_0 = getProxy(BayProxy):getRawData()
	local var_67_1, var_67_2 = self:getEliteTeamByIndex(arg_67_1)

	if not var_67_1[TeamType.FormShips] or #var_67_1[TeamType.FormShips] == 0 then
		return false, "empty"
	end

	local var_67_3 = {
		[TeamType.Main] = 0,
		[TeamType.Vanguard] = 0,
		[TeamType.Submarine] = 0
	}
	local var_67_4 = {}

	for iter_67_0, iter_67_1 in ipairs(var_67_1[TeamType.FormShips]) do
		if var_67_0[iter_67_1] then
			if var_67_0[iter_67_1]:getFlag("inEvent") then
				return false, "inEvent"
			end

			local var_67_5 = var_67_0[iter_67_1]:getTeamType()

			var_67_3[var_67_5] = var_67_3[var_67_5] + 1
			var_67_4[#var_67_4 + 1] = var_67_0[iter_67_1]:getShipType()
		end
	end

	local var_67_6

	if var_67_2 == FleetType.Normal and (var_67_3[TeamType.Main] > TeamType.MainMax or var_67_3[TeamType.Vanguard] > TeamType.VanguardMax or var_67_3[TeamType.Main] * var_67_3[TeamType.Vanguard] == 0) then
		do return false, "teamCount" end

		var_67_6 = checkExist(self:getConfig("limitation"), {
			arg_67_1
		}) or {}
	end

	local var_67_7 = underscore(var_67_6):chain():flatten():filter(function(arg_68_0)
		return arg_68_0 ~= 0
	end):value()

	ChapterProxy.SortRecommendLimitation(var_67_7)

	local var_67_8 = 1

	while var_67_8 <= #var_67_4 do
		local var_67_9

		for iter_67_2, iter_67_3 in ipairs(var_67_7) do
			if ShipType.ContainInLimitBundle(iter_67_3, var_67_4[var_67_8]) then
				var_67_9 = iter_67_2

				break
			end
		end

		if var_67_9 then
			table.remove(var_67_7, var_67_9)

			var_67_8 = var_67_8 + 1
		else
			table.remove(var_67_4, var_67_8)
		end
	end

	if var_67_2 == FleetType.Normal then
		local var_67_10 = {}

		for iter_67_4, iter_67_5 in ipairs(var_67_4) do
			var_67_10[ShipType.GetTeamFromShipType(iter_67_5)] = true
		end

		for iter_67_6, iter_67_7 in ipairs({
			TeamType.Vanguard,
			TeamType.Main
		}) do
			var_67_10[iter_67_7] = var_67_10[iter_67_7] or underscore.all(var_67_7, function(arg_69_0)
				return underscore.all(ShipType.GetShipTypesFromLimit(arg_69_0), function(arg_70_0)
					return ShipType.GetTeamFromShipType(arg_70_0) ~= iter_67_7
				end)
			end)
		end

		if var_67_10[TeamType.Vanguard] and var_67_10[TeamType.Main] then
			return true
		else
			return false, "typeLimitation"
		end
	elseif #var_67_7 == 0 or #var_67_4 > 0 then
		return true
	else
		return false, "typeLimitation"
	end

	return
end

function Chapter:getSupportFleet()
	self:EliteShipTypeFilter()

	return underscore.to_array(self:getEliteTeamByIndex(4)[TeamType.FormShips])
end

function Chapter:activeAlways()
	if getProxy(ChapterProxy):getMapById(self:getConfig("map")):isActivity() then
		local var_72_0 = pg.activity_template[self:GetBindActID()]

		if type(var_72_0.config_client) == "table" then
			return table.contains(var_72_0.config_client.prevs or {}, self.id)
		end
	end

	return false
end

function Chapter:GetPrevChapterNames()
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in ipairs(self:getConfig("pre_chapter")) do
		if iter_73_1[1] ~= 0 then
			table.insert(var_73_0, self:bindConfigTable()[iter_73_1[1]].chapter_name)
		end
	end

	return var_73_0
end

function Chapter:CanQuickPlay()
	return pg.chapter_setting[self.id] and pg.chapter_setting[self.id].expedite > 0
end

function Chapter:GetQuickPlayFlag()
	return PlayerPrefs.GetInt("chapter_quickPlay_flag_" .. self.id, 0) == 1
end

function Chapter:writeDrops(arg_76_1)
	_.each(arg_76_1, function(arg_77_0)
		if arg_77_0.type == DROP_TYPE_SHIP and not table.contains(self.dropShipIdList, arg_77_0.id) then
			table.insert(self.dropShipIdList, arg_77_0.id)
		end

		return
	end)

	return
end

function Chapter:UpdateDropShipList(arg_78_1)
	for iter_78_0, iter_78_1 in ipairs(arg_78_1) do
		if not table.contains(self.dropShipIdList, iter_78_1) then
			table.insert(self.dropShipIdList, iter_78_1)
		end
	end

	return
end

function Chapter:GetDropShipList()
	return self.dropShipIdList
end

function Chapter:getOniChapterInfo()
	return pg.chapter_capture[self.id]
end

function Chapter:getBombChapterInfo()
	return pg.chapter_boom[self.id]
end

function Chapter:getNpcShipByType(arg_82_1)
	local var_82_0 = {}
	local var_82_1 = getProxy(TaskProxy)

	local function var_82_2(arg_83_0)
		if arg_83_0 == 0 then
			return true
		end

		local var_83_0 = var_82_1:getTaskVO(arg_83_0)

		return var_83_0 and not var_83_0:isFinish()
	end

	for iter_82_0, iter_82_1 in ipairs(self:getConfig("npc_data")) do
		if not arg_82_1 or arg_82_1 == pg.npc_squad_template[iter_82_1].type and var_82_2(pg.npc_squad_template[iter_82_1].task_id) then
			for iter_82_2, iter_82_3 in ipairs({
				"vanguard_list",
				"main_list"
			}) do
				for iter_82_4, iter_82_5 in ipairs(pg.npc_squad_template[iter_82_1][iter_82_3]) do
					table.insert(var_82_0, NpcShip.New({
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

function Chapter:getTodayDefeatCount()
	return getProxy(DailyLevelProxy):getChapterDefeatCount(self.configId)
end

function Chapter:isTriesLimit()
	local var_85_0 = self:getConfig("count")

	return var_85_0 and var_85_0 > 0
end

function Chapter:updateTodayDefeatCount()
	getProxy(DailyLevelProxy):updateChapterDefeatCount(self.configId)

	return
end

function Chapter:enoughTimes2Start()
	if self:isTriesLimit() then
		return self:getTodayDefeatCount() < self:getConfig("count")
	else
		return true
	end

	return
end

function Chapter:GetRestDailyBonus()
	local var_88_0 = 0

	if self:IsRemaster() then
		return var_88_0
	end

	for iter_88_0, iter_88_1 in ipairs((self:getConfig("boss_expedition_id"))) do
		var_88_0 = math.max(var_88_0, (pg.expedition_activity_template[iter_88_1] or nil) and (pg.expedition_activity_template[iter_88_1].bonus_time or 0))
	end

	if pg.chapter_defense[self.id] then
		var_88_0 = math.max(var_88_0, pg.chapter_defense[self.id].bonus_time or 0)
	end

	return (math.max(var_88_0 - self.todayDefeatCount, 0))
end

function Chapter:GetDailyBonusQuota()
	return self:GetRestDailyBonus() > 0
end

function Chapter:GetDailyBonusRate()
	local var_90_0 = 0

	for iter_90_0, iter_90_1 in ipairs((self:getConfig("boss_expedition_id"))) do
		var_90_0 = math.max(var_90_0, (pg.expedition_activity_template[iter_90_1] or nil) and (pg.expedition_activity_template[iter_90_1].bonus_rate or 0))
	end

	if pg.chapter_defense[self.id] then
		var_90_0 = math.max(var_90_0, pg.chapter_defense[self.id].bonus_rate or 0)
	end

	return var_90_0 > 0 and var_90_0 or nil
end

function Chapter:GetDailyBonusIconName()
	local var_91_0 = self:GetDailyBonusRate()

	return var_91_0 and "bonusX" .. tostring(var_91_0) or "bonusX5"
end

Chapter.OPERATION_BUFF_TYPE_COST = "more_oil"
Chapter.OPERATION_BUFF_TYPE_REWARD = "extra_drop"
Chapter.OPERATION_BUFF_TYPE_EXP = "chapter_up"
Chapter.OPERATION_BUFF_TYPE_DESC = "desc"

function Chapter:GetSPOperationItemCacheKey()
	return "specialOPItem_" .. self
end

function Chapter:GetSpItems()
	local var_93_0 = {}
	local var_93_1 = getProxy(BagProxy):getItemsByType(Item.SPECIAL_OPERATION_TICKET)
	local var_93_2 = noEmptyStr(self:getConfig("special_operation_list"))

	if not var_93_2 or not next(var_93_2) then
		return var_93_0
	end

	for iter_93_0, iter_93_1 in ipairs(var_93_2) do
		if pg.benefit_buff_template[iter_93_1] and pg.benefit_buff_template[iter_93_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			local var_93_3 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[iter_93_1].benefit_condition)

			for iter_93_2, iter_93_3 in ipairs(var_93_1) do
				assert(var_93_3[1] == "item")

				if var_93_3[2] == iter_93_3.configId then
					table.insert(var_93_0, iter_93_3)

					break
				end
			end
		end
	end

	return var_93_0
end

function Chapter:GetSPBuffByItem()
	for iter_94_0, iter_94_1 in ipairs(pg.benefit_buff_template.get_id_list_by_benefit_type[Chapter.OPERATION_BUFF_TYPE_DESC]) do
		local var_94_0 = pg.benefit_buff_template[iter_94_1]
		local var_94_1 = ActivityBuff.GetBenefitCondition(pg.benefit_buff_template[iter_94_1].benefit_condition)

		assert(var_94_1[1] == "item")

		if var_94_1[2] == self then
			return var_94_0.id
		end
	end

	return
end

function Chapter:GetActiveSPItemID()
	local var_95_0 = PlayerPrefs.GetInt(Chapter.GetSPOperationItemCacheKey(self.id), 0)

	if var_95_0 == 0 then
		return 0
	end

	if self:GetRestDailyBonus() > 0 then
		return 0
	end

	if _.detect(self:GetSpItems(), function(arg_96_0)
		return arg_96_0:GetConfigID() == var_95_0
	end) then
		return var_95_0
	end

	return 0
end

function Chapter:GetLimitOilCost(arg_97_1, arg_97_2)
	if not self:isLoop() then
		return 9999
	end

	return self:getConfig("use_oil_limit")[arg_97_1 and 3 or (pg.expedition_data_template[arg_97_2].type == ChapterConst.ExpeditionTypeBoss or pg.expedition_data_template[arg_97_2].type == ChapterConst.ExpeditionTypeMulBoss) and 2 or 1] or 9999
end

function Chapter:IsRemaster()
	local var_98_0 = getProxy(ChapterProxy):getMapById(self:getConfig("map"))

	return var_98_0 and var_98_0:isRemaster()
end

function Chapter:GetBindActID()
	return self:getConfig("act_id")
end

function Chapter:GetMaxBattleCount()
	local var_100_0 = 0
	local var_100_1 = getProxy(ChapterProxy):getMapById(self:getConfig("map"))

	if var_100_1:getMapType() == Map.ELITE then
		var_100_0 = pg.gameset.hard_level_multiple_sorties_times.key_value
		var_100_0 = math.clamp(pg.gameset.hard_level_multiple_sorties_times.key_value, 0, getProxy(DailyLevelProxy):GetRestEliteCount())
	elseif var_100_1:isRemaster() then
		var_100_0 = pg.gameset.archives_level_multiple_sorties_times.key_value
		var_100_0 = math.clamp(pg.gameset.archives_level_multiple_sorties_times.key_value, 0, getProxy(ChapterProxy).remasterTickets)
	else
		var_100_0 = var_100_1:isActivity() and pg.gameset.activity_level_multiple_sorties_times.key_value or pg.gameset.main_level_multiple_sorties_times.key_value
	end

	if self:isTriesLimit() then
		var_100_0 = math.clamp(var_100_0, 0, self:getConfig("count") - self:getTodayDefeatCount())
	end

	return var_100_0
end

function Chapter:IsSupportSubmarineStage()
	return self:GetSupportFleetMaxCount() > 0 and tobool(self:getConfigMiscArg("submarine_support"))
end

function Chapter:IsFogStage()
	return tobool(self:getConfigMiscArg("fog"))
end

return Chapter
