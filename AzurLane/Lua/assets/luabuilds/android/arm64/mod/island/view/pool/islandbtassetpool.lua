local var_0_0 = class("IslandBtAssetPool", import(".IslandObjectPool"))

function var_0_0.CanDelete(arg_1_0)
	return arg_1_0:Isloaded()
end

function var_0_0.Dequeue(arg_2_0)
	return arg_2_0:NewItem()
end

function var_0_0.DequeueAsyn(arg_3_0, arg_3_1)
	assert(arg_3_0:Isloaded(), "call load first")
	arg_3_1(Object.Instantiate(arg_3_0.asset))

	return
end

function var_0_0.Enqueue(arg_4_0, arg_4_1)
	return
end

return var_0_0
