class = var_0_10000

local var_0_0 = var_0_10000("Context")

var_0_0.TRANS_TYPE = {
	CROSS = 1,
	ONE_BY_ONE = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}
	arg_1_0.mediator = arg_1_1.mediator
	arg_1_0.viewComponent = arg_1_1.viewComponent
	arg_1_0.scene = arg_1_1.scene
	arg_1_0.onRemoved = arg_1_1.onRemoved
	defaultValue = var_2
	arg_1_0.cleanStack = var_2(arg_1_1.cleanStack, false)
	defaultValue = var_2
	arg_1_0.cleanChild = var_2(arg_1_1.cleanChild, false)
	defaultValue = var_2
	arg_1_0.irregularSequence = var_2(arg_1_1.irregularSequence, false)
	defaultValue = var_2
	arg_1_0.skipBack = var_2(arg_1_1.skipBack, false)

	local var_1_0

	if not arg_1_1.data then
		var_1_0 = {}
	end

	arg_1_0.data = var_1_0
	arg_1_0.parent = arg_1_1.parent
	arg_1_0.children = {}

	return
end

function var_0_0.extendData(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return
	end

	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_2_1) == "table", "data object should be a table")

	pairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1) do
		arg_2_0.data[iter_2_0] = iter_2_1
	end

	return
end

function var_0_0.addChild(arg_3_0, arg_3_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_3_0 = arg_3_1

	Context = var_1_10005

	var_1_10002(var_1_10003(var_3_0, var_1_10005), "should be an instance of Context")

	assert = var_1_10002

	var_1_10002(arg_3_1.parent == nil, "context already has parent")

	arg_3_1.parent = arg_3_0
	table = var_1_10002

	var_1_10002.insert(arg_3_0.children, arg_3_1)

	return
end

function var_0_0.addChilds(arg_4_0, arg_4_1)
	_ = var_1_10002

	var_1_10002.each(arg_4_1, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.addChild(var_5_0, arg_5_0)

		return
	end)

	return
end

function var_0_0.hasChild(arg_6_0)
	local var_6_0

	if arg_6_0.children then
		var_6_0 = #arg_6_0.children > 0
	end

	return var_6_0
end

function var_0_0.removeChild(arg_7_0, arg_7_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_7_0 = arg_7_1

	Context = var_1_10005

	var_1_10002(var_1_10003(var_7_0, var_1_10005), "should be an instance of Context")

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.children) do
		if iter_7_1 == arg_7_1 then
			table = var_1_10007

			return var_1_10007.remove(arg_7_0.children, iter_7_0)
		end
	end

	return nil
end

function var_0_0.retriveLastChild(arg_8_0)
	for iter_8_0 = #arg_8_0.children, 1, -1 do
		local var_8_0 = arg_8_0.children[iter_8_0]

		return var_5.retriveLastChild(var_8_0)
	end

	return arg_8_0
end

function var_0_0.GetHierarchy(arg_9_0)
	local var_9_0 = {
		arg_9_0
	}
	local var_9_1 = {}

	while #var_9_0 > 0 do
		table = var_9_2

		local var_9_2 = var_9_2.remove(var_9_0, 1)

		ipairs = var_4

		for iter_9_0, iter_9_1 in var_4(var_9_2.children) do
			table = var_1_10009

			var_1_10009.insert(var_9_0, iter_9_1)
		end

		table = var_4

		var_4.insert(var_9_1, var_9_2)
	end

	return var_9_1
end

function var_0_0.getContextByMediator(arg_10_0, arg_10_1)
	return (function(arg_11_0, arg_11_1)
		if arg_11_0.mediator == arg_11_1 then
			return arg_11_0
		end

		ipairs = var_2

		for iter_11_0, iter_11_1 in var_2(arg_11_0.children) do
			if var_0(iter_11_1, arg_11_1) ~= nil then
				return var_7
			end
		end

		return nil
	end)(arg_10_0, arg_10_1)
end

function var_0_0.onContextRemoved(arg_12_0)
	local var_12_0

	if arg_12_0.onRemoved then
		var_12_0 = arg_12_0.onRemoved()
	end

	return var_12_0
end

return var_0_0
