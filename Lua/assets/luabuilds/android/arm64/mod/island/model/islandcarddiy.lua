local var_0_0 = class("IslandCardDiy", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_1.num or 1

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_card_diy
end

function var_0_0.AddCount(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_0.count + arg_3_1

	return
end

return var_0_0
