class = var_0_10000

local var_0_0 = "CardPuzzleCardDetailMediator"

ContextMediator = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

var_0_1.DISPLAY_CARD_EFFECT = "DISPLAY_CARD_EFFECT"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.DISPLAY_CARD_EFFECT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		CardTowerCardEffectPreviewMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		CardTowerCardEffectPreviewWindow = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			card = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
