class = var_0_10000

local var_0_0 = "FriendDormShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".DormShip"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.configId = arg_1_1.tid
	arg_1_0.skinId = arg_1_1.skin_id

	return
end

function var_0_1.ToBayShip(arg_2_0)
	Ship = var_1_10001

	return (var_1_10001.New({
		energy = 100,
		id = arg_2_0.id,
		configId = arg_2_0.configId,
		skin_id = arg_2_0.skinId
	}))
end

return var_0_1
