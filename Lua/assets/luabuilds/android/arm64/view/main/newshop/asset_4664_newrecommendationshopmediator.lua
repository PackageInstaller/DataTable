local NewRecommendationShopMediator = class("NewRecommendationShopMediator", import("...base.ContextMediator"))

NewRecommendationShopMediator.GO_SHOP = "NewRecommendationShopMediator.GO_SHOP"

function NewRecommendationShopMediator:register()
	self:bind(NewRecommendationShopMediator.GO_SHOP, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.CHANGE_SCENE, arg_2_1, arg_2_2)

		return
	end)

	return
end

function NewRecommendationShopMediator:listNotificationInterests()
	return {
		NewShopMainScene.CLOSE_ALL_LAYER,
		PlayerProxy.UPDATED
	}
end

function NewRecommendationShopMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == NewShopMainScene.CLOSE_ALL_LAYER then
		self.viewComponent:closeView()
	elseif var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:ShowResUI()
	end

	return
end

return NewRecommendationShopMediator
