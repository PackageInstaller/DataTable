class = var_0_10000

local var_0_0 = var_0_10000("PoolObjPack")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.key = arg_1_1
	arg_1_0.ab = arg_1_2
	arg_1_0.items = {}
	arg_1_0.typeDic = {}

	return
end

function var_0_0.Get(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0.items[arg_2_1] then
		local var_2_0 = arg_2_0.items
		local var_2_1 = arg_2_0.ab

		var_2_0[arg_2_1] = var_4.LoadAssetSync(var_2_1, arg_2_1, arg_2_2, false, false)
		arg_2_0.typeDic[arg_2_1] = arg_2_2
	end

	return arg_2_0.items[arg_2_1]
end

function var_0_0.Remove(arg_3_0, arg_3_1)
	table = var_1_10002

	return var_1_10002.removebykey(arg_3_0.items, arg_3_1)
end

function var_0_0.GetAmount(arg_4_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_4_0.items)
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.items = nil
	arg_5_0.typeDic = nil

	local var_5_0 = arg_5_0.ab

	var_1.Dispose(var_5_0)

	arg_5_0.ab = nil

	return
end

return var_0_0
