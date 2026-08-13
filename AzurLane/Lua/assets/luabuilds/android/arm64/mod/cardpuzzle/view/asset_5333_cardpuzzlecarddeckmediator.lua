class = var_0_10000

local var_0_0 = "CardPuzzleCardDeckMediator"

ContextMediator = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

var_0_1.SHOW_CARD = "SHOW_CARD"
var_0_1.CLOSE_LAYER = "CLOSE_LAYER"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.card
	local var_1_1 = arg_1_0.contextData.hand
	local var_1_2 = arg_1_0.viewComponent

	var_3.SetCards(var_1_2, var_1_0, var_1_1)
	arg_1_0:bind(var_0_1.SHOW_CARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		CardPuzzleCardDetailMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		CardPuzzleCardDetailLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = arg_2_1

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_LAYER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.RESUME_BATTLE)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

function var_0_1.onBackPressed(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.sendNotification

	GAME = var_1_10005

	var_6_1(var_6_0, var_1_10005.RESUME_BATTLE)
	var_0_1.super.onBackPressed(arg_6_0, arg_6_1)

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
