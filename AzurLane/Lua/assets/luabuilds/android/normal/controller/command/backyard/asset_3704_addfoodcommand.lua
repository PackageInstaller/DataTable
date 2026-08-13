class = var_0_10000

local var_0_0 = "AddFoodCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	Item = var_1_10005

	local var_1_2 = var_1_10005.getConfigData(var_1_0)

	getProxy = var_6
	DormProxy = var_1_10007

	local var_1_3 = var_6(var_1_10007)
	local var_1_4 = var_6.getData(var_1_3)

	if var_7.getConfig(var_1_4, "capacity") + var_7:GetFoodMax() < var_7.food + var_1_2.usage_arg[1] * var_1_1 then
		var_7.food = var_8
	else
		var_7.food = var_7.food + var_1_2.usage_arg[1] * var_1_1
	end

	local var_1_5 = var_6
	local var_1_6 = var_6.updateDrom
	local var_1_7 = var_7

	BackYardConst = var_1_10012

	var_1_6(var_1_5, var_1_7, var_1_10012.DORM_UPDATE_TYPE_USEFOOD)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.sendNotification

	GAME = var_1_7

	var_1_9(var_1_8, var_1_7.ADD_FOOD_DONE, {
		id = var_1_0
	})

	return
end

return var_0_1
