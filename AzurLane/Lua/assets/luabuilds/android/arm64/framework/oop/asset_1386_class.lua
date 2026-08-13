local function var_0_0(arg_1_0, arg_1_1)
	type = var_1_10002

	if var_1_10002(arg_1_0) ~= "table" then
		return arg_1_0
	elseif arg_1_1[arg_1_0] then
		return arg_1_1[arg_1_0]
	end

	arg_1_1[arg_1_0] = {}
	type = var_1_10003

	local var_1_0 = var_1_10003(arg_1_0) == "table" and arg_1_0.__ctype == 2

	pairs = var_4

	for iter_1_0, iter_1_1 in var_4(arg_1_0) do
		if var_1_0 and iter_1_0 == "class" then
			var_2[iter_1_0] = iter_1_1
		else
			Clone_Copy = var_1_10009
			var_1_10009 = var_1_10009(iter_1_0, arg_1_1)
			Clone_Copy = var_1_10010
			var_2[var_1_10009] = var_1_10010(iter_1_1, arg_1_1)
		end
	end

	setmetatable = var_4

	local var_1_1 = var_2

	getmetatable = iter_1_0

	return var_4(var_1_1, iter_1_0(arg_1_0))
end

local var_0_1 = Clone_Copy

local function var_0_2(arg_2_0)
	Clone_Copy = var_1_10001

	return var_1_10001(arg_2_0, {})
end

local var_0_3 = Clone

local function var_0_4(arg_3_0, arg_3_1)
	type = var_1_10002

	local var_3_0 = var_1_10002(arg_3_1)
	local var_3_1

	if var_3_0 ~= "function" and var_3_0 ~= "table" then
		var_3_0 = nil
		arg_3_1 = nil
	end

	if var_3_0 == "function" or arg_3_1 and arg_3_1.__ctype == 1 then
		var_3_1 = {}

		if var_3_0 == "table" then
			pairs = var_4

			for iter_3_0, iter_3_1 in var_4(arg_3_1) do
				var_3_1[iter_3_0] = iter_3_1
			end

			var_3_1.__create = arg_3_1.__create
			var_3_1.super = arg_3_1
		else
			var_3_1.__create = arg_3_1
		end

		function var_3_1.Ctor()
			return
		end

		var_3_1.__cname = arg_3_0
		var_3_1.__ctype = 1

		function var_3_1.New(...)
			local var_5_0 = var_3_1.__create(...)

			pairs = var_2_10001

			for iter_5_0, iter_5_1 in var_2_10001(var_3_1) do
				var_5_0[iter_5_0] = iter_5_1
			end

			var_5_0.class = var_3_1

			var_5_0:Ctor(...)

			return var_5_0
		end
	else
		if arg_3_1 then
			setmetatable = var_4
			var_3_1 = var_4({}, arg_3_1)
			var_3_1.super = arg_3_1
		else
			var_3_1 = {
				Ctor = function()
					return
				end
			}
		end

		var_3_1.__cname = arg_3_0
		var_3_1.__ctype = 2
		var_3_1.__index = var_3_1

		function var_3_1.New(...)
			setmetatable = var_2_10000

			local var_7_0 = var_2_10000({}, var_3_1)

			var_7_0.class = var_3_1

			var_7_0:Ctor(...)

			return var_7_0
		end
	end

	return var_3_1
end

local var_0_5 = class

local function var_0_6(arg_8_0, arg_8_1)
	getmetatable = var_1_10002

	local var_8_0 = var_1_10002(arg_8_0)

	while var_8_0 ~= nil do
		if var_8_0 == arg_8_1 then
			return true
		else
			assert = var_1_10003
			getmetatable = var_1_10005
			var_1_10005 = var_8_0 ~= var_1_10005(var_8_0)

			var_1_10003(var_1_10005, "Loop metatable")

			getmetatable = var_1_10003
			var_8_0 = var_1_10003(var_8_0)
		end
	end

	return false
end

local var_0_7 = isa

local function var_0_8(arg_9_0, arg_9_1)
	superof = var_1_10002

	return var_1_10002(arg_9_0.class, arg_9_1)
end

local var_0_9 = instanceof

local function var_0_10(arg_10_0, arg_10_1)
	while arg_10_0 ~= nil do
		if arg_10_0 == arg_10_1 then
			return true
		else
			arg_10_0 = arg_10_0.super
		end
	end

	return false
end

local var_0_11 = superof

local function var_0_12(arg_11_0, arg_11_1)
	class = var_1_10002
	var_2._new = var_1_10002(arg_11_0, arg_11_1).New
	rawset = var_3

	var_3(var_2, "_singletonInstance", nil)

	function var_2.New()
		if not var_0._singletonInstance then
			return var_0.GetInstance()
		end

		error = var_0

		var_0("singleton class can not new. Please use " .. arg_11_0 .. ".GetInstance() to get it", 2)

		return
	end

	function var_2.GetInstance()
		rawget = var_2_10000

		if var_2_10000(var_0, "_singletonInstance") == nil then
			rawset = var_0

			var_0(var_0, "_singletonInstance", var_0._new())
		end

		return var_0._singletonInstance
	end

	return var_2
