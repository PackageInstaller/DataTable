function clone(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		if type(arg_2_0) ~= "table" then
			return arg_2_0
		elseif var_1_0[arg_2_0] then
			return var_1_0[arg_2_0]
		end

		local var_2_0 = {}

		var_1_0[arg_2_0] = var_2_0

		for iter_2_0, iter_2_1 in pairs(arg_2_0) do
			var_2_0[var_1_1(iter_2_0)] = var_1_1(iter_2_1)
		end

		return setmetatable(var_2_0, getmetatable(arg_2_0))
	end

	return var_1_1(arg_1_0)
end

function class(arg_3_0, arg_3_1)
	local var_3_0 = type(arg_3_1)
	local var_3_1

	if var_3_0 ~= "function" and var_3_0 ~= "table" then
		var_3_0 = nil
		arg_3_1 = nil
	end

	if var_3_0 == "function" or arg_3_1 and arg_3_1.__ctype == 1 then
		var_3_1 = {}

		if var_3_0 == "table" then
			for iter_3_0, iter_3_1 in pairs(arg_3_1) do
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

			for iter_5_0, iter_5_1 in pairs(var_3_1) do
				var_5_0[iter_5_0] = iter_5_1
			end

			var_5_0.class = var_3_1

			var_5_0:Ctor(...)

			return var_5_0
		end
	else
		if arg_3_1 then
			var_3_1 = setmetatable({}, arg_3_1)
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
			local var_7_0 = setmetatable({}, var_3_1)

			var_7_0.class = var_3_1

			var_7_0:Ctor(...)

			return var_7_0
		end
	end

	return var_3_1
end

function partialClass(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_2 or _G[arg_8_0] or class(arg_8_0, arg_8_1)
end

function isa(arg_9_0, arg_9_1)
	local var_9_0 = getmetatable(arg_9_0)

	while var_9_0 ~= nil do
		if var_9_0 == arg_9_1 then
			return true
		else
			var_9_0 = getmetatable(var_9_0)
		end
	end

	return false
end

function singletonClass(arg_10_0, arg_10_1)
	local var_10_0 = class(arg_10_0, arg_10_1)

	var_10_0._new = var_10_0.New

	rawset(var_10_0, "_singletonInstance", nil)

	function var_10_0.New()
		if not var_10_0._singletonInstance then
			return var_10_0.GetInstance()
		end

		error("singleton class can not new. Please use " .. arg_10_0 .. ".GetInstance() to get it", 2)
	end

	function var_10_0.GetInstance()
		if rawget(var_10_0, "_singletonInstance") == nil then
			rawset(var_10_0, "_singletonInstance", var_10_0._new())
		end

		return var_10_0._singletonInstance
	end

	return var_10_0
end

function removeSingletonInstance(arg_13_0)
	if arg_13_0 and rawget(arg_13_0, "_singletonInstance") then
		arg_13_0.New = arg_13_0._new
		arg_13_0._new = nil

		rawset(arg_13_0, "_singletonInstance", nil)

		return true
	end

	return false
end

function tracebackex()
	local var_14_0 = ""
	local var_14_1 = 2
	local var_14_2 = var_14_0 .. "stack traceback:\n"

	while true do
		local var_14_3 = debug.getinfo(var_14_1, "Sln")

		if not var_14_3 then
			break
		end

		if var_14_3.what == "C" then
			var_14_2 = var_14_2 .. tostring(var_14_1) .. "\tC function\n"
		else
			var_14_2 = var_14_2 .. string.format("\t[%s]:%d in function `%s`\n", var_14_3.short_src, var_14_3.currentline, var_14_3.name or "")
		end

		var_14_1 = var_14_1 + 1
	end

	return var_14_2
end

function tostringex(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		arg_15_1 = 0
	end

	local var_15_0 = string.rep("\t", arg_15_1)
	local var_15_1 = ""

	if type(arg_15_0) == "table" then
		if arg_15_1 > 5 then
			return "\t{ ... }"
		end

		local var_15_2 = ""

		for iter_15_0, iter_15_1 in pairs(arg_15_0) do
			var_15_2 = var_15_2 .. "\n\t" .. var_15_0 .. tostring(iter_15_0) .. ":"
			var_15_2 = var_15_2 .. tostringex(iter_15_1, arg_15_1 + 1)
		end

		if var_15_2 == "" then
			var_15_1 = var_15_1 .. var_15_0 .. "{ }\t(" .. tostring(arg_15_0) .. ")"
		else
			if arg_15_1 > 0 then
				var_15_1 = var_15_1 .. "\t(" .. tostring(arg_15_0) .. ")\n"
			end

			var_15_1 = var_15_1 .. var_15_0 .. "{" .. var_15_2 .. "\n" .. var_15_0 .. "}"
		end
	else
		var_15_1 = var_15_1 .. var_15_0 .. tostring(arg_15_0) .. "\t(" .. type(arg_15_0) .. ")"
	end

	return var_15_1
end
