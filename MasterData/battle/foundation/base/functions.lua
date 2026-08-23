function string.trim(arg_1_0)
	arg_1_0 = string.gsub(arg_1_0, "^[ \t\n\r]+", "")

	return string.gsub(arg_1_0, "[ \t\n\r]+$", "")
end

function string.split(arg_2_0, arg_2_1)
	arg_2_0 = tostring(arg_2_0)
	arg_2_1 = tostring(arg_2_1)

	if arg_2_1 == "" then
		return false
	end

	local var_2_0 = 0
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in function()
		return string.find(arg_2_0, arg_2_1, var_2_0, true)
	end do
		table.insert(var_2_1, string.sub(arg_2_0, var_2_0, iter_2_0 - 1))

		var_2_0 = iter_2_1 + 1
	end

	table.insert(var_2_1, string.sub(arg_2_0, var_2_0))

	return var_2_1
end

local function var_0_0(arg_4_0)
	if type(arg_4_0) == "string" then
		arg_4_0 = "\"" .. arg_4_0 .. "\""
	end

	return tostring(arg_4_0)
end

function dump(arg_5_0, arg_5_1, arg_5_2)
	if type(arg_5_2) ~= "number" then
		arg_5_2 = 3
	end

	local var_5_0 = {}
	local var_5_1 = {}

	print("dump from: " .. string.trim(string.split(debug.traceback("", 2), "\n")[3]))

	local function var_5_2(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_6_1 = arg_6_1 or "<var>"

		local var_6_0 = ""

		if type(arg_6_4) == "number" then
			var_6_0 = string.rep(" ", arg_6_4 - string.len(var_0_0(arg_6_1)))
		end

		if type(arg_6_0) ~= "table" then
			var_5_1[#var_5_1 + 1] = string.format("%s%s%s = %s", arg_6_2, var_0_0(arg_6_1), var_6_0, var_0_0(arg_6_0))
		elseif var_5_0[tostring(arg_6_0)] then
			var_5_1[#var_5_1 + 1] = string.format("%s%s%s = *REF*", arg_6_2, var_0_0(arg_6_1), var_6_0)
		else
			var_5_0[tostring(arg_6_0)] = true

			if arg_6_3 > arg_5_2 then
				var_5_1[#var_5_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_6_2, var_0_0(arg_6_1))
			else
				var_5_1[#var_5_1 + 1] = string.format("%s%s = {", arg_6_2, var_0_0(arg_6_1))

				local var_6_1 = {}
				local var_6_2 = 0
				local var_6_3 = {}

				for iter_6_0, iter_6_1 in pairs(arg_6_0) do
					var_6_1[#var_6_1 + 1] = iter_6_0

					local var_6_4 = string.len((var_0_0(iter_6_0)))

					if var_6_2 < var_6_4 then
						var_6_2 = var_6_4
					end

					var_6_3[iter_6_0] = iter_6_1
				end

				table.sort(var_6_1, function(arg_7_0, arg_7_1)
					if type(arg_7_0) == "number" and type(arg_7_1) == "number" then
						return arg_7_0 < arg_7_1
					else
						return tostring(arg_7_0) < tostring(arg_7_1)
					end
				end)

				for iter_6_2, iter_6_3 in ipairs(var_6_1) do
					var_5_2(var_6_3[iter_6_3], iter_6_3, arg_6_2 .. "    ", arg_6_3 + 1, var_6_2)
				end

				var_5_1[#var_5_1 + 1] = string.format("%s}", arg_6_2)
			end
		end
	end

	var_5_2(arg_5_0, arg_5_1, "- ", 1)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		print(iter_5_1)
	end
end

local function var_0_1(arg_8_0, arg_8_1)
	local var_8_0 = getmetatable(arg_8_0) or {}

	if not var_8_0.__index then
		var_8_0.__index = arg_8_1

		setmetatable(arg_8_0, var_8_0)
	elseif var_8_0.__index ~= arg_8_1 then
		setmetatableindex(var_8_0, arg_8_1)
	end
end

function class(arg_9_0)
	local var_9_0 = {
		__cname = arg_9_0
	}

	for iter_9_0, iter_9_1 in ipairs({
		...
	}) do
		local var_9_1 = type(iter_9_1)

		assert(var_9_1 == "nil" or var_9_1 == "table" or var_9_1 == "function", string.format("class() - create class \"%s\" with invalid super class type \"%s\"", arg_9_0, var_9_1))

		if var_9_1 == "function" then
			assert(var_9_0.__create == nil, string.format("class() - create class \"%s\" with more than one creating function", arg_9_0))

			var_9_0.__create = iter_9_1
		elseif var_9_1 == "table" then
			if iter_9_1[".isclass"] then
				assert(var_9_0.__create == nil, string.format("class() - create class \"%s\" with more than one creating function or native class", arg_9_0))

				function var_9_0.__create()
					return iter_9_1:create()
				end
			else
				var_9_0.__supers = var_9_0.__supers or {}
				var_9_0.__supers[#var_9_0.__supers + 1] = iter_9_1
				var_9_0.super = var_9_0.super or iter_9_1
			end
		else
			error(string.format("class() - create class \"%s\" with invalid super type", arg_9_0), 0)
		end
	end

	var_9_0.__index = var_9_0

	if not var_9_0.__supers or #var_9_0.__supers == 1 then
		setmetatable(var_9_0, {
			__index = var_9_0.super
		})
	else
		setmetatable(var_9_0, {
			__index = function(arg_11_0, arg_11_1)
				for iter_11_0 = 1, #var_9_0.__supers do
					if var_9_0.__supers[iter_11_0][arg_11_1] then
						return var_9_0.__supers[iter_11_0][arg_11_1]
					end
				end
			end
		})
	end

	var_9_0.ctor = var_9_0.ctor or function()
		return
	end

	function var_9_0.new()
		local var_13_0 = var_9_0.__create and var_9_0.__create(...) or {}

		var_0_1(var_13_0, var_9_0)

		var_13_0.class = var_9_0

		var_13_0:ctor(...)

		return var_13_0
	end

	function var_9_0.create(arg_14_0)
		return var_9_0.new(...)
	end

	return var_9_0
end

function table.insertto(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = checkint(arg_15_2)

	if arg_15_2 <= 0 then
		arg_15_2 = #arg_15_0 + 1
	end

	for iter_15_0 = 0, #arg_15_1 - 1 do
		arg_15_0[iter_15_0 + arg_15_2] = arg_15_1[iter_15_0 + 1]
	end
end

function math.clamp(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0 < arg_16_1 then
		return arg_16_1
	end

	if arg_16_2 < arg_16_0 then
		return arg_16_2
	end

	return arg_16_0
end
