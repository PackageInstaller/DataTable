local CardPuzzleCardDetailMediator = class("CardPuzzleCardDetailMediator", ContextMediator)

CardPuzzleCardDetailMediator.DISPLAY_CARD_EFFECT = "DISPLAY_CARD_EFFECT"

function CardPuzzleCardDetailMediator:register()
	self:bind(CardPuzzleCardDetailMediator.DISPLAY_CARD_EFFECT, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = CardTowerCardEffectPreviewMediator,
			viewComponent = CardTowerCardEffectPreviewWindow,
			data = {
				card = arg_2_1
			}
		}))

		return
	end)

	return
end

function CardPuzzleCardDetailMediator:listNotificationInterests()
	return {}
end

function CardPuzzleCardDetailMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return CardPuzzleCardDetailMediator
