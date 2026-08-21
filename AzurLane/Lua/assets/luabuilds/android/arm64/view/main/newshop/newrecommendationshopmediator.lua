local var_0_0 = class("NewRecommendationShopMediator", import("...base.ContextMediator"))

var_0_0.GO_SHOP = "NewRecommendationShopMediator.GO_SHOP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SHOP, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.CHANGE_SCENE, arg_2_1, arg_2_2)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		NewShopMainScene.CLOSE_ALL_LAYER,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == NewShopMainScene.CLOSE_ALL_LAYER then
		arg_4_0.viewComponent:closeView()
	elseif var_4_0 == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:ShowResUI()
	end

	return
end

return var_0_0
