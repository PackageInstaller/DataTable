class = var_0_10000

local var_0_0 = "NewEducateChar"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.RES_TYPE = {
	REFRESH_SHOP = 5,
	ACTION = 3,
	MONEY = 1,
	MOOD = 2,
	FAVOR = 4,
	REFRESH_CHOICE = 6
}
var_0_1.ATTR_TYPE = {
	ATTR = 1,
	PERSONALITY = 2
}
var_0_1.DIFFICULTY = {
	EASY = 0,
	HARD = 1
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child2_data
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	local var_2_0

	if not arg_2_1.difficulty then
		var_2_0 = var_0_1.DIFFICULTY.EASY
	end

	arg_2_0.difficulty = var_2_0
	NewEducateRound = var_2_0
	arg_2_0.roundData = var_2_0.New(arg_2_1)

	arg_2_0:SetResources(arg_2_1.res.resource)
	arg_2_0:SetAttrs(arg_2_1.res.attrs)

	arg_2_0.group2Plan = {}
	ipairs = var_2

	local var_2_1

	if not arg_2_1.plan.plan_upgrade then
		var_2_1 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_plan[iter_2_1].group_id
		arg_2_0.group2Plan[var_1_10007] = iter_2_1
	end

	arg_2_0:InitSiteData(arg_2_1.site)

	arg_2_0.assessRecords = {}
	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_1.evaluations) do
		arg_2_0.assessRecords[iter_2_3.key] = iter_2_3.value
	end

	local var_2_2

	if not arg_2_1.name then
		var_2_2 = ""
	end

	arg_2_0.callName = var_2_2

	local var_2_3

	if not arg_2_1.favor_lv then
		var_2_3 = 0
	end

	arg_2_0.gotFavorLv = var_2_3
	NewEducateBenefit = var_2_3
	arg_2_0.benefitData = var_2_3.New(arg_2_1.benefit, arg_2_1.display)

	arg_2_0:BuildSiteIdMap()

	return
end

function var_0_1.InitPermanent(arg_3_0, arg_3_1)
	NewEducatePermanent = var_1_10002
	arg_3_0.permanentData = var_1_10002.New(arg_3_0.id, arg_3_1)

	return
end

function var_0_1.SetPermanent(arg_4_0, arg_4_1)
	arg_4_0.permanentData = arg_4_1

	return
end

function var_0_1.GetPermanentData(arg_5_0)
	return arg_5_0.permanentData
end

function var_0_1.GetGameCnt(arg_6_0)
	local var_6_0 = arg_6_0.permanentData

	return var_1.GetGameCnt(var_6_0)
end

function var_0_1.InitFSM(arg_7_0, arg_7_1)
	NewEducateStateMgr = var_1_10002
	arg_7_0.fsm = var_1_10002.New(arg_7_0.id, arg_7_1)

	return
end

