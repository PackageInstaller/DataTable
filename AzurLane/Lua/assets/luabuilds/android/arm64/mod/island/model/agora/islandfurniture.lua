local var_0_0 = class("IslandFurniture")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.count = arg_1_1.count or 1
	arg_1_0.time = arg_1_1.time or arg_1_1.id
	arg_1_0.isNew = defaultValue(arg_1_1.isNew, false)

	return
end

function var_0_0.SetNew(arg_2_0, arg_2_1)
	arg_2_0.isNew = arg_2_1

	return
end

function var_0_0.SetTime(arg_3_0, arg_3_1)
	arg_3_0.time = arg_3_1

	return
end

return var_0_0
