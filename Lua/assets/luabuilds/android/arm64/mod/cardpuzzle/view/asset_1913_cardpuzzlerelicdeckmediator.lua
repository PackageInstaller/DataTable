local CardPuzzleRelicDeckMediator = class("CardPuzzleRelicDeckMediator", ContextMediator)

CardPuzzleRelicDeckMediator.SHOW_GIFT = "SHOW_GIFT"
CardPuzzleRelicDeckMediator.CLOSE_LAYER = "CLOSE_LAYER"

function CardPuzzleRelicDeckMediator:register()
	self.viewComponent:SetGifts(self.contextData.relicList)
	self:bind(CardPuzzleRelicDeckMediator.SHOW_GIFT, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = CardPuzzleRelicDetailMediator,
			viewComponent = CardPuzzleRelicDetailLayer,
			data = arg_2_1
		}))

		return
	end)
	self:bind(CardPuzzleRelicDeckMediator.CLOSE_LAYER, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.RESUME_BATTLE)

		return
	end)

	return
end

function CardPuzzleRelicDeckMediator:listNotificationInterests()
	return {}
end

function CardPuzzleRelicDeckMediator:remove()
	return
end

return CardPuzzleRelicDeckMediator
