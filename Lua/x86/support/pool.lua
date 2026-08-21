local var_0_0 = class("Pool")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._parent = arg_1_2
	arg_1_0._template = arg_1_1
	arg_1_0._count = arg_1_3
	arg_1_0._pool = {}
	arg_1_0._isUsing = {}
	arg_1_0._queue = {}

	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	for iter_2_0 = 1, arg_2_0._count do
		local var_2_0 = Object.Instantiate(arg_2_0._template, arg_2_0._parent.transform)

		var_2_0.transform.localScale = Vector3(1, 1, 1)
		arg_2_0._pool[iter_2_0] = var_2_0
		arg_2_0._isUsing[iter_2_0] = true
	end
end

function var_0_0.AddPool(arg_3_0)
	arg_3_0._count = arg_3_0._count + 1

	local var_3_0 = Object.Instantiate(arg_3_0._template, arg_3_0._parent.transform)

	var_3_0.transform.localScale = Vector3(1, 1, 1)
	arg_3_0._pool[arg_3_0._count] = var_3_0
	arg_3_0._isUsing[arg_3_0._count] = true
end

function var_0_0.GetCanUsingObj(arg_4_0)
	for iter_4_0 = 1, arg_4_0._count do
		if arg_4_0._isUsing[iter_4_0] == true then
			arg_4_0._isUsing[iter_4_0] = false

			table.insert(arg_4_0._queue, iter_4_0)

			return arg_4_0._pool[iter_4_0], iter_4_0
		end
	end

	arg_4_0:AddPool()

	arg_4_0._isUsing[arg_4_0._count] = false

	table.insert(arg_4_0._queue, arg_4_0._count)

	return arg_4_0._pool[arg_4_0._count], arg_4_0._count
end

function var_0_0.GetUseingIndexObj(arg_5_0, arg_5_1)
	return arg_5_0._pool[arg_5_1]
end

function var_0_0.FinishIndex(arg_6_0, arg_6_1)
	table.removebyvalue(arg_6_0._queue, arg_6_1)

	arg_6_0._isUsing[arg_6_1] = true
end

function var_0_0.GetQueueHead(arg_7_0)
	return arg_7_0._queue[1]
end

function var_0_0.AllUsed(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._isUsing) do
		if iter_8_1 then
			return false
		end
	end

	return true
end

function var_0_0.GetPool(arg_9_0)
	return arg_9_0._pool
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0._pool then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._pool) do
			Object.Destroy(iter_10_1)
		end

		arg_10_0._pool = nil
	end

	arg_10_0._isUsing = nil
	arg_10_0._queue = nil
	arg_10_0._template = nil
end

return var_0_0
