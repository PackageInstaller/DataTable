local var_0_0 = class("NewEducateChar", import("model.vo.BaseVO"))

var_0_0.RES_TYPE = {
	REFRESH_SHOP = 5,
	ACTION = 3,
	MONEY = 1,
	MOOD = 2,
	FAVOR = 4,
	REFRESH_CHOICE = 6
}
var_0_0.ATTR_TYPE = {
	ATTR = 1,
	PERSONALITY = 2
}
var_0_0.DIFFICULTY = {
	EASY = 0,
	HARD = 1
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child2_data
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.difficulty = arg_2_1.difficulty or var_0_0.DIFFICULTY.EASY
	arg_2_0.roundData = NewEducateRound.New(arg_2_1)

	arg_2_0:SetResources(arg_2_1.res.resource)
	arg_2_0:SetAttrs(arg_2_1.res.attrs)

	arg_2_0.group2Plan = {}

	local var_2_0 = arg_2_1.plan.plan_upgrade or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.group2Plan[pg.child2_plan[iter_2_1].group_id] = iter_2_1
	end

	arg_2_0:InitSiteData(arg_2_1.site)

	arg_2_0.assessRecords = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.evaluations) do
		arg_2_0.assessRecords[iter_2_3.key] = iter_2_3.value
	end

	arg_2_0.callName = arg_2_1.name or ""
	arg_2_0.gotFavorLv = arg_2_1.favor_lv or 0
	arg_2_0.benefitData = NewEducateBenefit.New(arg_2_1.benefit, arg_2_1.display)

	arg_2_0:BuildSiteIdMap()

	return
end

function var_0_0.InitPermanent(arg_3_0, arg_3_1)
	arg_3_0.permanentData = NewEducatePermanent.New(arg_3_0.id, arg_3_1)

	return
end

function var_0_0.SetPermanent(arg_4_0, arg_4_1)
	arg_4_0.permanentData = arg_4_1

	return
end

function var_0_0.GetPermanentData(arg_5_0)
	return arg_5_0.permanentData
end

function var_0_0.GetGameCnt(arg_6_0)
	return arg_6_0.permanentData:GetGameCnt()
end

function var_0_0.InitFSM(arg_7_0, arg_7_1)
	arg_7_0.fsm = NewEducateStateMgr.New(arg_7_0.id, arg_7_1)

	return
end

function var_0_0.InitSiteData(arg_8_0, arg_8_1)
	arg_8_0.siteShips = arg_8_1.characters or {}
	arg_8_0.normalType2Id = {}

	local var_8_0 = arg_8_1.works or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0.normalType2Id[pg.child2_site_normal[iter_8_1].type] = iter_8_1
	end

	for iter_8_2, iter_8_3 in pairs(NewEducateConst.SITE_NORMAL_TYPE) do
		arg_8_0.normalType2Id[iter_8_3] = arg_8_0.normalType2Id[iter_8_3] or underscore.detect(pg.child2_site_normal.get_id_list_by_character[arg_8_0.id] or {}, function(arg_9_0)
			local var_9_0 = pg.child2_site_normal[arg_9_0]

			return pg.child2_site_normal[arg_9_0].type == iter_8_3 and var_9_0.site_lv == 1
		end)
	end

	arg_8_0.normalRecords = {}

	local var_8_1 = arg_8_1.work_counter or {}

	for iter_8_4, iter_8_5 in ipairs(var_8_1) do
		arg_8_0.normalRecords[iter_8_5.key] = iter_8_5.value
	end

	arg_8_0.eventRecords = {}

	local var_8_2 = arg_8_1.event_counter or {}

	for iter_8_6, iter_8_7 in ipairs(var_8_2) do
		arg_8_0.eventRecords[iter_8_7.key] = iter_8_7.value
	end

	return
end

function var_0_0.GetSelectInfo(arg_10_0)
	local var_10_0 = {
		bg = arg_10_0.roundData:getConfig("main_background"),
		name = arg_10_0:getConfig("name2"),
		gameCnt = arg_10_0:GetGameCnt()
	}

	var_10_0.progressStr = arg_10_0.roundData:IsEndless() and i18n("child2_game_endless_cnt", arg_10_0.roundData:GetWave()) or i18n("child2_cur_round", arg_10_0.roundData.round)
	var_10_0.isHard = arg_10_0.difficulty == var_0_0.DIFFICULTY.HARD
	var_10_0.isEndless = arg_10_0.roundData:IsEndless()

	return var_10_0
end

