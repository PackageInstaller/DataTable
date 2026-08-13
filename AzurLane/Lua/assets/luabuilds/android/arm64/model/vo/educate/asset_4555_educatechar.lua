class = var_0_10000

local var_0_0 = "EducateChar"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.ATTR_TYPE_MAJOR = 1
var_0_1.ATTR_TYPE_PERSONALITY = 2
var_0_1.ATTR_TYPE_MINOR = 3
var_0_1.RES_MONEY_ID = 1
var_0_1.RES_MOOD_ID = 2
var_0_1.RES_SITE_ID = 3
var_0_1.RES_FAVOR_ID = 4
var_0_1.RES_ID_2_NAME = {
	[var_0_1.RES_MONEY_ID] = "money",
	[var_0_1.RES_MOOD_ID] = "mood",
	[var_0_1.RES_SITE_ID] = "site",
	[var_0_1.RES_FAVOR_ID] = "favor"
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.child_data
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.tid then
		var_2_0 = 1
	end

	arg_2_0.id = var_2_0
	arg_2_0.configId = arg_2_0.id

	arg_2_0:checkCfg()
	arg_2_0:initStageCfg()
	arg_2_0:initFavorCfg()

	local var_2_1

	if not arg_2_1.cur_time then
		var_2_1 = {
			week = 4,
			month = 2,
			day = 7
		}
	end

	arg_2_0.curTime = var_2_1
	arg_2_0.stage = arg_2_0:GetStageByTime(arg_2_0.curTime)

	local var_2_2

	if not arg_2_1.mood then
		pg = var_2_2
		var_2_2 = var_2_2.child_resource[var_0_1.RES_MOOD_ID].default_value
	end

	arg_2_0.mood = var_2_2

	local var_2_3

	if not arg_2_1.money then
		pg = var_2_3
		var_2_3 = var_2_3.child_resource[var_0_1.RES_MONEY_ID].default_value
	end

	arg_2_0.money = var_2_3

	local var_2_4

	if not arg_2_1.site_number then
		var_2_4 = arg_2_0:GetSiteCnt()
	end

	arg_2_0.site = var_2_4

	local var_2_5

	if not arg_2_1.favor then
		var_2_5 = {
			lv = 1,
			exp = 0
		}
	end

	arg_2_0.favor = var_2_5
	arg_2_0.attrs = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.attrs) do
		arg_2_0.attrs[iter_2_1.id] = iter_2_1.val
	end

	arg_2_0.isAddedExtraAttr = arg_2_1.had_adjustment == 1 or false
	EducateHelper = var_2

	local var_2_6 = var_2.GetTimeFromCfg

	pg = var_4
	arg_2_0.addExtraAttrTime = var_2_6(var_4.gameset.child_attr_2_add.description)

	local var_2_7

	if not arg_2_1.user_name then
		var_2_7 = ""
	end

	arg_2_0.callName = var_2_7

	arg_2_0:UpdateMainInfo()

	return
end

function var_0_1.checkCfg(arg_3_0)
	assert = var_1_10001

	var_1_10001(#arg_3_0:getConfig("char_prefab") == #arg_3_0:getConfig("main_word") and #arg_3_0:getConfig("main_word") == #arg_3_0:getConfig("word_expression"), "主界面立绘展示/台词/差分数量不一致，请检查相关配置")

	return
end

function var_0_1.initStageCfg(arg_4_0)
	arg_4_0.stage2timeRange = {}
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0:getConfig("stage")) do
		local var_4_0 = arg_4_0.stage2timeRange
		local var_4_1 = {}

		EducateHelper = var_1_10008
		var_4_1[1] = var_1_10008.CfgTime2Time(iter_4_1)
		var_4_0[iter_4_0] = var_4_1
	end

	return
end

function var_0_1.GetStageByTime(arg_5_0, arg_5_1)
	arg_5_0.time2stage = {}
	pairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.stage2timeRange) do
		EducateHelper = var_1_10007

		if var_1_10007.InTime(arg_5_1, iter_5_1[1], iter_5_1[2]) then
			return iter_5_0
		end
	end

	return 1
end

