local var_0_0 = class("EducateChar", import("model.vo.BaseVO"))

var_0_0.ATTR_TYPE_MAJOR = 1
var_0_0.ATTR_TYPE_PERSONALITY = 2
var_0_0.ATTR_TYPE_MINOR = 3
var_0_0.RES_MONEY_ID = 1
var_0_0.RES_MOOD_ID = 2
var_0_0.RES_SITE_ID = 3
var_0_0.RES_FAVOR_ID = 4
var_0_0.RES_ID_2_NAME = {
	[var_0_0.RES_MONEY_ID] = "money",
	[var_0_0.RES_MOOD_ID] = "mood",
	[var_0_0.RES_SITE_ID] = "site",
	[var_0_0.RES_FAVOR_ID] = "favor"
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child_data
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.tid or 1
	arg_2_0.configId = arg_2_0.id

	arg_2_0:checkCfg()
	arg_2_0:initStageCfg()
	arg_2_0:initFavorCfg()

	arg_2_0.curTime = arg_2_1.cur_time or {
		week = 4,
		month = 2,
		day = 7
	}
	arg_2_0.stage = arg_2_0:GetStageByTime(arg_2_0.curTime)
	arg_2_0.mood = arg_2_1.mood or pg.child_resource[var_0_0.RES_MOOD_ID].default_value
	arg_2_0.money = arg_2_1.money or pg.child_resource[var_0_0.RES_MONEY_ID].default_value
	arg_2_0.site = arg_2_1.site_number or arg_2_0:GetSiteCnt()
	arg_2_0.favor = arg_2_1.favor or {
		lv = 1,
		exp = 0
	}
	arg_2_0.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.attrs) do
		arg_2_0.attrs[iter_2_1.id] = iter_2_1.val
	end

	arg_2_0.isAddedExtraAttr = arg_2_1.had_adjustment == 1 or false
	arg_2_0.addExtraAttrTime = EducateHelper.GetTimeFromCfg(pg.gameset.child_attr_2_add.description)
	arg_2_0.callName = arg_2_1.user_name or ""

	arg_2_0:UpdateMainInfo()

	return
end

function var_0_0.checkCfg(arg_3_0)
	assert(#arg_3_0:getConfig("char_prefab") == #arg_3_0:getConfig("main_word") and #arg_3_0:getConfig("main_word") == #arg_3_0:getConfig("word_expression"), "主界面立绘展示/台词/差分数量不一致，请检查相关配置")

	return
end

function var_0_0.initStageCfg(arg_4_0)
	arg_4_0.stage2timeRange = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0:getConfig("stage")) do
		arg_4_0.stage2timeRange[iter_4_0] = {
			EducateHelper.CfgTime2Time(iter_4_1)
		}
	end

	return
end

function var_0_0.GetStageByTime(arg_5_0, arg_5_1)
	arg_5_0.time2stage = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.stage2timeRange) do
		if EducateHelper.InTime(arg_5_1, iter_5_1[1], iter_5_1[2]) then
			return iter_5_0
		end
	end

	return 1
end

function var_0_0.initFavorCfg(arg_6_0)
	arg_6_0.favorLv2NeedExp = {}
	arg_6_0.favorLv2PerformIds = {}
	arg_6_0.favorReplaceCfg = {}
	arg_6_0.favorMaxLv = arg_6_0:getConfig("favor_level")

	for iter_6_0, iter_6_1 in ipairs(arg_6_0:getConfig("favor_exp")) do
		arg_6_0.favorLv2NeedExp[iter_6_0] = iter_6_1
		arg_6_0.favorLv2PerformIds[iter_6_0] = arg_6_0:getConfig("trigger_performance")[iter_6_0]
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0:getConfig("trigger_performance_replace")) do
		arg_6_0.favorReplaceCfg[iter_6_3[1]] = iter_6_3[2]
	end

	return
end

function var_0_0.SetCallName(arg_7_0, arg_7_1)
	arg_7_0.callName = arg_7_1

	return
end

function var_0_0.GetCallName(arg_8_0)
	return arg_8_0.callName
end

function var_0_0.GetName(arg_9_0)
	return arg_9_0:getConfig("name")
end

