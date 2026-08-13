class = var_0_10000

local var_0_0 = var_0_10000("IslandFurniture")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.count then
		var_1_0 = 1
	end

	arg_1_0.count = var_1_0

	local var_1_1

	if not arg_1_1.time then
		var_1_1 = arg_1_1.id
	end

	arg_1_0.time = var_1_1
	defaultValue = var_1_1
	arg_1_0.isNew = var_1_1(arg_1_1.isNew, false)

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