end

local var_0_13 = singletonClass

local function var_0_14(arg_14_0)
	if arg_14_0 then
		rawget = var_1_10001

		if var_1_10001(arg_14_0, "_singletonInstance") then
			rawset = var_1

			var_1(arg_14_0, "_singletonInstance", nil)

			return true
		end
	end

	return false
end

local var_0_15 = removeSingletonInstance

local function var_0_16()
	local var_15_0 = ""
	local var_15_1 = 2
	local var_15_2 = var_15_0 .. "stack traceback:\n"

	while true do
		debug = var_2

		if not var_2.getinfo(var_15_1, "Sln") then
			break
		end

		local var_15_5

		if var_2.what == "C" then
			local var_15_3 = var_15_2

			tostring = var_15_5
			var_15_2 = var_15_3 .. var_15_5(var_15_1) .. "\tC function\n"
		else
			local var_15_4 = var_15_2

			string = var_15_5
			var_15_5 = var_15_5.format

			local var_15_6 = "\t[%s]:%d in function `%s`\n"
			local var_15_7 = var_2.short_src
			local var_15_8 = var_2.currentline
			local var_15_9

			if not var_2.name then
				var_15_9 = ""
			end

			var_15_2 = var_15_4 .. var_15_5(var_15_6, var_15_7, var_15_8, var_15_9)
		end

		local var_15_10 = 1

		while true do
			debug = var_15_5

			local var_15_11

			var_15_5, var_15_11 = var_15_5.getlocal(var_15_1, var_15_10)

			if not var_15_5 then
				break
			end

			local var_15_12 = var_15_2
			local var_15_13 = "\t\t"
			local var_15_14 = var_15_5
			local var_15_15 = " =\t"

			tostringex = var_1_10010
			var_15_2 = var_15_12 .. var_15_13 .. var_15_14 .. var_15_15 .. var_1_10010(var_15_11, 3) .. "\n"
			var_15_10 = var_15_10 + 1
		end

		var_15_1 = var_15_1 + 1
	end

	return var_15_2
end

local var_0_17 = tracebackex

local function var_0_18(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		arg_16_1 = 0
	end

	string = var_1_10002

	local var_16_0 = var_1_10002.rep("\t", arg_16_1)
	local var_16_1 = ""

	type = var_4

	local var_16_8

	if var_4(arg_16_0) == "table" then
		if arg_16_1 > 5 then
			return "\t{ ... }"
		end

		local var_16_2 = ""

		pairs = var_5

		for iter_16_0, iter_16_1 in var_5(arg_16_0) do
			local var_16_3 = var_16_2
			local var_16_4 = "\n\t"
			local var_16_5 = var_16_0

			tostring = var_1_10013

			local var_16_6 = var_16_3 .. var_16_4 .. var_16_5 .. var_1_10013(iter_16_0) .. ":"

			tostringex = var_16_4
			var_16_2 = var_16_6 .. var_16_4(iter_16_1, arg_16_1 + 1)
		end

		local var_16_9

		if var_16_2 == "" then
			local var_16_7 = var_16_1

			var_16_8 = var_16_0
			var_16_9 = "{ }\t("
			tostring = iter_16_0
			var_16_1 = var_16_7 .. var_16_8 .. var_16_9 .. iter_16_0(arg_16_0) .. ")"
		else
			if arg_16_1 > 0 then
				local var_16_10 = var_16_1

				var_16_8 = "\t("
				tostring = var_16_9
				var_16_1 = var_16_10 .. var_16_8 .. var_16_9(arg_16_0) .. ")\n"
			end

			var_16_1 = var_16_1 .. var_16_0 .. "{" .. var_16_2 .. "\n" .. var_16_0 .. "}"
		end
	else
		local var_16_11 = var_16_1
		local var_16_12 = var_16_0

		tostring = var_16_8

		local var_16_13 = var_16_8(arg_16_0)
		local var_16_14 = "\t("

		type = var_8
		var_16_1 = var_16_11 .. var_16_12 .. var_16_13 .. var_16_14 .. var_8(arg_16_0) .. ")"
	end

	return var_16_1
end

local var_0_19 = tostringex

local function var_0_20(arg_17_0, arg_17_1)
	assert = var_1_10002

	var_1_10002(arg_17_0, "Need a Base Class")

	setmetatable = var_1_10002

	local var_17_0 = var_1_10002({}, {
		__index = function(arg_18_0, arg_18_1)
			local var_18_0

			if not arg_17_0[arg_18_1] then
				var_18_0 = arg_17_1[arg_18_1]
			end

			return var_18_0
		end
	})

	var_17_0.super = arg_17_0
	var_17_0.__cname = arg_17_0.__cname .. " feat." .. arg_17_1.__cname
	var_17_0.__ctype = 2
	var_17_0.__index = var_17_0

	function var_17_0.New(...)
		setmetatable = var_2_10000

		local var_19_0 = var_2_10000({}, var_17_0)

		var_19_0.class = var_17_0

		var_19_0:Ctor(...)

		return var_19_0
	end

	return var_17_0
end

local var_0_21 = DecorateClass

return
