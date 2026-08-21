local var_0_0 = class("GameRoomPileGameView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomPileGameUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("overview/back")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)

	arg_3_0.controller = PileGameController.New()

	arg_3_0.controller.view:SetUI(arg_3_0._go)
	arg_3_0.controller:SetUp(arg_3_0:PackData(), function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0:GetMGHubData()

		arg_3_0:SendSuccess(arg_5_0)

		return
	end)
	arg_3_0.controller:setGameStartCallback(function(arg_6_0)
		arg_3_0:openCoinLayer(arg_6_0)

		return
	end)

	return
end

function var_0_0.PackData(arg_7_0)
	if arg_7_0:getGameRoomData() then
		arg_7_0.gameHelpTip = arg_7_0:getGameRoomData().game_help
	end

	return {
		highestScore = getProxy(GameRoomProxy):getRoomScore(arg_7_0:getGameRoomData().id),
		screen = Vector2(arg_7_0._tf.rect.width, arg_7_0._tf.rect.height),
		tip = arg_7_0.gameHelpTip
	}
end

function var_0_0.OnGetAwardDone(arg_8_0, arg_8_1)
	return
end

function var_0_0.onBackPressed(arg_9_0)
	if arg_9_0.controller:onBackPressed() then
		return
	end

	arg_9_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_10_0)
	arg_10_0.controller:Dispose()

	return
end

return var_0_0
