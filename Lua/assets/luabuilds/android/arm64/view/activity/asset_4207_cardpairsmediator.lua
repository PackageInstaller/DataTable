local CardPairsMediator = class("CardPairsMediator", import("..base.ContextMediator"))

CardPairsMediator.EVENT_OPERATION = "event operation"

function CardPairsMediator:register()
	self:bind(CardPairsMediator.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	self:setActivityData()
	self:setPlayerData()

	return
end

function CardPairsMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function CardPairsMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:setActivityData(var_4_1)
	elseif var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerData(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	elseif var_4_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:checkActivityEnd()
	end

	return
end

function CardPairsMediator:setPlayerData()
	self.viewComponent:setPlayerData((getProxy(PlayerProxy):getData()))

	return
end

function CardPairsMediator:setActivityData()
	self.viewComponent:setActivityData((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CARD_PAIRS)))

	return
end

return CardPairsMediator