function var_0_0.GetName(arg_11_0)
	return arg_11_0:getConfig("name")
end

function var_0_0.SetCallName(arg_12_0, arg_12_1)
	arg_12_0.callName = arg_12_1

	return
end

function var_0_0.GetCallName(arg_13_0)
	return arg_13_0.callName
end

function var_0_0.BuildSiteIdMap(arg_14_0)
	arg_14_0.siteIdMap = {}

	for iter_14_0, iter_14_1 in pairs(NewEducateConst.SITE_TYPE) do
		local var_14_0 = pg.child2_site_display.get_id_list_by_type[iter_14_1]

		arg_14_0.siteIdMap[iter_14_1] = {}

		switch(iter_14_1, {
			[NewEducateConst.SITE_TYPE.SHIP] = function()
				underscore.each(var_14_0, function(arg_16_0)
					arg_14_0.siteIdMap[iter_14_1][pg.child2_site_display[arg_16_0].param] = arg_16_0

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.SHOP] = function()
				arg_14_0.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_18_0)
					if pg.child2_site_display[arg_18_0].character == arg_14_0.id then
						table.insert(arg_14_0.siteIdMap[iter_14_1], arg_18_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.WORK] = function()
				arg_14_0.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_20_0)
					if pg.child2_site_display[arg_20_0].character == arg_14_0.id then
						table.insert(arg_14_0.siteIdMap[iter_14_1], arg_20_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.TRAVEL] = function()
				arg_14_0.siteIdMap[iter_14_1] = {}

				underscore.each(var_14_0, function(arg_22_0)
					if pg.child2_site_display[arg_22_0].character == arg_14_0.id then
						table.insert(arg_14_0.siteIdMap[iter_14_1], arg_22_0)
					end

					return
				end)

				return
			end,
			[NewEducateConst.SITE_TYPE.EVENT] = function()
				underscore.each(var_14_0, function(arg_24_0)
					arg_14_0.siteIdMap[iter_14_1][pg.child2_site_display[arg_24_0].param] = arg_24_0

					return
				end)

				return
			end
		})
	end

	return
end

