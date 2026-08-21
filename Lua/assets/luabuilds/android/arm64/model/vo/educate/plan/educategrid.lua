local var_0_0 = class("EducateGrid")

var_0_0.TYPE_LOCK = -1
var_0_0.TYPE_EMPTY = 0
var_0_0.TYPE_PLAN = 1
var_0_0.TYPE_PLAN_OCCUPY = 2
var_0_0.TYPE_EVENT = 3
var_0_0.TYPE_EVENT_OCCUPY = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.id = arg_1_1.id or 0

	arg_1_0:initData(arg_1_1)

	return
end

function var_0_0.initData(arg_2_0)
	switch(arg_2_0.type, {
		[var_0_0.TYPE_LOCK] = function()
			arg_2_0.data = nil

			return
		end,
		[var_0_0.TYPE_EMPTY] = function()
			arg_2_0.data = nil

			return
		end,
		[var_0_0.TYPE_PLAN] = function()
			arg_2_0.data = EducatePlan.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_PLAN_OCCUPY] = function()
			arg_2_0.data = EducatePlan.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_EVENT] = function()
			arg_2_0.data = EducateSpecialEvent.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_EVENT_OCCUPY] = function()
			arg_2_0.data = EducateSpecialEvent.New(arg_2_0.id)

			return
		end
	})

	return
end

function var_0_0.IsLock(arg_9_0)
	return arg_9_0.type == var_0_0.TYPE_LOCK
end

function var_0_0.IsEmpty(arg_10_0)
	return arg_10_0.type == var_0_0.TYPE_EMPTY
end

function var_0_0.IsPlan(arg_11_0)
	return arg_11_0.type == var_0_0.TYPE_PLAN
end

function var_0_0.IsPlanOccupy(arg_12_0)
	return arg_12_0.type == var_0_0.TYPE_PLAN_OCCUPY
end

function var_0_0.IsEvent(arg_13_0)
	return arg_13_0.type == var_0_0.TYPE_EVENT
end

function var_0_0.IsEventOccupy(arg_14_0)
	return arg_14_0.type == var_0_0.TYPE_EVENT_OCCUPY
end

function var_0_0.GetOccupyGridCnt(arg_15_0)
	if arg_15_0:IsPlan() or arg_15_0:IsPlanOccupy() then
		return arg_15_0.data:getConfig("cost_resource3") or 1
	end
end

function var_0_0.GetName(arg_16_0)
	if arg_16_0.type == var_0_0.TYPE_PLAN then
		return arg_16_0.data:getConfig("name")
	elseif arg_16_0.type == var_0_0.TYPE_EVENT then
		return arg_16_0.data:getConfig("id")
	end

	return ""
end

function var_0_0.GetPerformance(arg_17_0)
	return arg_17_0.data and arg_17_0.data:GetPerformance() or ""
end

function var_0_0.GetResult(arg_18_0)
	return arg_18_0.data and arg_18_0.data:GetResult() or {}
end

return var_0_0
