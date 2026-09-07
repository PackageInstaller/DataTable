local EducateEventProxy = class("EducateEventProxy")

function EducateEventProxy:Ctor()
	self.planSpecEvents = {}
	self.siteSpecEvents = {}
	self.mindBubbleSpecEvents = {}
	self.discountBubbleSpecEvents = {}

	for iter_1_0, iter_1_1 in ipairs(pg.child_event_special.all) do
		local var_1_0 = EducateSpecialEvent.New(iter_1_1)

		switch(var_1_0:GetType(), {
			[EducateSpecialEvent.TYPE_PLAN] = function()
				table.insert(self.planSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_SITE] = function()
				table.insert(self.siteSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_BUBBLE_MIND] = function()
				table.insert(self.mindBubbleSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT] = function()
				table.insert(self.discountBubbleSpecEvents, var_1_0)

				return
			end
		})
	end

	return
end

function EducateEventProxy:SetUp(arg_6_1)
	self.finishSpecEventIds = arg_6_1.finishSpecEventIds or {}
	self.needRequestHomeEvents = arg_6_1.needRequestHomeEvents
	self.waitTriggerEventIds = arg_6_1.home_events or {}
	self.curTime = getProxy(EducateProxy):GetCurTime()

	return
end

function EducateEventProxy:GetFinishSpecEventIds()
	return self.finishSpecEventIds
end

function EducateEventProxy:AddFinishSpecEvent(arg_8_1)
	table.insert(self.finishSpecEventIds, arg_8_1)

	return
end

function EducateEventProxy:IsFinishSpecEvent(arg_9_1)
	return table.contains(self.finishSpecEventIds, arg_9_1)
end

function EducateEventProxy:GetHomeSpecEvents()
	local var_10_1 = getProxy(EducateProxy):GetCharData()
	local var_10_2 = var_10_1:GetPersonalityId()
	local var_10_3 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_FAVOR_AND_MIND) and table.mergeArray(self.mindBubbleSpecEvents, self.discountBubbleSpecEvents) or self.discountBubbleSpecEvents

	return (underscore.select(var_10_1, function(arg_11_0)
		return not self:IsFinishSpecEvent(arg_11_0.id) and arg_11_0:InTime(self.curTime) and arg_11_0:IsMatch(var_10_2)
	end))
end

function EducateEventProxy:GetSiteSpecEvents(arg_12_1)
	local var_12_1 = getProxy(EducateProxy):GetCharData():GetPersonalityId()

	return (underscore.select(self.siteSpecEvents, function(arg_13_0)
		return not self:IsFinishSpecEvent(arg_13_0.id) and arg_13_0:IsMatchSite(arg_12_1) and arg_13_0:InTime(self.curTime) and arg_13_0:IsMatch(var_12_1)
	end))
end

function EducateEventProxy:GetPlanSpecEvents()
	local var_14_1 = getProxy(EducateProxy):GetCharData():GetPersonalityId()

	return (underscore.select(self.planSpecEvents, function(arg_15_0)
		return not self:IsFinishSpecEvent(arg_15_0.id) and arg_15_0:InNextWeekTime(self.curTime) and arg_15_0:IsMatch(var_14_1)
	end))
end

function EducateEventProxy:NeedGetHomeEventData()
	return self.needRequestHomeEvents
end

function EducateEventProxy:SetHomeEventData(arg_17_1)
	self.needRequestHomeEvents = false
	self.waitTriggerEventIds = arg_17_1

	return
end

function EducateEventProxy:GetHomeEventIds()
	return self.waitTriggerEventIds
end

function EducateEventProxy:RemoveEvent(arg_19_1)
	table.removebyvalue(self.waitTriggerEventIds, arg_19_1)

	return
end

function EducateEventProxy:OnNewWeek(arg_20_1)
	self.curTime = arg_20_1
	self.needRequestHomeEvents = true
	self.waitTriggerEventIds = {}

	return
end

return EducateEventProxy
