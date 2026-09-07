local CardPuzzleRelicDetailMediator = class("CardPuzzleRelicDetailMediator", ContextMediator)

function CardPuzzleRelicDetailMediator:register()
	return
end

function CardPuzzleRelicDetailMediator:listNotificationInterests()
	return {}
end

function CardPuzzleRelicDetailMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return CardPuzzleRelicDetailMediator