function var_0_0.GetSiteId(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_0.siteIdMap[arg_25_1][arg_25_2 or 1]
end

function var_0_0.GetNormalIdByType(arg_26_0, arg_26_1)
	return arg_26_0.normalType2Id[arg_26_1]
end

function var_0_0.UpdateNormalType2Id(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.normalType2Id[arg_27_1] = arg_27_2

	return
end

function var_0_0.AddNormalRecord(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.normalRecords[arg_28_1] or 0

	arg_28_0.normalRecords[arg_28_1] = var_28_0 + 1

	return
end

function var_0_0.GetNormalCnt(arg_29_0, arg_29_1)
	return arg_29_0.normalRecords[arg_29_1] or 0
end

function var_0_0.AddEventRecord(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.eventRecords[arg_30_1] or 0

	arg_30_0.eventRecords[arg_30_1] = var_30_0 + 1

	return
end

function var_0_0.GetEventCnt(arg_31_0, arg_31_1)
	return arg_31_0.eventRecords[arg_31_1] or 0
end

function var_0_0.SetShipIds(arg_32_0, arg_32_1)
	arg_32_0.siteShips = arg_32_1

	return
end

function var_0_0.GetShipIds(arg_33_0)
	return arg_33_0.siteShips
end

function var_0_0.UpdateShipId(arg_34_0, arg_34_1, arg_34_2)
	table.removebyvalue(arg_34_0.siteShips, arg_34_1)
	table.insert(arg_34_0.siteShips, arg_34_2)

	return
end

function var_0_0.AddAssessRecord(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.assessRecords[arg_35_1] = arg_35_2

	return
end

function var_0_0.GetResources(arg_36_0)
	return Clone(arg_36_0.resources)
end

function var_0_0.SetResources(arg_37_0, arg_37_1)
	arg_37_0.resources = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		arg_37_0.resources[iter_37_1.key] = iter_37_1.value
		arg_37_0.resources[iter_37_1.key] = math.max(pg.child2_resource[iter_37_1.key].min_value, arg_37_0.resources[iter_37_1.key])
		arg_37_0.resources[iter_37_1.key] = math.min(pg.child2_resource[iter_37_1.key].max_value, arg_37_0.resources[iter_37_1.key])
	end

	return
end

function var_0_0.GetRes(arg_38_0, arg_38_1)
	return arg_38_0.resources[arg_38_1] or 0
end

function var_0_0.GetPoint(arg_39_0)
	return arg_39_0:GetResByType(var_0_0.RES_TYPE.ACTION)
end

function var_0_0.GetResByType(arg_40_0, arg_40_1)
	return arg_40_0.resources[arg_40_0:GetResIdByType(arg_40_1)] or 0
end

function var_0_0.GetResIdByType(arg_41_0, arg_41_1)
	return underscore.detect(underscore.keys(arg_41_0.resources), function(arg_42_0)
		return pg.child2_resource[arg_42_0].type == arg_41_1
	end)
end

function var_0_0.UpdateRes(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.resources[arg_43_1] then
		warning("不符合当前角色的资源更新！！！")

		arg_43_0.resources[arg_43_1] = 0
	end

	arg_43_0.resources[arg_43_1] = arg_43_0.resources[arg_43_1] + arg_43_2
	arg_43_0.resources[arg_43_1] = math.max(pg.child2_resource[arg_43_1].min_value, arg_43_0.resources[arg_43_1])
	arg_43_0.resources[arg_43_1] = math.min(pg.child2_resource[arg_43_1].max_value, arg_43_0.resources[arg_43_1])

	return
end

function var_0_0.GetMoodStage(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 or arg_44_0:GetResByType(var_0_0.RES_TYPE.MOOD)

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

function var_0_0.UpgradeFavor(arg_45_0)
	arg_45_0.gotFavorLv = arg_45_0.gotFavorLv + 1

	return
end

function var_0_0.CheckFavor(arg_46_0)
	local var_46_0 = arg_46_0:GetFavorInfo()
	local var_46_1 = arg_46_0:getConfig("favor_exp")[var_46_0.lv]

	if not var_46_1 then
		return false
	end

	return var_46_1 <= var_46_0.value
end

function var_0_0.GetFavorInfo(arg_47_0)
	local var_47_0 = 0

	if arg_47_0.gotFavorLv > 0 then
		for iter_47_0 = 1, arg_47_0.gotFavorLv do
			var_47_0 = var_47_0 + arg_47_0:getConfig("favor_exp")[iter_47_0]
		end
	end

	return {
		lv = math.min(arg_47_0.gotFavorLv + 1, arg_47_0:getConfig("favor_level")),
		value = arg_47_0:GetResByType(var_0_0.RES_TYPE.FAVOR) - var_47_0
	}
end

function var_0_0.GetAttrs(arg_48_0)
	return Clone(arg_48_0.attrs)
end

function var_0_0.SetAttrs(arg_49_0, arg_49_1)
	arg_49_0.attrs = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		arg_49_0.attrs[iter_49_1.key] = iter_49_1.value
		arg_49_0.attrs[iter_49_1.key] = math.max(pg.child2_attr[iter_49_1.key].min_value, arg_49_0.attrs[iter_49_1.key])
		arg_49_0.attrs[iter_49_1.key] = math.min(pg.child2_attr[iter_49_1.key].max_value, arg_49_0.attrs[iter_49_1.key])
	end

	return
end

function var_0_0.GetAttr(arg_50_0, arg_50_1)
	return arg_50_0.attrs[arg_50_1]
end

function var_0_0.GetAttrIds(arg_51_0)
	local var_51_0 = underscore.select(underscore.keys(arg_51_0.attrs), function(arg_52_0)
		return pg.child2_attr[arg_52_0].type == var_0_0.ATTR_TYPE.ATTR
	end)

	table.sort(var_51_0)

	return var_51_0
end

function var_0_0.GetAttrSum(arg_53_0)
	return underscore.reduce(arg_53_0:GetAttrIds(), 0, function(arg_54_0, arg_54_1)
		return arg_54_0 + arg_53_0.attrs[arg_54_1]
	end)
end

function var_0_0.GetPersonalityId(arg_55_0)
	return underscore.detect(underscore.keys(arg_55_0.attrs), function(arg_56_0)
		return pg.child2_attr[arg_56_0].type == var_0_0.ATTR_TYPE.PERSONALITY
	end)
end

function var_0_0.GetPersonality(arg_57_0)
	return arg_57_0.attrs[arg_57_0:GetPersonalityId()]
end

function var_0_0.GetPersonalityMiddle(arg_58_0)
	local var_58_0 = pg.child2_attr[arg_58_0:GetPersonalityId()]

	return math.floor((var_58_0.min_value + var_58_0.max_value) / 2)
end

function var_0_0.GetPersonalityTag(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1 or arg_59_0:GetPersonality()

	return (switch(arg_59_0:getConfig("personality_type"), {
		function()
			for iter_60_0, iter_60_1 in ipairs(arg_59_0:getConfig("personality_param")) do
				if var_59_0 >= iter_60_1[2][1] and var_59_0 <= iter_60_1[2][2] then
					return iter_60_1[1]
				end
			end

			return arg_59_0:getConfig("personality_param")[1][1]
		end
	}, function()
		assert(false, "不合法的personality_type")

		return
	end))
end

function var_0_0.GetPersonalityTagTip(arg_62_0, arg_62_1)
	return i18n("child2_personal_id" .. arg_62_0.id .. "_tag" .. arg_62_1)
end

function var_0_0.GetPersonalityTagOptionBg(arg_63_0, arg_63_1)
	return underscore.detect(arg_63_0:getConfig("personality_tag_icon"), function(arg_64_0)
		return arg_64_0[1] == "tag" .. arg_63_1
	end)[3]
end

function var_0_0.UpdateAttr(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_0.attrs[arg_65_1] then
		warning("不符合当前角色的属性更新！！！")

		arg_65_0.attrs[arg_65_1] = 0
	end

	arg_65_0.attrs[arg_65_1] = arg_65_0.attrs[arg_65_1] + arg_65_2
	arg_65_0.attrs[arg_65_1] = math.max(pg.child2_attr[arg_65_1].min_value, arg_65_0.attrs[arg_65_1])
	arg_65_0.attrs[arg_65_1] = math.min(pg.child2_attr[arg_65_1].max_value, arg_65_0.attrs[arg_65_1])

	return
end

function var_0_0.GetAssessRankIdx(arg_66_0)
	local var_66_0 = arg_66_0.roundData:getConfig("target_id")

	if var_66_0 == 0 or arg_66_0.roundData:IsTemp() then
		return 0
	end

	local var_66_1 = arg_66_0.roundData:GetExtraFactor()
	local var_66_2 = arg_66_0:GetAttrSum()

	for iter_66_0 = #pg.child2_target[var_66_0].attr_sum_level, 1, -1 do
		if var_66_2 >= pg.child2_target[var_66_0].attr_sum_level[iter_66_0] * var_66_1 then
			return iter_66_0
		end
	end

	return #pg.child2_target[var_66_0].attr_sum_level
end

function var_0_0.GetAssessPreStory(arg_67_0)
	local var_67_0 = arg_67_0.roundData:getConfig("target_id")

	if var_67_0 == 0 then
		return nil
	end

	return pg.child2_target[var_67_0].pre_perform
end

function var_0_0.GetRoundData(arg_68_0)
	return arg_68_0.roundData
end

function var_0_0.GetFSM(arg_69_0)
	return arg_69_0.fsm
end

function var_0_0.GetBgm(arg_70_0)
	local var_70_0 = arg_70_0:GetPersonalityTag()

	return underscore.detect(arg_70_0:getConfig("bgm"), function(arg_71_0)
		return arg_71_0[1] == var_70_0
	end)[2]
end

function var_0_0.GetPaintingName(arg_72_0)
	local var_72_0 = arg_72_0:GetPersonalityTag()

	return underscore.detect(arg_72_0.roundData:getConfig("main_painting"), function(arg_73_0)
		return arg_73_0[1] == var_72_0
	end)[2]
end

function var_0_0.GetBGName(arg_74_0)
	return arg_74_0.roundData:getConfig("main_background")
end

function var_0_0.GetMainDialogueInfo(arg_75_0)
	local var_75_0 = arg_75_0:GetPersonalityTag()

	return underscore.detect(arg_75_0.roundData:getConfig("main_word"), function(arg_76_0)
		return arg_76_0[1] == var_75_0
	end)[2], underscore.detect(arg_75_0.roundData:getConfig("main_word_expression"), function(arg_77_0)
		return arg_77_0[1] == var_75_0
	end)[2]
end

function var_0_0.OnUpgradedPlan(arg_78_0, arg_78_1)
	arg_78_0.group2Plan[pg.child2_plan[arg_78_1].group_id] = arg_78_1

	return
end

function var_0_0.GetPlanList(arg_79_0)
	for iter_79_0, iter_79_1 in ipairs((arg_79_0.roundData:getConfig("plan_group"))) do
		if #pg.child2_plan.get_id_list_by_group_id[iter_79_1] == 1 then
			table.insert({}, NewEducatePlan.New(pg.child2_plan.get_id_list_by_group_id[iter_79_1][1]))
		elseif arg_79_0.group2Plan[iter_79_1] then
			table.insert({}, NewEducatePlan.New(arg_79_0.group2Plan[iter_79_1]))
		else
			table.sort(pg.child2_plan.get_id_list_by_group_id[iter_79_1], function(arg_80_0, arg_80_1)
				return pg.child2_plan[arg_80_0].level < pg.child2_plan[arg_80_1].level
			end)
			table.insert({}, NewEducatePlan.New(pg.child2_plan.get_id_list_by_group_id[iter_79_1][1]))
		end
	end

	for iter_79_2, iter_79_3 in ipairs(arg_79_0.benefitData:GetExtraPlan(arg_79_0)) do
		table.insert({}, NewEducatePlan.New(iter_79_3, true))
	end

	return {}
end

function var_0_0.OnNextRound(arg_81_0)
	arg_81_0.siteShips = {}

	arg_81_0.fsm:Reset()
	arg_81_0.roundData:OnNextRound()

	arg_81_0.resources[arg_81_0:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)] = arg_81_0.roundData:getConfig("map_mobility")

	if arg_81_0.resources[arg_81_0:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)] then
		arg_81_0.resources[arg_81_0:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)] = arg_81_0.roundData:getConfig("refresh_refill")
	end

	arg_81_0.benefitData:OnNextRound(arg_81_0.roundData.round)
	arg_81_0.permanentData:OnNextRound(arg_81_0.roundData.round)

	return
end

function var_0_0.GetBenefitData(arg_82_0)
	return arg_82_0.benefitData
end

function var_0_0.AddBuff(arg_83_0, arg_83_1, arg_83_2)
	arg_83_0.permanentData:CheckBuffRecord(arg_83_1)

	if arg_83_2 > 0 then
		arg_83_0.benefitData:AddBuff({
			id = arg_83_1,
			round = arg_83_0.roundData.round,
			is_pending = not arg_83_0.fsm:IsImmediateBenefit()
		})
	else
		arg_83_0.benefitData:RemoveBuff(arg_83_1)
	end

	return
end

function var_0_0.GetTalentList(arg_84_0)
	return arg_84_0.benefitData:GetListByType(NewEducateBuff.TYPE.TALENT)
end

function var_0_0.GetTalent(arg_85_0, arg_85_1)
	return arg_85_0.benefitData:GetBuff(arg_85_1)
end

function var_0_0.GetStatusList(arg_86_0)
	return arg_86_0.benefitData:GetListByType(NewEducateBuff.TYPE.STATUS)
end

function var_0_0.GetStatus(arg_87_0, arg_87_1)
	return arg_87_0.benefitData:GetBuff(arg_87_1)
end

function var_0_0.GetTarotId(arg_88_0)
	local var_88_0 = arg_88_0.benefitData:GetListByType(NewEducateBuff.TYPE.TAROT)[1]

	return var_88_0 and var_88_0.id
end

function var_0_0.GetGoodsDiscountInfos(arg_89_0)
	return arg_89_0.benefitData:GetGoodsDiscountInfos(arg_89_0)
end

function var_0_0.GetPlanDiscountInfos(arg_90_0)
	return arg_90_0.benefitData:GetPlanDiscountInfos(arg_90_0)
end

function var_0_0.IsUnlock(arg_91_0, arg_91_1)
	local var_91_0 = underscore.detect(arg_91_0:getConfig("unlock"), function(arg_92_0)
		return arg_92_0[1] == arg_91_1
	end)

	if var_91_0 then
		local var_91_1 = var_91_0[2] or 1

		return var_91_1 <= arg_91_0.roundData.round
	end
end

function var_0_0.GetOwnCnt(arg_93_0, arg_93_1)
	return switch(arg_93_1.type, {
		[NewEducateConst.DROP_TYPE.ATTR] = function()
			return arg_93_0:GetAttr(arg_93_1.id)
		end,
		[NewEducateConst.DROP_TYPE.RES] = function()
			return arg_93_0:GetRes(arg_93_1.id)
		end,
		[NewEducateConst.DROP_TYPE.BUFF] = function()
			return arg_93_0.benefitData:ExistBuff(arg_93_1.id) and 1 or 0
		end
	}, function()
		return 0
	end)
end

function var_0_0.IsMatch(arg_98_0, arg_98_1)
	return compareNumber(arg_98_0:GetOwnCnt(arg_98_1), arg_98_1.operator, arg_98_1.number)
end

function var_0_0.IsMatchs(arg_99_0, arg_99_1)
	return underscore.all(arg_99_1, function(arg_100_0)
		return arg_99_0:IsMatch(arg_100_0)
	end)
end

function var_0_0.IsMatchCondition(arg_101_0, arg_101_1)
	return (switch(pg.child2_condition[arg_101_1].type, {
		[NewEducateConst.CONDITION_TYPE.DROP] = function()
			return compareNumber(arg_101_0:GetOwnCnt({
				type = var_0.param[1],
				id = var_0.param[2],
				number = var_0.param[4]
			}), var_0.param[3], var_0.param[4])
		end,
		[NewEducateConst.CONDITION_TYPE.ATTR_SUM] = function()
			return compareNumber(arg_101_0:GetAttrSum(), var_0.param[1], var_0.param[2])
		end,
		[NewEducateConst.CONDITION_TYPE.EVENT_SITE_CNT] = function()
			return compareNumber(arg_101_0:GetEventCnt(var_0.param[1]), var_0.param[2], var_0.param[3])
		end,
		[NewEducateConst.CONDITION_TYPE.ROUND] = function()
			return compareNumber(arg_101_0.roundData.round, var_0.param[1], var_0.param[2])
		end,
		[NewEducateConst.CONDITION_TYPE.NORMAL_SITE_CNT] = function()
			return compareNumber(underscore.reduce(var_0.param[1], 0, function(arg_107_0, arg_107_1)
				return arg_107_0 + arg_101_0:GetNormalCnt(arg_107_1)
			end), var_0.param[2], var_0.param[3])
		end
	}, function()
		assert(false, "非法condition type" .. var_0.type)

		return
	end))
end

function var_0_0.LogicalOperator(arg_109_0, arg_109_1)
	if type(arg_109_1) == "number" then
		return arg_109_0:IsMatchCondition(arg_109_1)
	end

	local var_109_0 = arg_109_1.operator

	if arg_109_1.operator == "||" then
		if arg_109_1.conditions.operator then
			return underscore.any(arg_109_1.conditions, function(arg_110_0)
				return arg_109_0:LogicalOperator(arg_110_0)
			end)
		else
			return underscore.any(arg_109_1.conditions, function(arg_111_0)
				return arg_109_0:IsMatchCondition(arg_111_0)
			end)
		end
	elseif var_109_0 == "&&" then
		if arg_109_1.conditions.operator then
			return underscore.all(arg_109_1.conditions, function(arg_112_0)
				return arg_109_0:LogicalOperator(arg_112_0)
			end)
		else
			return underscore.all(arg_109_1.conditions, function(arg_113_0)
				return arg_109_0:IsMatchCondition(arg_113_0)
			end)
		end
	end

	return
end

function var_0_0.IsFormatCondition(arg_114_0, arg_114_1)
	return (arg_114_1[1] == "||" or arg_114_1[1] == "&&") and type(arg_114_1[2]) == "table" and type(arg_114_1[2][1]) == "number"
end

function var_0_0.GetFormatCondition(arg_115_0, arg_115_1)
	if type(arg_115_1) == "number" then
		return arg_115_1
	end

	if arg_115_0:IsFormatCondition(arg_115_1) then
		return {
			operator = arg_115_1[1],
			conditions = arg_115_1[2]
		}
	elseif arg_115_0:IsFormatCondition(arg_115_1[2]) then
		return {
			operator = arg_115_1[1],
			conditions = underscore.map(arg_115_1[2], function(arg_116_0)
				arg_115_0:GetFormatCondition(arg_116_0)

				return
			end)
		}
	end

	return
end

function var_0_0.IsMatchComplex(arg_117_0, arg_117_1)
	if #arg_117_1 == 0 then
		return true
	end

	return arg_117_0:LogicalOperator(arg_117_0:GetFormatCondition(arg_117_1))
end

function var_0_0.GetConditionIdsFromComplex(arg_118_0, arg_118_1)
	if type(arg_118_1) == "number" then
		return {
			arg_118_1
		}
	end

	if type(arg_118_1) == "table" and #arg_118_1 == 0 then
		return arg_118_1
	end

	if arg_118_0:IsFormatCondition(arg_118_1) then
		return arg_118_1[2]
	elseif arg_118_0:IsFormatCondition(arg_118_1[2]) then
		return underscore.map(arg_118_1[2], function(arg_119_0)
			arg_118_0:GetConditionIdsFromComplex(arg_119_0)

			return
		end)
	end

	return
end

return var_0_0
