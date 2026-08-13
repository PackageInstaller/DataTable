class = var_0_10000

local var_0_0 = var_0_10000("EducateGrid")

var_0_0.TYPE_LOCK = -1
var_0_0.TYPE_EMPTY = 0
var_0_0.TYPE_PLAN = 1
var_0_0.TYPE_PLAN_OCCUPY = 2
var_0_0.TYPE_EVENT = 3
var_0_0.TYPE_EVENT_OCCUPY = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type

	local var_1_0

	if not arg_1_1.id then
		var_1_0 = 0
	end

	arg_1_0.id = var_1_0

	arg_1_0:initData(arg_1_1)

	return
end

function var_0_0.initData(arg_2_0)
	switch = var_1_10001

	var_1_10001(arg_2_0.type, {
		[var_0_0.TYPE_LOCK] = function()
			arg_2_0.data = nil

			return
		end,
		[var_0_0.TYPE_EMPTY] = function()
			arg_2_0.data = nil

			return
		end,
		[var_0_0.TYPE_PLAN] = function()
			local var_5_0 = arg_2_0

			EducatePlan = var_2_10001
			var_5_0.data = var_2_10001.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_PLAN_OCCUPY] = function()
			local var_6_0 = arg_2_0

			EducatePlan = var_2_10001
			var_6_0.data = var_2_10001.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_EVENT] = function()
			local var_7_0 = arg_2_0

			EducateSpecialEvent = var_2_10001
			var_7_0.data = var_2_10001.New(arg_2_0.id)

			return
		end,
		[var_0_0.TYPE_EVENT_OCCUPY] = function()
			local var_8_0 = arg_2_0

			EducateSpecialEvent = var_2_10001
			var_8_0.data = var_2_10001.New(arg_2_0.id)

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
		local var_15_0 = arg_15_0.data
		local var_15_1

		if not var_1.getConfig(var_15_0, "cost_resource3") then
			var_15_1 = 1
		end

		return var_15_1
	end
end

function var_0_0.GetName(arg_16_0)
	if arg_16_0.type == var_0_0.TYPE_PLAN then
		local var_16_0 = arg_16_0.data

		return var_1.getConfig(var_16_0, "name")
	elseif arg_16_0.type == var_0_0.TYPE_EVENT then
		local var_16_1 = arg_16_0.data

		return var_1.getConfig(var_16_1, "id")
	end

	return ""
end

function var_0_0.GetPerformance(arg_17_0)
	if arg_17_0.data then
		local var_17_0 = arg_17_0.data
		local var_17_1

		if not var_1.GetPerformance(var_17_0) then
			var_17_1 = ""
		end

		return var_17_1
	end
end

function var_0_0.GetResult(arg_18_0)
	if arg_18_0.data then
		local var_18_0 = arg_18_0.data
		local var_18_1

		if not var_1.GetResult(var_18_0) then
			var_18_1 = {}
		end

		return var_18_1
	end
end

return var_0_0
