local var_0_0 = class("BaseEntity", import(".BaseDispatcher"))

var_0_0.Fields = {}
var_0_0.Listeners = {}

local var_0_1 = {
	__index = function(arg_1_0, arg_1_1)
		local var_1_0 = rawget(arg_1_0, "fields")[arg_1_1]

		if var_1_0 ~= nil then
			return var_1_0
		end

		local var_1_1 = rawget(arg_1_0, arg_1_1)

		if var_1_1 ~= nil then
			return var_1_1
		end

		return rawget(arg_1_0, "class")[arg_1_1]
	end,
	__newindex = function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = rawget(arg_2_0, "fields")
		local var_2_1 = rawget(arg_2_0, "class")

		while var_2_1 ~= nil and var_2_1 ~= var_0_0 do
			if var_2_1.Fields[arg_2_1] ~= nil then
				assert(type(arg_2_2) == "nil" or type(arg_2_2) == var_2_1.Fields[arg_2_1], "Field type mismatch: " .. var_2_1.__cname .. "." .. arg_2_1)

				var_2_0[arg_2_1] = arg_2_2

				return
			end

			var_2_1 = var_2_1.super
		end

		assert(false, "Field miss: " .. rawget(arg_2_0, "class").__cname .. "." .. arg_2_1)

		return
	end
}

function var_0_0.Ctor(arg_3_0, ...)
	var_0_0.super.Ctor(arg_3_0)

	local var_3_0 = {}

	rawset(arg_3_0, "fields", {})

	local var_3_1 = arg_3_0.class

	while var_3_1 ~= nil and var_3_1 ~= var_0_0 do
		for iter_3_0, iter_3_1 in pairs(var_3_1.Listeners) do
			assert(var_3_1.Fields[iter_3_0] == nil, "Repeated field: " .. var_3_1.__cname .. "." .. iter_3_0)

			local var_3_2 = var_3_1[iter_3_1]

			var_3_0[iter_3_0] = var_3_0[iter_3_0] or function(...)
				var_3_2(arg_3_0, ...)

				return
			end
		end

		var_3_1 = var_3_1.super
	end

	setmetatable(arg_3_0, var_0_1)
	arg_3_0:Build(...)

	return
end

function var_0_0.Build(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

function var_0_0.Clear(arg_7_0)
	var_0_0.super.ClearListeners(arg_7_0)

	local var_7_0 = rawget(arg_7_0, "class")
	local var_7_1 = rawget(arg_7_0, "fields")

	while var_7_0 ~= nil and var_7_0 ~= var_0_0 do
		for iter_7_0, iter_7_1 in pairs(var_7_0.Fields) do
			var_7_1[iter_7_0] = nil
		end

		var_7_0 = var_7_0.super
	end

	return
end

function var_0_0.Clone(arg_8_0)
	return var_0_0.Clone_Copy(arg_8_0, {})
end

function var_0_0.Clone_Copy(arg_9_0, arg_9_1)
	if type(arg_9_0) ~= "table" then
		return arg_9_0
	elseif arg_9_1[arg_9_0] then
		return arg_9_1[arg_9_0]
	end

	if type(arg_9_0) == "table" and instanceof(arg_9_0, var_0_0) then
		local var_9_0 = rawget(arg_9_0, "class")
		local var_9_1 = var_9_0.New()

		arg_9_1[arg_9_0] = var_9_1

		local var_9_2 = rawget(arg_9_0, "fields")

		while var_9_0 ~= nil and var_9_0 ~= var_0_0 do
			for iter_9_0, iter_9_1 in pairs(var_9_0.Fields) do
				var_9_1[iter_9_0] = var_0_0.Clone_Copy(var_9_2[iter_9_0], arg_9_1)
			end

			var_9_0 = var_9_0.super
		end

		return var_9_1
	else
		local var_9_3 = {}

		arg_9_1[arg_9_0] = {}

		local var_9_4 = type(arg_9_0) == "table" and arg_9_0.__ctype == 2

		for iter_9_2, iter_9_3 in pairs(arg_9_0) do
			if var_9_4 and iter_9_2 == "class" then
				var_9_3[iter_9_2] = iter_9_3
			else
				var_9_3[var_0_0.Clone_Copy(iter_9_2, arg_9_1)] = var_0_0.Clone_Copy(iter_9_3, arg_9_1)
			end
		end

		return setmetatable(var_9_3, getmetatable(arg_9_0))
	end

	return
end

function var_0_0.Trans(arg_10_0, arg_10_1)
	assert(superof(arg_10_1, var_0_0), "class error: without super of BaseEntity")

	local var_10_0 = arg_10_1.New()
	local var_10_1 = rawget(arg_10_0, "fields")

	while arg_10_1 ~= nil and arg_10_1 ~= var_0_0 do
		for iter_10_0, iter_10_1 in pairs(arg_10_1.Fields) do
			var_10_0[iter_10_0] = var_10_1[iter_10_0]
		end

		arg_10_1 = arg_10_1.super
	end

	return var_10_0
end

return var_0_0
