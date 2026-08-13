class = var_0_10000

local var_0_0 = "LoadReferenceRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	LoadAnyAsync = var_1

	var_1(arg_1_0.path, arg_1_0.name, arg_1_0.type, function(arg_2_0)
		if arg_1_0.stopped then
			return
		end

		if arg_1_0.onLoaded then
			arg_1_0.onLoaded(arg_2_0)
		end

		return
	end)

	return arg_1_0
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.path = arg_3_1
	arg_3_0.name = arg_3_2
	arg_3_0.type = arg_3_3
	arg_3_0.onLoaded = arg_3_4

	return
end

return var_0_1
