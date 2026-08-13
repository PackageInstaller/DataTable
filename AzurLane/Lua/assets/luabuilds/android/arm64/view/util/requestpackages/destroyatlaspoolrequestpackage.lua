class = var_0_10000

local var_0_0 = "DestroyAtlasPoolRequestPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	if arg_1_0.callback then
		arg_1_0.callback(arg_1_0.path)
	end

	PoolMgr = var_1

	local var_1_0 = var_1.GetInstance()

	var_1.DestroySprite(var_1_0, arg_1_0.path)

	return arg_1_0
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.path = arg_2_1
	arg_2_0.name = ""
	arg_2_0.callback = arg_2_2

	return
end

return var_0_1
