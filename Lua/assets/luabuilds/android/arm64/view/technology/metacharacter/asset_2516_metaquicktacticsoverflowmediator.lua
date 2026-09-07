local MetaQuickTacticsOverflowMediator = class("MetaQuickTacticsOverflowMediator", import("...base.ContextMediator"))

MetaQuickTacticsOverflowMediator.USE_TACTICS_BOOK = "MetaQuickTacticsOverflowMediator.USE_TACTICS_BOOK"

function MetaQuickTacticsOverflowMediator:register()
	self:bindEvent()

	return
end

function MetaQuickTacticsOverflowMediator:listNotificationInterests()
	return {}
end

function MetaQuickTacticsOverflowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

function MetaQuickTacticsOverflowMediator:bindEvent()
	self:bind(MetaQuickTacticsOverflowMediator.USE_TACTICS_BOOK, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.META_QUICK_TACTICS, {
			shipID = arg_5_1,
			skillID = arg_5_2,
			useCountDict = arg_5_3
		})

		return
	end)

	return
end

return MetaQuickTacticsOverflowMediator
