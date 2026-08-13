class = var_0_10000

local var_0_0 = "RacingMiniGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.miniGame.MiniGameTemplateView"))

var_0_1.canSelectStage = false

function var_0_1.getUIName(arg_1_0)
	return "RacingMiniGameUI"
end

function var_0_1.getGameController(arg_2_0)
	RacingMiniGameController = var_1_10001

	return var_1_10001
end

function var_0_1.getShowSide(arg_3_0)
	return false
end

function var_0_1.initPageUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.rtTitlePage = var_1.Find(var_4_0, "TitlePage")

	local var_4_1 = arg_4_0.rtTitlePage
	local var_4_2 = var_1.Find(var_4_1, "countdown")
	local var_4_3 = var_1.Find(var_4_2, "bg")
	local var_4_4 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10005

	local var_4_5 = var_4_4(var_4_3, var_4(var_1_10005))

	var_2.SetEndEvent(var_4_5, function()
		local var_5_0 = arg_4_0

		var_0.openUI(var_5_0)

		local var_5_1 = arg_4_0.gameController

		var_0.StartGame(var_5_1)

		pg = var_0

		local var_5_2 = var_0.BgmMgr.GetInstance()

		var_0.ContinuePlay(var_5_2)

		return
	end)

	local var_4_6 = arg_4_0.rtTitlePage
	local var_4_7 = var_2.Find(var_4_6, "pause")

	onButton = var_4_6

	local var_4_8 = arg_4_0
	local var_4_9 = var_4_7:Find("window/btn_confirm")

	local function var_4_10()
		local var_6_0 = arg_4_0

		var_0.openUI(var_6_0)

		local var_6_1 = arg_4_0.gameController

		var_0.ResumeGame(var_6_1)

		return
	end

	SFX_CONFIRM = var_7

	var_4_6(var_4_8, var_4_9, var_4_10, var_7)

	local var_4_11 = arg_4_0.rtTitlePage
	local var_4_12 = var_3.Find(var_4_11, "exit")

	onButton = var_4_11

	local var_4_13 = arg_4_0
	local var_4_14 = var_4_12:Find("window/btn_cancel")

	local function var_4_15()
		local var_7_0 = arg_4_0

		var_0.openUI(var_7_0)

		local var_7_1 = arg_4_0.gameController

		var_0.ResumeGame(var_7_1)

		return
	end

	SFX_CANCEL = var_8

	var_4_11(var_4_13, var_4_14, var_4_15, var_8)

	onButton = var_4_11

	local var_4_16 = arg_4_0
	local var_4_17 = var_4_12:Find("window/btn_confirm")

	local function var_4_18()
		local var_8_0 = arg_4_0

		var_0.openUI(var_8_0)

		local var_8_1 = arg_4_0.gameController

		var_0.EndGame(var_8_1)

		return
	end

	SFX_CONFIRM = var_8

	var_4_11(var_4_16, var_4_17, var_4_18, var_8)

	local var_4_19 = arg_4_0.rtTitlePage
	local var_4_20 = var_4.Find(var_4_19, "result")

	onButton = var_4_19

	local var_4_21 = arg_4_0
	local var_4_22 = var_4_20:Find("window/btn_finish")

	local function var_4_23()
		local var_9_0 = arg_4_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CONFIRM = var_9

	var_4_19(var_4_21, var_4_22, var_4_23, var_9)

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:initPageUI()
	arg_10_0:initControllerUI()

	arg_10_0.gameController = arg_10_0:getGameController().New(arg_10_0, arg_10_0._tf)

	local var_10_0 = arg_10_0.gameController

	var_1.ResetGame(var_10_0)

	local var_10_1 = arg_10_0.gameController
	local var_10_2 = var_1.ReadyGame

	getProxy = var_3
	MiniGameProxy = var_1_10004

	local var_10_3 = var_3(var_1_10004)

	var_10_2(var_10_1, var_3.GetRank(var_10_3, arg_10_0:GetMGData().id))

	pg = var_10_2

	local var_10_4 = var_10_2.BgmMgr.GetInstance()

	var_1.StopPlay(var_10_4)
	arg_10_0:openUI("countdown")

	return
end

function var_0_1.initOpenUISwich(arg_11_0)
	var_0_1.super.initOpenUISwich(arg_11_0)

	arg_11_0.openSwitchDic.main = nil

	function arg_11_0.openSwitchDic.result()
		pg = var_2_10000

		local var_12_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_12_0, "ui-streamers")

		local var_12_1 = arg_11_0
		local var_12_2 = var_0.GetMGData(var_12_1).id
		local var_12_3 = arg_11_0.gameController.point

		getProxy = var_2
		MiniGameProxy = var_2_10003

		local var_12_4 = var_2(var_2_10003)
		local var_12_5 = var_2.GetHighScore(var_12_4, var_12_2) / 100
		local var_12_6 = arg_11_0.rtTitlePage
		local var_12_7 = var_3.Find(var_12_6, "result")

		setActive = var_12_6

		var_12_6(var_12_7:Find("window/now/new"), var_12_5 < var_12_3)

		if var_12_5 <= var_12_3 then
			var_12_5 = var_12_3
			getProxy = var_12_6
			MiniGameProxy = var_5

			local var_12_8 = var_12_6(var_5)

			var_12_6 = var_12_6.UpdataHighScore

			local var_12_9 = var_12_2

			math = var_7

			var_12_6(var_12_8, var_12_9, var_7.floor(var_12_3 * 100))
		end

		setText = var_12_6

		local var_12_10 = var_12_7
		local var_12_11 = var_12_7.Find(var_12_10, "window/high/Text")

		string = var_12_10

		var_12_6(var_12_11, var_12_10.format("%.2fm", var_12_5))

		setText = var_12_6

		local var_12_12 = var_12_7
		local var_12_13 = var_12_7.Find(var_12_12, "window/now/Text")

		string = var_12_12

		var_12_6(var_12_13, var_12_12.format("%.2fm", var_12_3))

		local var_12_14 = arg_11_0
		local var_12_15 = var_4.GetMGHubData(var_12_14)
		local var_12_16 = arg_11_0
		local var_12_17 = var_5.emit

		BaseMiniGameMediator = var_7

		var_12_17(var_12_16, var_7.GAME_FINISH_TRACKING, {
			game_id = var_12_2,
			hub_id = var_12_15.id,
			isComplete = arg_11_0.gameController.result
		})

		local var_12_18 = arg_11_0

		if (not var_5.getShowSide(var_12_18) or arg_11_0.stageIndex == var_12_15.usedtime + 1) and var_12_15.count > 0 then
			local var_12_19 = arg_11_0

			var_5.SendSuccess(var_12_19, 0)
		end

		return
	end

	function arg_11_0.openSwitchDic.countdown()
		pg = var_2_10000

		local var_13_0 = var_2_10000.CriMgr.GetInstance()
		local var_13_1 = var_0.PlaySoundEffect_V3

		SFX_STEP_PILE_COUNTDOWN = var_2_10002

		var_13_1(var_13_0, var_2_10002)

		return
	end

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.gameController

	var_1.willExit(var_14_0)

	return
end

return var_0_1
