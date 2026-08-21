local var_0_0 = class("GameRoomTowerView", import("..BaseMiniGameView"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomTowerUI"
end

function var_0_0.GetMGData(arg_2_0)
	return getProxy(MiniGameProxy):GetMiniGameData(arg_2_0.contextData.miniGameId):clone()
end

function var_0_0.GetMGHubData(arg_3_0)
	return getProxy(MiniGameProxy):GetHubByGameId(arg_3_0.contextData.miniGameId)
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:Start()

	arg_4_0.backBtn = findTF(arg_4_0._tf, "overview/back")

	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0.controller = TowerClimbingController.New()

	arg_6_0.controller:setGameStateCallback(function()
		arg_6_0:openCoinLayer(false)

		return
	end, function()
		arg_6_0:openCoinLayer(true)

		return
	end)
	arg_6_0.controller:setRoomTip(arg_6_0:getGameRoomData().game_help)
	arg_6_0.controller.view:SetUI(arg_6_0._go)
	arg_6_0.controller:SetCallBack(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_6_0.sendSuccessFlag = true

		arg_6_0:SendSuccess(arg_9_0)

		return
	end, function(arg_10_0, arg_10_1)
		return
	end)
	arg_6_0.controller:SetUp((arg_6_0:PackData()))

	return
end

function var_0_0.updateHighScore(arg_11_0)
	local var_11_0 = getProxy(GameRoomProxy):getRoomScore(arg_11_0:getGameRoomData().id)
	local var_11_1 = {
		var_11_0,
		var_11_0,
		var_11_0
	}

	if not {
		var_11_0,
		var_11_0,
		var_11_0
	} then
		var_11_1 = {}
	end

	if arg_11_0.controller then
		arg_11_0.controller:updateHighScore(var_11_1)
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(MiniGameProxy):GetHubByHubId(arg_12_0.hub_id).count

	var_12_0 = var_12_0 or 0
	arg_12_0.itemNums = var_12_0

	setText(findTF(arg_12_0._tf, "overview/item/num"), arg_12_0.itemNums)
	arg_12_0:updateHighScore()

	return
end

function var_0_0.getGameTimes(arg_13_0)
	return arg_13_0:GetMGHubData().count
end

function var_0_0.GetTowerClimbingPageAndScore(arg_14_0)
	return 0, 1, {
		arg_14_0,
		arg_14_0,
		arg_14_0
	}
end

function var_0_0.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_16_0)
		return arg_16_0[1]
	end))
end

function var_0_0.PackData(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = var_0_0.GetTowerClimbingPageAndScore(getProxy(GameRoomProxy):getRoomScore(arg_17_0:getGameRoomData().id))

	print(var_17_0, "-", var_17_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = arg_17_0._tf.rect.width,
		screenHeight = arg_17_0._tf.rect.height,
		higestscore = var_17_0,
		pageIndex = var_17_1,
		mapScores = var_17_2,
		awards = var_0_0.GetAwardScores()
	}
end

function var_0_0.onBackPressed(arg_18_0)
	if arg_18_0.controller and arg_18_0.controller:onBackPressed() then
		return
	end

	arg_18_0:emit(var_0_0.ON_BACK)

	return
end

function var_0_0.willExit(arg_19_0)
	if arg_19_0.controller then
		arg_19_0.controller:Dispose()
	end

	return
end

return var_0_0
