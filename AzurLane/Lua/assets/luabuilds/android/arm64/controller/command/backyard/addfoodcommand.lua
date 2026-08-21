local var_0_0 = class("AddFoodCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = Item.getConfigData(var_1_0.id)
	local var_1_3 = getProxy(DormProxy)
	local var_1_4 = var_1_3:getData()
	local var_1_5 = var_1_4:getConfig("capacity") + var_1_4:GetFoodMax()

	var_1_4.food = var_1_5 < var_1_4.food + var_1_2.usage_arg[1] * var_1_0.count and var_1_5 or var_1_4.food + var_1_2.usage_arg[1] * var_1_0.count

	var_1_3:updateDrom(var_1_4, BackYardConst.DORM_UPDATE_TYPE_USEFOOD)
	arg_1_0:sendNotification(GAME.ADD_FOOD_DONE, {
		id = var_1_1
	})

	return
end

return var_0_0
