class = var_0_10000

local var_0_0 = var_0_10000("EducateEventProxy")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.planSpecEvents = {}
	arg_1_0.siteSpecEvents = {}
	arg_1_0.mindBubbleSpecEvents = {}
	arg_1_0.discountBubbleSpecEvents = {}
	pg = var_1

	local var_1_0 = var_1.child_event_special.all

	ipairs = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10002(var_1_0) do
		EducateSpecialEvent = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		switch = var_8

		local var_1_1 = var_1_10007:GetType()
		local var_1_2 = {}

		EducateSpecialEvent = var_1_10011
		var_1_2[var_1_10011.TYPE_PLAN] = function()
			table = var_2_10000

			var_2_10000.insert(arg_1_0.planSpecEvents, var_1_10007)

			return
		end
		EducateSpecialEvent = var_1_10011
		var_1_2[var_1_10011.TYPE_SITE] = function()
			table = var_2_10000

			var_2_10000.insert(arg_1_0.siteSpecEvents, var_1_10007)

			return
		end
		EducateSpecialEvent = var_1_10011
		var_1_2[var_1_10011.TYPE_BUBBLE_MIND] = function()
			table = var_2_10000

			var_2_10000.insert(arg_1_0.mindBubbleSpecEvents, var_1_10007)

			return
		end
		EducateSpecialEvent = var_1_10011
		var_1_2[var_1_10011.TYPE_BUBBLE_DISCOUNT] = function()
			table = var_2_10000

			var_2_10000.insert(arg_1_0.discountBubbleSpecEvents, var_1_10007)

			return
		end

		var_8(var_1_1, var_1_2)
	end

	return
end

function var_0_0.SetUp(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_1.finishSpecEventIds then
		var_6_0 = {}
	end

	arg_6_0.finishSpecEventIds = var_6_0
	arg_6_0.needRequestHomeEvents = arg_6_1.needRequestHomeEvents

	local var_6_1

	if not arg_6_1.home_events then
		var_6_1 = {}
	end

	arg_6_0.waitTriggerEventIds = var_6_1
	getProxy = var_6_1
	EducateProxy = var_1_10003

	local var_6_2 = var_6_1(var_1_10003)

	arg_6_0.curTime = var_2.GetCurTime(var_6_2)

	return
end

function var_0_0.GetFinishSpecEventIds(arg_7_0)
	return arg_7_0.finishSpecEventIds
end

function var_0_0.AddFinishSpecEvent(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.insert(arg_8_0.finishSpecEventIds, arg_8_1)

	return
end

function var_0_0.IsFinishSpecEvent(arg_9_0, arg_9_1)
	table = var_1_10002

	return var_1_10002.contains(arg_9_0.finishSpecEventIds, arg_9_1)
end

function var_0_0.GetHomeSpecEvents(arg_10_0)
	local var_10_0 = {}

	getProxy = var_1_10002
	EducateProxy = var_1_10003

	local var_10_1 = var_1_10002(var_1_10003)
	local var_10_2 = var_2.GetCharData(var_10_1)
	local var_10_3 = var_2.GetPersonalityId(var_10_2)

	EducateHelper = var_10_2

	local var_10_4 = var_10_2.IsSystemUnlock

	EducateConst = var_1_10004

	if var_10_4(var_1_10004.SYSTEM_FAVOR_AND_MIND) then
		table = var_4

		local var_10_5

		if not var_4.mergeArray(arg_10_0.mindBubbleSpecEvents, arg_10_0.discountBubbleSpecEvents) then
			var_10_5 = arg_10_0.discountBubbleSpecEvents
		end

		underscore = var_1_10005

		return (var_1_10005.select(var_10_5, function(arg_11_0)
			local var_11_0 = arg_10_0
			local var_11_1

			if not var_1.IsFinishSpecEvent(var_11_0, arg_11_0.id) then
				if arg_11_0:InTime(arg_10_0.curTime) then
					var_11_1 = arg_11_0:IsMatch(var_10_3)
				end
			else
				var_11_1 = false
			end

			if false then
				var_11_1 = true
			end

			return var_11_1
		end))
	end
end

function var_0_0.GetSiteSpecEvents(arg_12_0, arg_12_1)
	local var_12_0 = {}

	getProxy = var_1_10003
	EducateProxy = var_1_10004

	local var_12_1 = var_1_10003(var_1_10004)
	local var_12_2 = var_3.GetCharData(var_12_1)
	local var_12_3 = var_3.GetPersonalityId(var_12_2)

	underscore = var_12_2

	return (var_12_2.select(arg_12_0.siteSpecEvents, function(arg_13_0)
		local var_13_0 = arg_12_0
		local var_13_1

		if not var_1.IsFinishSpecEvent(var_13_0, arg_13_0.id) then
			if arg_13_0:IsMatchSite(arg_12_1) and arg_13_0:InTime(arg_12_0.curTime) then
				var_13_1 = arg_13_0:IsMatch(var_12_3)
			end
		else
			var_13_1 = false
		end

		if false then
			var_13_1 = true
		end

		return var_13_1
	end))
end

function var_0_0.GetPlanSpecEvents(arg_14_0)
	local var_14_0 = {}

	getProxy = var_1_10002
	EducateProxy = var_1_10003

	local var_14_1 = var_1_10002(var_1_10003)
	local var_14_2 = var_2.GetCharData(var_14_1)
	local var_14_3 = var_2.GetPersonalityId(var_14_2)

	underscore = var_14_2

	return (var_14_2.select(arg_14_0.planSpecEvents, function(arg_15_0)
		local var_15_0 = arg_14_0
		local var_15_1

		if not var_1.IsFinishSpecEvent(var_15_0, arg_15_0.id) then
			if arg_15_0:InNextWeekTime(arg_14_0.curTime) then
				var_15_1 = arg_15_0:IsMatch(var_14_3)
			end
		else
			var_15_1 = false
		end

		if false then
			var_15_1 = true
		end

		return var_15_1
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
	table = var_1_10002

	var_1_10002.removebyvalue(arg_19_0.waitTriggerEventIds, arg_19_1)

	return
end

function var_0_0.OnNewWeek(arg_20_0, arg_20_1)
	arg_20_0.curTime = arg_20_1
	arg_20_0.needRequestHomeEvents = true
	arg_20_0.waitTriggerEventIds = {}

	return
end

return var_0_0
