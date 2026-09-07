local NewEducateChar = class("NewEducateChar", import("model.vo.BaseVO"))

NewEducateChar.RES_TYPE = {
	REFRESH_SHOP = 5,
	ACTION = 3,
	MONEY = 1,
	MOOD = 2,
	FAVOR = 4,
	REFRESH_CHOICE = 6
}
NewEducateChar.ATTR_TYPE = {
	ATTR = 1,
	PERSONALITY = 2
}
NewEducateChar.DIFFICULTY = {
	EASY = 0,
	HARD = 1
}

function NewEducateChar:bindConfigTable()
	return pg.child2_data
end

function NewEducateChar:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.difficulty = arg_2_1.difficulty or NewEducateChar.DIFFICULTY.EASY
	self.roundData = NewEducateRound.New(arg_2_1)

	self:SetResources(arg_2_1.res.resource)
	self:SetAttrs(arg_2_1.res.attrs)

	self.group2Plan = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.plan.plan_upgrade or {}) do
		self.group2Plan[pg.child2_plan[iter_2_1].group_id] = iter_2_1
	end

	self:InitSiteData(arg_2_1.site)

	self.assessRecords = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.evaluations) do
		self.assessRecords[iter_2_3.key] = iter_2_3.value
	end

	self.callName = arg_2_1.name or ""
	self.gotFavorLv = arg_2_1.favor_lv or 0
	self.benefitData = NewEducateBenefit.New(arg_2_1.benefit, arg_2_1.display)

	self:BuildSiteIdMap()

	return
end

function NewEducateChar:InitPermanent(arg_3_1)
	self.permanentData = NewEducatePermanent.New(self.id, arg_3_1)

	return
end

function NewEducateChar:SetPermanent(arg_4_1)
	self.permanentData = arg_4_1

	return
end

function NewEducateChar:GetPermanentData()
	return self.permanentData
end

function NewEducateChar:GetGameCnt()
	return self.permanentData:GetGameCnt()
end

function NewEducateChar:InitFSM(arg_7_1)
	self.fsm = NewEducateStateMgr.New(self.id, arg_7_1)

	return
end

function NewEducateChar:InitSiteData(arg_8_1)
	self.siteShips = arg_8_1.characters or {}
	self.normalType2Id = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.works or {}) do
		self.normalType2Id[pg.child2_site_normal[iter_8_1].type] = iter_8_1
	end

	for iter_8_2, iter_8_3 in pairs(NewEducateConst.SITE_NORMAL_TYPE) do
		self.normalType2Id[iter_8_3] = self.normalType2Id[iter_8_3] or underscore.detect(pg.child2_site_normal.get_id_list_by_character[self.id] or {}, function(arg_9_0)
			return pg.child2_site_normal[arg_9_0].type == iter_8_3 and pg.child2_site_normal[arg_9_0].site_lv == 1
		end)
	end

	self.normalRecords = {}

	for iter_8_4, iter_8_5 in ipairs(arg_8_1.work_counter or {}) do
		self.normalRecords[iter_8_5.key] = iter_8_5.value
	end

	self.eventRecords = {}

	for iter_8_6, iter_8_7 in ipairs(arg_8_1.event_counter or {}) do
		self.eventRecords[iter_8_7.key] = iter_8_7.value
	end

	return
end

function NewEducateChar:GetSelectInfo()
	local var_10_0 = {
		bg = self.roundData:getConfig("main_background"),
		name = self:getConfig("name2"),
		gameCnt = self:GetGameCnt()
	}

	var_10_0.progressStr = self.roundData:IsEndless() and i18n("child2_game_endless_cnt", self.roundData:GetWave()) or i18n("child2_cur_round", self.roundData.round)
	var_10_0.isHard = self.difficulty == NewEducateChar.DIFFICULTY.HARD
	var_10_0.isEndless = self.roundData:IsEndless()

	return var_10_0
end

function NewEducateChar:GetName()
	return self:getConfig("name")
end

function NewEducateChar:SetCallName(arg_12_1)
	self.callName = arg_12_1

	return
end

function NewEducateChar:GetCallName()
	return self.callName
