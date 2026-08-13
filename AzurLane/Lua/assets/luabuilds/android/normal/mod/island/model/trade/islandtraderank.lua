class = var_0_10000

local var_0_0 = var_0_10000("IslandTradeRank")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.value = arg_1_1.value
	arg_1_0.skinId = arg_1_1.skinId
	arg_1_0.islandLevel = arg_1_1.islandLevel
	arg_1_0.name = arg_1_1.name

	return
end

function var_0_0.IsVaild(arg_2_0)
	return arg_2_0.value > 0
end

function var_0_0.IsSelf(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getRawData(var_3_0)

	return arg_3_0.id == var_3_1.id
end

function var_0_0.SetValue(arg_4_0, arg_4_1)
	arg_4_0.value = arg_4_1

	return
end

return var_0_0