function var_0_1.InitSiteData(arg_8_0, arg_8_1)
	local var_8_0

	if not arg_8_1.characters then
		var_8_0 = {}
	end

	arg_8_0.siteShips = var_8_0
	arg_8_0.normalType2Id = {}
	ipairs = var_2

	local var_8_1

	if not arg_8_1.works then
		var_8_1 = {}
	end

	for iter_8_0, iter_8_1 in var_2(var_8_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_site_normal[iter_8_1].type
		arg_8_0.normalType2Id[var_1_10007] = iter_8_1
	end

	pg = var_2

	local var_8_2 = var_2.child2_site_normal.get_id_list_by_character[arg_8_0.id]

	pairs = var_3
	NewEducateConst = iter_8_0

	for iter_8_2, iter_8_3 in var_3(iter_8_0.SITE_NORMAL_TYPE) do
		if not arg_8_0.normalType2Id[iter_8_3] then
			local var_8_3 = arg_8_0.normalType2Id

			underscore = var_1_10009
			var_8_3[iter_8_3] = var_1_10009.detect(var_8_2 or {}, function(arg_9_0)
				pg = var_2_10001

				return var_2_10001.child2_site_normal[arg_9_0].type == iter_8_3 and var_1.site_lv == 1
			end)
		end
	end

	arg_8_0.normalRecords = {}
	ipairs = var_3

	local var_8_4

	if not arg_8_1.work_counter then
		var_8_4 = {}
	end

	for iter_8_4, iter_8_5 in var_3(var_8_4) do
		arg_8_0.normalRecords[iter_8_5.key] = iter_8_5.value
	end

	arg_8_0.eventRecords = {}
	ipairs = var_3

	local var_8_5

	if not arg_8_1.event_counter then
		var_8_5 = {}
	end

	for iter_8_6, iter_8_7 in var_3(var_8_5) do
		arg_8_0.eventRecords[iter_8_7.key] = iter_8_7.value
	end

	return
end

function var_0_1.GetSelectInfo(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0.roundData

	var_10_0.bg = var_2.getConfig(var_10_1, "main_background")
	var_10_0.name = arg_10_0:getConfig("name2")
	var_10_0.gameCnt = arg_10_0:GetGameCnt()

	local var_10_2 = arg_10_0.roundData

	if var_2.IsEndless(var_10_2) then
		i18n = var_10_5

		local var_10_3 = "child2_game_endless_cnt"
		local var_10_4 = arg_10_0.roundData
		local var_10_5

		if not var_10_5(var_10_3, var_5.GetWave(var_10_4)) then
			i18n = var_10_5
			var_10_5 = var_10_5("child2_cur_round", arg_10_0.roundData.round)
		end

		var_10_0.progressStr = var_10_5
		var_10_0.isHard = arg_10_0.difficulty == var_0_1.DIFFICULTY.HARD

		local var_10_6 = arg_10_0.roundData

		var_10_0.isEndless = var_2.IsEndless(var_10_6)

		return var_10_0
	end
end

function var_0_1.GetName(arg_11_0)
	return arg_11_0:getConfig("name")
end

function var_0_1.SetCallName(arg_12_0, arg_12_1)
	arg_12_0.callName = arg_12_1

	return
end

function var_0_1.GetCallName(arg_13_0)
	return arg_13_0.callName
end

function var_0_1.BuildSiteIdMap(arg_14_0)
	arg_14_0.siteIdMap = {}
	pairs = var_1
	NewEducateConst = var_1_10003

	for iter_14_0, iter_14_1 in var_1(var_1_10003.SITE_TYPE) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.child2_site_display.get_id_list_by_type[iter_14_1]

		local var_14_0 = arg_14_0.siteIdMap

		var_14_0[iter_14_1] = {}
		switch = var_14_0

		local var_14_1 = iter_14_1
		local var_14_2 = {}

		NewEducateConst = var_1_10011
		var_14_2[var_1_10011.SITE_TYPE.SHIP] = function()
			underscore = var_2_10000

			var_2_10000.each(var_1_10006, function(arg_16_0)
				pg = var_3_10001

				local var_16_0 = var_3_10001.child2_site_display[arg_16_0].param

				arg_14_0.siteIdMap[iter_14_1][var_16_0] = arg_16_0

				return
			end)

			return
		end
		NewEducateConst = var_1_10011
		var_14_2[var_1_10011.SITE_TYPE.SHOP] = function()
			local var_17_0 = arg_14_0.siteIdMap

			var_17_0[iter_14_1] = {}
			underscore = var_17_0

			var_17_0.each(var_1_10006, function(arg_18_0)
				pg = var_3_10001

				if var_3_10001.child2_site_display[arg_18_0].character == arg_14_0.id then
					table = var_1

					var_1.insert(arg_14_0.siteIdMap[iter_14_1], arg_18_0)
				end

				return
			end)

			return
		end
		NewEducateConst = var_1_10011
		var_14_2[var_1_10011.SITE_TYPE.WORK] = function()
			local var_19_0 = arg_14_0.siteIdMap

			var_19_0[iter_14_1] = {}
			underscore = var_19_0

			var_19_0.each(var_1_10006, function(arg_20_0)
				pg = var_3_10001

				if var_3_10001.child2_site_display[arg_20_0].character == arg_14_0.id then
					table = var_1

					var_1.insert(arg_14_0.siteIdMap[iter_14_1], arg_20_0)
				end

				return
			end)

			return
		end
		NewEducateConst = var_1_10011
		var_14_2[var_1_10011.SITE_TYPE.TRAVEL] = function()
			local var_21_0 = arg_14_0.siteIdMap

			var_21_0[iter_14_1] = {}
			underscore = var_21_0

			var_21_0.each(var_1_10006, function(arg_22_0)
				pg = var_3_10001

				if var_3_10001.child2_site_display[arg_22_0].character == arg_14_0.id then
					table = var_1

					var_1.insert(arg_14_0.siteIdMap[iter_14_1], arg_22_0)
				end

				return
			end)

			return
		end
		NewEducateConst = var_1_10011
		var_14_2[var_1_10011.SITE_TYPE.EVENT] = function()
			underscore = var_2_10000

			var_2_10000.each(var_1_10006, function(arg_24_0)
				pg = var_3_10001

				local var_24_0 = var_3_10001.child2_site_display[arg_24_0].param

				arg_14_0.siteIdMap[iter_14_1][var_24_0] = arg_24_0

				return
			end)

			return
		end

		var_14_0(var_14_1, var_14_2)
	end

	return
end

function var_0_1.GetSiteId(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2 or 1

	return arg_25_0.siteIdMap[arg_25_1][var_25_0]
end

function var_0_1.GetNormalIdByType(arg_26_0, arg_26_1)
	return arg_26_0.normalType2Id[arg_26_1]
end

function var_0_1.UpdateNormalType2Id(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.normalType2Id[arg_27_1] = arg_27_2

	return
end

function var_0_1.AddNormalRecord(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.normalRecords
	local var_28_1

	if not arg_28_0.normalRecords[arg_28_1] then
		var_28_1 = 0
	end

	var_28_0[arg_28_1] = var_28_1 + 1

	return
end

function var_0_1.GetNormalCnt(arg_29_0, arg_29_1)
	local var_29_0

	if not arg_29_0.normalRecords[arg_29_1] then
		var_29_0 = 0
	end

	return var_29_0
end

function var_0_1.AddEventRecord(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.eventRecords
	local var_30_1

	if not arg_30_0.eventRecords[arg_30_1] then
		var_30_1 = 0
	end

	var_30_0[arg_30_1] = var_30_1 + 1

	return
end

function var_0_1.GetEventCnt(arg_31_0, arg_31_1)
	local var_31_0

	if not arg_31_0.eventRecords[arg_31_1] then
		var_31_0 = 0
	end

	return var_31_0
end

function var_0_1.SetShipIds(arg_32_0, arg_32_1)
	arg_32_0.siteShips = arg_32_1

	return
end

function var_0_1.GetShipIds(arg_33_0)
	return arg_33_0.siteShips
end

function var_0_1.UpdateShipId(arg_34_0, arg_34_1, arg_34_2)
	table = var_1_10003

	var_1_10003.removebyvalue(arg_34_0.siteShips, arg_34_1)

	table = var_3

	var_3.insert(arg_34_0.siteShips, arg_34_2)

	return
end

function var_0_1.AddAssessRecord(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.assessRecords[arg_35_1] = arg_35_2

	return
end

function var_0_1.GetResources(arg_36_0)
	Clone = var_1_10001

	return var_1_10001(arg_36_0.resources)
end

function var_0_1.SetResources(arg_37_0, arg_37_1)
	arg_37_0.resources = {}
	ipairs = var_2

	for iter_37_0, iter_37_1 in var_2(arg_37_1) do
		arg_37_0.resources[iter_37_1.key] = iter_37_1.value

		local var_37_0 = arg_37_0.resources
		local var_37_1 = iter_37_1.key

		math = var_9

		local var_37_2 = var_9.max

		pg = var_1_10011
		var_37_0[var_37_1] = var_37_2(var_1_10011.child2_resource[iter_37_1.key].min_value, arg_37_0.resources[iter_37_1.key])

		local var_37_3 = arg_37_0.resources
		local var_37_4 = iter_37_1.key

		math = var_9

		local var_37_5 = var_9.min

		pg = var_1_10011
		var_37_3[var_37_4] = var_37_5(var_1_10011.child2_resource[iter_37_1.key].max_value, arg_37_0.resources[iter_37_1.key])
	end

	return
end

function var_0_1.GetRes(arg_38_0, arg_38_1)
	local var_38_0

	if not arg_38_0.resources[arg_38_1] then
		var_38_0 = 0
	end

	return var_38_0
end

function var_0_1.GetPoint(arg_39_0)
	return arg_39_0:GetResByType(var_0_1.RES_TYPE.ACTION)
end

function var_0_1.GetResByType(arg_40_0, arg_40_1)
	local var_40_0

	if not arg_40_0.resources[arg_40_0:GetResIdByType(arg_40_1)] then
		var_40_0 = 0
	end

	return var_40_0
end

function var_0_1.GetResIdByType(arg_41_0, arg_41_1)
	underscore = var_1_10002

	local var_41_0 = var_1_10002.detect

	underscore = var_1_10004

	return var_41_0(var_1_10004.keys(arg_41_0.resources), function(arg_42_0)
		pg = var_2_10001

		return var_2_10001.child2_resource[arg_42_0].type == arg_41_1
	end)
end

function var_0_1.UpdateRes(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.resources[arg_43_1] then
		warning = var_3

		var_3("不符合当前角色的资源更新！！！")

		arg_43_0.resources[arg_43_1] = 0
	end

	arg_43_0.resources[arg_43_1] = arg_43_0.resources[arg_43_1] + arg_43_2

	local var_43_0 = arg_43_0.resources

	math = var_4

	local var_43_1 = var_4.max

	pg = var_1_10006
	var_43_0[arg_43_1] = var_43_1(var_1_10006.child2_resource[arg_43_1].min_value, arg_43_0.resources[arg_43_1])

	local var_43_2 = arg_43_0.resources

	math = var_4

	local var_43_3 = var_4.min

	pg = var_6
	var_43_2[arg_43_1] = var_43_3(var_6.child2_resource[arg_43_1].max_value, arg_43_0.resources[arg_43_1])

	return
end

function var_0_1.GetMoodStage(arg_44_0, arg_44_1)
	pg = var_1_10002

	local var_44_0 = var_1_10002.gameset.child_emotion.description

	if (arg_44_1 or arg_44_0:GetResByType(var_0_1.RES_TYPE.MOOD)) <= var_44_0[1][1][1] then
		return 1, var_44_0[1][2]
	end

	if var_44_0[#var_44_0][1][2] <= var_3 then
		return #var_44_0, var_44_0[#var_44_0][2]
	end

	ipairs = var_4

	for iter_44_0, iter_44_1 in var_4(var_44_0) do
		if var_3 >= iter_44_1[1][1] and var_3 < iter_44_1[1][2] then
			return iter_44_0, iter_44_1[2]
		end
	end

	return
end

function var_0_1.UpgradeFavor(arg_45_0)
	arg_45_0.gotFavorLv = arg_45_0.gotFavorLv + 1

	return
end

function var_0_1.CheckFavor(arg_46_0)
	local var_46_0 = arg_46_0:GetFavorInfo()

	if not arg_46_0:getConfig("favor_exp")[var_46_0.lv] then
		return false
	end

	return var_2 <= var_46_0.value
end

function var_0_1.GetFavorInfo(arg_47_0)
	local var_47_0 = arg_47_0:GetResByType(var_0_1.RES_TYPE.FAVOR)

	math = var_1_10002

	local var_47_1 = var_1_10002.min(arg_47_0.gotFavorLv + 1, arg_47_0:getConfig("favor_level"))
	local var_47_2 = 0

	if arg_47_0.gotFavorLv > 0 then
		for iter_47_0 = 1, arg_47_0.gotFavorLv do
			var_47_2 = var_47_2 + arg_47_0:getConfig("favor_exp")[iter_47_0]
		end
	end

	return {
		lv = var_47_1,
		value = var_47_0 - var_47_2
	}
end

function var_0_1.GetAttrs(arg_48_0)
	Clone = var_1_10001

	return var_1_10001(arg_48_0.attrs)
end

function var_0_1.SetAttrs(arg_49_0, arg_49_1)
	arg_49_0.attrs = {}
	ipairs = var_2

	for iter_49_0, iter_49_1 in var_2(arg_49_1) do
		arg_49_0.attrs[iter_49_1.key] = iter_49_1.value

		local var_49_0 = arg_49_0.attrs
		local var_49_1 = iter_49_1.key

		math = var_9

		local var_49_2 = var_9.max

		pg = var_1_10011
		var_49_0[var_49_1] = var_49_2(var_1_10011.child2_attr[iter_49_1.key].min_value, arg_49_0.attrs[iter_49_1.key])

		local var_49_3 = arg_49_0.attrs
		local var_49_4 = iter_49_1.key

		math = var_9

		local var_49_5 = var_9.min

		pg = var_1_10011
		var_49_3[var_49_4] = var_49_5(var_1_10011.child2_attr[iter_49_1.key].max_value, arg_49_0.attrs[iter_49_1.key])
	end

	return
end

function var_0_1.GetAttr(arg_50_0, arg_50_1)
	return arg_50_0.attrs[arg_50_1]
end

function var_0_1.GetAttrIds(arg_51_0)
	underscore = var_1_10001

	local var_51_0 = var_1_10001.select

	underscore = var_1_10003

	local var_51_1 = var_51_0(var_1_10003.keys(arg_51_0.attrs), function(arg_52_0)
		pg = var_2_10001

		return var_2_10001.child2_attr[arg_52_0].type == var_0_1.ATTR_TYPE.ATTR
	end)

	table = var_1_10002

	var_1_10002.sort(var_51_1)

	return var_51_1
end

function var_0_1.GetAttrSum(arg_53_0)
	underscore = var_1_10001

	return var_1_10001.reduce(arg_53_0:GetAttrIds(), 0, function(arg_54_0, arg_54_1)
		return arg_54_0 + arg_53_0.attrs[arg_54_1]
	end)
end

function var_0_1.GetPersonalityId(arg_55_0)
	underscore = var_1_10001

	local var_55_0 = var_1_10001.detect

	underscore = var_1_10003

	return var_55_0(var_1_10003.keys(arg_55_0.attrs), function(arg_56_0)
		pg = var_2_10001

		return var_2_10001.child2_attr[arg_56_0].type == var_0_1.ATTR_TYPE.PERSONALITY
	end)
end

function var_0_1.GetPersonality(arg_57_0)
	return arg_57_0.attrs[arg_57_0:GetPersonalityId()]
end

function var_0_1.GetPersonalityMiddle(arg_58_0)
	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.GetPersonalityId(var_58_0)

	pg = var_1_10002

	local var_58_2 = var_1_10002.child2_attr[var_58_1]

	math = var_58_0

	return var_58_0.floor((var_58_2.min_value + var_58_2.max_value) / 2)
end

function var_0_1.GetPersonalityTag(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1 or arg_59_0:GetPersonality()

	switch = var_1_10003

	return (var_1_10003(arg_59_0:getConfig("personality_type"), {
		function()
			ipairs = var_2_10000

			local var_60_0 = arg_59_0

			for iter_60_0, iter_60_1 in var_2_10000(var_2.getConfig(var_60_0, "personality_param")) do
				if var_59_0 >= iter_60_1[2][1] and var_59_0 <= iter_60_1[2][2] then
					return iter_60_1[1]
				end
			end

			local var_60_1 = arg_59_0

			return var_0.getConfig(var_60_1, "personality_param")[1][1]
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "不合法的personality_type")

		return
	end))
end

function var_0_1.GetPersonalityTagTip(arg_62_0, arg_62_1)
	i18n = var_1_10002

	return var_1_10002("child2_personal_id" .. arg_62_0.id .. "_tag" .. arg_62_1)
end

function var_0_1.GetPersonalityTagOptionBg(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0:getConfig("personality_tag_icon")

	underscore = var_1_10003

	return var_1_10003.detect(var_63_0, function(arg_64_0)
		return arg_64_0[1] == "tag" .. arg_63_1
	end)[3]
end

function var_0_1.UpdateAttr(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_0.attrs[arg_65_1] then
		warning = var_3

		var_3("不符合当前角色的属性更新！！！")

		arg_65_0.attrs[arg_65_1] = 0
	end

	arg_65_0.attrs[arg_65_1] = arg_65_0.attrs[arg_65_1] + arg_65_2

	local var_65_0 = arg_65_0.attrs

	math = var_4

	local var_65_1 = var_4.max

	pg = var_1_10006
	var_65_0[arg_65_1] = var_65_1(var_1_10006.child2_attr[arg_65_1].min_value, arg_65_0.attrs[arg_65_1])

	local var_65_2 = arg_65_0.attrs

	math = var_4

	local var_65_3 = var_4.min

	pg = var_6
	var_65_2[arg_65_1] = var_65_3(var_6.child2_attr[arg_65_1].max_value, arg_65_0.attrs[arg_65_1])

	return
end

function var_0_1.GetAssessRankIdx(arg_66_0)
	local var_66_0 = arg_66_0.roundData

	if var_1.getConfig(var_66_0, "target_id") ~= 0 then
		local var_66_1 = arg_66_0.roundData

		if var_2.IsTemp(var_66_1) then
			return 0
		end

		local var_66_2 = arg_66_0.roundData
		local var_66_3 = var_2.GetExtraFactor(var_66_2)
		local var_66_4 = arg_66_0:GetAttrSum()

		pg = var_66_2

		for iter_66_0 = #var_66_2.child2_target[var_1].attr_sum_level, 1, -1 do
			if var_66_4 >= var_4[iter_66_0] * var_66_3 then
				return iter_66_0
			end
		end

		return #var_4
	end
end

function var_0_1.GetAssessPreStory(arg_67_0)
	local var_67_0 = arg_67_0.roundData

	if var_1.getConfig(var_67_0, "target_id") == 0 then
		return nil
	end

	pg = var_1_10002

	return var_1_10002.child2_target[var_1].pre_perform
end

function var_0_1.GetRoundData(arg_68_0)
	return arg_68_0.roundData
end

function var_0_1.GetFSM(arg_69_0)
	return arg_69_0.fsm
end

function var_0_1.GetBgm(arg_70_0)
	local var_70_0 = arg_70_0:GetPersonalityTag()

	underscore = var_1_10002

	return var_1_10002.detect(arg_70_0:getConfig("bgm"), function(arg_71_0)
		return arg_71_0[1] == var_70_0
	end)[2]
end

function var_0_1.GetPaintingName(arg_72_0)
	local var_72_0 = arg_72_0:GetPersonalityTag()

	underscore = var_1_10002

	local var_72_1 = var_1_10002.detect
	local var_72_2 = arg_72_0.roundData

	return var_72_1(var_4.getConfig(var_72_2, "main_painting"), function(arg_73_0)
		return arg_73_0[1] == var_72_0
	end)[2]
end

function var_0_1.GetBGName(arg_74_0)
	local var_74_0 = arg_74_0.roundData

	return var_1.getConfig(var_74_0, "main_background")
end

function var_0_1.GetMainDialogueInfo(arg_75_0)
	local var_75_0 = arg_75_0
	local var_75_1 = arg_75_0.GetPersonalityTag(var_75_0)

	underscore = var_1_10002

	local var_75_2 = var_1_10002.detect
	local var_75_3 = arg_75_0.roundData
	local var_75_4 = var_75_2(var_4.getConfig(var_75_3, "main_word"), function(arg_76_0)
		return arg_76_0[1] == var_75_1
	end)

	underscore = var_75_0

	local var_75_5 = var_75_0.detect
	local var_75_6 = arg_75_0.roundData
	local var_75_7 = var_75_5(var_5.getConfig(var_75_6, "main_word_expression"), function(arg_77_0)
		return arg_77_0[1] == var_75_1
	end)

	return var_75_4[2], var_75_7[2]
end

function var_0_1.OnUpgradedPlan(arg_78_0, arg_78_1)
	pg = var_1_10002

	local var_78_0 = var_1_10002.child2_plan[arg_78_1].group_id

	arg_78_0.group2Plan[var_78_0] = arg_78_1

	return
end

function var_0_1.GetPlanList(arg_79_0)
	local var_79_0 = {}
	local var_79_1 = arg_79_0.roundData
	local var_79_2 = var_2.getConfig(var_79_1, "plan_group")

	ipairs = var_1_10003

	for iter_79_0, iter_79_1 in var_1_10003(var_79_2) do
		pg = var_1_10008

		if #var_1_10008.child2_plan.get_id_list_by_group_id[iter_79_1] == 1 then
			table = var_9

			local var_79_3 = var_9.insert

			var_1_10011 = var_79_0
			NewEducatePlan = var_1_10012

			var_79_3(var_1_10011, var_1_10012.New(var_1_10008[1]))
		else
			local var_79_4

			if arg_79_0.group2Plan[iter_79_1] then
				table = var_79_4
				var_79_4 = var_79_4.insert
				var_1_10011 = var_79_0
				NewEducatePlan = var_1_10012

				var_79_4(var_1_10011, var_1_10012.New(arg_79_0.group2Plan[iter_79_1]))
			else
				table = var_79_4

				var_79_4.sort(var_1_10008, function(arg_80_0, arg_80_1)
					pg = var_2_10002

					local var_80_0 = var_2_10002.child2_plan[arg_80_0].level

					pg = var_2_10003

					return var_80_0 < var_2_10003.child2_plan[arg_80_1].level
				end)

				table = var_9

				local var_79_5 = var_9.insert

				var_1_10011 = var_79_0
				NewEducatePlan = var_1_10012

				var_79_5(var_1_10011, var_1_10012.New(var_1_10008[1]))
			end
		end
	end

	ipairs = var_3

	local var_79_6 = arg_79_0.benefitData

	for iter_79_2, iter_79_3 in var_3(var_5.GetExtraPlan(var_79_6, arg_79_0)) do
		table = var_79_7

		local var_79_7 = var_79_7.insert
		local var_79_8 = var_79_0

		NewEducatePlan = var_1_10011

		var_79_7(var_79_8, var_1_10011.New(iter_79_3, true))
	end

	return var_79_0
end

function var_0_1.OnNextRound(arg_81_0)
	arg_81_0.siteShips = {}

	local var_81_0 = arg_81_0.fsm

	var_1.Reset(var_81_0)

	local var_81_1 = arg_81_0.roundData

	var_1.OnNextRound(var_81_1)

	local var_81_2 = arg_81_0.resources
	local var_81_3 = arg_81_0
	local var_81_4 = arg_81_0.GetResIdByType

	NewEducateChar = var_1_10005

	local var_81_5 = var_81_4(var_81_3, var_1_10005.RES_TYPE.ACTION)
	local var_81_6 = arg_81_0.roundData

	var_81_2[var_81_5] = var_3.getConfig(var_81_6, "map_mobility")

	local var_81_7 = arg_81_0.resources
	local var_81_8 = arg_81_0
	local var_81_9 = arg_81_0.GetResIdByType

	NewEducateChar = var_81_6

	if var_81_7[var_81_9(var_81_8, var_81_6.RES_TYPE.REFRESH_SHOP)] then
		local var_81_10 = arg_81_0.resources
		local var_81_11 = arg_81_0
		local var_81_12 = arg_81_0.GetResIdByType

		NewEducateChar = var_5

		local var_81_13 = var_81_12(var_81_11, var_5.RES_TYPE.REFRESH_SHOP)
		local var_81_14 = arg_81_0.roundData

		var_81_10[var_81_13] = var_3.getConfig(var_81_14, "refresh_refill")
	end

	local var_81_15 = arg_81_0.benefitData

	var_1.OnNextRound(var_81_15, arg_81_0.roundData.round)

	local var_81_16 = arg_81_0.permanentData

	var_1.OnNextRound(var_81_16, arg_81_0.roundData.round)

	return
end

function var_0_1.GetBenefitData(arg_82_0)
	return arg_82_0.benefitData
end

function var_0_1.AddBuff(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = arg_83_0.permanentData

	var_3.CheckBuffRecord(var_83_0, arg_83_1)

	if arg_83_2 > 0 then
		local var_83_1 = arg_83_0.fsm
		local var_83_2 = not var_3.IsImmediateBenefit(var_83_1)
		local var_83_3 = {
			id = arg_83_1,
			round = arg_83_0.roundData.round,
			is_pending = var_83_2
		}
		local var_83_4 = arg_83_0.benefitData

		var_5.AddBuff(var_83_4, var_83_3)
	else
		local var_83_5 = arg_83_0.benefitData

		var_3.RemoveBuff(var_83_5, arg_83_1)
	end

	return
end

function var_0_1.GetTalentList(arg_84_0)
	local var_84_0 = arg_84_0.benefitData
	local var_84_1 = var_1.GetListByType

	NewEducateBuff = var_1_10004

	return var_84_1(var_84_0, var_1_10004.TYPE.TALENT)
end

function var_0_1.GetTalent(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0.benefitData

	return var_2.GetBuff(var_85_0, arg_85_1)
end

function var_0_1.GetStatusList(arg_86_0)
	local var_86_0 = arg_86_0.benefitData
	local var_86_1 = var_1.GetListByType

	NewEducateBuff = var_1_10004

	return var_86_1(var_86_0, var_1_10004.TYPE.STATUS)
end

function var_0_1.GetStatus(arg_87_0, arg_87_1)
	local var_87_0 = arg_87_0.benefitData

	return var_2.GetBuff(var_87_0, arg_87_1)
end

function var_0_1.GetTarotId(arg_88_0)
	local var_88_0 = arg_88_0.benefitData
	local var_88_1 = var_1.GetListByType

	NewEducateBuff = var_1_10004

	return var_88_1(var_88_0, var_1_10004.TYPE.TAROT)[1] and var_1.id
end

function var_0_1.GetGoodsDiscountInfos(arg_89_0)
	local var_89_0 = arg_89_0.benefitData

	return var_1.GetGoodsDiscountInfos(var_89_0, arg_89_0)
end

function var_0_1.GetPlanDiscountInfos(arg_90_0)
	local var_90_0 = arg_90_0.benefitData

	return var_1.GetPlanDiscountInfos(var_90_0, arg_90_0)
end

function var_0_1.IsUnlock(arg_91_0, arg_91_1)
	underscore = var_1_10002

	local var_91_0

	if not var_1_10002.detect(arg_91_0:getConfig("unlock"), function(arg_92_0)
		return arg_92_0[1] == arg_91_1
	end) or not var_2[2] then
		var_91_0 = 1
	end

	return var_91_0 <= arg_91_0.roundData.round
end

function var_0_1.GetOwnCnt(arg_93_0, arg_93_1)
	switch = var_1_10002

	local var_93_0 = arg_93_1.type
	local var_93_1 = {}

	NewEducateConst = var_1_10006
	var_93_1[var_1_10006.DROP_TYPE.ATTR] = function()
		local var_94_0 = arg_93_0

		return var_0.GetAttr(var_94_0, arg_93_1.id)
	end
	NewEducateConst = var_6
	var_93_1[var_6.DROP_TYPE.RES] = function()
		local var_95_0 = arg_93_0

		return var_0.GetRes(var_95_0, arg_93_1.id)
	end
	NewEducateConst = var_6
	var_93_1[var_6.DROP_TYPE.BUFF] = function()
		local var_96_0 = arg_93_0.benefitData

		return var_0.ExistBuff(var_96_0, arg_93_1.id) and 1 or 0
	end

	return var_1_10002(var_93_0, var_93_1, function()
		return 0
	end)
end

function var_0_1.IsMatch(arg_98_0, arg_98_1)
	compareNumber = var_1_10002

	return var_1_10002(arg_98_0:GetOwnCnt(arg_98_1), arg_98_1.operator, arg_98_1.number)
end

function var_0_1.IsMatchs(arg_99_0, arg_99_1)
	underscore = var_1_10002

	return var_1_10002.all(arg_99_1, function(arg_100_0)
		local var_100_0 = arg_99_0

		return var_1.IsMatch(var_100_0, arg_100_0)
	end)
end

function var_0_1.IsMatchCondition(arg_101_0, arg_101_1)
	pg = var_1_10002

	local var_101_0 = var_1_10002.child2_condition[arg_101_1]

	switch = var_1_10003

	local var_101_1 = var_101_0.type
	local var_101_2 = {}

	NewEducateConst = var_1_10007
	var_101_2[var_1_10007.CONDITION_TYPE.DROP] = function()
		local var_102_0 = {
			type = var_101_0.param[1],
			id = var_101_0.param[2],
			number = var_101_0.param[4]
		}

		compareNumber = var_1

		local var_102_1 = arg_101_0

		return var_1(var_3.GetOwnCnt(var_102_1, var_102_0), var_101_0.param[3], var_101_0.param[4])
	end
	NewEducateConst = var_7
	var_101_2[var_7.CONDITION_TYPE.ATTR_SUM] = function()
		compareNumber = var_2_10000

		local var_103_0 = arg_101_0

		return var_2_10000(var_2.GetAttrSum(var_103_0), var_101_0.param[1], var_101_0.param[2])
	end
	NewEducateConst = var_7
	var_101_2[var_7.CONDITION_TYPE.EVENT_SITE_CNT] = function()
		compareNumber = var_2_10000

		local var_104_0 = arg_101_0

		return var_2_10000(var_2.GetEventCnt(var_104_0, var_101_0.param[1]), var_101_0.param[2], var_101_0.param[3])
	end
	NewEducateConst = var_7
	var_101_2[var_7.CONDITION_TYPE.ROUND] = function()
		compareNumber = var_2_10000

		return var_2_10000(arg_101_0.roundData.round, var_101_0.param[1], var_101_0.param[2])
	end
	NewEducateConst = var_7
	var_101_2[var_7.CONDITION_TYPE.NORMAL_SITE_CNT] = function()
		underscore = var_2_10000

		local var_106_0 = var_2_10000.reduce(var_101_0.param[1], 0, function(arg_107_0, arg_107_1)
			local var_107_0 = arg_101_0

			return arg_107_0 + var_2.GetNormalCnt(var_107_0, arg_107_1)
		end)

		compareNumber = var_2_10001

		return var_2_10001(var_106_0, var_101_0.param[2], var_101_0.param[3])
	end

	return (var_1_10003(var_101_1, var_101_2, function()
		assert = var_2_10000

		var_2_10000(false, "非法condition type" .. var_101_0.type)

		return
	end))
end

function var_0_1.LogicalOperator(arg_109_0, arg_109_1)
	type = var_1_10002

	if var_1_10002(arg_109_1) == "number" then
		return arg_109_0:IsMatchCondition(arg_109_1)
	end

	if arg_109_1.operator == "||" then
		if arg_109_1.conditions.operator then
			underscore = var_3

			return var_3.any(arg_109_1.conditions, function(arg_110_0)
				local var_110_0 = arg_109_0

				return var_1.LogicalOperator(var_110_0, arg_110_0)
			end)
		else
			underscore = var_3

			return var_3.any(arg_109_1.conditions, function(arg_111_0)
				local var_111_0 = arg_109_0

				return var_1.IsMatchCondition(var_111_0, arg_111_0)
			end)
		end
	elseif var_2 == "&&" then
		if arg_109_1.conditions.operator then
			underscore = var_3

			return var_3.all(arg_109_1.conditions, function(arg_112_0)
				local var_112_0 = arg_109_0

				return var_1.LogicalOperator(var_112_0, arg_112_0)
			end)
		else
			underscore = var_3

			return var_3.all(arg_109_1.conditions, function(arg_113_0)
				local var_113_0 = arg_109_0

				return var_1.IsMatchCondition(var_113_0, arg_113_0)
			end)
		end
	end

	return
end

function var_0_1.IsFormatCondition(arg_114_0, arg_114_1)
	if arg_114_1[1] == "||" or arg_114_1[1] == "&&" then
		type = var_2

		if var_2(arg_114_1[2]) == "table" then
			type = var_2

			local var_114_0

			if var_2(arg_114_1[2][1]) ~= "number" then
				var_114_0 = false
			else
				var_114_0 = true
			end

			return var_114_0
		end
	end
end

function var_0_1.GetFormatCondition(arg_115_0, arg_115_1)
	type = var_1_10002

	if var_1_10002(arg_115_1) == "number" then
		return arg_115_1
	end

	if arg_115_0:IsFormatCondition(arg_115_1) then
		return {
			operator = arg_115_1[1],
			conditions = arg_115_1[2]
		}
	elseif arg_115_0:IsFormatCondition(arg_115_1[2]) then
		local var_115_0 = {
			operator = arg_115_1[1]
		}

		underscore = var_3
		var_115_0.conditions = var_3.map(arg_115_1[2], function(arg_116_0)
			local var_116_0 = arg_115_0

			var_1.GetFormatCondition(var_116_0, arg_116_0)

			return
		end)

		return var_115_0
	end

	return
end

function var_0_1.IsMatchComplex(arg_117_0, arg_117_1)
	if #arg_117_1 == 0 then
		return true
	end

	return arg_117_0:LogicalOperator(arg_117_0:GetFormatCondition(arg_117_1))
end

function var_0_1.GetConditionIdsFromComplex(arg_118_0, arg_118_1)
	type = var_1_10002

	if var_1_10002(arg_118_1) == "number" then
		return {
			arg_118_1
		}
	end

	type = var_2

	if var_2(arg_118_1) == "table" and #arg_118_1 == 0 then
		return arg_118_1
	end

	if arg_118_0:IsFormatCondition(arg_118_1) then
		return arg_118_1[2]
	elseif arg_118_0:IsFormatCondition(arg_118_1[2]) then
		underscore = var_2

		return var_2.map(arg_118_1[2], function(arg_119_0)
			local var_119_0 = arg_118_0

			var_1.GetConditionIdsFromComplex(var_119_0, arg_119_0)

			return
		end)
	end

	return
end

return var_0_1