function var_0_1.initFavorCfg(arg_6_0)
	arg_6_0.favorLv2NeedExp = {}
	arg_6_0.favorLv2PerformIds = {}
	arg_6_0.favorReplaceCfg = {}
	arg_6_0.favorMaxLv = arg_6_0:getConfig("favor_level")
	ipairs = var_1

	for iter_6_0, iter_6_1 in var_1(arg_6_0:getConfig("favor_exp")) do
		arg_6_0.favorLv2NeedExp[iter_6_0] = iter_6_1
		arg_6_0.favorLv2PerformIds[iter_6_0] = arg_6_0:getConfig("trigger_performance")[iter_6_0]
	end

	ipairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0:getConfig("trigger_performance_replace")) do
		arg_6_0.favorReplaceCfg[iter_6_3[1]] = iter_6_3[2]
	end

	return
end

function var_0_1.SetCallName(arg_7_0, arg_7_1)
	arg_7_0.callName = arg_7_1

	return
end

function var_0_1.GetCallName(arg_8_0)
	return arg_8_0.callName
end

function var_0_1.GetName(arg_9_0)
	return arg_9_0:getConfig("name")
end

function var_0_1.GetStage(arg_10_0)
	return arg_10_0.stage
end

function var_0_1.GetNextWeekStage(arg_11_0)
	EducateHelper = var_1_10001

	local var_11_0 = var_1_10001.GetTimeAfterWeeks(arg_11_0.curTime, 1)

	return arg_11_0:GetStageByTime(var_11_0) or 1
end

function var_0_1.GetPlanCnt(arg_12_0)
	return arg_12_0:getConfig("stage_plan_number")[arg_12_0.stage]
end

function var_0_1.GetNextWeekPlanCnt(arg_13_0)
	return arg_13_0:getConfig("stage_plan_number")[arg_13_0:GetNextWeekStage()]
end