function var_0_0.GetStage(arg_10_0)
	return arg_10_0.stage
end

function var_0_0.GetNextWeekStage(arg_11_0)
	return arg_11_0:GetStageByTime((EducateHelper.GetTimeAfterWeeks(arg_11_0.curTime, 1))) or 1
end

function var_0_0.GetPlanCnt(arg_12_0)
	return arg_12_0:getConfig("stage_plan_number")[arg_12_0.stage]
end

function var_0_0.GetNextWeekPlanCnt(arg_13_0)
	return arg_13_0:getConfig("stage_plan_number")[arg_13_0:GetNextWeekStage()]
end

function var_0_0.GetSiteCnt(arg_14_0)
	if not getProxy(EducateProxy):InVirtualStage() then
		return arg_14_0:getConfig("stage_site_number")[arg_14_0.stage]
	else
		return arg_14_0:getConfig("stage_site_number")[arg_14_0.stage + 1]
	end

	return
end

function var_0_0.GetStageReaminWeek(arg_15_0, arg_15_1)
	return (arg_15_0:getConfig("stage")[arg_15_1][2][1] + 1 - arg_15_0.curTime.month) * 4 - arg_15_0.curTime.week
end

function var_0_0.GetAttrIdsByType(arg_16_0, arg_16_1)
	if arg_16_1 == var_0_0.ATTR_TYPE_MAJOR then
		return arg_16_0:getConfig("attr_1_list")
	end

	if arg_16_1 == var_0_0.ATTR_TYPE_PERSONALITY then
		return arg_16_0:getConfig("attr_2_list")
	end

	if arg_16_1 == var_0_0.ATTR_TYPE_MINOR then
		return arg_16_0:getConfig("attr_3_list")
	end

	return {}
end

function var_0_0.GetAttrTypeById(arg_17_0, arg_17_1)
	if table.contains(arg_17_0:getConfig("attr_1_list"), arg_17_1) then
		return var_0_0.ATTR_TYPE_MAJOR
	end

	if table.contains(arg_17_0:getConfig("attr_2_list"), arg_17_1) then
		return var_0_0.ATTR_TYPE_PERSONALITY
	end

	if table.contains(arg_17_0:getConfig("attr_3_list"), arg_17_1) then
		return var_0_0.ATTR_TYPE_MINOR
	end

	assert(false, "not exist attr id:" .. arg_17_1)

	return
end

function var_0_0.IsPersonalityAttr(arg_18_0, arg_18_1)
	return table.contains(arg_18_0:getConfig("attr_2_list"), arg_18_1)
end

function var_0_0.GetAttrGroupByType(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.attrs) do
		if pg.child_attr[iter_19_0].type == arg_19_1 then
			table.insert({}, {
				iter_19_0,
				iter_19_1
			})
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_20_0)
			return arg_20_0[1]
		end
	}))

	return {}
end

function var_0_0.GetAttrSortIds(arg_21_0)
	local var_21_0 = table.mergeArray(table.mergeArray(arg_21_0:getConfig("attr_1_list"), arg_21_0:getConfig("attr_2_list")), arg_21_0:getConfig("attr_3_list"))

	table.sort(var_21_0, CompareFuncs({
		function(arg_22_0)
			return -arg_21_0:GetAttrById(arg_22_0)
		end,
		function(arg_23_0)
			return arg_23_0
		end
	}))

	return var_21_0
end

function var_0_0.GetAttrById(arg_24_0, arg_24_1)
	return arg_24_0.attrs[arg_24_1] or 0
end

