class = var_0_10000

local var_0_0 = var_0_10000("WSBaseCommand")

local function var_0_1(arg_1_0, arg_1_1)
	if arg_1_0 ~= nil then
		type = var_1_10002

		local var_1_0

		if var_1_10002(arg_1_0) ~= arg_1_1 then
			var_1_0 = false
		else
			var_1_0 = true
		end

		return var_1_0
	end
end

local var_0_2 = {
	__index = function(arg_2_0, arg_2_1)
		rawget = var_1_10002

		local var_2_0 = var_1_10002(arg_2_0, "class")
		local var_2_1 = var_0_1

		rawget = var_5

		if var_2_1(var_5(var_0_0, arg_2_1), "function") then
			return var_2_0[arg_2_1]
		else
			local var_2_2 = var_0_1

			rawget = var_5

			if var_2_2(var_5(var_2_0, arg_2_1), "function") then
				return function(arg_3_0, ...)
					arg_3_0:Op(arg_2_1, ...)

					return
				end
			else
				rawget = var_3

				if var_3(arg_2_0, arg_2_1) == nil then
					return var_2_0[arg_2_1]
				else
					return var_3
				end
			end
		end

		return
	end
}

function var_0_0.Ctor(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
	arg_4_0.wsOps = {}
	setmetatable = var_2

	var_2(arg_4_0, var_0_2)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

function var_0_0.Op(arg_6_0, arg_6_1, ...)
	assert = var_1_10002

	var_1_10002(arg_6_1 and #arg_6_1 > 0)

	if #arg_6_0.wsOps > 0 then
		WorldConst = var_2

		var_2.Print("ignore operation: " .. arg_6_1 .. ", current operation: " .. arg_6_0.wsOps[#arg_6_0.wsOps])

		return
	end

	WorldConst = var_2

	var_2.Print(arg_6_0.index .. " do operation: " .. arg_6_1)

	table = var_2

	var_2.insert(arg_6_0.wsOps, arg_6_1)
	arg_6_0.class[arg_6_1](arg_6_0, ...)

	return
end

function var_0_0.OpDone(arg_7_0, arg_7_1, ...)
	assert = var_1_10002

	var_1_10002(#arg_7_0.wsOps > 0, "current operation can not be nil.")

	local var_7_0 = arg_7_0.wsOps[#arg_7_0.wsOps]

	if arg_7_1 ~= nil and var_7_0 .. "Done" ~= arg_7_1 then
		assert = var_3

		var_3(false, "current operation " .. var_7_0 .. " mismatch with " .. arg_7_1)

		return
	end

	WorldConst = var_3

	var_3.Print(arg_7_0.index .. " operation done: " .. var_7_0)

	table = var_3

	var_3.remove(arg_7_0.wsOps, #arg_7_0.wsOps)

	if arg_7_1 then
		arg_7_0.class[arg_7_1](arg_7_0, ...)
	end

	return
end

function var_0_0.OpRaw(arg_8_0, arg_8_1, ...)
	setmetatable = var_1_10002

	var_1_10002({
		Op = function(arg_9_0, arg_9_1, ...)
			arg_9_0.class[arg_9_1](arg_9_0, ...)

			return
		end,
		OpDone = function(arg_10_0, arg_10_1, ...)
			if arg_10_1 then
				arg_10_0[arg_10_1](arg_10_0, ...)
			end

			return
		end
	}, {
		__index = arg_8_0,
		__newindex = arg_8_0
	})[arg_8_1](var_2, ...)

	return
end

function var_0_0.OpClear(arg_11_0)
	arg_11_0.wsOps = {}

	return
end

return var_0_0
