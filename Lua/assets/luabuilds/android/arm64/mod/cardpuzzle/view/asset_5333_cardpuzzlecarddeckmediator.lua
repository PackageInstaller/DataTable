local CardPuzzleCardDeckMediator = class("CardPuzzleCardDeckMediator", ContextMediator)

CardPuzzleCardDeckMediator.SHOW_CARD = "SHOW_CARD"
CardPuzzleCardDeckMediator.CLOSE_LAYER = "CLOSE_LAYER"

function CardPuzzleCardDeckMediator:register()
	self.viewComponent:SetCards(self.contextData.card, self.contextData.hand)
	self:bind(CardPuzzleCardDeckMediator.SHOW_CARD, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = CardPuzzleCardDetailMediator,
			viewComponent = CardPuzzleCardDetailLayer,
			data = arg_2_1
		}))

		return
	end)
	self:bind(CardPuzzleCardDeckMediator.CLOSE_LAYER, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.RESUME_BATTLE)

		return
	end)

	return
end

function CardPuzzleCardDeckMediator:listNotificationInterests()
	return {}
end

function CardPuzzleCardDeckMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

function CardPuzzleCardDeckMediator:onBackPressed(arg_6_1)
	self:sendNotification(GAME.RESUME_BATTLE)
	CardPuzzleCardDeckMediator.super.onBackPressed(self, arg_6_1)

	return
end

function CardPuzzleCardDeckMediator:remove()
	return
end

return CardPuzzleCardDeckMediator