function var_0_1.GetSiteCnt(arg_14_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	if not var_1.InVirtualStage(var_14_0) then
		return arg_14_0:getConfig("stage_site_number")[arg_14_0.stage]
	else
		return arg_14_0:getConfig("stage_site_number")[arg_14_0.stage + 1]
	end

	return
end

function var_0_1.GetStageReaminWeek(arg_15_0, arg_15_1)
	return (arg_15_0:getConfig("stage")[arg_15_1][2][1] + 1 - arg_15_0.curTime.month) * 4 - arg_15_0.curTime.week
end

function var_0_1.GetAttrIdsByType(arg_16_0, arg_16_1)
	if arg_16_1 == var_0_1.ATTR_TYPE_MAJOR then
		return arg_16_0:getConfig("attr_1_list")
	end

	if arg_16_1 == var_0_1.ATTR_TYPE_PERSONALITY then
		return arg_16_0:getConfig("attr_2_list")
	end

	if arg_16_1 == var_0_1.ATTR_TYPE_MINOR then
		return arg_16_0:getConfig("attr_3_list")
	end

	return {}
end

function var_0_1.GetAttrTypeById(arg_17_0, arg_17_1)
	table = var_1_10002

	if var_1_10002.contains(arg_17_0:getConfig("attr_1_list"), arg_17_1) then
		return var_0_1.ATTR_TYPE_MAJOR
	end

	table = var_2

	if var_2.contains(arg_17_0:getConfig("attr_2_list"), arg_17_1) then
		return var_0_1.ATTR_TYPE_PERSONALITY
	end

	table = var_2

	if var_2.contains(arg_17_0:getConfig("attr_3_list"), arg_17_1) then
		return var_0_1.ATTR_TYPE_MINOR
	end

	assert = var_2

	var_2(false, "not exist attr id:" .. arg_17_1)

	return
end

function var_0_1.IsPersonalityAttr(arg_18_0, arg_18_1)
	table = var_1_10002

	return var_1_10002.contains(arg_18_0:getConfig("attr_2_list"), arg_18_1)
end

function var_0_1.GetAttrGroupByType(arg_19_0, arg_19_1)
	local var_19_0 = {}

	pairs = var_1_10003

	for iter_19_0, iter_19_1 in var_1_10003(arg_19_0.attrs) do
		pg = var_1_10008

		if var_1_10008.child_attr[iter_19_0].type == arg_19_1 then
			table = var_1_10008

			var_1_10008.insert(var_19_0, {
				iter_19_0,
				iter_19_1
			})
		end
	end

	table = var_3

	local var_19_1 = var_3.sort
	local var_19_2 = var_19_0

	CompareFuncs = iter_19_0

	var_19_1(var_19_2, iter_19_0({
		function(arg_20_0)
			return arg_20_0[1]
		end
	}))

	return var_19_0
end

function var_0_1.GetAttrSortIds(arg_21_0)
	table = var_1_10001

	local var_21_0 = var_1_10001.mergeArray(arg_21_0:getConfig("attr_1_list"), arg_21_0:getConfig("attr_2_list"))

	table = var_1_10002

	local var_21_1 = var_1_10002.mergeArray(var_21_0, arg_21_0:getConfig("attr_3_list"))

	table = var_2

	local var_21_2 = var_2.sort
	local var_21_3 = var_21_1

	CompareFuncs = var_5

	var_21_2(var_21_3, var_5({
		function(arg_22_0)
			local var_22_0 = arg_21_0

			return -var_1.GetAttrById(var_22_0, arg_22_0)
		end,
		function(arg_23_0)
			return arg_23_0
		end
	}))

	return var_21_1
end

function var_0_1.GetAttrById(arg_24_0, arg_24_1)
	local var_24_0

	if not arg_24_0.attrs[arg_24_1] then
		var_24_0 = 0
	end

	return var_24_0
end

function var_0_1.GetAttrInfo(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.child_attr[arg_25_1].rank
	local var_25_1 = arg_25_0.attrs[arg_25_1]

	ipairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(var_25_0) do
		if var_25_1 >= iter_25_1[1][1] and var_25_1 < iter_25_1[1][2] then
			return iter_25_1[2], var_25_1 .. "/" .. iter_25_1[1][2]
		end
	end

	return var_25_0[#var_25_0][2], var_25_1 .. "/" .. var_25_0[#var_25_0][1][2]
end

function var_0_1.UpdateAttr(arg_26_0, arg_26_1, arg_26_2)
	assert = var_1_10003

	var_1_10003(arg_26_0.attrs[arg_26_1], "not exist attr id: " .. arg_26_1)

	arg_26_0.attrs[arg_26_1] = arg_26_0.attrs[arg_26_1] + arg_26_2

	return
end

function var_0_1.GetPersonalityId(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.getConfig(var_27_0, "attr_2_list")[1]

	ipairs = var_27_0

	for iter_27_0, iter_27_1 in var_27_0(var_1) do
		if arg_27_0.attrs[iter_27_1] > arg_27_0.attrs[var_27_1] then
			var_27_1 = iter_27_1
		end
	end

	return var_27_1
end

function var_0_1.CheckExtraAttrAdd(arg_28_0)
	local var_28_0

	if not arg_28_0.isAddedExtraAttr then
		EducateHelper = var_1
		var_28_0 = var_1.IsSameDay(arg_28_0.addExtraAttrTime, arg_28_0.curTime)
	else
		var_28_0 = false
	end

	if false then
		var_28_0 = true
	end

	return var_28_0
end

function var_0_1.SetIsAddedExtraAttr(arg_29_0, arg_29_1)
	arg_29_0.isAddedExtraAttr = arg_29_1

	return
end

function var_0_1.GetResById(arg_30_0, arg_30_1)
	return arg_30_0[var_0_1.RES_ID_2_NAME[arg_30_1]]
end

function var_0_1.UpdateRes(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 ~= var_0_1.RES_FAVOR_ID then
		arg_31_0[var_0_1.RES_ID_2_NAME[arg_31_1]] = arg_31_0[var_0_1.RES_ID_2_NAME[arg_31_1]] + arg_31_2

		local var_31_0 = var_0_1.RES_ID_2_NAME[arg_31_1]

		math = var_4

		local var_31_1 = var_4.max

		pg = var_1_10006
		arg_31_0[var_31_0] = var_31_1(var_1_10006.child_resource[arg_31_1].min_value, arg_31_0[var_0_1.RES_ID_2_NAME[arg_31_1]])

		local var_31_2 = var_0_1.RES_ID_2_NAME[arg_31_1]

		math = var_4

		local var_31_3 = var_4.min

		pg = var_6
		arg_31_0[var_31_2] = var_31_3(var_6.child_resource[arg_31_1].max_value, arg_31_0[var_0_1.RES_ID_2_NAME[arg_31_1]])
	else
		arg_31_0.favor.exp = arg_31_0.favor.exp + arg_31_2
	end

	return
end

function var_0_1.GetFavor(arg_32_0)
	return arg_32_0.favor
end

function var_0_1.GetFavorMaxLv(arg_33_0)
	return arg_33_0.favorMaxLv
end

function var_0_1.GetFavorUpgradExp(arg_34_0, arg_34_1)
	local var_34_0

	if not arg_34_0.favorLv2NeedExp[arg_34_1] then
		var_34_0 = 999999
	end

	return var_34_0
end

function var_0_1.GetFavorUpgradPerformIds(arg_35_0, arg_35_1)
	local var_35_0

	if not arg_35_0:GetPerformByReplace(arg_35_1) then
		var_35_0 = {}
	end

	return var_35_0
end

function var_0_1.GetPerformByReplace(arg_36_0, arg_36_1)
	if arg_36_0.favorReplaceCfg[arg_36_1] then
		local var_36_0 = arg_36_0:GetPersonalityId()

		ipairs = var_1_10003

		for iter_36_0, iter_36_1 in var_1_10003(arg_36_0.favorReplaceCfg[arg_36_1]) do
			if iter_36_1[1] == 1 and var_36_0 == iter_36_1[2] then
				return iter_36_1[3]
			end
		end
	end

	return arg_36_0.favorLv2PerformIds[arg_36_1]
end

function var_0_1.CheckFavor(arg_37_0)
	if arg_37_0.favor.lv >= arg_37_0:GetFavorMaxLv() then
		return false
	end

	return arg_37_0.favor.exp >= arg_37_0:GetFavorUpgradExp(arg_37_0.favor.lv)
end

function var_0_1.UpgradeFavor(arg_38_0)
	local var_38_0 = arg_38_0:GetFavorUpgradExp(arg_38_0.favor.lv)

	arg_38_0.favor.lv = arg_38_0.favor.lv + 1
	arg_38_0.favor.exp = arg_38_0.favor.exp - var_38_0

	return
end

function var_0_1.GetFavorPerformIds(arg_39_0)
	return arg_39_0:GetFavorUpgradPerformIds(arg_39_0.favor.lv)
end

function var_0_1.GetMoodStage(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.gameset.child_emotion.description

	if arg_40_0.mood <= var_40_0[1][1][1] then
		return 1
	end

	if arg_40_0.mood >= var_40_0[#var_40_0][1][2] then
		return #var_40_0
	end

	ipairs = var_2

	for iter_40_0, iter_40_1 in var_2(var_40_0) do
		if arg_40_0.mood >= iter_40_1[1][1] and arg_40_0.mood <= iter_40_1[1][2] then
			return iter_40_0
		end
	end

	return
end

function var_0_1.CheckEndCondition(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.GetPersonalityId(var_41_0)
	local var_41_2 = true

	ipairs = var_41_0

	for iter_41_0, iter_41_1 in var_41_0(arg_41_1) do
		local var_41_3 = iter_41_1[1]

		EducateConst = var_1_10010

		if var_41_3 == var_1_10010.DROP_TYPE_ATTR then
			if not iter_41_1[3] then
				if var_41_1 ~= iter_41_1[2] then
					return false
				end
			elseif arg_41_0.attrs[iter_41_1[2]] < iter_41_1[3] then
				return false
			end
		else
			EducateConst = var_1_10010

			if var_41_3 == var_1_10010.DROP_TYPE_RES and arg_41_0[var_0_1.RES_ID_2_NAME[iter_41_1[2]]] < iter_41_1[3] then
				return false
			end
		end
	end

	return true
end

function var_0_1.getCurMainIndex(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1 or arg_42_0.curTime
	local var_42_1 = arg_42_0:GetPersonalityId()

	ipairs = var_1_10004

	for iter_42_0, iter_42_1 in var_1_10004(arg_42_0:getConfig("char_prefab")) do
		EducateHelper = var_42_2

		local var_42_2, var_42_3 = var_42_2.CfgTime2Time(iter_42_1[1])

		EducateHelper = var_11

		if var_11.InTime(var_42_0, var_42_2, var_42_3) then
			if iter_42_1[2] == 0 then
				return iter_42_0
			elseif iter_42_1[2] == var_42_1 then
				return iter_42_0
			end
		end
	end

	return 1
end

function var_0_1.UpdateMainInfo(arg_43_0)
	local var_43_0 = arg_43_0:getCurMainIndex()

	arg_43_0.paintingName = arg_43_0:getConfig("char_prefab")[var_43_0][3]
	arg_43_0.mainWordList = arg_43_0:getConfig("main_word")[var_43_0]
	arg_43_0.mainFaceList = arg_43_0:getConfig("word_expression")[var_43_0]

	return
end

function var_0_1.GetBGName(arg_44_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_44_0 = var_1_10001(var_1_10003)

	if not var_1.InVirtualStage(var_44_0) then
		local var_44_1

		if not arg_44_0:getConfig("background_prefab")[arg_44_0.stage] then
			var_44_1 = ""
		end

		return var_44_1
	else
		local var_44_2

		if not arg_44_0:getConfig("background_prefab")[arg_44_0.stage + 1] then
			var_44_2 = ""
		end

		return var_44_2
	end

	return
end

function var_0_1.getBgmByStage(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.getConfig(var_45_0, "bgm")[arg_45_1]

	type = var_1_10003

	if var_1_10003(var_45_1) == "string" then
		return var_45_1
	else
		type = var_3

		if var_3(var_45_1) == "table" then
			local var_45_2 = arg_45_0:GetPersonalityId()

			ipairs = var_45_0

			for iter_45_0, iter_45_1 in var_45_0(var_45_1) do
				if iter_45_1[1] == var_45_2 then
					return iter_45_1[2]
				end
			end
		end
	end

	return
end

function var_0_1.GetBgm(arg_46_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_46_0 = var_1_10001(var_1_10003)

	if not var_1.InVirtualStage(var_46_0) then
		return arg_46_0:getBgmByStage(arg_46_0.stage)
	else
		return arg_46_0:getBgmByStage(arg_46_0.stage + 1)
	end

	return
end

function var_0_1.GetPaintingName(arg_47_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_47_0 = var_1_10001(var_1_10003)

	if not var_1.InVirtualStage(var_47_0) then
		local var_47_1

		if not arg_47_0.paintingName then
			var_47_1 = "tbniang"
		end

		return var_47_1
	else
		local var_47_2, var_47_3, var_47_4 = arg_47_0:GetNextWeekMainInfo()

		return var_47_2
	end

	return
end

function var_0_1.GetMainDialogueInfo(arg_48_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_48_0 = var_1_10001(var_1_10003)

	if not var_1.InVirtualStage(var_48_0) then
		return arg_48_0.mainWordList, arg_48_0.mainFaceList
	else
		local var_48_1, var_48_2, var_48_3 = arg_48_0:GetNextWeekMainInfo()

		return var_48_2, var_48_3
	end

	return
end

function var_0_1.GetNextWeekMainInfo(arg_49_0)
	EducateHelper = var_1_10001

	local var_49_0 = var_1_10001.GetTimeAfterWeeks(arg_49_0.curTime, 1)
	local var_49_1 = arg_49_0:getCurMainIndex(var_49_0)

	return arg_49_0:getConfig("char_prefab")[var_49_1][3], arg_49_0:getConfig("main_word")[var_49_1], arg_49_0:getConfig("word_expression")[var_49_1]
end

function var_0_1.OnNewWeek(arg_50_0, arg_50_1)
	arg_50_0.curTime = arg_50_1
	arg_50_0.stage = arg_50_0:GetStageByTime(arg_50_0.curTime)
	arg_50_0.site = arg_50_0:GetSiteCnt()

	arg_50_0:UpdateMainInfo()

	return
end

return var_0_1
