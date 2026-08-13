class = var_0_10000

local var_0_0 = "GameRoomTowerView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomTowerUI"
end

function var_0_1.GetMGData(arg_2_0)
	local var_2_0 = arg_2_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10003

	local var_2_1 = var_1_10002(var_1_10003)
	local var_2_2 = var_2.GetMiniGameData(var_2_1, var_2_0)

	return var_2.clone(var_2_2)
end

function var_0_1.GetMGHubData(arg_3_0)
	local var_3_0 = arg_3_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10003

	local var_3_1 = var_1_10002(var_1_10003)

	return var_2.GetHubByGameId(var_3_1, var_3_0)
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:Start()

	findTF = var_1
	arg_4_0.backBtn = var_1(arg_4_0._tf, "overview/back")
	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.backBtn

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_0, var_4_1, var_4_2, var_1_10005)

	return
end

function var_0_1.Start(arg_6_0)
	TowerClimbingController = var_1_10001
	arg_6_0.controller = var_1_10001.New()

	local var_6_0 = arg_6_0.controller

	var_1.setGameStateCallback(var_6_0, function()
		local var_7_0 = arg_6_0

		var_0.openCoinLayer(var_7_0, false)

		return
	end, function()
		local var_8_0 = arg_6_0

		var_0.openCoinLayer(var_8_0, true)

		return
	end)

	local var_6_1 = arg_6_0.controller

	var_1.setRoomTip(var_6_1, arg_6_0:getGameRoomData().game_help)

	local var_6_2 = arg_6_0.controller.view

	var_1.SetUI(var_6_2, arg_6_0._go)

	local function var_6_3(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		arg_6_0.sendSuccessFlag = true

		local var_9_0 = arg_6_0

		var_4.SendSuccess(var_9_0, arg_9_0)

		return
	end

	local function var_6_4(arg_10_0, arg_10_1)
		return
	end

	local var_6_5 = arg_6_0.controller

	var_3.SetCallBack(var_6_5, var_6_3, var_6_4)

	local var_6_6 = arg_6_0:PackData()
	local var_6_7 = arg_6_0.controller

	var_4.SetUp(var_6_7, var_6_6)

	return
end

function var_0_1.updateHighScore(arg_11_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.getRoomScore(var_11_0, arg_11_0:getGameRoomData().id)
	local var_11_2

	if not {
		var_11_1,
		var_11_1,
		var_11_1
	} then
		var_11_2 = {}
	end

	if arg_11_0.controller then
		local var_11_3 = arg_11_0.controller

		var_3.updateHighScore(var_11_3, var_11_2)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	MiniGameProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1

	if not var_2.GetHubByHubId(var_12_0, arg_12_0.hub_id).count then
		var_12_1 = 0
	end

	arg_12_0.itemNums = var_12_1
	setText = var_12_1
	findTF = var_12_0

	var_12_1(var_12_0(arg_12_0._tf, "overview/item/num"), arg_12_0.itemNums)
	arg_12_0:updateHighScore()

	return
end

function var_0_1.getGameTimes(arg_13_0)
	return arg_13_0:GetMGHubData().count
end

function var_0_1.GetTowerClimbingPageAndScore(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 1
	local var_14_2 = {
		arg_14_0,
		arg_14_0,
		arg_14_0
	}

	return var_14_0, var_14_1, var_14_2
end

function var_0_1.GetAwardScores()
	pg = var_1_10000

	local var_15_0 = var_1_10000.mini_game

	MiniGameDataCreator = var_1_10001

	local var_15_1 = var_15_0[var_1_10001.TowerClimbingGameID].simple_config_data

	_ = var_1

	return (var_1.map(var_15_1, function(arg_16_0)
		return arg_16_0[1]
	end))
end

function var_0_1.PackData(arg_17_0)
	local var_17_0 = arg_17_0._tf.rect.width
	local var_17_1 = arg_17_0._tf.rect.height
	local var_17_2 = var_0_1.GetTowerClimbingPageAndScore

	getProxy = var_1_10004
	GameRoomProxy = var_1_10005

	local var_17_3 = var_1_10004(var_1_10005)
	local var_17_4, var_17_5, var_17_6 = var_17_2(var_4.getRoomScore(var_17_3, arg_17_0:getGameRoomData().id))

	print = var_6

	var_6(var_17_4, "-", var_17_5)

	local var_17_7 = var_0_1.GetAwardScores()

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = var_17_0,
		screenHeight = var_17_1,
		higestscore = var_17_4,
		pageIndex = var_17_5,
		mapScores = var_17_6,
		awards = var_17_7
	}
end

function var_0_1.onBackPressed(arg_18_0)
	if arg_18_0.controller then
		local var_18_0 = arg_18_0.controller

		if var_1.onBackPressed(var_18_0) then
			return
		end
	end

	arg_18_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_19_0)
	if arg_19_0.controller then
		local var_19_0 = arg_19_0.controller

		var_1.Dispose(var_19_0)
	end

	return
end

return var_0_1
