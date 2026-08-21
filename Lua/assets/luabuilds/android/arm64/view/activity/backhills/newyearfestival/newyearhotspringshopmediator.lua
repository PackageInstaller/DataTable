local var_0_0 = class("NewYearHotSpringShopMediator", import("view.base.ContextMediator"))

var_0_0.ON_ACT_SHOPPING = "NewYearHotSpringShopMediator:ON_ACT_SHOPPING"

function var_0_0.register(arg_1_0)
	arg_1_0:TransActivity2ShopData((getProxy(ActivityProxy):getActivityById(ActivityConst.HOTSPRING_SHOP)))
	arg_1_0:bind(var_0_0.ON_ACT_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		arg_1_0:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4
		})

		return
	end)
	arg_1_0:bind(GAME.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)

	return
end

function var_0_0.TransActivity2ShopData(arg_4_0, arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		local var_4_0 = ActivityShop.New(arg_4_1)

		arg_4_0.viewComponent:SetShop(var_4_0)

		return var_4_0
	end

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1.id == ActivityConst.HOTSPRING_SHOP then
			arg_6_0:TransActivity2ShopData(var_6_1)
			arg_6_0.viewComponent:UpdateView()
		end
	elseif var_6_0 == ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, function()
			arg_6_0.viewComponent:OnShoppingDone()
			existCall(var_6_1.callback)

			return
		end)
	end

	return
end

return var_0_0
