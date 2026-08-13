class = var_0_10000

local var_0_0 = "GetSpriteRequestPackage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	local var_1_0 = arg_1_0.path
	local var_1_1 = arg_1_0.name

	PoolMgr = var_1_10003

	local var_1_2 = var_1_10003.GetInstance()

	var_3.GetSprite(var_1_2, var_1_0, var_1_1, true, function(arg_2_0)
		if arg_1_0.stopped then
			PoolMgr = var_1

			local var_2_0 = var_1.GetInstance()

			var_1.DecreasSprite(var_2_0, var_1_0, var_1_1)

			return
		end

		if arg_1_0.onLoaded then
			arg_1_0.onLoaded(arg_2_0)
		end

		return
	end)

	return arg_1_0
end

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.path = arg_3_1
	arg_3_0.name = arg_3_2
	arg_3_0.onLoaded = arg_3_3

	return
end

return var_0_1
