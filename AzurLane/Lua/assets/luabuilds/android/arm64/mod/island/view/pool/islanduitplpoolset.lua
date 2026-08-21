local var_0_0 = class("IslandUITplPoolSet", import(".IslandRootTplPool"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.root = arg_1_1
	arg_1_0.pool = IslandUIPool.New(arg_1_0.root, arg_1_2, typeof(GameObject), arg_1_4, arg_1_5)

	return
end

return var_0_0
