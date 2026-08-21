local var_0_0 = class("EducateEventProxy")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.planSpecEvents = {}
	arg_1_0.siteSpecEvents = {}
	arg_1_0.mindBubbleSpecEvents = {}
	arg_1_0.discountBubbleSpecEvents = {}

	for iter_1_0, iter_1_1 in ipairs(pg.child_event_special.all) do
		local var_1_0 = EducateSpecialEvent.New(iter_1_1)

		switch(var_1_0:GetType(), {
			[EducateSpecialEvent.TYPE_PLAN] = function()
				table.insert(arg_1_0.planSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_SITE] = function()
				table.insert(arg_1_0.siteSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_BUBBLE_MIND] = function()
				table.insert(arg_1_0.mindBubbleSpecEvents, var_1_0)

				return
			end,
			[EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT] = function()
				table.insert(arg_1_0.discountBubbleSpecEvents, var_1_0)

				return
			end
		})
	end

	return
end

function var_0_0.SetUp(arg_6_0, arg_6_1)
	arg_6_0.finishSpecEventIds = arg_6_1.finishSpecEventIds or {}
	arg_6_0.needRequestHomeEvents = arg_6_1.needRequestHomeEvents
	arg_6_0.waitTriggerEventIds = arg_6_1.home_events or {}
	arg_6_0.curTime = getProxy(EducateProxy):GetCurTime()

	return
end

function var_0_0.GetFinishSpecEventIds(arg_7_0)
	return arg_7_0.finishSpecEventIds
end

function var_0_0.AddFinishSpecEvent(arg_8_0, arg_8_1)
	table.insert(arg_8_0.finishSpecEventIds, arg_8_1)

	return
end

function var_0_0.IsFinishSpecEvent(arg_9_0, arg_9_1)
	return table.contains(arg_9_0.finishSpecEventIds, arg_9_1)
end

function var_0_0.GetHomeSpecEvents(arg_10_0)
	local var_10_9000
	local var_10_1 = getProxy(EducateProxy):GetCharData()
	local var_10_2 = var_10_1.GetPersonalityId(var_10_9000)
	local var_10_3 = EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_FAVOR_AND_MIND) and table.mergeArray(arg_10_0.mindBubbleSpecEvents, arg_10_0.discountBubbleSpecEvents) or arg_10_0.discountBubbleSpecEvents

	return (underscore.select(var_10_1, function(arg_11_0)
		return not arg_10_0:IsFinishSpecEvent(arg_11_0.id) and arg_11_0:InTime(arg_10_0.curTime) and arg_11_0:IsMatch(var_10_2)
	end))
end

function var_0_0.GetSiteSpecEvents(arg_12_0, arg_12_1)
	local var_12_1 = getProxy(EducateProxy):GetCharData():GetPersonalityId()

	return (underscore.select(arg_12_0.siteSpecEvents, function(arg_13_0)
		return not arg_12_0:IsFinishSpecEvent(arg_13_0.id) and arg_13_0:IsMatchSite(arg_12_1) and arg_13_0:InTime(arg_12_0.curTime) and arg_13_0:IsMatch(var_12_1)
	end))
end

function var_0_0.GetPlanSpecEvents(arg_14_0)
	local var_14_1 = getProxy(EducateProxy):GetCharData():GetPersonalityId()

	return (underscore.select(arg_14_0.planSpecEvents, function(arg_15_0)
		return not arg_14_0:IsFinishSpecEvent(arg_15_0.id) and arg_15_0:InNextWeekTime(arg_14_0.curTime) and arg_15_0:IsMatch(var_14_1)
	end))
end

function var_0_0.NeedGetHomeEventData(arg_16_0)
	return arg_16_0.needRequestHomeEvents
end

function var_0_0.SetHomeEventData(arg_17_0, arg_17_1)
	arg_17_0.needRequestHomeEvents = false
	arg_17_0.waitTriggerEventIds = arg_17_1

	return
end

function var_0_0.GetHomeEventIds(arg_18_0)
	return arg_18_0.waitTriggerEventIds
end

function var_0_0.RemoveEvent(arg_19_0, arg_19_1)
	table.removebyvalue(arg_19_0.waitTriggerEventIds, arg_19_1)

	return
end

function var_0_0.OnNewWeek(arg_20_0, arg_20_1)
	arg_20_0.curTime = arg_20_1
	arg_20_0.needRequestHomeEvents = true
	arg_20_0.waitTriggerEventIds = {}

	return
end

return var_0_0
