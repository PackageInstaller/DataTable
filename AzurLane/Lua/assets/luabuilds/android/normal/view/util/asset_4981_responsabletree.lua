local var_0_0 = {}

var_0_0.__cname = "ResponsableTree"
var_0_0.__ctype = 2

local var_0_1 = {
	__mode = "kv"
}

setmetatable = var_0_10002
var_0_0.InstanceMap = var_0_10002({}, var_0_1)
var_0_0.DATA_ADD = 1
var_0_0.DATA_UPDATE = 0
var_0_0.DATA_DELETE = -1

function var_0_0.__index(arg_1_0, arg_1_1)
	local var_1_0

	if not var_0_0[arg_1_1] then
		var_1_0 = arg_1_0._properties[arg_1_1]
	end

	return var_1_0
end

local var_0_2 = 1000
local var_0_3 = 0

function var_0_0.__newindex(arg_2_0, arg_2_1, arg_2_2)
	rawget = var_1_10003

	if var_1_10003(arg_2_0._properties, arg_2_1) ~= arg_2_2 and not arg_2_0._quiet then
		local var_2_0 = var_3
		local var_2_1 = var_0_0.CreateShell(arg_2_2, arg_2_0)

		arg_2_0._properties[arg_2_1] = var_2_1

		local var_2_2 = var_0_0.DATA_UDPATE

		var_2_2 = var_2_0 == nil and var_0_0.DATA_ADD or var_2_2
		var_2_2 = var_2_1 == nil and var_0_0.DATA_DELETE or var_2_2
		type = var_7

		local var_2_3

		if var_7(var_2_0) == "table" and var_2_0.class == var_0_0 then
			var_2_3 = var_2_0._parents
			var_2_3[arg_2_0] = nil
		end

		type = var_2_3

		if var_2_3(var_2_1) == "table" and var_2_1.class == var_0_0 then
			var_2_1._parents[arg_2_0] = true
		end

		var_0_3 = 0

		arg_2_0:Response(arg_2_0, {
			arg_2_1
		}, {
			var_3,
			var_2_2
		})
	end

	return
end

