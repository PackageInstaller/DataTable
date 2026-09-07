local NewYearHotSpringShopMediator = class("NewYearHotSpringShopMediator", import("view.base.ContextMediator"))

NewYearHotSpringShopMediator.ON_ACT_SHOPPING = "NewYearHotSpringShopMediator:ON_ACT_SHOPPING"

function NewYearHotSpringShopMediator:register()
	self:TransActivity2ShopData((getProxy(ActivityProxy):getActivityById(ActivityConst.HOTSPRING_SHOP)))
	self:bind(NewYearHotSpringShopMediator.ON_ACT_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4
		})

		return
	end)
	self:bind(GAME.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)

	return
end

function NewYearHotSpringShopMediator:TransActivity2ShopData(arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		local var_4_0 = ActivityShop.New(arg_4_1)

		self.viewComponent:SetShop(var_4_0)

		return var_4_0
	end

	return
end

function NewYearHotSpringShopMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD
	}
end

function NewYearHotSpringShopMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1.id == ActivityConst.HOTSPRING_SHOP then
			self:TransActivity2ShopData(var_6_1)
			self.viewComponent:UpdateView()
		end
	elseif var_6_0 == ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, function()
			self.viewComponent:OnShoppingDone()
			existCall(var_6_1.callback)

			return
		end)
	end

	return
end

return NewYearHotSpringShopMediator
