class = var_0_10000

local var_0_0 = "OreMiniGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.MiniGameTemplateView"))

function var_0_1.getUIName(arg_1_0)
	return "OreMiniGameUI"
end

function var_0_1.getGameController(arg_2_0)
	OreMiniGameController = var_1_10001

	return var_1_10001
end

function var_0_1.getShowSide(arg_3_0)
	return false
end

function var_0_1.initPageUI(arg_4_0)
	var_0_1.super.initPageUI(arg_4_0)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.rtTitlePage
	local var_4_2 = var_3.Find(var_4_1, "main/btn_help")

	local function var_4_3()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.ore_minigame_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.rtTitlePage
	local var_4_6 = var_3.Find(var_4_5, "result/window/btn_finish")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.openUI(var_6_0, "main")

		local var_6_1 = arg_4_0.gameController

		var_0.ResetGame(var_6_1)

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_4_4, var_4_6, var_4_7, var_5)

	local var_4_8 = arg_4_0.rtTitlePage
	local var_4_9 = var_1.Find(var_4_8, "main/res_bar")

	pg = var_4_8

	local var_4_10 = var_4_8.activity_template

	ActivityConst = var_3

	local var_4_11 = var_4_10[var_3.ISLAND_GAME_ID].config_client.item_id

	LoadImageSpriteAsync = var_3
	Item = var_4_7

	var_3(var_4_7.getConfigData(var_4_11).icon, var_4_9:Find("icon"), true)

	setText = var_3

	var_3(var_4_9:Find("num"), arg_4_0:GetMGHubData().count)

	onButton = var_3

	local var_4_12 = arg_4_0
	local var_4_13 = var_4_9

	local function var_4_14()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		BaseMiniGameMediator = var_2_10002

		local var_7_2 = var_2_10002.OPEN_SUB_LAYER
		local var_7_3 = {}

		IslandGameLimitMediator = var_2_10004
		var_7_3.mediator = var_2_10004
		IslandGameLimitLayer = var_2_10004
		var_7_3.viewComponent = var_2_10004

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_4_12, var_4_13, var_4_14, var_7)

	return
end

function var_0_1.updateMainUI(arg_8_0)
	var_0_1.super.updateMainUI(arg_8_0)

	local var_8_0 = arg_8_0.rtTitlePage
	local var_8_1 = var_1.Find(var_8_0, "main/res_bar")

	pg = var_8_0

	local var_8_2 = var_8_0.activity_template

	ActivityConst = var_3

	local var_8_3 = var_8_2[var_3.ISLAND_GAME_ID].config_client.item_id

	setText = var_3

	var_3(var_8_1:Find("num"), arg_8_0:GetMGHubData().count)

	return
end

function var_0_1.willExit(arg_9_0)
	local var_9_0 = arg_9_0.gameController

	var_1.willExit(var_9_0)

	return
end

return var_0_1
