class = var_0_10000

local var_0_0 = "CardPuzzleRelicDeckMediator"

ContextMediator = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

var_0_1.SHOW_GIFT = "SHOW_GIFT"
var_0_1.CLOSE_LAYER = "CLOSE_LAYER"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.relicList
	local var_1_1 = arg_1_0.viewComponent

	var_2.SetGifts(var_1_1, var_1_0)
	arg_1_0:bind(var_0_1.SHOW_GIFT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		CardPuzzleRelicDetailMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		CardPuzzleRelicDetailLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = arg_2_1

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_LAYER, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.RESUME_BATTLE)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
