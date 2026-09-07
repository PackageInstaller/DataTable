local BackyardFeedMediator = class("BackyardFeedMediator", import("...base.ContextMediator"))

BackyardFeedMediator.USE_FOOD = "BackyardFeedMediator:USE_FOOD"
BackyardFeedMediator.BUY_FOOD = "BackyardFeedMediator:BUY_FOOD"
BackyardFeedMediator.EXTEND = "BackyardFeedMediator:EXTEND"

function BackyardFeedMediator:register()
	local var_1_0 = getProxy(SettingsProxy)

	self:bind(BackyardFeedMediator.USE_FOOD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_2_3 then
			var_1_0:setBackyardRemind()
			self.viewComponent:SetIsRemind(var_1_0:getBackyardRemind())
		end

		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	self:bind(BackyardFeedMediator.BUY_FOOD, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_3_1,
			count = arg_3_2
		})

		return
	end)
	self:bind(BackyardFeedMediator.EXTEND, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_4_1,
			count = arg_4_2
		})

		return
	end)
	self.viewComponent:SetIsRemind(var_1_0:getBackyardRemind())

	return
end

function BackyardFeedMediator:listNotificationInterests()
	return {
		GAME.ADD_FOOD_DONE,
		DormProxy.DORM_UPDATEED,
		GAME.SHOPPING_DONE
	}
end

function BackyardFeedMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.ADD_FOOD_DONE then
		self.viewComponent:OnUsageItem(arg_6_1:getBody().id)
	elseif var_6_0 == DormProxy.DORM_UPDATEED and arg_6_1:getType() == BackYardConst.DORM_UPDATE_TYPE_USEFOOD then
		self.viewComponent:OnDormUpdated()
	elseif var_6_0 == GAME.SHOPPING_DONE then
		self.viewComponent:OnShopDone()
	end

	return
end

return BackyardFeedMediator