end

function NewEducateChar:BuildSiteIdMap()
	self.siteIdMap = {}

	for iter_14_0, iter_14_1 in pairs(NewEducateConst.SITE_TYPE) do
		local var_14_0 = pg.child2_site_display.get_id_list_by_type[iter_14_1]

		self.siteIdMap[iter_14_1] = {}

		switch(iter_14_1, {
			[NewEducateConst.SITE_TYPE.SHIP] = function()
				underscore.each(var_14_0, function(arg_16_0)
					self.siteIdMap[iter_14_1][pg.child2_site_display[arg_16_0].param] = arg_16_0

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.SHOP] = function()
				self.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_18_0)
					if pg.child2_site_display[arg_18_0].character == self.id then
						table.insert(self.siteIdMap[iter_14_1], arg_18_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.WORK] = function()
				self.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_20_0)
					if pg.child2_site_display[arg_20_0].character == self.id then
						table.insert(self.siteIdMap[iter_14_1], arg_20_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.TRAVEL] = function()
				self.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_22_0)
					if pg.child2_site_display[arg_22_0].character == self.id then
						table.insert(self.siteIdMap[iter_14_1], arg_22_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.EVENT] = function()
				underscore.each(var_14_0, function(arg_24_0)
					self.siteIdMap[iter_14_1][pg.child2_site_display[arg_24_0].param] = arg_24_0

					return
				end)

				return
			end
		})
	end

	return
end

function NewEducateChar:GetSiteId(arg_25_1, arg_25_2)
	return self.siteIdMap[arg_25_1][arg_25_2 or 1]
end

function NewEducateChar:GetNormalIdByType(arg_26_1)
	return self.normalType2Id[arg_26_1]
end

function NewEducateChar:UpdateNormalType2Id(arg_27_1, arg_27_2)
	self.normalType2Id[arg_27_1] = arg_27_2

	return
end

function NewEducateChar:AddNormalRecord(arg_28_1)
	self.normalRecords[arg_28_1] = (self.normalRecords[arg_28_1] or 0) + 1

	return
end

function NewEducateChar:GetNormalCnt(arg_29_1)
	return self.normalRecords[arg_29_1] or 0
end

function NewEducateChar:AddEventRecord(arg_30_1)
	self.eventRecords[arg_30_1] = (self.eventRecords[arg_30_1] or 0) + 1

	return
end

function NewEducateChar:GetEventCnt(arg_31_1)
	return self.eventRecords[arg_31_1] or 0
end

function NewEducateChar:SetShipIds(arg_32_1)
	self.siteShips = arg_32_1

	return
end

function NewEducateChar:GetShipIds()
	return self.siteShips
end

function NewEducateChar:UpdateShipId(arg_34_1, arg_34_2)
	table.removebyvalue(self.siteShips, arg_34_1)
	table.insert(self.siteShips, arg_34_2)

	return
end

function NewEducateChar:AddAssessRecord(arg_35_1, arg_35_2)
	self.assessRecords[arg_35_1] = arg_35_2

	return
end

function NewEducateChar:GetResources()
	return Clone(self.resources)
end

function NewEducateChar:SetResources(arg_37_1)
	self.resources = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		self.resources[iter_37_1.key] = iter_37_1.value
		self.resources[iter_37_1.key] = math.max(pg.child2_resource[iter_37_1.key].min_value, self.resources[iter_37_1.key])
		self.resources[iter_37_1.key] = math.min(pg.child2_resource[iter_37_1.key].max_value, self.resources[iter_37_1.key])
	end

	return
end

function NewEducateChar:GetRes(arg_38_1)
	return self.resources[arg_38_1] or 0
end

function NewEducateChar:GetPoint()
	return self:GetResByType(NewEducateChar.RES_TYPE.ACTION)
end

function NewEducateChar:GetResByType(arg_40_1)
	return self.resources[self:GetResIdByType(arg_40_1)] or 0
end

function NewEducateChar:GetResIdByType(arg_41_1)
	return underscore.detect(underscore.keys(self.resources), function(arg_42_0)
		return pg.child2_resource[arg_42_0].type == arg_41_1
	end)
