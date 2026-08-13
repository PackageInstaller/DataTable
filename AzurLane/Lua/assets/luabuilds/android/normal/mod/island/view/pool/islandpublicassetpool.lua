class = var_0_10000

local var_0_0 = "IslandPublicAssetPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandObjectPool"))

function var_0_1.CanDelete(arg_1_0)
	return arg_1_0:Isloaded()
end

function var_0_1.Dequeue(arg_2_0)
	return arg_2_0:NewItem()
end

function var_0_1.DequeueAsyn(arg_3_0, arg_3_1)
	arg_3_1(arg_3_0:NewItem())

	return
end

function var_0_1.NewItem(arg_4_0)
	assert = var_1_10001

	var_1_10001(arg_4_0:Isloaded(), "call load first")

	return arg_4_0.asset
end

function var_0_1.Enqueue(arg_5_0, arg_5_1)
	return
end

return var_0_1
