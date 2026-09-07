local EducateChar = class("EducateChar", import("model.vo.BaseVO"))

EducateChar.ATTR_TYPE_MAJOR = 1
EducateChar.ATTR_TYPE_PERSONALITY = 2
EducateChar.ATTR_TYPE_MINOR = 3
EducateChar.RES_MONEY_ID = 1
EducateChar.RES_MOOD_ID = 2
EducateChar.RES_SITE_ID = 3
EducateChar.RES_FAVOR_ID = 4
EducateChar.RES_ID_2_NAME = {
	[EducateChar.RES_MONEY_ID] = "money",
	[EducateChar.RES_MOOD_ID] = "mood",
	[EducateChar.RES_SITE_ID] = "site",
	[EducateChar.RES_FAVOR_ID] = "favor"
}

function EducateChar:bindConfigTable()
	return pg.child_data
end

function EducateChar:Ctor(arg_2_1)
	self.id = arg_2_1.tid or 1
	self.configId = self.id

	self:checkCfg()
	self:initStageCfg()
	self:initFavorCfg()

	self.curTime = arg_2_1.cur_time or {
		week = 4,
		month = 2,
		day = 7
	}
	self.stage = self:GetStageByTime(self.curTime)
	self.mood = arg_2_1.mood or pg.child_resource[EducateChar.RES_MOOD_ID].default_value
	self.money = arg_2_1.money or pg.child_resource[EducateChar.RES_MONEY_ID].default_value
	self.site = arg_2_1.site_number or self:GetSiteCnt()
	self.favor = arg_2_1.favor or {
		lv = 1,
		exp = 0
	}
	self.attrs = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.attrs) do
		self.attrs[iter_2_1.id] = iter_2_1.val
	end

	self.isAddedExtraAttr = arg_2_1.had_adjustment == 1 or false
	self.addExtraAttrTime = EducateHelper.GetTimeFromCfg(pg.gameset.child_attr_2_add.description)
	self.callName = arg_2_1.user_name or ""

	self:UpdateMainInfo()

	return
end