end

function NewEducateChar:UpdateRes(arg_43_1, arg_43_2)
	if not self.resources[arg_43_1] then
		warning("不符合当前角色的资源更新！！！")

		self.resources[arg_43_1] = 0
	end

	self.resources[arg_43_1] = self.resources[arg_43_1] + arg_43_2
	self.resources[arg_43_1] = math.max(pg.child2_resource[arg_43_1].min_value, self.resources[arg_43_1])
	self.resources[arg_43_1] = math.min(pg.child2_resource[arg_43_1].max_value, self.resources[arg_43_1])

	return
end

function NewEducateChar:GetMoodStage(arg_44_1)
	local var_44_0 = arg_44_1 or self:GetResByType(NewEducateChar.RES_TYPE.MOOD)

	if var_44_0 <= pg.gameset.child_emotion.description[1][1][1] then
		return 1, pg.gameset.child_emotion.description[1][2]
	end

	if var_44_0 >= pg.gameset.child_emotion.description[#pg.gameset.child_emotion.description][1][2] then
		return #pg.gameset.child_emotion.description, pg.gameset.child_emotion.description[#pg.gameset.child_emotion.description][2]
	end

	for iter_44_0, iter_44_1 in ipairs(pg.gameset.child_emotion.description) do
		if var_44_0 >= iter_44_1[1][1] and var_44_0 < iter_44_1[1][2] then
			return iter_44_0, iter_44_1[2]
		end
	end

	return
end

function NewEducateChar:UpgradeFavor()
	self.gotFavorLv = self.gotFavorLv + 1

	return
end

function NewEducateChar:CheckFavor()
	local var_46_0 = self:GetFavorInfo()
	local var_46_1 = self:getConfig("favor_exp")[var_46_0.lv]

	if not var_46_1 then
		return false
	end

	return var_46_1 <= var_46_0.value
end

function NewEducateChar:GetFavorInfo()
	local var_47_0 = 0

	if self.gotFavorLv > 0 then
		for iter_47_0 = 1, self.gotFavorLv do
			var_47_0 = var_47_0 + self:getConfig("favor_exp")[iter_47_0]
		end
	end

	return {
		lv = math.min(self.gotFavorLv + 1, self:getConfig("favor_level")),
		value = self:GetResByType(NewEducateChar.RES_TYPE.FAVOR) - var_47_0
	}
end

function NewEducateChar:GetAttrs()
	return Clone(self.attrs)
end

function NewEducateChar:SetAttrs(arg_49_1)
	self.attrs = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		self.attrs[iter_49_1.key] = iter_49_1.value
		self.attrs[iter_49_1.key] = math.max(pg.child2_attr[iter_49_1.key].min_value, self.attrs[iter_49_1.key])
		self.attrs[iter_49_1.key] = math.min(pg.child2_attr[iter_49_1.key].max_value, self.attrs[iter_49_1.key])
	end

	return
end

function NewEducateChar:GetAttr(arg_50_1)
	return self.attrs[arg_50_1]
end

function NewEducateChar:GetAttrIds()
	local var_51_0 = underscore.select(underscore.keys(self.attrs), function(arg_52_0)
		return pg.child2_attr[arg_52_0].type == NewEducateChar.ATTR_TYPE.ATTR
	end)

	table.sort(var_51_0)

	return var_51_0
end

function NewEducateChar:GetAttrSum()
	return underscore.reduce(self:GetAttrIds(), 0, function(arg_54_0, arg_54_1)
		return arg_54_0 + self.attrs[arg_54_1]
	end)
end

function NewEducateChar:GetPersonalityId()
	return underscore.detect(underscore.keys(self.attrs), function(arg_56_0)
		return pg.child2_attr[arg_56_0].type == NewEducateChar.ATTR_TYPE.PERSONALITY
	end)
end

function NewEducateChar:GetPersonality()
	return self.attrs[self:GetPersonalityId()]
end

function NewEducateChar:GetPersonalityMiddle()
	local var_58_0 = pg.child2_attr[self:GetPersonalityId()]

	return math.floor((var_58_0.min_value + var_58_0.max_value) / 2)
end

function NewEducateChar:GetPersonalityTag(arg_59_1)
	local var_59_0 = arg_59_1 or self:GetPersonality()

	return (switch(self:getConfig("personality_type"), {
		function()
			for iter_60_0, iter_60_1 in ipairs(self:getConfig("personality_param")) do
				if var_59_0 >= iter_60_1[2][1] and var_59_0 <= iter_60_1[2][2] then
					return iter_60_1[1]
				end
			end

			return self:getConfig("personality_param")[1][1]
		end
	}, function()
		assert(false, "不合法的personality_type")

		return
	end))
end

function NewEducateChar:GetPersonalityTagTip(arg_62_1)
	return i18n("child2_personal_id" .. self.id .. "_tag" .. arg_62_1)
end

function NewEducateChar:GetPersonalityTagOptionBg(arg_63_1)
	return underscore.detect(self:getConfig("personality_tag_icon"), function(arg_64_0)
		return arg_64_0[1] == "tag" .. arg_63_1
	end)[3]
end

function NewEducateChar:UpdateAttr(arg_65_1, arg_65_2)
	if not self.attrs[arg_65_1] then
		warning("不符合当前角色的属性更新！！！")

		self.attrs[arg_65_1] = 0
	end

	self.attrs[arg_65_1] = self.attrs[arg_65_1] + arg_65_2
	self.attrs[arg_65_1] = math.max(pg.child2_attr[arg_65_1].min_value, self.attrs[arg_65_1])
	self.attrs[arg_65_1] = math.min(pg.child2_attr[arg_65_1].max_value, self.attrs[arg_65_1])

	return
end

function NewEducateChar:GetAssessRankIdx()
	local var_66_0 = self.roundData:getConfig("target_id")

	if var_66_0 == 0 or self.roundData:IsTemp() then
		return 0
	end

	local var_66_1 = self.roundData:GetExtraFactor()
	local var_66_2 = self:GetAttrSum()

	for iter_66_0 = #pg.child2_target[var_66_0].attr_sum_level, 1, -1 do
		if var_66_2 >= pg.child2_target[var_66_0].attr_sum_level[iter_66_0] * var_66_1 then
			return iter_66_0
		end
	end

	return #pg.child2_target[var_66_0].attr_sum_level
end

function NewEducateChar:GetAssessPreStory()
	local var_67_0 = self.roundData:getConfig("target_id")

	if var_67_0 == 0 then
		return nil
	end

	return pg.child2_target[var_67_0].pre_perform
end

function NewEducateChar:GetRoundData()
	return self.roundData
end

function NewEducateChar:GetFSM()
	return self.fsm
end

function NewEducateChar:GetBgm()
	local var_70_0 = self:GetPersonalityTag()

	return underscore.detect(self:getConfig("bgm"), function(arg_71_0)
		return arg_71_0[1] == var_70_0
	end)[2]
end

function NewEducateChar:GetPaintingName()
	local var_72_0 = self:GetPersonalityTag()

	return underscore.detect(self.roundData:getConfig("main_painting"), function(arg_73_0)
		return arg_73_0[1] == var_72_0
	end)[2]
end

function NewEducateChar:GetBGName()
	return self.roundData:getConfig("main_background")
end

function NewEducateChar:GetMainDialogueInfo()
	local var_75_0 = self:GetPersonalityTag()

	return underscore.detect(self.roundData:getConfig("main_word"), function(arg_76_0)
		return arg_76_0[1] == var_75_0
	end)[2], underscore.detect(self.roundData:getConfig("main_word_expression"), function(arg_77_0)
		return arg_77_0[1] == var_75_0
	end)[2]
end

function NewEducateChar:OnUpgradedPlan(arg_78_1)
	self.group2Plan[pg.child2_plan[arg_78_1].group_id] = arg_78_1

	return
end

function NewEducateChar:GetPlanList()
	local var_79_0 = {}

	for iter_79_0, iter_79_1 in ipairs((self.roundData:getConfig("plan_group"))) do
		if #pg.child2_plan.get_id_list_by_group_id[iter_79_1] == 1 then
			table.insert(var_79_0, NewEducatePlan.New(pg.child2_plan.get_id_list_by_group_id[iter_79_1][1]))
		elseif self.group2Plan[iter_79_1] then
			table.insert(var_79_0, NewEducatePlan.New(self.group2Plan[iter_79_1]))
		else
			table.sort(pg.child2_plan.get_id_list_by_group_id[iter_79_1], function(arg_80_0, arg_80_1)
				return pg.child2_plan[arg_80_0].level < pg.child2_plan[arg_80_1].level
			end)
			table.insert(var_79_0, NewEducatePlan.New(pg.child2_plan.get_id_list_by_group_id[iter_79_1][1]))
		end
	end

	for iter_79_2, iter_79_3 in ipairs(self.benefitData:GetExtraPlan(self)) do
		table.insert(var_79_0, NewEducatePlan.New(iter_79_3, true))
	end

	return var_79_0
end

function NewEducateChar:OnNextRound()
	self.siteShips = {}

	self.fsm:Reset()
	self.roundData:OnNextRound()

	self.resources[self:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)] = self.roundData:getConfig("map_mobility")

	if self.resources[self:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)] then
		self.resources[self:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)] = self.roundData:getConfig("refresh_refill")
	end

	self.benefitData:OnNextRound(self.roundData.round)
	self.permanentData:OnNextRound(self.roundData.round)

	return
