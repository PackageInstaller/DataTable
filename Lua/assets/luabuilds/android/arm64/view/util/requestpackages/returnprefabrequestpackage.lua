local var_0_0 = class("ReturnPrefabRequestPackage", import(".RequestPackage"))

function var_0_0.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	if arg_1_0.callback then
		arg_1_0.callback(arg_1_0.go)
	end

	PoolMgr.GetInstance():ReturnPrefab(arg_1_0.path, arg_1_0.name, arg_1_0.go, true)

	return arg_1_0
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.path = arg_2_1
	arg_2_0.name = arg_2_2
	arg_2_0.go = arg_2_3
	arg_2_0.callback = arg_2_4

	return
end

return var_0_0
