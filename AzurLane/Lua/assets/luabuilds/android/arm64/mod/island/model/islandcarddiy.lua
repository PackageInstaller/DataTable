class = var_0_10000

local var_0_0 = "IslandCardDiy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.num then
		var_1_0 = 1
	end

	arg_1_0.count = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_card_diy
end

function var_0_1.AddCount(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_0.count + arg_3_1

	return
end

return var_0_1
