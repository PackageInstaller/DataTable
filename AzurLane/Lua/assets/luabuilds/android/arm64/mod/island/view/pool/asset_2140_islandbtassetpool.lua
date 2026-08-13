class = var_0_10000

local var_0_0 = "IslandBtAssetPool"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandObjectPool"))

function var_0_1.CanDelete(arg_1_0)
	return arg_1_0:Isloaded()
end

function var_0_1.Dequeue(arg_2_0)
	return arg_2_0:NewItem()
end

function var_0_1.DequeueAsyn(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_0:Isloaded(), "call load first")

	local var_3_0 = arg_3_1

	Object = var_4

	var_3_0(var_4.Instantiate(arg_3_0.asset))

	return
end

function var_0_1.Enqueue(arg_4_0, arg_4_1)
	return
end

return var_0_1
