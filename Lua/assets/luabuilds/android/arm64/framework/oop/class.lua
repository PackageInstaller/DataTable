function Clone_Copy(arg_1_0, arg_1_1)
	if type(arg_1_0) ~= "table" then
		return arg_1_0
	elseif arg_1_1[arg_1_0] then
		return arg_1_1[arg_1_0]
	end

	local var_1_0 = {}

	arg_1_1[arg_1_0] = {}

	local var_1_1 = type(arg_1_0) == "table" and arg_1_0.__ctype == 2

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if var_1_1 and iter_1_0 == "class" then
			var_1_0[iter_1_0] = iter_1_1
		else
			var_1_0[Clone_Copy(iter_1_0, arg_1_1)] = Clone_Copy(iter_1_1, arg_1_1)
		end
	end

	return setmetatable(var_1_0, getmetatable(arg_1_0))
end

function Clone(arg_2_0)
	return Clone_Copy(arg_2_0, {})
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

function isa(arg_8_0, arg_8_1)
	local var_8_0 = getmetatable(arg_8_0)

	while var_8_0 ~= nil do
		if var_8_0 == arg_8_1 then
			return true
		else
			assert(var_8_0 ~= getmetatable(var_8_0), "Loop metatable")

			var_8_0 = getmetatable(var_8_0)
		end
	end

	return false
end

function instanceof(arg_9_0, arg_9_1)
	return superof(arg_9_0.class, arg_9_1)
end

function superof(arg_10_0, arg_10_1)
	while arg_10_0 ~= nil do
		if arg_10_0 == arg_10_1 then
			return true
		else
			arg_10_0 = arg_10_0.super
		end
	end

	return false
end

function singletonClass(arg_11_0, arg_11_1)
	local var_11_0 = class(arg_11_0, arg_11_1)

	var_11_0._new = var_11_0.New

	rawset(var_11_0, "_singletonInstance", nil)

	function var_11_0.New()
		if not var_11_0._singletonInstance then
			return var_11_0.GetInstance()
		end

		error("singleton class can not new. Please use " .. arg_11_0 .. ".GetInstance() to get it", 2)

		return
	end

	function var_11_0.GetInstance()
		if rawget(var_11_0, "_singletonInstance") == nil then
			rawset(var_11_0, "_singletonInstance", var_11_0._new())
		end

		return var_11_0._singletonInstance
	end

	return var_11_0
end

function removeSingletonInstance(arg_14_0)
	if arg_14_0 and rawget(arg_14_0, "_singletonInstance") then
		rawset(arg_14_0, "_singletonInstance", nil)

		return true
	end

	return false
end

function tracebackex()
	local var_15_0 = 2
	local var_15_1 = "" .. "stack traceback:\n"

	while true do
		local var_15_2 = debug.getinfo(var_15_0, "Sln")

		if not var_15_2 then
			break
		end

		if var_15_2.what == "C" then
			var_15_1 = var_15_1 .. tostring(var_15_0) .. "\tC function\n"
		else
			local var_15_3 = var_15_1
			local var_15_4 = var_15_2.name or ""

			var_15_1 = var_15_3 .. string.format("\t[%s]:%d in function `%s`\n", var_15_2.short_src, var_15_2.currentline, var_15_4)
		end

		local var_15_5 = 1

		while true do
			local var_15_6, var_15_7 = debug.getlocal(var_15_0, var_15_5)

			if not var_15_6 then
				break
			end

			var_15_1 = var_15_1 .. "\t\t" .. var_15_6 .. " =\t" .. tostringex(var_15_7, 3) .. "\n"
			var_15_5 = var_15_5 + 1
		end

		var_15_0 = var_15_0 + 1
	end

	return var_15_1
end

function tostringex(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		arg_16_1 = 0
	end

	local var_16_0 = string.rep("\t", arg_16_1)
	local var_16_1 = ""

	if type(arg_16_0) == "table" then
		if arg_16_1 > 5 then
			return "\t{ ... }"
		end

		local var_16_2 = ""

		for iter_16_0, iter_16_1 in pairs(arg_16_0) do
			var_16_2 = var_16_2 .. "\n\t" .. var_16_0 .. tostring(iter_16_0) .. ":"
			var_16_2 = var_16_2 .. tostringex(iter_16_1, arg_16_1 + 1)
		end

		if var_16_2 == "" then
			var_16_1 = var_16_1 .. var_16_0 .. "{ }\t(" .. tostring(arg_16_0) .. ")"
		else
			if arg_16_1 > 0 then
				var_16_1 = var_16_1 .. "\t(" .. tostring(arg_16_0) .. ")\n"
			end

			var_16_1 = var_16_1 .. var_16_0 .. "{" .. var_16_2 .. "\n" .. var_16_0 .. "}"
		end
	else
		var_16_1 = var_16_1 .. var_16_0 .. tostring(arg_16_0) .. "\t(" .. type(arg_16_0) .. ")"
	end

	return var_16_1
end

function DecorateClass(arg_17_0, arg_17_1)
	assert(arg_17_0, "Need a Base Class")

	local var_17_0 = setmetatable({}, {
		__index = function(arg_18_0, arg_18_1)
			return arg_17_0[arg_18_1] or arg_17_1[arg_18_1]
		end
	})

	var_17_0.super = arg_17_0
	var_17_0.__cname = arg_17_0.__cname .. " feat." .. arg_17_1.__cname
	var_17_0.__ctype = 2
	var_17_0.__index = var_17_0

	function var_17_0.New(...)
		local var_19_0 = setmetatable({}, var_17_0)

		var_19_0.class = var_17_0

		var_19_0:Ctor(...)

		return var_19_0
	end

	return var_17_0
end

return