end

function NewEducateChar:GetBenefitData()
	return self.benefitData
end

function NewEducateChar:AddBuff(arg_83_1, arg_83_2)
	self.permanentData:CheckBuffRecord(arg_83_1)

	if arg_83_2 > 0 then
		self.benefitData:AddBuff({
			id = arg_83_1,
			round = self.roundData.round,
			is_pending = not self.fsm:IsImmediateBenefit()
		})
	else
		self.benefitData:RemoveBuff(arg_83_1)
	end

	return
end

function NewEducateChar:GetTalentList()
	return self.benefitData:GetListByType(NewEducateBuff.TYPE.TALENT)
end

function NewEducateChar:GetTalent(arg_85_1)
	return self.benefitData:GetBuff(arg_85_1)
end

function NewEducateChar:GetStatusList()
	return self.benefitData:GetListByType(NewEducateBuff.TYPE.STATUS)
end

function NewEducateChar:GetStatus(arg_87_1)
	return self.benefitData:GetBuff(arg_87_1)
end

function NewEducateChar:GetTarotId()
	local var_88_0 = self.benefitData:GetListByType(NewEducateBuff.TYPE.TAROT)[1]

	return var_88_0 and var_88_0.id
end

function NewEducateChar:GetGoodsDiscountInfos()
	return self.benefitData:GetGoodsDiscountInfos(self)
