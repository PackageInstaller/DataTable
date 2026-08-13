class = var_0_10000

local var_0_0 = "GameRoomPileGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomPileGameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "overview/back")

	return
end

local var_0_2 = 7

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	PileGameController = var_1_10001
	arg_3_0.controller = var_1_10001.New()

	local var_3_3 = arg_3_0.controller.view

	var_1.SetUI(var_3_3, arg_3_0._go)

	local var_3_4 = arg_3_0:PackData()
	local var_3_5 = arg_3_0.controller

	var_2.SetUp(var_3_5, var_3_4, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.GetMGHubData(var_5_0)
		local var_5_2 = arg_3_0

		var_3.SendSuccess(var_5_2, arg_5_0)

		return
	end)

	local var_3_6 = arg_3_0.controller

	var_2.setGameStartCallback(var_3_6, function(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.openCoinLayer(var_6_0, arg_6_0)

		return
	end)

	return
end

function var_0_1.PackData(arg_7_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getRoomScore(var_7_0, arg_7_0:getGameRoomData().id)

	if arg_7_0:getGameRoomData() then
		arg_7_0.gameHelpTip = arg_7_0:getGameRoomData().game_help
	end

	local var_7_2 = {
		highestScore = var_7_1
	}

	Vector2 = var_7_0
	var_7_2.screen = var_7_0(arg_7_0._tf.rect.width, arg_7_0._tf.rect.height)
	var_7_2.tip = arg_7_0.gameHelpTip

	return var_7_2
end

function var_0_1.OnGetAwardDone(arg_8_0, arg_8_1)
	return
end

function var_0_1.onBackPressed(arg_9_0)
	local var_9_0 = arg_9_0.controller

	if var_1.onBackPressed(var_9_0) then
		return
	end

	arg_9_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_10_0)
	local var_10_0 = arg_10_0.controller

	var_1.Dispose(var_10_0)

	return
end

return var_0_1
