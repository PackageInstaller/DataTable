class = var_0_10000

local var_0_0 = "GetActivityShopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	ActivityConst = var_1_10004

	local var_1_1 = var_1_10004.ACTIVITY_TYPE_SHOP

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getActivitiesByType(var_1_2, var_1_1)

	getProxy = var_1_2
	ShopsProxy = var_8

	local var_1_4 = var_1_2(var_8)
	local var_1_5 = {}

	_ = var_1_10009

	var_1_10009.each(var_1_3, function(arg_2_0)
		if arg_2_0 and not arg_2_0:isEnd() and arg_2_0:getConfig("config_id") == 0 then
			ActivityShop = var_1

			local var_2_0 = var_1.New(arg_2_0)

			var_1_5[arg_2_0.id] = var_2_0

			local var_2_1 = var_1_4

			var_2.addActivityShops(var_2_1, var_1_5)
		end

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.sendNotification

	GAME = var_11

	var_1_7(var_1_6, var_11.GET_ACTIVITY_SHOP_DONE)

	if var_1_0 then
		var_1_0(var_1_5)
	end

	return
end

return var_0_1
