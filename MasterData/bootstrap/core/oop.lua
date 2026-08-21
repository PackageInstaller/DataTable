module("bootstrap.core.oop", package.seeall)

function checknumber(arg_1_0, arg_1_1)
	return tonumber(arg_1_0, arg_1_1) or 0
end

function checkint(arg_2_0)
	return math.round(checknumber(arg_2_0))
end

function checkbool(arg_3_0)
	return arg_3_0 ~= nil and arg_3_0 ~= false
end

function checktable(arg_4_0)
	if type(arg_4_0) ~= "table" then
		arg_4_0 = {}
	end

	return arg_4_0
end

function isset(arg_5_0, arg_5_1)
	local var_5_0 = type(arg_5_0)

	return (var_5_0 == "table" or var_5_0 == "userdata") and arg_5_0[arg_5_1] ~= nil
end

local var_0_0

local function var_0_1(arg_6_0, arg_6_1)
	if type(arg_6_0) == "userdata" then
		local var_6_0 = tolua.getpeer(arg_6_0)

		if not var_6_0 then
			var_6_0 = {}

			tolua.setpeer(arg_6_0, var_6_0)
		end

		var_0_1(var_6_0, arg_6_1)
	else
		local var_6_1 = getmetatable(arg_6_0) or {}

		if not var_6_1.__index then
			var_6_1.__index = arg_6_1

			setmetatable(arg_6_0, var_6_1)
		elseif var_6_1.__index ~= arg_6_1 then
			var_0_1(var_6_1, arg_6_1)
		end
	end
end

setmetatableindex = var_0_1

function clone(arg_7_0)
	local var_7_0 = {}

	local function var_7_1(arg_8_0)
		if type(arg_8_0) ~= "table" then
			return arg_8_0
		elseif var_7_0[arg_8_0] then
			return var_7_0[arg_8_0]
		end

		local var_8_0 = {}

		var_7_0[arg_8_0] = var_8_0

		for iter_8_0, iter_8_1 in pairs(arg_8_0) do
			var_8_0[var_7_1(iter_8_0)] = var_7_1(iter_8_1)
		end

		return setmetatable(var_8_0, getmetatable(arg_8_0))
	end

	return var_7_1(arg_7_0)
end

function nclass(arg_9_0, arg_9_1)
	local var_9_0 = class(arg_9_0, function()
		return arg_9_1.New()
	end)

	var_9_0.super = arg_9_1

	setmetatable(var_9_0, {
		__index = var_9_0.super
	})

	return var_9_0
end

function class(arg_11_0, ...)
	local var_11_0 = {
		__cname = arg_11_0
	}
	local var_11_1 = {
		...
	}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = type(iter_11_1)

		assert(var_11_2 == "nil" or var_11_2 == "table" or var_11_2 == "function", string.format("class() - create class \"%s\" with invalid super class type \"%s\"", arg_11_0, var_11_2))

		if var_11_2 == "function" then
			assert(var_11_0.__create == nil, string.format("class() - create class \"%s\" with more than one creating function", arg_11_0))

			var_11_0.__create = iter_11_1
		elseif var_11_2 == "table" then
			if iter_11_1[".isclass"] then
				assert(var_11_0.__create == nil, string.format("class() - create class \"%s\" with more than one creating function or native class", arg_11_0))

				function var_11_0.__create()
					return iter_11_1:create()
				end
			else
				var_11_0.__supers = var_11_0.__supers or {}
				var_11_0.__supers[#var_11_0.__supers + 1] = iter_11_1

				if not var_11_0.super then
					var_11_0.super = iter_11_1
				end
			end
		else
			error(string.format("class() - create class \"%s\" with invalid super type", arg_11_0), 0)
		end
	end

	var_11_0.__index = var_11_0

	if not var_11_0.__supers or #var_11_0.__supers == 1 then
		if var_11_0.super then
			setmetatable(var_11_0, {
				__index = var_11_0.super
			})
		end
	else
		setmetatable(var_11_0, {
			__index = function(arg_13_0, arg_13_1)
				local var_13_0 = var_11_0.__supers

				for iter_13_0 = 1, #var_13_0 do
					local var_13_1 = var_13_0[iter_13_0]

					if var_13_1[arg_13_1] then
						return var_13_1[arg_13_1]
					end
				end
			end
		})
	end

	function var_11_0.New(...)
		local var_14_0

		if var_11_0.__create then
			var_14_0 = var_11_0.__create(...)
		else
			var_14_0 = {}
		end

		if type(var_14_0) == "userdata" then
			if not tolua.getpeer(var_14_0) then
				local var_14_1 = {}

				tolua.setpeer(var_14_0, var_14_1)
			end

			for iter_14_0, iter_14_1 in pairs(var_11_0) do
				var_14_0[iter_14_0] = iter_14_1
			end

			var_14_0.class = var_11_0
		else
			setmetatableindex(var_14_0, var_11_0)

			var_14_0.class = var_11_0
		end

		local var_14_2 = findNearestCtorObj(var_14_0)

		if var_14_2 then
			var_14_2.ctor(var_14_0, ...)
		end

		return var_14_0
	end

	function var_11_0.create(arg_15_0, ...)
		return var_11_0.New(...)
	end

	return var_11_0
end

function findNearestCtorObj(arg_16_0)
	local var_16_0
	local var_16_1 = arg_16_0

	while var_16_1 do
		if var_16_1.ctor then
			var_16_0 = var_16_1

			break
		end

		var_16_1 = var_16_1.super
	end

	return var_16_0
end

local var_0_2

local function var_0_3(arg_17_0, arg_17_1)
	local var_17_0 = rawget(arg_17_0, "__index")

	if type(var_17_0) == "table" and rawget(var_17_0, "__cname") == arg_17_1 then
		return true
	end

	if rawget(arg_17_0, "__cname") == arg_17_1 then
		return true
	end

	local var_17_1 = rawget(arg_17_0, "__supers")

	if not var_17_1 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if var_0_3(iter_17_1, arg_17_1) then
			return true
		end
	end

	return false
end

function iskindof(arg_18_0, arg_18_1)
	local var_18_0 = type(arg_18_0)

	if var_18_0 ~= "table" and var_18_0 ~= "userdata" then
		return false
	end

	local var_18_1

	if var_18_0 == "userdata" then
		if tolua.typename(arg_18_0) == arg_18_1 then
			return true
		end

		var_18_1 = tolua.getpeer(arg_18_0)
	else
		var_18_1 = getmetatable(arg_18_0)
	end

	if var_18_1 then
		return var_0_3(var_18_1, arg_18_1)
	end

	return false
end

setglobal("checknumber", checknumber)
setglobal("checkint", checkint)
setglobal("checkbool", checkbool)
setglobal("checktable", checktable)
setglobal("isset", isset)
setglobal("clone", clone)
setglobal("nclass", nclass)
setglobal("class", class)
setglobal("iskindof", iskindof)
