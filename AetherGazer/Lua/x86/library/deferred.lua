local var_0_0 = {}

var_0_0.__version = "1.0.0-beta"

local var_0_1 = {}

var_0_1.__index = var_0_1

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4

local function var_0_7(arg_1_0)
	if type(arg_1_0) == "table" then
		local var_1_0 = getmetatable(arg_1_0)

		return var_1_0 ~= nil and type(var_1_0.__call) == "function"
	end

	return type(arg_1_0) == "function"
end

local function var_0_8(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_6

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.queue) do
		if arg_2_1 == var_0_5 then
			iter_2_1:resolve(arg_2_0.value)
		else
			iter_2_1:reject(arg_2_0.value)
		end
	end

	arg_2_0.state = arg_2_1
end

local function var_0_9(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if type(arg_3_0) == "table" and type(arg_3_0.value) == "table" and var_0_7(arg_3_1) then
		local var_3_0 = false
		local var_3_1, var_3_2 = pcall(arg_3_1, arg_3_0.value, function(arg_4_0)
			if var_3_0 then
				return
			end

			var_3_0 = true
			arg_3_0.value = arg_4_0

			arg_3_2()
		end, function(arg_5_0)
			if var_3_0 then
				return
			end

			var_3_0 = true
			arg_3_0.value = arg_5_0

			arg_3_3()
		end)

		if not var_3_1 and not var_3_0 then
			if var_3_0 then
				return
			end

			var_3_0 = true
			arg_3_0.value = var_3_2

			arg_3_3()
		end
	else
		arg_3_4()
	end
end

local function var_0_10(arg_6_0)
	local var_6_0

	if type(arg_6_0.value) == "table" then
		local var_6_1, var_6_2 = pcall(function()
			var_6_0 = arg_6_0.value.next
		end)

		if not var_6_1 then
			function var_6_0()
				return var_6_2
			end
		end
	end

	var_0_9(arg_6_0, var_6_0, function()
		arg_6_0.state = var_0_3

		var_0_10(arg_6_0)
	end, function()
		arg_6_0.state = var_0_4

		var_0_10(arg_6_0)
	end, function()
		local var_11_0
		local var_11_1

		if arg_6_0.state == var_0_3 and var_0_7(arg_6_0.success) then
			var_11_0, var_11_1 = pcall(arg_6_0.success, arg_6_0.value)
		elseif arg_6_0.state == var_0_4 and var_0_7(arg_6_0.failure) then
			var_11_0, var_11_1 = pcall(arg_6_0.failure, arg_6_0.value)

			if var_11_0 then
				arg_6_0.state = var_0_3
			end
		end

		if var_11_0 ~= nil then
			if var_11_0 then
				arg_6_0.value = var_11_1
			else
				arg_6_0.value = var_11_1

				Debug.LogError(arg_6_0.value)

				return var_0_8(arg_6_0)
			end
		end

		if arg_6_0.value == arg_6_0 then
			local var_11_2
			local var_11_3

			var_11_3, arg_6_0.value = pcall(error, "TypeError : resolving promise with itself")

			return var_0_8(arg_6_0)
		else
			var_0_9(arg_6_0, var_6_0, function()
				var_0_8(arg_6_0, var_0_5)
			end, function(arg_13_0)
				var_0_8(arg_6_0, arg_13_0)
			end, function()
				var_0_8(arg_6_0, arg_6_0.state == var_0_3 and var_0_5)
			end)
		end
	end)
end

local function var_0_11(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.state == var_0_2 then
		arg_15_0.value = arg_15_2
		arg_15_0.state = arg_15_1

		local var_15_0, var_15_1 = pcall(var_0_10, arg_15_0)

		if not var_15_0 then
			arg_15_0.value = var_15_1
			arg_15_0.state = var_0_4

			var_0_10(arg_15_0)
		end
	end

	return arg_15_0
end

function var_0_1.resolve(arg_16_0, arg_16_1)
	if var_0_0.async then
		var_0_0.async(function()
			if type(arg_16_1) == "table" and arg_16_1.is_promise then
				if arg_16_1.state == var_0_5 then
					arg_16_0:resolve(arg_16_1.value)
				elseif arg_16_1.state == var_0_6 then
					arg_16_0:reject(arg_16_1.value)
				else
					table.insert(arg_16_1.queue, arg_16_0)
				end

				return
			end

			var_0_11(arg_16_0, var_0_3, arg_16_1)
		end)
	else
		var_0_11(arg_16_0, var_0_3, arg_16_1)
	end

	return arg_16_0
end

function var_0_1.reject(arg_18_0, arg_18_1)
	if var_0_0.async then
		var_0_0.async(function()
			var_0_11(arg_18_0, var_0_4, arg_18_1)
		end)
	else
		var_0_11(arg_18_0, var_0_4, arg_18_1)
	end

	return arg_18_0
end

function var_0_0.new(arg_20_0)
	if var_0_7(arg_20_0) then
		local var_20_0 = var_0_0.new()
		local var_20_1 = var_0_0.async

		var_0_0.async = nil

		local var_20_2, var_20_3 = pcall(arg_20_0, var_20_0)

		if not var_20_2 then
			var_20_0:reject(var_20_3)
		end

		var_0_0.async = var_20_1

		return var_20_0
	end

	arg_20_0 = arg_20_0 or {}

	local var_20_4

	var_20_4 = {
		is_promise = true,
		state = 0,
		next = function(arg_21_0, arg_21_1, arg_21_2)
			local var_21_0 = var_0_0.new({
				success = arg_21_1,
				failure = arg_21_2,
				extend = arg_20_0.extend
			})

			if var_20_4.state == var_0_5 then
				var_21_0:resolve(var_20_4.value)
			elseif var_20_4.state == var_0_6 then
				var_21_0:reject(var_20_4.value)
			else
				table.insert(var_20_4.queue, var_21_0)
			end

			return var_21_0
		end,
		queue = {},
		success = arg_20_0.success,
		failure = arg_20_0.failure
	}
	var_20_4 = setmetatable(var_20_4, var_0_1)

	if var_0_7(arg_20_0.extend) then
		arg_20_0.extend(var_20_4)
	end

	return var_20_4
end

function var_0_0.all(arg_22_0)
	local var_22_0 = var_0_0.new()

	if arg_22_0 == nil or #arg_22_0 == 0 then
		return var_22_0:resolve({})
	end

	local var_22_1 = "resolve"
	local var_22_2 = #arg_22_0
	local var_22_3 = {}

	local function var_22_4(arg_23_0, arg_23_1)
		return function(arg_24_0)
			var_22_3[arg_23_0] = arg_24_0

			if not arg_23_1 then
				var_22_1 = "reject"
			end

			var_22_2 = var_22_2 - 1

			if var_22_2 == 0 then
				var_22_0[var_22_1](var_22_0, var_22_3)
			end

			return arg_24_0
		end
	end

	for iter_22_0 = 1, var_22_2 do
		arg_22_0[iter_22_0]:next(var_22_4(iter_22_0, true), var_22_4(iter_22_0, false))
	end

	return var_22_0
end

function var_0_0.map(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.new()
	local var_25_1 = {}

	local function var_25_2(arg_26_0)
		if arg_26_0 > #arg_25_0 then
			var_25_0:resolve(var_25_1)
		else
			arg_25_1(arg_25_0[arg_26_0]):next(function(arg_27_0)
				table.insert(var_25_1, arg_27_0)
				var_25_2(arg_26_0 + 1)
			end, function(arg_28_0)
				var_25_0:reject(arg_28_0)
			end)
		end
	end

	var_25_2(1)

	return var_25_0
end

function var_0_0.first(arg_29_0)
	local var_29_0 = var_0_0.new()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
		iter_29_1:next(function(arg_30_0)
			var_29_0:resolve(arg_30_0)
		end, function(arg_31_0)
			var_29_0:reject(arg_31_0)
		end)
	end

	return var_29_0
end

function var_0_0.promisify(arg_32_0)
	return function(...)
		local var_33_0 = var_0_0.new()
		local var_33_1 = {
			...
		}

		table.insert(var_33_1, function(arg_34_0, ...)
			if arg_34_0 == nil or arg_34_0 == "" then
				local var_34_0 = {
					...
				}

				if #var_34_0 <= 1 then
					var_33_0:resolve(...)
				else
					var_33_0:resolve(var_34_0)
				end
			else
				var_33_0:reject(arg_34_0)
			end
		end)

		local var_33_2, var_33_3 = pcall(arg_32_0, unpack(var_33_1))

		if not var_33_2 then
			var_33_0:reject(var_33_3)
		end

		return var_33_0
	end
end

return var_0_0
