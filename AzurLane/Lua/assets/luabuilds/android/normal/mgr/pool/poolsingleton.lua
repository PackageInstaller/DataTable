require = var_0_10000

local var_0_0 = var_0_10000("Mgr/Pool/PoolUtil")

class = var_1

local var_0_1 = var_1("PoolSingleton")

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.prefab = arg_1_1
	arg_1_0.index = 0

	return
end

function var_0_1.Clear(arg_2_0)
	var_0_0.Destroy(arg_2_0.prefab)

	arg_2_0.prefab = nil
	arg_2_0.index = 0

	return
end

return var_0_1
