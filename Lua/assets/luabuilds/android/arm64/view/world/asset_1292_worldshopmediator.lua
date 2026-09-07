local WorldShopMediator = class("WorldShopMediator", import("view.base.ContextMediator"))

WorldShopMediator.BUY_ITEM = "WorldShopMediator:BUY_ITEM"

function WorldShopMediator:register()
	self:bind(WorldShopMediator.BUY_ITEM, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function WorldShopMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE
	}
end

function WorldShopMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_4_1)
	elseif var_4_0 == GAME.SHOPPING_DONE and #var_4_1.awards > 0 then
		self.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_4_1.awards
		})
	end

	return
end

return WorldShopMediator
