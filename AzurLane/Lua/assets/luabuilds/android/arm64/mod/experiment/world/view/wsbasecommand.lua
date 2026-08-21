local var_0_0 = class("WSBaseCommand")

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0 ~= nil and type(arg_1_0) == arg_1_1
end

local var_0_2 = {
	__index = function(arg_2_0, arg_2_1)
		local var_2_0 = rawget(arg_2_0, "class")

		if var_0_1(rawget(var_0_0, arg_2_1), "function") then
			return var_2_0[arg_2_1]
		elseif var_0_1(rawget(var_2_0, arg_2_1), "function") then
			return function(arg_3_0, ...)
				arg_3_0:Op(arg_2_1, ...)

				return
			end
		else
			local var_2_1 = rawget(arg_2_0, arg_2_1)

			if var_2_1 == nil then
				return var_2_0[arg_2_1]
			else
				return var_2_1
			end
		end

		return
	end
}

function var_0_0.Ctor(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
	arg_4_0.wsOps = {}

	setmetatable(arg_4_0, var_0_2)

	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

function var_0_0.Op(arg_6_0, arg_6_1, ...)
	assert(arg_6_1 and #arg_6_1 > 0)

	if #arg_6_0.wsOps > 0 then
		WorldConst.Print("ignore operation: " .. arg_6_1 .. ", current operation: " .. arg_6_0.wsOps[#arg_6_0.wsOps])

		return
	end

	WorldConst.Print(arg_6_0.index .. " do operation: " .. arg_6_1)
	table.insert(arg_6_0.wsOps, arg_6_1)
	arg_6_0.class[arg_6_1](arg_6_0, ...)

	return
end

function var_0_0.OpDone(arg_7_0, arg_7_1, ...)
	assert(#arg_7_0.wsOps > 0, "current operation can not be nil.")

	if arg_7_1 ~= nil and arg_7_0.wsOps[#arg_7_0.wsOps] .. "Done" ~= arg_7_1 then
		assert(false, "current operation " .. arg_7_0.wsOps[#arg_7_0.wsOps] .. " mismatch with " .. arg_7_1)

		return
	end

	WorldConst.Print(arg_7_0.index .. " operation done: " .. arg_7_0.wsOps[#arg_7_0.wsOps])
	table.remove(arg_7_0.wsOps, #arg_7_0.wsOps)

	if arg_7_1 then
		arg_7_0.class[arg_7_1](arg_7_0, ...)
	end

	return
end

function var_0_0.OpRaw(arg_8_0, arg_8_1, ...)
	local var_8_0 = setmetatable({
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
	})

	var_8_0[arg_8_1](var_8_0, ...)

	return
end

function var_0_0.OpClear(arg_11_0)
	arg_11_0.wsOps = {}

	return
end

return var_0_0
