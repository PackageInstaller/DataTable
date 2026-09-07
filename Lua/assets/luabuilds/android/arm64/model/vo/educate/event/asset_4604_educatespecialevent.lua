local EducateSpecialEvent = class("EducateSpecialEvent", import("model.vo.BaseVO"))

EducateSpecialEvent.TYPE_PLAN = 1
EducateSpecialEvent.TYPE_SITE = 2
EducateSpecialEvent.TYPE_BUBBLE_MIND = 3
EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT = 4
EducateSpecialEvent.TAG_ING = 1
EducateSpecialEvent.TAG_COMING = 2
EducateSpecialEvent.TAG_END = 3
EducateSpecialEvent.TAG2NAME = {
	[EducateSpecialEvent.TAG_ING] = "ING",
	[EducateSpecialEvent.TAG_COMING] = "COMING",
	[EducateSpecialEvent.TAG_END] = "END"
}

function EducateSpecialEvent:Ctor(arg_1_1)
	self.id = arg_1_1
	self.configId = self.id

	self:initTime()

	return
end

function EducateSpecialEvent:bindConfigTable()
	return pg.child_event_special
end

function EducateSpecialEvent:GetType()
	return self:getConfig("type")
end

function EducateSpecialEvent:IsPlanType()
	return self:GetType() == EducateSpecialEvent.TYPE_PLAN
end

function EducateSpecialEvent:GetGridIndexs()
	local var_5_0 = {}

	for iter_5_0 = self.startTime.day, self.endTime.day do
		for iter_5_1 = self:getConfig("date")[1][4], self:getConfig("date")[2][4] do
			table.insert(var_5_0, {
				iter_5_0,
				iter_5_1
			})
		end
	end

	return var_5_0
end

function EducateSpecialEvent:IsSiteType()
	return self:GetType() == EducateSpecialEvent.TYPE_SITE
end

function EducateSpecialEvent:IsMatchSite(arg_7_1)
	return table.contains(self:getConfig("type_param"), arg_7_1)
end

function EducateSpecialEvent:initTime()
	self.startTime, self.endTime = EducateHelper.CfgTime2Time((self:getConfig("date")))

	return
end

function EducateSpecialEvent:InTime(arg_9_1)
	return EducateHelper.InTime(arg_9_1, self.startTime, self.endTime)
end

function EducateSpecialEvent:IsMatch(arg_10_1)
	if self:getConfig("child_attr2") == 0 then
		return true
	end

	return self:getConfig("child_attr2") == arg_10_1
end

function EducateSpecialEvent:IsUnlockSite()
	if not self:IsSiteType() then
		return true
	end

	return EducateHelper.IsSiteUnlock(self:getConfig("type_param")[1], getProxy(EducateProxy):IsFirstGame())
end

function EducateSpecialEvent:InNextWeekTime(arg_12_1)
	local var_12_0 = EducateHelper.GetTimeAfterDays(arg_12_1, 7)

	return var_12_0.month >= self.startTime.month and var_12_0.month <= self.endTime.month and var_12_0.week >= self.startTime.week and var_12_0.week <= self.endTime.week
end

function EducateSpecialEvent:GetPerformance()
	return self:getConfig("performance")
end

function EducateSpecialEvent:GetResult()
	return self:getConfig("result_display") or {}
end

function EducateSpecialEvent:InMonth(arg_15_1)
	return arg_15_1 <= self.startTime.month and arg_15_1 >= self.endTime.month
end

function EducateSpecialEvent:IsShow()
	return self:getConfig("show") ~= 0
end

function EducateSpecialEvent:IsImport()
	return self:getConfig("show") == 1
end

function EducateSpecialEvent:IsOther()
	return self:getConfig("show") == 2
end

function EducateSpecialEvent:GetTag(arg_19_1, arg_19_2)
	if table.contains(arg_19_1, self.id) or arg_19_2 > self.endTime.week then
		return EducateSpecialEvent.TAG_END
	else
		return (arg_19_2 >= self.startTime.week or nil) and (EducateSpecialEvent.TAG_ING or EducateSpecialEvent.TAG_COMING)
	end

	return
end

function EducateSpecialEvent:GetTimeDesc()
	if self.startTime.week == self.endTime.week then
		return i18n("word_which_week", self.startTime.week)
	else
		return i18n("word_which_week", self.startTime.week) .. "-" .. i18n("word_which_week", self.endTime.week)
	end

	return
end

function EducateSpecialEvent:GetDiscountShopId()
	if self:getConfig("type") == EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT then
		return pg.child_site_option[self:getConfig("type_param")[1]].param[1]
	end

	assert(nil, "not discount type:" .. self.id)

	return
end

function EducateSpecialEvent:GetDiscountRatio()
	if self:getConfig("type") == EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT then
		return self:getConfig("type_param")[2]
	end

	assert(nil, "not discount type:" .. self.id)

	return
end

function EducateSpecialEvent:InDiscountTime(arg_23_1)
	if self:getConfig("type") == EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT then
		return EducateHelper.InTime(arg_23_1, self.startTime, (EducateHelper.GetTimeAfterWeeks(arg_23_1, self:getConfig("type_param")[3])))
	end

	assert(nil, "not discount type:" .. self.id)

	return
end

return EducateSpecialEvent
