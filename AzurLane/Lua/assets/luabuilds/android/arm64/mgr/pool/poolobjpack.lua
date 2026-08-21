local var_0_0 = class("PoolObjPack")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.key = arg_1_1
	arg_1_0.ab = arg_1_2
	arg_1_0.items = {}
	arg_1_0.typeDic = {}

	return
end

function var_0_0.Get(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0.items[arg_2_1] then
		arg_2_0.items[arg_2_1] = arg_2_0.ab:LoadAssetSync(arg_2_1, arg_2_2, false, false)
		arg_2_0.typeDic[arg_2_1] = arg_2_2
	end

	return arg_2_0.items[arg_2_1]
end

function var_0_0.Remove(arg_3_0, arg_3_1)
	return table.removebykey(arg_3_0.items, arg_3_1)
end

function var_0_0.GetAmount(arg_4_0)
	return table.getCount(arg_4_0.items)
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.items = nil
	arg_5_0.typeDic = nil

	arg_5_0.ab:Dispose()

	arg_5_0.ab = nil

	return
end

return var_0_0
