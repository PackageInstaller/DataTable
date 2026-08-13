class = var_0_10000

local var_0_0 = "BaseEntity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseDispatcher"))

var_0_1.Fields = {}
var_0_1.Listeners = {}

local var_0_2 = {
	__index = function(arg_1_0, arg_1_1)
		rawget = var_1_10002

		local var_1_0 = var_1_10002(arg_1_0, "class")

		rawget = var_3

		if var_3(arg_1_0, "fields")[arg_1_1] ~= nil then
			return var_4
		end

		rawget = var_5

		if var_5(arg_1_0, arg_1_1) ~= nil then
			return var_4
		end

		return var_1_0[arg_1_1]
	end,
	__newindex = function(arg_2_0, arg_2_1, arg_2_2)
		rawget = var_1_10003

		local var_2_0 = var_1_10003(arg_2_0, "fields")

		rawget = var_4

		local var_2_1 = var_4(arg_2_0, "class")

		while var_2_1 ~= nil and var_2_1 ~= var_0_1 do
			local var_2_2

			if var_2_1.Fields[arg_2_1] ~= nil then
				assert = var_5
				type = var_2_2

				if var_2_2(arg_2_2) ~= "nil" then
					type = var_2_2

					if var_2_2(arg_2_2) ~= var_2_1.Fields[arg_2_1] then
						var_2_2 = false

						goto label_2_0
					end
				end

				var_2_2 = true

				::label_2_0::

				var_5(var_2_2, "Field type mismatch: " .. var_2_1.__cname .. "." .. arg_2_1)

				var_2_0[arg_2_1] = arg_2_2

				return
			end

			var_2_1 = var_2_1.super
		end

		assert = var_5

		local var_2_3 = false
		local var_2_4 = "Field miss: "

		rawget = var_1_10008

		var_5(var_2_3, var_2_4 .. var_1_10008(arg_2_0, "class").__cname .. "." .. arg_2_1)

		return
	end
}

function var_0_1.Ctor(arg_3_0, ...)
	var_0_1.super.Ctor(arg_3_0)

	local var_3_0 = {}

	rawset = var_2

	var_2(arg_3_0, "fields", var_3_0)

	local var_3_1 = arg_3_0.class

	while var_3_1 ~= nil and var_3_1 ~= var_0_1 do
		pairs = var_3

		for iter_3_0, iter_3_1 in var_3(var_3_1.Listeners) do
			assert = var_1_10008

			var_1_10008(var_3_1.Fields[iter_3_0] == nil, "Repeated field: " .. var_3_1.__cname .. "." .. iter_3_0)

			var_1_10008 = var_3_1[iter_3_1]

			local var_3_2

			if not var_3_0[iter_3_0] then
				function var_3_2(...)
					var_1_10008(arg_3_0, ...)

					return
				end
			end

			var_3_0[iter_3_0] = var_3_2
		end

		var_3_1 = var_3_1.super
	end

	setmetatable = var_3

	var_3(arg_3_0, var_0_2)
	arg_3_0:Build(...)

	return
end

function var_0_1.Build(arg_5_0)
	return
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

function var_0_1.Clear(arg_7_0)
	var_0_1.super.ClearListeners(arg_7_0)

	rawget = var_1

	local var_7_0 = var_1(arg_7_0, "class")

	rawget = var_2

	local var_7_1 = var_2(arg_7_0, "fields")

	while var_7_0 ~= nil and var_7_0 ~= var_0_1 do
		pairs = var_3

		for iter_7_0, iter_7_1 in var_3(var_7_0.Fields) do
			var_7_1[iter_7_0] = nil
		end

		var_7_0 = var_7_0.super
	end

	return
end

function var_0_1.Clone(arg_8_0)
	return var_0_1.Clone_Copy(arg_8_0, {})
end

function var_0_1.Clone_Copy(arg_9_0, arg_9_1)
	type = var_1_10002

	if var_1_10002(arg_9_0) ~= "table" then
		return arg_9_0
	elseif arg_9_1[arg_9_0] then
		return arg_9_1[arg_9_0]
	end

	type = var_2

	if var_2(arg_9_0) == "table" then
		instanceof = var_2

		if var_2(arg_9_0, var_0_1) then
			rawget = var_2
			arg_9_1[arg_9_0] = var_2(arg_9_0, "class").New()
			rawget = var_4

			local var_9_0 = var_4(arg_9_0, "fields")

			while var_9_1 ~= nil and var_9_1 ~= var_0_1 do
				pairs = var_5

				for iter_9_0, iter_9_1 in var_5(var_9_1.Fields) do
					var_3[iter_9_0] = var_0_1.Clone_Copy(var_9_0[iter_9_0], arg_9_1)
				end

				local var_9_1 = var_9_1.super
			end

			do return var_3 end

			goto label_9_0
		end
	end

	arg_9_1[arg_9_0] = {}
	type = var_3

	do
		local var_9_2 = var_3(arg_9_0) == "table" and arg_9_0.__ctype == 2

		pairs = var_4

		for iter_9_2, iter_9_3 in var_4(arg_9_0) do
			if var_9_2 and iter_9_2 == "class" then
				var_2[iter_9_2] = iter_9_3
			else
				var_2[var_0_1.Clone_Copy(iter_9_2, arg_9_1)] = var_0_1.Clone_Copy(iter_9_3, arg_9_1)
			end
		end

		setmetatable = var_4

		local var_9_3 = var_2

		getmetatable = var_6

		return var_4(var_9_3, var_6(arg_9_0))
	end

	::label_9_0::

	return
end

function var_0_1.Trans(arg_10_0, arg_10_1)
	assert = var_1_10002
	superof = var_1_10003

	var_1_10002(var_1_10003(arg_10_1, var_0_1), "class error: without super of BaseEntity")

	local var_10_0 = arg_10_1.New()

	rawget = var_3

	local var_10_1 = var_3(arg_10_0, "fields")

	while arg_10_1 ~= nil and arg_10_1 ~= var_0_1 do
		pairs = var_4

		for iter_10_0, iter_10_1 in var_4(arg_10_1.Fields) do
			var_10_0[iter_10_0] = var_10_1[iter_10_0]
		end

		arg_10_1 = arg_10_1.super
	end

	return var_10_0
end

return var_0_1
