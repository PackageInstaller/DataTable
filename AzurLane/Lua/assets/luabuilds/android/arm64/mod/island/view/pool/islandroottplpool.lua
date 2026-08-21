local var_0_0 = class("IslandRootTplPool", import(".IslandPoolBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.root = arg_1_1
	arg_1_0.pool = IslandObjectPool.New(arg_1_0.root, arg_1_2, typeof(GameObject), arg_1_4)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	if arg_2_0.pool:Isloaded() then
		arg_2_1()

		return
	end

	arg_2_0.pool:Load(arg_2_1)

	return
end

function var_0_0.GetObject(arg_3_0)
	return arg_3_0.pool:Dequeue()
end

function var_0_0.ReturnObject(arg_4_0, arg_4_1)
	arg_4_0.pool:Enqueue(arg_4_1)

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.pool:Clear()

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.pool:Dispose()

	return
end

return var_0_0