function EducateChar:checkCfg()
	assert(#self:getConfig("char_prefab") == #self:getConfig("main_word") and #self:getConfig("main_word") == #self:getConfig("word_expression"), "主界面立绘展示/台词/差分数量不一致，请检查相关配置")

	return
end

function EducateChar:initStageCfg()
	self.stage2timeRange = {}

	for iter_4_0, iter_4_1 in ipairs(self:getConfig("stage")) do
		self.stage2timeRange[iter_4_0] = {
			EducateHelper.CfgTime2Time(iter_4_1)
		}
	end

	return
end

function EducateChar:GetStageByTime(arg_5_1)
	self.time2stage = {}

	for iter_5_0, iter_5_1 in pairs(self.stage2timeRange) do
		if EducateHelper.InTime(arg_5_1, iter_5_1[1], iter_5_1[2]) then
			return iter_5_0
		end
	end

	return 1
end

function EducateChar:initFavorCfg()
	self.favorLv2NeedExp = {}
	self.favorLv2PerformIds = {}
	self.favorReplaceCfg = {}
	self.favorMaxLv = self:getConfig("favor_level")

	for iter_6_0, iter_6_1 in ipairs(self:getConfig("favor_exp")) do
		self.favorLv2NeedExp[iter_6_0] = iter_6_1
		self.favorLv2PerformIds[iter_6_0] = self:getConfig("trigger_performance")[iter_6_0]
	end

	for iter_6_2, iter_6_3 in ipairs(self:getConfig("trigger_performance_replace")) do
		self.favorReplaceCfg[iter_6_3[1]] = iter_6_3[2]
	end

	return
end

function EducateChar:SetCallName(arg_7_1)
	self.callName = arg_7_1

	return
end

function EducateChar:GetCallName()
	return self.callName
end

function EducateChar:GetName()
	return self:getConfig("name")
end

function EducateChar:GetStage()
	return self.stage
end

function EducateChar:GetNextWeekStage()
	return self:GetStageByTime((EducateHelper.GetTimeAfterWeeks(self.curTime, 1))) or 1
end

function EducateChar:GetPlanCnt()
	return self:getConfig("stage_plan_number")[self.stage]
end

function EducateChar:GetNextWeekPlanCnt()
	return self:getConfig("stage_plan_number")[self:GetNextWeekStage()]
end

function EducateChar:GetSiteCnt()
	if not getProxy(EducateProxy):InVirtualStage() then
		return self:getConfig("stage_site_number")[self.stage]
	else
		return self:getConfig("stage_site_number")[self.stage + 1]
	end

	return
end

function EducateChar:GetStageReaminWeek(arg_15_1)
	return (self:getConfig("stage")[arg_15_1][2][1] + 1 - self.curTime.month) * 4 - self.curTime.week
end

function EducateChar:GetAttrIdsByType(arg_16_1)
	if arg_16_1 == EducateChar.ATTR_TYPE_MAJOR then
		return self:getConfig("attr_1_list")
	end

	if arg_16_1 == EducateChar.ATTR_TYPE_PERSONALITY then
		return self:getConfig("attr_2_list")
	end

	if arg_16_1 == EducateChar.ATTR_TYPE_MINOR then
		return self:getConfig("attr_3_list")
	end

	return {}
end

function EducateChar:GetAttrTypeById(arg_17_1)
	if table.contains(self:getConfig("attr_1_list"), arg_17_1) then
		return EducateChar.ATTR_TYPE_MAJOR
	end

	if table.contains(self:getConfig("attr_2_list"), arg_17_1) then
		return EducateChar.ATTR_TYPE_PERSONALITY
	end

	if table.contains(self:getConfig("attr_3_list"), arg_17_1) then
		return EducateChar.ATTR_TYPE_MINOR
	end

	assert(false, "not exist attr id:" .. arg_17_1)

	return
end

function EducateChar:IsPersonalityAttr(arg_18_1)
	return table.contains(self:getConfig("attr_2_list"), arg_18_1)
end

function EducateChar:GetAttrGroupByType(arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self.attrs) do
		if pg.child_attr[iter_19_0].type == arg_19_1 then
			table.insert(var_19_0, {
				iter_19_0,
				iter_19_1
			})
		end
	end

	table.sort(var_19_0, CompareFuncs({
		function(arg_20_0)
			return arg_20_0[1]
		end
	}))

	return var_19_0
end

function EducateChar:GetAttrSortIds()
	local var_21_0 = table.mergeArray(table.mergeArray(self:getConfig("attr_1_list"), self:getConfig("attr_2_list")), self:getConfig("attr_3_list"))

	table.sort(var_21_0, CompareFuncs({
		function(arg_22_0)
			return -self:GetAttrById(arg_22_0)
		end,
		function(arg_23_0)
			return arg_23_0
		end
	}))

	return var_21_0
end

function EducateChar:GetAttrById(arg_24_1)
	return self.attrs[arg_24_1] or 0
end

function EducateChar:GetAttrInfo(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(pg.child_attr[arg_25_1].rank) do
		if self.attrs[arg_25_1] >= iter_25_1[1][1] and self.attrs[arg_25_1] < iter_25_1[1][2] then
			return iter_25_1[2], self.attrs[arg_25_1] .. "/" .. iter_25_1[1][2]
		end
	end

	return pg.child_attr[arg_25_1].rank[#pg.child_attr[arg_25_1].rank][2], self.attrs[arg_25_1] .. "/" .. pg.child_attr[arg_25_1].rank[#pg.child_attr[arg_25_1].rank][1][2]
end

function EducateChar:UpdateAttr(arg_26_1, arg_26_2)
	assert(self.attrs[arg_26_1], "not exist attr id: " .. arg_26_1)

	self.attrs[arg_26_1] = self.attrs[arg_26_1] + arg_26_2

	return
end

function EducateChar:GetPersonalityId()
	local var_27_0 = self:getConfig("attr_2_list")
	local var_27_1 = var_27_0[1]

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if self.attrs[iter_27_1] > self.attrs[var_27_1] then
			var_27_1 = iter_27_1
		end
	end

	return var_27_1
end

function EducateChar:CheckExtraAttrAdd()
	return not self.isAddedExtraAttr and EducateHelper.IsSameDay(self.addExtraAttrTime, self.curTime)
end

function EducateChar:SetIsAddedExtraAttr(arg_29_1)
	self.isAddedExtraAttr = arg_29_1

	return
end

function EducateChar:GetResById(arg_30_1)
	return self[EducateChar.RES_ID_2_NAME[arg_30_1]]
end

function EducateChar:UpdateRes(arg_31_1, arg_31_2)
	if arg_31_1 ~= EducateChar.RES_FAVOR_ID then
		self[EducateChar.RES_ID_2_NAME[arg_31_1]] = self[EducateChar.RES_ID_2_NAME[arg_31_1]] + arg_31_2
		self[EducateChar.RES_ID_2_NAME[arg_31_1]] = math.max(pg.child_resource[arg_31_1].min_value, self[EducateChar.RES_ID_2_NAME[arg_31_1]])
		self[EducateChar.RES_ID_2_NAME[arg_31_1]] = math.min(pg.child_resource[arg_31_1].max_value, self[EducateChar.RES_ID_2_NAME[arg_31_1]])
	else
		self.favor.exp = self.favor.exp + arg_31_2
	end

	return
end

function EducateChar:GetFavor()
	return self.favor
end

function EducateChar:GetFavorMaxLv()
	return self.favorMaxLv
end

function EducateChar:GetFavorUpgradExp(arg_34_1)
	return self.favorLv2NeedExp[arg_34_1] or 999999
end

function EducateChar:GetFavorUpgradPerformIds(arg_35_1)
	return self:GetPerformByReplace(arg_35_1) or {}
end

function EducateChar:GetPerformByReplace(arg_36_1)
	if self.favorReplaceCfg[arg_36_1] then
		local var_36_0 = self:GetPersonalityId()

		for iter_36_0, iter_36_1 in ipairs(self.favorReplaceCfg[arg_36_1]) do
			if iter_36_1[1] == 1 and var_36_0 == iter_36_1[2] then
				return iter_36_1[3]
			end
		end
	end

	return self.favorLv2PerformIds[arg_36_1]
end

function EducateChar:CheckFavor()
	if self.favor.lv >= self:GetFavorMaxLv() then
		return false
	end

	return self.favor.exp >= self:GetFavorUpgradExp(self.favor.lv)
end

function EducateChar:UpgradeFavor()
	self.favor.lv = self.favor.lv + 1
	self.favor.exp = self.favor.exp - self:GetFavorUpgradExp(self.favor.lv)

	return
end

function EducateChar:GetFavorPerformIds()
	return self:GetFavorUpgradPerformIds(self.favor.lv)
end

function EducateChar:GetMoodStage()
	if self.mood <= pg.gameset.child_emotion.description[1][1][1] then
		return 1
	end

	if self.mood >= pg.gameset.child_emotion.description[#pg.gameset.child_emotion.description][1][2] then
		return #pg.gameset.child_emotion.description
	end

	for iter_40_0, iter_40_1 in ipairs(pg.gameset.child_emotion.description) do
		if self.mood >= iter_40_1[1][1] and self.mood <= iter_40_1[1][2] then
			return iter_40_0
		end
	end

	return
end

function EducateChar:CheckEndCondition(arg_41_1)
	local var_41_0 = self:GetPersonalityId()

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1[1] == EducateConst.DROP_TYPE_ATTR then
			if not iter_41_1[3] then
				if var_41_0 ~= iter_41_1[2] then
					return false
				end
			elseif self.attrs[iter_41_1[2]] < iter_41_1[3] then
				return false
			end
		elseif iter_41_1[1] == EducateConst.DROP_TYPE_RES and self[EducateChar.RES_ID_2_NAME[iter_41_1[2]]] < iter_41_1[3] then
			return false
		end
	end

	return true
end

function EducateChar:getCurMainIndex(arg_42_1)
	local var_42_0 = arg_42_1 or self.curTime
	local var_42_1 = self:GetPersonalityId()

	for iter_42_0, iter_42_1 in ipairs(self:getConfig("char_prefab")) do
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

function EducateChar:UpdateMainInfo()
	local var_43_0 = self:getCurMainIndex()

	self.paintingName = self:getConfig("char_prefab")[var_43_0][3]
	self.mainWordList = self:getConfig("main_word")[var_43_0]
	self.mainFaceList = self:getConfig("word_expression")[var_43_0]

	return
end

function EducateChar:GetBGName()
	if not getProxy(EducateProxy):InVirtualStage() then
		return self:getConfig("background_prefab")[self.stage] or ""
	else
		return self:getConfig("background_prefab")[self.stage + 1] or ""
	end

	return
end

function EducateChar:getBgmByStage(arg_45_1)
	local var_45_0 = self:getConfig("bgm")[arg_45_1]

	if type(var_45_0) == "string" then
		return var_45_0
	elseif type(var_45_0) == "table" then
		local var_45_1 = self:GetPersonalityId()

		for iter_45_0, iter_45_1 in ipairs(var_45_0) do
			if iter_45_1[1] == var_45_1 then
				return iter_45_1[2]
			end
		end
	end

	return
end

function EducateChar:GetBgm()
	if not getProxy(EducateProxy):InVirtualStage() then
		return self:getBgmByStage(self.stage)
	else
		return self:getBgmByStage(self.stage + 1)
	end

	return
end

function EducateChar:GetPaintingName()
	if not getProxy(EducateProxy):InVirtualStage() then
		return self.paintingName or "tbniang"
	else
		local var_47_1, var_47_2, var_47_3 = self:GetNextWeekMainInfo()

		return var_47_1
	end

	return
end

function EducateChar:GetMainDialogueInfo()
	if not getProxy(EducateProxy):InVirtualStage() then
		return self.mainWordList, self.mainFaceList
	else
		local var_48_0, var_48_1, var_48_2 = self:GetNextWeekMainInfo()

		return var_48_1, var_48_2
	end

	return
end

function EducateChar:GetNextWeekMainInfo()
	local var_49_0 = self:getCurMainIndex((EducateHelper.GetTimeAfterWeeks(self.curTime, 1)))

	return self:getConfig("char_prefab")[var_49_0][3], self:getConfig("main_word")[var_49_0], self:getConfig("word_expression")[var_49_0]
end

function EducateChar:OnNewWeek(arg_50_1)
	self.curTime = arg_50_1
	self.stage = self:GetStageByTime(self.curTime)
	self.site = self:GetSiteCnt()

	self:UpdateMainInfo()

	return
end

return EducateChar