end

function NewEducateChar:GetPlanDiscountInfos()
	return self.benefitData:GetPlanDiscountInfos(self)
end

function NewEducateChar:IsUnlock(arg_91_1)
	local var_91_0 = underscore.detect(self:getConfig("unlock"), function(arg_92_0)
		return arg_92_0[1] == arg_91_1
	end)

	return ((var_91_0 or nil) and (var_91_0[2] or 1)) <= self.roundData.round
end

function NewEducateChar:GetOwnCnt(arg_93_1)
	return switch(arg_93_1.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			return self:GetAttr(arg_93_1.id)
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			return self:GetRes(arg_93_1.id)
		end,
		[NewEducateConst.DROP_TYPE.BUFF] = function()
			return self.benefitData:ExistBuff(arg_93_1.id) and 1 or 0
		end
	}, function()
		return 0
	end)
end

function NewEducateChar:IsMatch(arg_98_1)
	return compareNumber(self:GetOwnCnt(arg_98_1), arg_98_1.operator, arg_98_1.number)
end

function NewEducateChar:IsMatchs(arg_99_1)
	return underscore.all(arg_99_1, function(arg_100_0)
		return self:IsMatch(arg_100_0)
	end)
end

function NewEducateChar:IsMatchCondition(arg_101_1)
	local var_101_0 = pg.child2_condition[arg_101_1]

	return (switch(pg.child2_condition[arg_101_1].type, {
		[NewEducateConst.CONDITION_TYPE.DROP] = function()
			return compareNumber(self:GetOwnCnt({
				type = var_101_0.param[1],
				id = var_101_0.param[2],
				number = var_101_0.param[4]
			}), var_101_0.param[3], var_101_0.param[4])
		end,
		[NewEducateConst.CONDITION_TYPE.ATTR_SUM] = function()
			return compareNumber(self:GetAttrSum(), var_101_0.param[1], var_101_0.param[2])
		end,
		[NewEducateConst.CONDITION_TYPE.EVENT_SITE_CNT] = function()
			return compareNumber(self:GetEventCnt(var_101_0.param[1]), var_101_0.param[2], var_101_0.param[3])
		end,
		[NewEducateConst.CONDITION_TYPE.ROUND] = function()
			return compareNumber(self.roundData.round, var_101_0.param[1], var_101_0.param[2])
		end,
		[NewEducateConst.CONDITION_TYPE.NORMAL_SITE_CNT] = function()
			return compareNumber(underscore.reduce(var_101_0.param[1], 0, function(arg_107_0, arg_107_1)
				return arg_107_0 + self:GetNormalCnt(arg_107_1)
			end), var_101_0.param[2], var_101_0.param[3])
		end
	}, function()
		assert(false, "非法condition type" .. var_101_0.type)

		return
	end))
