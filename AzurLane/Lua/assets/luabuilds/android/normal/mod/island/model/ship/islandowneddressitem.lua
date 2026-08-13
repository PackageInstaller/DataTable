class = var_0_10000

local var_0_0 = "IslandOwnedDressItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.num = arg_1_1.num
	arg_1_0.read = arg_1_1.read

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_dress_template
end

function var_0_1.GetRarity(arg_3_0)
	return arg_3_0:getConfig("quality")
end

return var_0_1
