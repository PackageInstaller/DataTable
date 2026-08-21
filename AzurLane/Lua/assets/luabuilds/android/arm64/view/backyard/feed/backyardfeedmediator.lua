local var_0_0 = class("BackyardFeedMediator", import("...base.ContextMediator"))

var_0_0.USE_FOOD = "BackyardFeedMediator:USE_FOOD"
var_0_0.BUY_FOOD = "BackyardFeedMediator:BUY_FOOD"
var_0_0.EXTEND = "BackyardFeedMediator:EXTEND"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(SettingsProxy)

	arg_1_0:bind(var_0_0.USE_FOOD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if arg_2_3 then
			var_1_0:setBackyardRemind()
			arg_1_0.viewComponent:SetIsRemind(var_1_0:getBackyardRemind())
		end

		arg_1_0:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.BUY_FOOD, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_3_1,
			count = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.EXTEND, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_4_1,
			count = arg_4_2
		})

		return
	end)
	arg_1_0.viewComponent:SetIsRemind(getProxy(SettingsProxy):getBackyardRemind())

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.ADD_FOOD_DONE,
		DormProxy.DORM_UPDATEED,
		GAME.SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.ADD_FOOD_DONE then
		arg_6_0.viewComponent:OnUsageItem(arg_6_1:getBody().id)
	elseif var_6_0 == DormProxy.DORM_UPDATEED and arg_6_1:getType() == BackYardConst.DORM_UPDATE_TYPE_USEFOOD then
		arg_6_0.viewComponent:OnDormUpdated()
	elseif var_6_0 == GAME.SHOPPING_DONE then
		arg_6_0.viewComponent:OnShopDone()
	end

	return
end

return var_0_0
