class = var_0_10000

local var_0_0 = "IslandTowerClimbingGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTowerClimbingUI"
end

function var_0_1.GetMGData(arg_2_0)
	local var_2_0 = arg_2_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_2_1 = var_1_10002(var_1_10004)
	local var_2_2 = var_2.GetMiniGameData(var_2_1, var_2_0)

	return var_2.clone(var_2_2)
end

function var_0_1.GetMGHubData(arg_3_0)
	local var_3_0 = arg_3_0.contextData.miniGameId

	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)

	return var_2.GetHubByGameId(var_3_1, var_3_0)
end

function var_0_1.didEnter(arg_4_0)
	Physics2D = var_1_10001

	if not var_1_10001.autoSimulation then
		Physics2D = var_1
		var_1.autoSimulation = true
		arg_4_0.isChangeAutoSimulation = true
	end

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

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1

	local var_4_3 = arg_4_0

	findTF = var_4_1

	local var_4_4 = var_4_1(arg_4_0._tf, "overview/item")

	local function var_4_5()
		local var_6_0 = {}

		IslandGameLimitMediator = var_2_10001
		var_6_0.mediator = var_2_10001
		IslandGameLimitLayer = var_2_10001
		var_6_0.viewComponent = var_2_10001

		local var_6_1 = {}

		IslandGameLimitLayer = var_2_10002
		var_6_1.type = var_2_10002.limit_type_jiujiu
		var_6_0.data = var_6_1

		local var_6_2 = arg_4_0
		local var_6_3 = var_1.emit

		BaseMiniGameMediator = var_2_10004

		var_6_3(var_6_2, var_2_10004.OPEN_SUB_LAYER, var_6_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_4_3, var_4_4, var_4_5, var_6)

	ActivityConst = var_1

	local var_4_6 = var_1.ISLAND_GAME_ID

	pg = var_1_10002

	local var_4_7 = var_1_10002.activity_template[var_4_6].config_client.item_id

	Item = var_4_3
	arg_4_0.itemConfig = var_4_3.getConfigData(var_4_7)
	LoadImageSpriteAsync = var_3

	local var_4_8 = arg_4_0.itemConfig.icon

	findTF = var_6

	var_3(var_4_8, var_6(arg_4_0._tf, "overview/item/img"), true)

	pg = var_3
	arg_4_0.hub_id = var_3.activity_template[var_4_6].config_id
	getProxy = var_3
	MiniGameProxy = var_4_8

	local var_4_9 = var_3(var_4_8)
	local var_4_10

	if not var_3.GetHubByHubId(var_4_9, arg_4_0.hub_id).count then
		var_4_10 = 0
	end

	arg_4_0.itemNums = var_4_10
	setText = var_4_10
	findTF = var_4_9

	var_4_10(var_4_9(arg_4_0._tf, "overview/item/num"), arg_4_0.itemNums)

	return
end

function var_0_1.Start(arg_7_0)
	TowerClimbingController = var_1_10001
	arg_7_0.controller = var_1_10001.New()

	local var_7_0 = arg_7_0.controller.view

	var_1.SetUI(var_7_0, arg_7_0._go)

	local function var_7_1(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_7_0
		local var_8_1 = var_4.GetMGData(var_8_0)
		local var_8_2

		if not var_4.GetRuntimeData(var_8_1, "elements") then
			var_8_2 = {}
		end

		for iter_8_0 = 1, arg_8_3 do
			if #var_8_2 < iter_8_0 then
				table = var_9

				var_9.insert(var_8_2, 0)
			end
		end

		if arg_8_0 >= var_8_2[arg_8_3] then
			var_8_2[arg_8_3] = arg_8_0

			local var_8_3 = arg_7_0

			var_5.StoreDataToServer(var_8_3, var_8_2)

			local var_8_4 = arg_7_0

			var_5.updateHighScore(var_8_4)
		end

		local var_8_5 = arg_7_0

		if var_5.getGameTimes(var_8_5) then
			local var_8_6 = arg_7_0

			if var_5.getGameTimes(var_8_6) > 0 then
				arg_7_0.sendSuccessFlag = true

				local var_8_7 = arg_7_0

				var_5.SendSuccess(var_8_7, 0)
			end
		end

		return
	end

	local function var_7_2(arg_9_0, arg_9_1)
		return
	end

	local var_7_3 = arg_7_0.controller

	var_3.SetCallBack(var_7_3, var_7_1, var_7_2)

	local var_7_4 = arg_7_0:PackData()
	local var_7_5 = arg_7_0.controller

	var_4.SetUp(var_7_5, var_7_4)

	return
end

function var_0_1.updateHighScore(arg_10_0)
	local var_10_0 = arg_10_0:GetMGData()
	local var_10_1

	if not var_1.GetRuntimeData(var_10_0, "elements") then
		var_10_1 = {}
	end

	if arg_10_0.controller then
		-- block empty
	end

	local var_10_2 = arg_10_0.controller

	var_2.updateHighScore(var_10_2, var_10_1)

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	MiniGameProxy = var_1_10004

	local var_11_0 = var_1_10002(var_1_10004)
	local var_11_1

	if not var_2.GetHubByHubId(var_11_0, arg_11_0.hub_id).count then
		var_11_1 = 0
	end

	arg_11_0.itemNums = var_11_1
	setText = var_11_1
	findTF = var_11_0

	var_11_1(var_11_0(arg_11_0._tf, "overview/item/num"), arg_11_0.itemNums)
	arg_11_0:updateHighScore()

	return
end

function var_0_1.getGameTimes(arg_12_0)
	return arg_12_0:GetMGHubData().count
end

function var_0_1.GetTowerClimbingPageAndScore(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 1
	local var_13_2 = {
		0,
		0,
		0
	}

	return var_13_0, var_13_1, var_13_2
end

function var_0_1.GetAwardScores()
	pg = var_1_10000

	local var_14_0 = var_1_10000.mini_game

	MiniGameDataCreator = var_1_10001

	local var_14_1 = var_14_0[var_1_10001.TowerClimbingGameID].simple_config_data

	_ = var_1

	return (var_1.map(var_14_1, function(arg_15_0)
		return arg_15_0[1]
	end))
end

function var_0_1.PackData(arg_16_0)
	local var_16_0 = arg_16_0._tf.rect.width
	local var_16_1 = arg_16_0._tf.rect.height
	local var_16_2 = arg_16_0:GetMGData()
	local var_16_3 = var_3.GetRuntimeData(var_16_2, "elements")
	local var_16_4, var_16_5, var_16_6 = var_0_1.GetTowerClimbingPageAndScore(var_16_3)

	print = var_1_10007

	var_1_10007(var_16_4, "-", var_16_5)

	local var_16_7 = var_0_1.GetAwardScores()

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = var_16_0,
		screenHeight = var_16_1,
		higestscore = var_16_4,
		pageIndex = var_16_5,
		mapScores = var_16_6,
		awards = var_16_7
	}
end

function var_0_1.onBackPressed(arg_17_0)
	if arg_17_0.controller then
		local var_17_0 = arg_17_0.controller

		if var_1.onBackPressed(var_17_0) then
			return
		end
	end

	arg_17_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_18_0)
	if arg_18_0.controller then
		local var_18_0 = arg_18_0.controller

		var_1.Dispose(var_18_0)
	end

	if arg_18_0.isChangeAutoSimulation then
		Physics2D = var_1
		var_1.autoSimulation = false
		arg_18_0.isChangeAutoSimulation = nil
	end

	return
end

return var_0_1