function var_0_0.GetAttrInfo(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(pg.child_attr[arg_25_1].rank) do
		if arg_25_0.attrs[arg_25_1] >= iter_25_1[1][1] and arg_25_0.attrs[arg_25_1] < iter_25_1[1][2] then
			return iter_25_1[2], arg_25_0.attrs[arg_25_1] .. "/" .. iter_25_1[1][2]
		end
	end

	return pg.child_attr[arg_25_1].rank[#pg.child_attr[arg_25_1].rank][2], arg_25_0.attrs[arg_25_1] .. "/" .. pg.child_attr[arg_25_1].rank[#pg.child_attr[arg_25_1].rank][1][2]
end

function var_0_0.UpdateAttr(arg_26_0, arg_26_1, arg_26_2)
	assert(arg_26_0.attrs[arg_26_1], "not exist attr id: " .. arg_26_1)

	arg_26_0.attrs[arg_26_1] = arg_26_0.attrs[arg_26_1] + arg_26_2

	return
end

function var_0_0.GetPersonalityId(arg_27_0)
	local var_27_0 = arg_27_0:getConfig("attr_2_list")
	local var_27_1 = var_27_0[1]

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if arg_27_0.attrs[iter_27_1] > arg_27_0.attrs[var_27_1] then
			var_27_1 = iter_27_1
		end
	end

	return var_27_1
end

function var_0_0.CheckExtraAttrAdd(arg_28_0)
	return not arg_28_0.isAddedExtraAttr and EducateHelper.IsSameDay(arg_28_0.addExtraAttrTime, arg_28_0.curTime)
end

function var_0_0.SetIsAddedExtraAttr(arg_29_0, arg_29_1)
	arg_29_0.isAddedExtraAttr = arg_29_1

	return
end

function var_0_0.GetResById(arg_30_0, arg_30_1)
	return arg_30_0[var_0_0.RES_ID_2_NAME[arg_30_1]]
end

function var_0_0.UpdateRes(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 ~= var_0_0.RES_FAVOR_ID then
		arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]] = arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]] + arg_31_2
		arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]] = math.max(pg.child_resource[arg_31_1].min_value, arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]])
		arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]] = math.min(pg.child_resource[arg_31_1].max_value, arg_31_0[var_0_0.RES_ID_2_NAME[arg_31_1]])
	else
		arg_31_0.favor.exp = arg_31_0.favor.exp + arg_31_2
	end

	return
end

function var_0_0.GetFavor(arg_32_0)
	return arg_32_0.favor
end

function var_0_0.GetFavorMaxLv(arg_33_0)
	return arg_33_0.favorMaxLv
end

function var_0_0.GetFavorUpgradExp(arg_34_0, arg_34_1)
	return arg_34_0.favorLv2NeedExp[arg_34_1] or 999999
end

function var_0_0.GetFavorUpgradPerformIds(arg_35_0, arg_35_1)
	return arg_35_0:GetPerformByReplace(arg_35_1) or {}
end

function var_0_0.GetPerformByReplace(arg_36_0, arg_36_1)
	if arg_36_0.favorReplaceCfg[arg_36_1] then
		local var_36_0 = arg_36_0:GetPersonalityId()

		for iter_36_0, iter_36_1 in ipairs(arg_36_0.favorReplaceCfg[arg_36_1]) do
			if iter_36_1[1] == 1 and var_36_0 == iter_36_1[2] then
				return iter_36_1[3]
			end
		end
	end

	return arg_36_0.favorLv2PerformIds[arg_36_1]
end

function var_0_0.CheckFavor(arg_37_0)
	if arg_37_0.favor.lv >= arg_37_0:GetFavorMaxLv() then
		return false
	end

	return arg_37_0.favor.exp >= arg_37_0:GetFavorUpgradExp(arg_37_0.favor.lv)
end

function var_0_0.UpgradeFavor(arg_38_0)
	arg_38_0.favor.lv = arg_38_0.favor.lv + 1
	arg_38_0.favor.exp = arg_38_0.favor.exp - arg_38_0:GetFavorUpgradExp(arg_38_0.favor.lv)

	return
end

function var_0_0.GetFavorPerformIds(arg_39_0)
	return arg_39_0:GetFavorUpgradPerformIds(arg_39_0.favor.lv)
end

