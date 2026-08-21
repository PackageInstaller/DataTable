local var_0_0 = {
	funcs = {}
}

var_0_0.__index = var_0_0

function var_0_0.__call(arg_1_0, arg_1_1)
	return var_0_0:new(arg_1_1)
end

function var_0_0.new(arg_2_0, arg_2_1, arg_2_2)
	return setmetatable({
		_val = arg_2_1,
		chained = arg_2_2 or false
	}, arg_2_0)
end

function var_0_0.iter(arg_3_0)
	if type(arg_3_0) == "function" then
		return arg_3_0
	end

	return coroutine.wrap(function()
		for iter_4_0 = 1, #arg_3_0 do
			coroutine.yield(arg_3_0[iter_4_0])
		end
	end)
end

function var_0_0.range(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == nil then
		arg_5_1 = arg_5_0
		arg_5_0 = 1
	end

	arg_5_2 = arg_5_2 or 1

	local var_5_0 = coroutine.wrap(function()
		for iter_6_0 = arg_5_0, arg_5_1, arg_5_2 do
			coroutine.yield(iter_6_0)
		end
	end)

	return var_0_0:new(var_5_0)
end

function var_0_0.identity(arg_7_0)
	return arg_7_0
end

function var_0_0.chain(arg_8_0)
	arg_8_0.chained = true

	return arg_8_0
end

function var_0_0.value(arg_9_0)
	return arg_9_0._val
end

function var_0_0.funcs.each(arg_10_0, arg_10_1)
	for iter_10_0 in var_0_0.iter(arg_10_0) do
		arg_10_1(iter_10_0)
	end

	return arg_10_0
end

function var_0_0.funcs.map(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 in var_0_0.iter(arg_11_0) do
		var_11_0[#var_11_0 + 1] = arg_11_1(iter_11_0)
	end

	return var_11_0
end

function var_0_0.funcs.reduce(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 in var_0_0.iter(arg_12_0) do
		arg_12_1 = arg_12_2(arg_12_1, iter_12_0)
	end

	return arg_12_1
end

function var_0_0.funcs.detect(arg_13_0, arg_13_1)
	for iter_13_0 in var_0_0.iter(arg_13_0) do
		if arg_13_1(iter_13_0) then
			return iter_13_0
		end
	end

	return nil
end

function var_0_0.funcs.select(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 in var_0_0.iter(arg_14_0) do
		if arg_14_1(iter_14_0) then
			var_14_0[#var_14_0 + 1] = iter_14_0
		end
	end

	return var_14_0
end

function var_0_0.funcs.reject(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0 in var_0_0.iter(arg_15_0) do
		if not arg_15_1(iter_15_0) then
			var_15_0[#var_15_0 + 1] = iter_15_0
		end
	end

	return var_15_0
end

function var_0_0.funcs.all(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or var_0_0.identity

	for iter_16_0 in var_0_0.iter(arg_16_0) do
		if not arg_16_1(iter_16_0) then
			return false
		end
	end

	return true
end

function var_0_0.funcs.any(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or var_0_0.identity

	for iter_17_0 in var_0_0.iter(arg_17_0) do
		if arg_17_1(iter_17_0) then
			return true
		end
	end

	return false
end

function var_0_0.funcs.include(arg_18_0, arg_18_1)
	for iter_18_0 in var_0_0.iter(arg_18_0) do
		if iter_18_0 == arg_18_1 then
			return true
		end
	end

	return false
end

function var_0_0.funcs.invoke(arg_19_0, arg_19_1, ...)
	local var_19_0 = {
		...
	}

	var_0_0.funcs.each(arg_19_0, function(arg_20_0)
		arg_20_0[arg_19_1](arg_20_0, unpack(var_19_0))
	end)

	return arg_19_0
end

function var_0_0.funcs.pluck(arg_21_0, arg_21_1)
	return var_0_0.funcs.map(arg_21_0, function(arg_22_0)
		return arg_22_0[arg_21_1]
	end)
end

function var_0_0.funcs.min(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or var_0_0.identity

	return var_0_0.funcs.reduce(arg_23_0, {}, function(arg_24_0, arg_24_1)
		if arg_24_0.item == nil then
			arg_24_0.item = arg_24_1
			arg_24_0.value = arg_23_1(arg_24_1)
		else
			local var_24_0 = arg_23_1(arg_24_1)

			if var_24_0 < arg_24_0.value then
				arg_24_0.item = arg_24_1
				arg_24_0.value = var_24_0
			end
		end

		return arg_24_0
	end).item
end

function var_0_0.funcs.max(arg_25_0, arg_25_1)
	arg_25_1 = arg_25_1 or var_0_0.identity

	return var_0_0.funcs.reduce(arg_25_0, {}, function(arg_26_0, arg_26_1)
		if arg_26_0.item == nil then
			arg_26_0.item = arg_26_1
			arg_26_0.value = arg_25_1(arg_26_1)
		else
			local var_26_0 = arg_25_1(arg_26_1)

			if var_26_0 > arg_26_0.value then
				arg_26_0.item = arg_26_1
				arg_26_0.value = var_26_0
			end
		end

		return arg_26_0
	end).item
end

function var_0_0.funcs.to_array(arg_27_0)
	local var_27_0 = {}

	for iter_27_0 in var_0_0.iter(arg_27_0) do
		var_27_0[#var_27_0 + 1] = iter_27_0
	end

	return var_27_0
end

function var_0_0.funcs.reverse(arg_28_0)
	local var_28_0 = {}

	for iter_28_0 in var_0_0.iter(arg_28_0) do
		table.insert(var_28_0, 1, iter_28_0)
	end

	return var_28_0
end

function var_0_0.funcs.sort(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0

	if type(arg_29_0) == "function" then
		var_29_0 = var_0_0.funcs.to_array(arg_29_0)
	end

	table.sort(var_29_0, arg_29_1)

	return var_29_0
end

function var_0_0.funcs.first(arg_30_0, arg_30_1)
	if arg_30_1 == nil then
		return arg_30_0[1]
	else
		local var_30_0 = {}

		arg_30_1 = math.min(arg_30_1, #arg_30_0)

		for iter_30_0 = 1, arg_30_1 do
			var_30_0[iter_30_0] = arg_30_0[iter_30_0]
		end

		return var_30_0
	end
end

function var_0_0.funcs.rest(arg_31_0, arg_31_1)
	arg_31_1 = arg_31_1 or 2

	local var_31_0 = {}

	for iter_31_0 = arg_31_1, #arg_31_0 do
		var_31_0[#var_31_0 + 1] = arg_31_0[iter_31_0]
	end

	return var_31_0
end

function var_0_0.funcs.slice(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}

	arg_32_1 = math.max(arg_32_1, 1)

	local var_32_1 = math.min(arg_32_1 + arg_32_2 - 1, #arg_32_0)

	for iter_32_0 = arg_32_1, var_32_1 do
		var_32_0[#var_32_0 + 1] = arg_32_0[iter_32_0]
	end

	return var_32_0
end

function var_0_0.funcs.flatten(arg_33_0)
	local var_33_0 = {}

	for iter_33_0 in var_0_0.iter(arg_33_0) do
		if type(iter_33_0) == "table" then
			local var_33_1 = var_0_0.funcs.flatten(iter_33_0)

			var_0_0.funcs.each(var_33_1, function(arg_34_0)
				var_33_0[#var_33_0 + 1] = arg_34_0
			end)
		else
			var_33_0[#var_33_0 + 1] = iter_33_0
		end
	end

	return var_33_0
end

function var_0_0.funcs.push(arg_35_0, arg_35_1)
	table.insert(arg_35_0, arg_35_1)

	return arg_35_0
end

function var_0_0.funcs.pop(arg_36_0)
	return table.remove(arg_36_0)
end

function var_0_0.funcs.shift(arg_37_0)
	return table.remove(arg_37_0, 1)
end

function var_0_0.funcs.unshift(arg_38_0, arg_38_1)
	table.insert(arg_38_0, 1, arg_38_1)

	return arg_38_0
end

function var_0_0.funcs.join(arg_39_0, arg_39_1)
	return table.concat(arg_39_0, arg_39_1)
end

function var_0_0.funcs.keys(arg_40_0)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_0) do
		var_40_0[#var_40_0 + 1] = iter_40_0
	end

	return var_40_0
end

function var_0_0.funcs.values(arg_41_0)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(arg_41_0) do
		var_41_0[#var_41_0 + 1] = iter_41_1
	end

	return var_41_0
end

function var_0_0.funcs.extend(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in pairs(arg_42_1) do
		arg_42_0[iter_42_0] = iter_42_1
	end

	return arg_42_0
end

function var_0_0.funcs.is_empty(arg_43_0)
	return next(arg_43_0) == nil
end

function var_0_0.funcs.is_equal(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = type(arg_44_0)

	if var_44_0 ~= type(arg_44_1) then
		return false
	end

	if var_44_0 ~= "table" then
		return arg_44_0 == arg_44_1
	end

	local var_44_1 = getmetatable(arg_44_0)

	if not arg_44_2 and var_44_1 and var_44_1.__eq then
		return arg_44_0 == arg_44_1
	end

	local var_44_2 = var_0_0.funcs.is_equal

	for iter_44_0, iter_44_1 in pairs(arg_44_0) do
		local var_44_3 = arg_44_1[iter_44_0]

		if var_44_3 == nil or not var_44_2(iter_44_1, var_44_3, arg_44_2) then
			return false
		end
	end

	for iter_44_2, iter_44_3 in pairs(arg_44_1) do
		if arg_44_0[iter_44_2] == nil then
			return false
		end
	end

	return true
end

function var_0_0.funcs.compose(...)
	local function var_45_0(arg_46_0, ...)
		if #arg_46_0 > 1 then
			return arg_46_0[1](var_45_0(_.rest(arg_46_0), ...))
		else
			return arg_46_0[1](...)
		end
	end

	local var_45_1 = {
		...
	}

	return function(...)
		return var_45_0(var_45_1, ...)
	end
end

function var_0_0.funcs.wrap(arg_48_0, arg_48_1)
	return function(...)
		return arg_48_1(arg_48_0, ...)
	end
end

function var_0_0.funcs.curry(arg_50_0, arg_50_1)
	return function(...)
		return arg_50_0(arg_50_1, ...)
	end
end

function var_0_0.functions()
	return var_0_0.keys(var_0_0.funcs)
end

var_0_0.methods = var_0_0.functions
var_0_0.funcs.for_each = var_0_0.funcs.each
var_0_0.funcs.collect = var_0_0.funcs.map
var_0_0.funcs.inject = var_0_0.funcs.reduce
var_0_0.funcs.foldl = var_0_0.funcs.reduce
var_0_0.funcs.filter = var_0_0.funcs.select
var_0_0.funcs.every = var_0_0.funcs.all
var_0_0.funcs.some = var_0_0.funcs.any
var_0_0.funcs.head = var_0_0.funcs.first
var_0_0.funcs.tail = var_0_0.funcs.rest
var_0_0.funcs.contains = var_0_0.funcs.include

;(function()
	local function var_53_0(arg_54_0)
		local var_54_0 = false

		if getmetatable(arg_54_0) == var_0_0 then
			var_54_0 = arg_54_0.chained
			arg_54_0 = arg_54_0._val
		end

		return arg_54_0, var_54_0
	end

	local function var_53_1(arg_55_0, arg_55_1)
		if arg_55_1 then
			arg_55_0 = var_0_0:new(arg_55_0, true)
		end

		return arg_55_0
	end

	for iter_53_0, iter_53_1 in pairs(var_0_0.funcs) do
		var_0_0[iter_53_0] = function(arg_56_0, ...)
			local var_56_0, var_56_1 = var_53_0(arg_56_0)

			return var_53_1(iter_53_1(var_56_0, ...), var_56_1)
		end
	end
end)()

return var_0_0:new()
