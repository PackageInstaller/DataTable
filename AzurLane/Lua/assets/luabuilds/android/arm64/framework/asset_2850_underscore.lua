var_0.__index = {
	funcs = {}
}

function var_0.__call(arg_1_0, arg_1_1)
	local var_1_0 = var_0

	return var_2.new(var_1_0, arg_1_1)
end

function var_0.new(arg_2_0, arg_2_1, arg_2_2)
	setmetatable = var_1_10003

	return var_1_10003({
		_val = arg_2_1,
		chained = arg_2_2 or false
	}, arg_2_0)
end

function var_0.iter(arg_3_0)
	type = var_1_10001

	if var_1_10001(arg_3_0) == "function" then
		return arg_3_0
	end

	coroutine = var_1

	return var_1.wrap(function()
		for iter_4_0 = 1, #arg_3_0 do
			coroutine = var_2_10004

			var_2_10004.yield(arg_3_0[iter_4_0])
		end

		return
	end)
end

function var_0.range(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		arg_5_1 = arg_5_0
		arg_5_0 = 1
	end

	arg_5_2 = arg_5_2 or 1
	coroutine = var_1_10003

	local var_5_0 = var_1_10003.wrap(function()
		for iter_6_0 = arg_5_0, arg_5_1, arg_5_2 do
			coroutine = var_2_10004

			var_2_10004.yield(iter_6_0)
		end

		return
	end)
	local var_5_1 = var_0

	return var_4.new(var_5_1, var_5_0)
end

function var_0.identity(arg_7_0)
	return arg_7_0
end

function var_0.chain(arg_8_0)
	arg_8_0.chained = true

	return arg_8_0
end

function var_0.value(arg_9_0)
	return arg_9_0._val
end

function var_0.funcs.each(arg_10_0, arg_10_1)
	for iter_10_0 in var_0.iter(arg_10_0) do
		arg_10_1(iter_10_0)
	end

	return arg_10_0
end

function var_0.funcs.map(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 in var_0.iter(arg_11_0) do
		var_11_0[#var_11_0 + 1] = arg_11_1(iter_11_0)
	end

	return var_11_0
end

function var_0.funcs.reduce(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 in var_0.iter(arg_12_0) do
		arg_12_1 = arg_12_2(arg_12_1, iter_12_0)
	end

	return arg_12_1
end

function var_0.funcs.detect(arg_13_0, arg_13_1)
	for iter_13_0 in var_0.iter(arg_13_0) do
		if arg_13_1(iter_13_0) then
			return iter_13_0
		end
	end

	return nil
end

function var_0.funcs.select(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 in var_0.iter(arg_14_0) do
		if arg_14_1(iter_14_0) then
			var_14_0[#var_14_0 + 1] = iter_14_0
		end
	end

	return var_14_0
end

function var_0.funcs.reject(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0 in var_0.iter(arg_15_0) do
		if not arg_15_1(iter_15_0) then
			var_15_0[#var_15_0 + 1] = iter_15_0
		end
	end

	return var_15_0
end

function var_0.funcs.all(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or var_0.identity

	for iter_16_0 in var_0.iter(arg_16_0) do
		if not arg_16_1(iter_16_0) then
			return false
		end
	end

	return true
end

function var_0.funcs.any(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or var_0.identity

	for iter_17_0 in var_0.iter(arg_17_0) do
		if arg_17_1(iter_17_0) then
			return true
		end
	end

	return false
end

function var_0.funcs.include(arg_18_0, arg_18_1)
	for iter_18_0 in var_0.iter(arg_18_0) do
		if iter_18_0 == arg_18_1 then
			return true
		end
	end

	return false
end

function var_0.funcs.invoke(arg_19_0, arg_19_1, ...)
	packEx = var_1_10002

	local var_19_0 = var_1_10002(...)

	var_0.funcs.each(arg_19_0, function(arg_20_0)
		local var_20_0 = arg_20_0[arg_19_1]
		local var_20_1 = arg_20_0

		unpackEx = var_2_10004

		var_20_0(var_20_1, var_2_10004(var_19_0))

		return
	end)

	return arg_19_0
end

function var_0.funcs.pluck(arg_21_0, arg_21_1)
	return var_0.funcs.map(arg_21_0, function(arg_22_0)
		return arg_22_0[arg_21_1]
	end)
end

function var_0.funcs.min(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or var_0.identity

	return var_0.funcs.reduce(arg_23_0, {}, function(arg_24_0, arg_24_1)
		if arg_24_0.item == nil then
			arg_24_0.item = arg_24_1
			arg_24_0.value = arg_23_1(arg_24_1)
		elseif arg_23_1(arg_24_1) < arg_24_0.value then
			arg_24_0.item = arg_24_1
			arg_24_0.value = var_2
		end

		return arg_24_0
	end).item
end

function var_0.funcs.max(arg_25_0, arg_25_1)
	arg_25_1 = arg_25_1 or var_0.identity

	return var_0.funcs.reduce(arg_25_0, {}, function(arg_26_0, arg_26_1)
		if arg_26_0.item == nil then
			arg_26_0.item = arg_26_1
			arg_26_0.value = arg_25_1(arg_26_1)
		elseif arg_25_1(arg_26_1) > arg_26_0.value then
			arg_26_0.item = arg_26_1
			arg_26_0.value = var_2
		end

		return arg_26_0
	end).item
end

function var_0.funcs.to_array(arg_27_0)
	local var_27_0 = {}

	for iter_27_0 in var_0.iter(arg_27_0) do
		var_27_0[#var_27_0 + 1] = iter_27_0
	end

	return var_27_0
end

function var_0.funcs.reverse(arg_28_0)
	local var_28_0 = {}

	for iter_28_0 = #arg_28_0, 1, -1 do
		table = var_1_10006

		var_1_10006.insert(var_28_0, arg_28_0[iter_28_0])
	end

	return var_28_0
end

function var_0.funcs.sort(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0

	type = var_1_10003

	if var_1_10003(arg_29_0) == "function" then
		var_29_0 = var_0.funcs.to_array(arg_29_0)
	end

	table = var_3

	var_3.sort(var_29_0, arg_29_1)

	return var_29_0
end

function var_0.funcs.first(arg_30_0, arg_30_1)
	if arg_30_1 == nil then
		return arg_30_0[1]
	else
		local var_30_0 = {}

		math = var_1_10003
		arg_30_1 = var_1_10003.min(arg_30_1, #arg_30_0)

		for iter_30_0 = 1, arg_30_1 do
			var_30_0[iter_30_0] = arg_30_0[iter_30_0]
		end

		return var_30_0
	end

	return
end

function var_0.funcs.rest(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or 2

	local var_31_0 = {}

	for iter_31_0 = arg_31_1, #arg_31_0 do
		var_31_0[#var_31_0 + 1] = arg_31_0[iter_31_0]
	end

	return var_31_0
end

function var_0.funcs.slice(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}

	math = var_1_10004
	arg_32_1 = var_1_10004.max(arg_32_1, 1)
	math = var_4

	local var_32_1 = var_4.min(arg_32_1 + arg_32_2 - 1, #arg_32_0)

	for iter_32_0 = arg_32_1, var_32_1 do
		var_32_0[#var_32_0 + 1] = arg_32_0[iter_32_0]
	end

	return var_32_0
end

function var_0.funcs.unfold(arg_33_0, arg_33_1)
	type = var_1_10002

	if var_1_10002(arg_33_0) == "table" then
		for iter_33_0 in var_0.iter(arg_33_0) do
			var_0.funcs.unfold(iter_33_0, arg_33_1)
		end
	else
		arg_33_1(arg_33_0)
	end

	return
end

function var_0.funcs.flatten(arg_34_0)
	local var_34_0 = {}

	var_0.funcs.unfold(arg_34_0, function(arg_35_0)
		var_34_0[#var_34_0 + 1] = arg_35_0

		return
	end)

	return var_34_0
end

function var_0.funcs.push(arg_36_0, arg_36_1)
	table = var_1_10002

	var_1_10002.insert(arg_36_0, arg_36_1)

	return arg_36_0
end

function var_0.funcs.pop(arg_37_0)
	table = var_1_10001

	return var_1_10001.remove(arg_37_0)
end

function var_0.funcs.shift(arg_38_0)
	table = var_1_10001

	return var_1_10001.remove(arg_38_0, 1)
end

function var_0.funcs.unshift(arg_39_0, arg_39_1)
	table = var_1_10002

	var_1_10002.insert(arg_39_0, 1, arg_39_1)

	return arg_39_0
end

function var_0.funcs.join(arg_40_0, arg_40_1)
	table = var_1_10002

	return var_1_10002.concat(arg_40_0, arg_40_1)
end

function var_0.funcs.keys(arg_41_0)
	local var_41_0 = {}

	pairs = var_1_10002

	for iter_41_0, iter_41_1 in var_1_10002(arg_41_0) do
		var_41_0[#var_41_0 + 1] = iter_41_0
	end

	return var_41_0
end

function var_0.funcs.values(arg_42_0)
	local var_42_0 = {}

	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0) do
		var_42_0[#var_42_0 + 1] = iter_42_1
	end

	return var_42_0
end

function var_0.funcs.extend(arg_43_0, arg_43_1)
	pairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_1) do
		arg_43_0[iter_43_0] = iter_43_1
	end

	return arg_43_0
end

function var_0.funcs.is_empty(arg_44_0)
	next = var_1_10001

	return var_1_10001(arg_44_0) == nil
end

function var_0.funcs.is_equal(arg_45_0, arg_45_1, arg_45_2)
	type = var_1_10003

	local var_45_0 = var_1_10003(arg_45_0)

	type = var_1_10004

	if var_45_0 ~= var_1_10004(arg_45_1) then
		return false
	end

	local var_45_1

	if var_45_0 ~= "table" then
		var_45_1 = arg_45_0 == arg_45_1

		return var_45_1
	end

	getmetatable = var_45_1

	local var_45_2 = var_45_1(arg_45_0)

	if not arg_45_2 and var_45_2 and var_45_2.__eq then
		return arg_45_0 == arg_45_1
	end

	local var_45_3 = var_0.funcs.is_equal

	pairs = var_7

	for iter_45_0, iter_45_1 in var_7(arg_45_0) do
		if arg_45_1[iter_45_0] == nil or not var_45_3(iter_45_1, var_12, arg_45_2) then
			return false
		end
	end

	pairs = var_7

	for iter_45_2, iter_45_3 in var_7(arg_45_1) do
		if arg_45_0[iter_45_2] == nil then
			return false
		end
	end

	return true
end

function var_0.funcs.compose(...)
	local function var_46_0(arg_47_0, ...)
		if #arg_47_0 > 1 then
			local var_47_0 = arg_47_0[1]
			local var_47_1 = var_46_0

			_ = var_2_10005

			return var_47_0(var_47_1(var_2_10005.rest(arg_47_0), ...))
		else
			return arg_47_0[1](...)
		end

		return
	end

	local var_46_1 = {
		...
	}

	return function(...)
		return var_46_0(var_46_1, ...)
	end
end

function var_0.funcs.wrap(arg_49_0, arg_49_1)
	return function(...)
		return arg_49_1(arg_49_0, ...)
	end
end

function var_0.funcs.curry(arg_51_0, arg_51_1)
	return function(...)
		return arg_51_0(arg_51_1, ...)
	end
end

function var_0.functions()
	return var_0.keys(var_0.funcs)
end

var_0.methods = var_0.functions
var_0.funcs.for_each = var_0.funcs.each
var_0.funcs.collect = var_0.funcs.map
var_0.funcs.inject = var_0.funcs.reduce
var_0.funcs.foldl = var_0.funcs.reduce
var_0.funcs.filter = var_0.funcs.select
var_0.funcs.every = var_0.funcs.all
var_0.funcs.some = var_0.funcs.any
var_0.funcs.head = var_0.funcs.first
var_0.funcs.tail = var_0.funcs.rest
var_0.funcs.contains = var_0.funcs.include

;(function()
	local function var_54_0(arg_55_0)
		local var_55_0 = false

		getmetatable = var_2_10002

		if var_2_10002(arg_55_0) == var_0 then
			var_55_0 = arg_55_0.chained
			arg_55_0 = arg_55_0._val
		end

		return arg_55_0, var_55_0
	end

	local function var_54_1(arg_56_0, arg_56_1)
		if arg_56_1 then
			local var_56_0 = var_0

			arg_56_0 = var_2.new(var_56_0, arg_56_0, true)
		end

		return arg_56_0
	end

	pairs = var_1_10002

	for iter_54_0, iter_54_1 in var_1_10002(var_0.funcs) do
		var_0[iter_54_0] = function(arg_57_0, ...)
			local var_57_0, var_57_1 = var_54_0(arg_57_0)

			return var_54_1(iter_54_1(var_57_0, ...), var_57_1)
		end
	end

	return
end)()

return var_0:new()