function var_0_0.Response(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if var_0_3 >= var_0_2 then
		errorMsg = var_4

		var_4("Exceed the Iterate Limitation, Might have inherit loop")

		return
	end

	var_0_3 = var_0_3 + 1
	next = var_4

	local var_3_0

	if not not var_4(arg_3_0._listeners) then
		table = var_3_0
		var_3_0 = var_3_0.concat(arg_3_2, ".")
		ipairs = var_6

		for iter_3_0, iter_3_1 in var_6(arg_3_0._listeners) do
			local var_3_1 = iter_3_1.settings

			ipairs = var_1_10012

			for iter_3_2, iter_3_3 in var_1_10012(iter_3_1.keys) do
				local var_3_2 = "^" .. iter_3_3 .. "$"

				string = var_18

				local var_3_4

				if not var_18.match(var_3_0, var_3_2) and (not var_3_1 or not var_3_1.strict) then
					local var_3_3 = "^" .. iter_3_3 .. "%."

					string = var_19
					var_3_4 = var_19.match(var_3_0, var_3_3)
				end

				local var_3_5

				if var_3_4 then
					var_3_5 = var_3_5 or var_3_1 and not var_3_1.NoAffectOnTransparent

					arg_3_0:DoAction(iter_3_1, arg_3_2, arg_3_3)

					break
				end
			end
		end
	end

	if var_3_5 then
		next = var_3_0

		if not var_3_0(arg_3_0._parents) then
			return
		end

		table = var_3_0

		local var_3_6 = var_3_0.getCount(arg_3_0._parents)

		pairs = var_6

		for iter_3_4, iter_3_5 in var_6(arg_3_0._parents) do
			var_3_6 = var_3_6 - 1

			if 0 < var_3_6 then
				Clone = var_11

				local var_3_7

				if not var_11(arg_3_2) then
					var_3_7 = arg_3_2
				end

				table = var_1_10012
				var_1_10012 = var_1_10012.insert

				local var_3_8 = var_3_7
				local var_3_9 = 1

				table = iter_3_2

				var_1_10012(var_3_8, var_3_9, iter_3_2.keyof(iter_3_4:GetRawData(), arg_3_0))
				iter_3_4:Response(arg_3_1, var_3_7, arg_3_3)
			end
		end

		return
	end
end

function var_0_0.DoAction(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {}
	local var_4_1 = #arg_4_1.keys

	ipairs = var_1_10006

	for iter_4_0, iter_4_1 in var_1_10006(arg_4_1.keys) do
		string = var_1_10011

		if not var_1_10011.split(iter_4_1, ".") then
			var_1_10011 = {}
		end

		var_1_10012 = arg_4_0

		local var_4_2 = 0

		while var_1_10012 and var_4_2 < #var_1_10011 do
			var_1_10012 = var_1_10012[var_1_10011[var_4_2 + 1]]
		end

		var_4_0[iter_4_0] = var_1_10012
	end

	if arg_4_1.settings and arg_4_1.settings.useOldRef then
		table = var_6

		local var_4_3 = var_6.shallowCopy(var_4_0)

		ipairs = var_7

		for iter_4_2, iter_4_3 in var_7(arg_4_1.keys) do
			string = var_1_10012

			if not var_1_10012.split(iter_4_3, ".") then
				var_1_10012 = {}
			end

			table = var_13

			if var_13.equal(var_1_10012, arg_4_2) then
				var_4_3[iter_4_2] = arg_4_3[1]

				break
			end
		end

		arg_4_1.listener(var_4_1, var_4_0, var_4_3, arg_4_3[2])
	else
		local var_4_4 = arg_4_1.listener

		unpack = var_7

		var_4_4(var_7(var_4_0, 1, var_4_1))
	end

	return
end

function var_0_0.PropertyChange(arg_5_0, arg_5_1)
	var_0_3 = 0

	arg_5_0:Response(arg_5_0, {
		arg_5_1
	}, {
		arg_5_0[arg_5_1],
		var_0_0.DATA_UPDATE
	})

	return
end

function var_0_0.CreateShell(arg_6_0, arg_6_1)
	type = var_1_10002

	if var_1_10002(arg_6_0) ~= "table" or arg_6_0.class == var_0_0 then
		return arg_6_0
	end

	if var_0_0.InstanceMap[arg_6_0] then
		if arg_6_1 then
			var_0_0.InstanceMap[arg_6_0]._parents[arg_6_1] = true
		end

		return var_0_0.InstanceMap[arg_6_0]
	end

	local var_6_0 = {
		_quiet = false,
		class = var_0_0,
		_properties = {},
		_listeners = {},
		_parents = {}
	}
	local var_6_1

	if arg_6_1 then
		var_6_1 = var_6_0._parents
		var_6_1[arg_6_1] = true
	end

	setmetatable = var_6_1

	var_6_1(var_6_0, var_0_0)

	setmetatable = var_6_1

	var_6_1(var_6_0._parents, var_0_1)

	local var_6_2 = var_0_0.InstanceMap

	var_6_2[arg_6_0] = var_6_0
	getmetatable = var_6_2

	if var_6_2(arg_6_0) then
		setmetatable = var_4

		var_4(var_6_0._properties, var_3)
	end

	pairs = var_4

	for iter_6_0, iter_6_1 in var_4(arg_6_0) do
		type = var_1_10009

		if var_1_10009(iter_6_1) == "table" and iter_6_1.class ~= var_0_0 then
			rawset = var_1_10009

			var_1_10009(var_6_0._properties, iter_6_0, var_0_0.CreateShell(iter_6_1, var_6_0))
		else
			rawset = var_1_10009

			var_1_10009(var_6_0._properties, iter_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.AddRawListener(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {
		keys = arg_7_1,
		listener = arg_7_2,
		settings = arg_7_3
	}

	table = var_1_10005

	var_1_10005.insert(arg_7_0._listeners, var_7_0)

	return function()
		table = var_2_10000

		return var_2_10000.removebyvalue(arg_7_0._listeners, var_7_0)
	end
end

function var_0_0.GetRawData(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_1 or not arg_9_0._properties[arg_9_1] then
		var_9_0 = arg_9_0._properties
	end

	return var_9_0
end

function var_0_0.SetRawData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._properties[arg_10_1] = arg_10_2

	return
end

function var_0_0.EnterQuietMode(arg_11_0)
	arg_11_0._quiet = true

	return
end

function var_0_0.ExitQuietMode(arg_12_0)
	arg_12_0._quiet = false

	return
end

function var_0_0.insert(arg_13_0, ...)
	select = var_1_10001

	local var_13_0

	if var_1_10001("#", ...) > 1 then
		select = var_13_0
		var_13_0 = var_13_0(1, ...)
		select = var_2

		local var_13_1 = var_2(2, ...)

		assert = var_3

		local var_13_2 = var_13_0 ~= nil
		local var_13_3 = "invalid param 1 for insert, expect number but got "

		type = var_1_10006

		var_3(var_13_2, var_13_3 .. var_1_10006(var_13_0))

		if var_13_1 == nil then
			return
		end

		local var_13_4 = #arg_13_0._properties
		local var_13_5 = arg_13_0._properties[var_13_0]
		local var_13_6

		arg_13_0[var_13_0] = var_13_1

		for iter_13_0 = var_13_0 + 1, var_13_4 + 1 do
			var_13_5, arg_13_0[iter_13_0] = arg_13_0._properties[iter_13_0], var_13_5
		end
	else
		select = var_13_0

		if var_13_0(1, ...) == nil then
			return
		end

		arg_13_0[#arg_13_0._properties + 1] = var_1
	end

	return
end

function var_0_0.remove(arg_14_0, arg_14_1)
	if arg_14_1 == 0 then
		return
	end

	if #arg_14_0._properties == 0 or var_2 < arg_14_1 or arg_14_1 + var_2 <= 0 then
		return
	end

	arg_14_1 = arg_14_1 or var_2
	arg_14_1 = arg_14_1 > 0 and arg_14_1 or var_2 + arg_14_1

	local var_14_0 = arg_14_0[arg_14_1]

	arg_14_0[arg_14_1] = nil

	for iter_14_0 = arg_14_1, var_2 - 1 do
		arg_14_0[iter_14_0] = arg_14_0._properties[iter_14_0 + 1]
	end

	arg_14_0[var_2] = nil

	return var_14_0
end

return var_0_0
