local var_0_0 = class("MetaQuickTacticsMediator", import("...base.ContextMediator"))

var_0_0.USE_TACTICS_BOOK = "MetaQuickTacticsMediator.USE_TACTICS_BOOK"
var_0_0.OPEN_OVERFLOW_LAYER = "MetaQuickTacticsMediator.OPEN_OVERFLOW_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.META_QUICK_TACTICS_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.META_QUICK_TACTICS_DONE then
		arg_3_0.viewComponent:updateAfterUse()
		arg_3_0.viewComponent:resetUseData()
		arg_3_0.viewComponent:updateAfterModifyUseCount()
	end

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
	arg_4_0:bind(var_0_0.OPEN_OVERFLOW_LAYER, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_4_0:addSubLayers(Context.New({
			mediator = MetaQuickTacticsOverflowMediator,
			viewComponent = MetaQuickTacticsOverflowLayer,
			data = {
				shipID = arg_6_1,
				skillID = arg_6_2,
				useCountDict = arg_6_3,
				overExp = arg_6_4
			}
		}))

		return
	end)

	return
end

return var_0_0
