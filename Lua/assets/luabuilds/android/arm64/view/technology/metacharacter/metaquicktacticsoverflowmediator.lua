local var_0_0 = class("MetaQuickTacticsOverflowMediator", import("...base.ContextMediator"))

var_0_0.USE_TACTICS_BOOK = "MetaQuickTacticsOverflowMediator.USE_TACTICS_BOOK"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

function var_0_0.bindEvent(arg_4_0)
	arg_4_0:bind(var_0_0.USE_TACTICS_BOOK, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_4_0:sendNotification(GAME.META_QUICK_TACTICS, {
			shipID = arg_5_1,
			skillID = arg_5_2,
			useCountDict = arg_5_3
		})

		return
	end)

	return
end

return var_0_0