end

function NewEducateChar:LogicalOperator(arg_109_1)
	if type(arg_109_1) == "number" then
		return self:IsMatchCondition(arg_109_1)
	end

	local var_109_0 = arg_109_1.operator

	if arg_109_1.operator == "||" then
		if arg_109_1.conditions.operator then
			return underscore.any(arg_109_1.conditions, function(arg_110_0)
				return self:LogicalOperator(arg_110_0)
			end)
		else
			return underscore.any(arg_109_1.conditions, function(arg_111_0)
				return self:IsMatchCondition(arg_111_0)
			end)
		end
	elseif var_109_0 == "&&" then
		if arg_109_1.conditions.operator then
			return underscore.all(arg_109_1.conditions, function(arg_112_0)
				return self:LogicalOperator(arg_112_0)
			end)
		else
			return underscore.all(arg_109_1.conditions, function(arg_113_0)
				return self:IsMatchCondition(arg_113_0)
			end)
		end
	end

	return
end

function NewEducateChar:IsFormatCondition(arg_114_1)
	return (arg_114_1[1] == "||" or arg_114_1[1] == "&&") and type(arg_114_1[2]) == "table" and type(arg_114_1[2][1]) == "number"
end

function NewEducateChar:GetFormatCondition(arg_115_1)
	if type(arg_115_1) == "number" then
		return arg_115_1
	end

	if self:IsFormatCondition(arg_115_1) then
		return {
			operator = arg_115_1[1],
			conditions = arg_115_1[2]
		}
	elseif self:IsFormatCondition(arg_115_1[2]) then
		return {
			operator = arg_115_1[1],
			conditions = underscore.map(arg_115_1[2], function(arg_116_0)
				self:GetFormatCondition(arg_116_0)

				return
			end)
		}
	end

	return
end

function NewEducateChar:IsMatchComplex(arg_117_1)
	if #arg_117_1 == 0 then
		return true
	end

	return self:LogicalOperator(self:GetFormatCondition(arg_117_1))
end

function NewEducateChar:GetConditionIdsFromComplex(arg_118_1)
	if type(arg_118_1) == "number" then
		return {
			arg_118_1
		}
	end

	if type(arg_118_1) == "table" and #arg_118_1 == 0 then
		return arg_118_1
	end

	if self:IsFormatCondition(arg_118_1) then
		return arg_118_1[2]
	elseif self:IsFormatCondition(arg_118_1[2]) then
		return underscore.map(arg_118_1[2], function(arg_119_0)
			self:GetConditionIdsFromComplex(arg_119_0)

			return
		end)
	end

	return
end

return NewEducateChar
