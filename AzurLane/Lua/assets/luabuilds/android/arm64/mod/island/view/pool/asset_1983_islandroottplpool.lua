class = var_0_10000

local var_0_0 = "IslandRootTplPool"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandPoolBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.root = arg_1_1
	IslandObjectPool = var_1_10005

	local var_1_0 = var_1_10005.New
	local var_1_1 = arg_1_0.root
	local var_1_2 = arg_1_2

	typeof = var_1_10009
	GameObject = var_1_10011
	arg_1_0.pool = var_1_0(var_1_1, var_1_2, var_1_10009(var_1_10011), arg_1_4)

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.pool

	if var_2.Isloaded(var_2_0) then
		arg_2_1()

		return
	end

	local var_2_1 = arg_2_0.pool

	var_2.Load(var_2_1, arg_2_1)

	return
end

function var_0_1.GetObject(arg_3_0)
	local var_3_0 = arg_3_0.pool

	return var_1.Dequeue(var_3_0)
end

function var_0_1.ReturnObject(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.pool

	var_2.Enqueue(var_4_0, arg_4_1)

	return
end

function var_0_1.Clear(arg_5_0)
	local var_5_0 = arg_5_0.pool

	var_1.Clear(var_5_0)

	return
end

function var_0_1.Dispose(arg_6_0)
	local var_6_0 = arg_6_0.pool

	var_1.Dispose(var_6_0)

	return
end

return var_0_1
