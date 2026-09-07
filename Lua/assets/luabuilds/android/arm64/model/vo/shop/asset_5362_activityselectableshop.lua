local ActivitySelectableShop = class("ActivitySelectableShop", import(".ActivityShop"))

function ActivitySelectableShop:Ctor(arg_1_1)
	self.activityId = arg_1_1.id

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data1_list) do
		var_1_0[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	self.goods = {}

	local var_1_1 = self:bindConfigTable()

	for iter_1_2, iter_1_3 in ipairs(var_1_1.all) do
		if arg_1_1.id == var_1_1[iter_1_3].activity then
			local var_1_2 = var_1_0[iter_1_3] or 0

			self.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_2
			}, Goods.TYPE_ACTIVITY_SELECTABLE)
		end
	end

	self.type = ShopArgs.ShopActivity
	self.config = pg.activity_template[self.activityId]

	return
end

function ActivitySelectableShop:IsSameKind(arg_2_1)
	local var_2_0 = isa(arg_2_1, ActivitySelectableShop)

	if var_2_0 then
		var_2_0 = arg_2_1.activityId and arg_2_1.activityId == self.activityId
	end

	return var_2_0
end

return ActivitySelectableShop
