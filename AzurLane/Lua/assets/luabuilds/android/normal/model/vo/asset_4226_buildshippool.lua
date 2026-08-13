class = var_0_10000

local var_0_0 = "BuildShipPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.BUILD_POOL_MARK_SPECIAL = "special"
var_0_1.BUILD_POOL_MARK_LIGHT = "light"
var_0_1.BUILD_POOL_MARK_HEAVY = "heavy"
var_0_1.BUILD_POOL_MARK_NEW = "new"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	assert = var_2

	var_2(arg_1_1.mark)

	arg_1_0.mark = arg_1_1.mark

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.ship_data_create_material
end

function var_0_1.GetPoolId(arg_3_0)
	return arg_3_0.configId
end

function var_0_1.GetSortCode(arg_4_0)
	if arg_4_0.mark == var_0_1.BUILD_POOL_MARK_SPECIAL then
		return 4
	elseif arg_4_0.mark == var_0_1.BUILD_POOL_MARK_LIGHT then
		return 2
	elseif arg_4_0.mark == var_0_1.BUILD_POOL_MARK_HEAVY then
		return 3
	elseif arg_4_0.mark == var_0_1.BUILD_POOL_MARK_NEW then
		return 1
	else
		return 5
	end

	return
end

function var_0_1.IsActivity(arg_5_0)
	return false
end

function var_0_1.GetMark(arg_6_0)
	return arg_6_0.mark
end

return var_0_1
