class = var_0_10000

local var_0_0 = "NewRecommendationShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.GO_SHOP = "NewRecommendationShopMediator.GO_SHOP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SHOP, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.CHANGE_SCENE, arg_2_1, arg_2_2)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	NewShopMainScene = var_1_10002
	var_3_0[1] = var_1_10002.CLOSE_ALL_LAYER
	PlayerProxy = var_2
	var_3_0[2] = var_2.UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	NewShopMainScene = var_4_1

	if var_4_0 == var_4_1.CLOSE_ALL_LAYER then
		local var_4_3 = arg_4_0.viewComponent

		var_4.closeView(var_4_3)
	else
		PlayerProxy = var_4

		if var_4_0 == var_4.UPDATED then
			local var_4_4 = arg_4_0.viewComponent

			var_4.ShowResUI(var_4_4)
		end
	end

	return
end

return var_0_1
