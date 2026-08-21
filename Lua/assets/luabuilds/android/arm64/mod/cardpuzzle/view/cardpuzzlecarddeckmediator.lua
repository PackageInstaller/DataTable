local var_0_0 = class("CardPuzzleCardDeckMediator", ContextMediator)

var_0_0.SHOW_CARD = "SHOW_CARD"
var_0_0.CLOSE_LAYER = "CLOSE_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:SetCards(arg_1_0.contextData.card, arg_1_0.contextData.hand)
	arg_1_0:bind(var_0_0.SHOW_CARD, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CardPuzzleCardDetailMediator,
			viewComponent = CardPuzzleCardDetailLayer,
			data = arg_2_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.CLOSE_LAYER, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.RESUME_BATTLE)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

function var_0_0.onBackPressed(arg_6_0, arg_6_1)
	arg_6_0:sendNotification(GAME.RESUME_BATTLE)
	var_0_0.super.onBackPressed(arg_6_0, arg_6_1)

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
