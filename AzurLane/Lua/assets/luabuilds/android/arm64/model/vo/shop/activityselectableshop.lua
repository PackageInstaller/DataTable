local var_0_0 = class("ActivitySelectableShop", import(".ActivityShop"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data1_list) do
		({})[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	arg_1_0.goods = {}

	local var_1_0 = arg_1_0:bindConfigTable()

	for iter_1_2, iter_1_3 in ipairs(var_1_0.all) do
		if arg_1_1.id == var_1_0[iter_1_3].activity then
			local var_1_1 = ({})[iter_1_3]

			if not ({})[iter_1_3] then
				var_1_1 = 0
			end

			arg_1_0.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_1
			}, Goods.TYPE_ACTIVITY_SELECTABLE)
		end
	end

	arg_1_0.type = ShopArgs.ShopActivity
	arg_1_0.config = pg.activity_template[arg_1_0.activityId]

	return
end

function var_0_0.IsSameKind(arg_2_0, arg_2_1)
	local var_2_0 = isa(arg_2_1, ActivitySelectableShop)

	if var_2_0 then
		var_2_0 = arg_2_1.activityId and arg_2_1.activityId == arg_2_0.activityId
	end

	return var_2_0
end

return var_0_0
