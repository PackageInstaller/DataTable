class = var_0_10000

local var_0_0 = "ActivitySelectableShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityShop"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.id

	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_1.data1_list) do
		var_1_0[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	arg_1_0.goods = {}

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.bindConfigTable(var_1_1)

	ipairs = var_1_1

	for iter_1_2, iter_1_3 in var_1_1(var_1_2.all) do
		if arg_1_1.id == var_1_2[iter_1_3].activity then
			local var_1_3

			if not var_1_0[iter_1_3] then
				var_1_3 = 0
			end

			local var_1_4 = arg_1_0.goods

			Goods = var_1_10011
			var_1_10011 = var_1_10011.Create

			local var_1_5 = {
				shop_id = iter_1_3,
				buy_count = var_1_3
			}

			Goods = var_1_10013
			var_1_4[iter_1_3] = var_1_10011(var_1_5, var_1_10013.TYPE_ACTIVITY_SELECTABLE)
		end
	end

	ShopArgs = var_4
	arg_1_0.type = var_4.ShopActivity
	pg = var_4
	arg_1_0.config = var_4.activity_template[arg_1_0.activityId]

	return
end

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	ActivitySelectableShop = var_1_10004

	local var_2_1

	if var_1_10002(var_2_0, var_1_10004) and arg_2_1.activityId then
		var_2_1 = arg_2_1.activityId == arg_2_0.activityId
	end

	return var_2_1
end

return var_0_1
