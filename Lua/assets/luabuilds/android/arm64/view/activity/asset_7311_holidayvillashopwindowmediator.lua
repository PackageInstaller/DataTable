local HolidayVillaShopWindowMediator = class("HolidayVillaShopWindowMediator", import("..base.ContextMediator"))

HolidayVillaShopWindowMediator.SHOPPING_CONFIRM = "HolidayVillaShopWindowMediator.SHOPPING_CONFIRM"

function HolidayVillaShopWindowMediator:register()
	self:bind(HolidayVillaShopWindowMediator.SHOPPING_CONFIRM, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ISLAND_SHOPPING, {
			shop = self.contextData.shop,
			arg1 = self.contextData.goods.id,
			arg2 = arg_2_1
		})

		return
	end)
	self.viewComponent:setGoods(self.contextData.goods)

	return
end

function HolidayVillaShopWindowMediator:listNotificationInterests()
	return {
		GAME.ISLAND_SHOPPING_DONE
	}
end

function HolidayVillaShopWindowMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.ISLAND_SHOPPING_DONE then
		self.viewComponent:closeView()
	end

	return
end

return HolidayVillaShopWindowMediator
