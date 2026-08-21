local var_0_0 = class("IslandOwnedDressItem", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.num = arg_1_1.num
	arg_1_0.read = arg_1_1.read

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_dress_template
end

function var_0_0.GetRarity(arg_3_0)
	return arg_3_0:getConfig("quality")
end

return var_0_0
