class = var_0_10000

local var_0_0 = var_0_10000("SyncUnitVisitor")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.RecordLastInteract(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.lastInteract = {
		type = arg_2_2,
		id = arg_2_1
	}

	return
end

function var_0_0.ClearLastInteract(arg_3_0)
	arg_3_0.lastInteract = nil

	return
end

function var_0_0.GetLastInteract(arg_4_0)
	return arg_4_0.lastInteract
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
