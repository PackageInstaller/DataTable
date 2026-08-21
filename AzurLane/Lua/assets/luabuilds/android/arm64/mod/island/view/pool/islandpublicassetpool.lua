local var_0_0 = class("IslandPublicAssetPool", import(".IslandObjectPool"))

function var_0_0.CanDelete(arg_1_0)
	return arg_1_0:Isloaded()
end

function var_0_0.Dequeue(arg_2_0)
	return arg_2_0:NewItem()
end

function var_0_0.DequeueAsyn(arg_3_0, arg_3_1)
	arg_3_1(arg_3_0:NewItem())

	return
end

function var_0_0.NewItem(arg_4_0)
	assert(arg_4_0:Isloaded(), "call load first")

	return arg_4_0.asset
end

function var_0_0.Enqueue(arg_5_0, arg_5_1)
	return
end

return var_0_0