function var_0_0.GetMoodStage(arg_40_0)
	if arg_40_0.mood <= pg.gameset.child_emotion.description[1][1][1] then
		return 1
	end

	if arg_40_0.mood >= pg.gameset.child_emotion.description[#pg.gameset.child_emotion.description][1][2] then
		return #pg.gameset.child_emotion.description
	end

	for iter_40_0, iter_40_1 in ipairs(pg.gameset.child_emotion.description) do
		if arg_40_0.mood >= iter_40_1[1][1] and arg_40_0.mood <= iter_40_1[1][2] then
			return iter_40_0
		end
	end

	return
end

function var_0_0.CheckEndCondition(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:GetPersonalityId()

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1[1] == EducateConst.DROP_TYPE_ATTR then
			if not iter_41_1[3] then
				if var_41_0 ~= iter_41_1[2] then
					return false
				end
			elseif arg_41_0.attrs[iter_41_1[2]] < iter_41_1[3] then
				return false
			end
		elseif iter_41_1[1] == EducateConst.DROP_TYPE_RES and arg_41_0[var_0_0.RES_ID_2_NAME[iter_41_1[2]]] < iter_41_1[3] then
			return false
		end
	end

	return true
end

function var_0_0.getCurMainIndex(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1 or arg_42_0.curTime
	local var_42_1 = arg_42_0:GetPersonalityId()

	for iter_42_0, iter_42_1 in ipairs(arg_42_0:getConfig("char_prefab")) do
		local var_42_2, var_42_3 = EducateHelper.CfgTime2Time(iter_42_1[1])

		if EducateHelper.InTime(var_42_0, var_42_2, var_42_3) then
			if iter_42_1[2] == 0 then
				return iter_42_0
			elseif iter_42_1[2] == var_42_1 then
				return iter_42_0
			end
		end
	end

	return 1
end

function var_0_0.UpdateMainInfo(arg_43_0)
	local var_43_0 = arg_43_0:getCurMainIndex()

	arg_43_0.paintingName = arg_43_0:getConfig("char_prefab")[var_43_0][3]
	arg_43_0.mainWordList = arg_43_0:getConfig("main_word")[var_43_0]
	arg_43_0.mainFaceList = arg_43_0:getConfig("word_expression")[var_43_0]

	return
end

function var_0_0.GetBGName(arg_44_0)
	if not getProxy(EducateProxy):InVirtualStage() then
		return arg_44_0:getConfig("background_prefab")[arg_44_0.stage] or ""
	else
		return arg_44_0:getConfig("background_prefab")[arg_44_0.stage + 1] or ""
	end

	return
end

function var_0_0.getBgmByStage(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getConfig("bgm")[arg_45_1]

	if type(var_45_0) == "string" then
		return var_45_0
	elseif type(var_45_0) == "table" then
		local var_45_1 = arg_45_0:GetPersonalityId()

		for iter_45_0, iter_45_1 in ipairs(var_45_0) do
			if iter_45_1[1] == var_45_1 then
				return iter_45_1[2]
			end
		end
	end

	return
end

function var_0_0.GetBgm(arg_46_0)
	if not getProxy(EducateProxy):InVirtualStage() then
		return arg_46_0:getBgmByStage(arg_46_0.stage)
	else
		return arg_46_0:getBgmByStage(arg_46_0.stage + 1)
	end

	return
end

function var_0_0.GetPaintingName(arg_47_0)
	if not getProxy(EducateProxy):InVirtualStage() then
		return arg_47_0.paintingName or "tbniang"
	else
		local var_47_1, var_47_2, var_47_3 = arg_47_0:GetNextWeekMainInfo()

		return var_47_1
	end

	return
end

function var_0_0.GetMainDialogueInfo(arg_48_0)
	if not getProxy(EducateProxy):InVirtualStage() then
		return arg_48_0.mainWordList, arg_48_0.mainFaceList
	else
		local var_48_0, var_48_1, var_48_2 = arg_48_0:GetNextWeekMainInfo()

		return var_48_1, var_48_2
	end

	return
end

function var_0_0.GetNextWeekMainInfo(arg_49_0)
	local var_49_0 = arg_49_0:getCurMainIndex((EducateHelper.GetTimeAfterWeeks(arg_49_0.curTime, 1)))

	return arg_49_0:getConfig("char_prefab")[var_49_0][3], arg_49_0:getConfig("main_word")[var_49_0], arg_49_0:getConfig("word_expression")[var_49_0]
end

function var_0_0.OnNewWeek(arg_50_0, arg_50_1)
	arg_50_0.curTime = arg_50_1
	arg_50_0.stage = arg_50_0:GetStageByTime(arg_50_0.curTime)
	arg_50_0.site = arg_50_0:GetSiteCnt()

	arg_50_0:UpdateMainInfo()

	return
end

return var_0_0
