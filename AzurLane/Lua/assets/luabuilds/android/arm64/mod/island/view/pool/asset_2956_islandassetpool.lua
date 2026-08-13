class = var_0_10000

local var_0_0 = "IslandAssetPool"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandObjectPool"))

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

function var_0_1.Enqueue(arg_4_0, arg_4_1)
	Object = var_1_10002

	var_1_10002.Destroy(arg_4_1)

	return
end

return var_0_1
