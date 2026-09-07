local EducateShopMediator = class("EducateShopMediator", import("..base.EducateContextMediator"))

EducateShopMediator.ON_SHOPPING = "ON_SHOPPING"

function EducateShopMediator:register()
	self:bind(EducateShopMediator.ON_SHOPPING, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.EDUCATE_SHOPPING, {
			shopId = arg_2_1.shopId,
			goods = arg_2_1.goods
		})

		return
	end)

	return
end

function EducateShopMediator:listNotificationInterests()
	return {
		GAME.EDUCATE_SHOPPING_DONE
	}
end

function EducateShopMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.EDUCATE_SHOPPING_DONE then
		self.viewComponent:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
			items = arg_4_1:getBody().drops
		})
		self.viewComponent:refreshShops()
	end

	return
end

return EducateShopMediator
