local var_0_0 = class("CardPuzzleRelicDeckMediator", ContextMediator)

var_0_0.SHOW_GIFT = "SHOW_GIFT"
var_0_0.CLOSE_LAYER = "CLOSE_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:SetGifts(arg_1_0.contextData.relicList)
	arg_1_0:bind(var_0_0.SHOW_GIFT, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CardPuzzleRelicDetailMediator,
			viewComponent = CardPuzzleRelicDetailLayer,
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

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
