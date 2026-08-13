class = var_0_10000

local var_0_0 = "GameRoomOreView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.miniGame.MiniGameTemplateView"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomOreUI"
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
	local var_4_2 = var_4.Find(var_4_1, "main/btn_help")

	local function var_4_3()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.ore_minigame_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_4_1

	var_1(var_4_0, var_4_2, var_4_3, var_4_1)

	onButton = var_1

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.rtTitlePage
	local var_4_6 = var_4.Find(var_4_5, "result/window/btn_finish")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.openUI(var_6_0, "main")

		local var_6_1 = arg_4_0.gameController

		var_0.ResetGame(var_6_1)

		return
	end

	SFX_CONFIRM = var_4_5

	var_1(var_4_4, var_4_6, var_4_7, var_4_5)

	return
end

function var_0_1.initOpenUISwich(arg_7_0)
	arg_7_0.openSwitchDic = {
		main = function()
			local var_8_0 = arg_7_0

			var_0.updateMainUI(var_8_0)

			return
		end,
		pause = function()
			local var_9_0 = arg_7_0.gameController

			var_0.PauseGame(var_9_0)

			return
		end,
		exit = function()
			local var_10_0 = arg_7_0.gameController

			var_0.PauseGame(var_10_0)

			return
		end,
		result = function()
			local var_11_0 = arg_7_0
			local var_11_1 = var_0.GetMGData(var_11_0)
			local var_11_2

			if not var_0.GetRuntimeData(var_11_1, "elements") then
				var_11_2 = {}
			end

			local var_11_3 = arg_7_0.gameController.point

			getProxy = var_11_1
			GameRoomProxy = var_2_10004

			local var_11_4 = var_11_1(var_2_10004)
			local var_11_5 = var_2.getRoomScore
			local var_11_6 = arg_7_0
			local var_11_7 = var_11_5(var_11_4, var_5.getGameRoomData(var_11_6).id)
			local var_11_8 = arg_7_0.rtTitlePage
			local var_11_9 = var_3.Find(var_11_8, "result")

			setActive = var_11_4

			var_11_4(var_11_9:Find("window/now/new"), var_11_7 < var_11_3)

			if var_11_7 <= var_11_3 then
				var_11_7 = var_11_3
				var_11_2[1] = var_11_3
			end

			local var_11_10 = arg_7_0

			var_4.StoreDataToServer(var_11_10, {
				var_11_7
			})

			setText = var_4

			var_4(var_11_9:Find("window/high/Text"), var_11_7)

			setText = var_4

			var_4(var_11_9:Find("window/now/Text"), var_11_3)

			local var_11_11 = arg_7_0
			local var_11_12 = var_4.GetMGHubData(var_11_11)
			local var_11_13 = arg_7_0

			var_5.SendSuccess(var_11_13, var_11_3)

			return
		end
	}

	return
end

function var_0_1.openUI(arg_12_0, arg_12_1)
	if not arg_12_0.openSwitchDic then
		arg_12_0:initOpenUISwich()
	end

	if arg_12_0.status then
		setActive = var_2

		local var_12_0 = arg_12_0.rtTitlePage

		var_2(var_4.Find(var_12_0, arg_12_0.status), false)
	end

	if arg_12_1 == "main" then
		arg_12_0:openCoinLayer(true)
	else
		arg_12_0:openCoinLayer(false)
	end

	if arg_12_1 then
		setActive = var_2

		local var_12_1 = arg_12_0.rtTitlePage

		var_2(var_4.Find(var_12_1, arg_12_1), true)
	end

	arg_12_0.status = arg_12_1
	switch = var_2

	var_2(arg_12_1, arg_12_0.openSwitchDic)

	return
end

function var_0_1.updateMainUI(arg_13_0)
	var_0_1.super.updateMainUI(arg_13_0)

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.gameController

	var_1.willExit(var_14_0)

	return
end

return var_0_1
