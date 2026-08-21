local var_0_0 = class("CardPuzzleCardDetailMediator", ContextMediator)

var_0_0.DISPLAY_CARD_EFFECT = "DISPLAY_CARD_EFFECT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.DISPLAY_CARD_EFFECT, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
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

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
