class = var_0_10000

local var_0_0 = "AsyncParallelExcutionRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	if not arg_1_0.funcs or #arg_1_0.funcs == 0 then
		return
	end

	local var_1_0 = #arg_1_0.funcs

	local function var_1_1()
		if arg_1_0.stopped then
			return
		end

		var_1_0 = var_1_0 - 1

		if var_1_0 == 0 and arg_1_0.final then
			arg_1_0.final()
		end

		return
	end

	if 0 < var_1_0 then
		ipairs = var_4

		for iter_1_0, iter_1_1 in var_4(var_1) do
			iter_1_1(var_1_1)
		end
	elseif arg_1_0.final then
		arg_1_0.final()
	end

	return
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.funcs = arg_3_1
	arg_3_0.final = arg_3_2

	return
end

return var_0_1
