class = var_0_10000

local var_0_0 = "CastleGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

var_0_1.LEVEL_GAME = "leavel game"
var_0_1.PAUSE_GAME = "pause game "
var_0_1.OPEN_PAUSE_UI = "open pause ui"
var_0_1.OPEN_LEVEL_UI = "open leave ui"
var_0_1.BACK_MENU = "back menu"
var_0_1.CLOSE_GAME = "close game"
var_0_1.SHOW_RULE = "show rule"
var_0_1.READY_START = "ready start"
var_0_1.COUNT_DOWN = "count down"
var_0_1.STORE_SERVER = "store server"
var_0_1.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_1.ADD_SCORE = "add score"
var_0_1.GAME_OVER = "game over"

function var_0_1.getUIName(arg_1_0)
	CastleGameVo = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initEvent()
	arg_2_0:initUI()
	arg_2_0:initController()

	return
end

function var_0_1.initData(arg_3_0)
	CastleGameVo = var_1_10001

	var_1_10001.Init(arg_3_0:GetMGData().id, arg_3_0:GetMGHubData().id)

	CastleGameVo = var_1

	local var_3_0 = var_1.frameRate

	if 60 < var_3_0 then
		var_3_0 = 60
	end

	Timer = var_2
	arg_3_0.timer = var_2.New(function()
		local var_4_0 = arg_3_0

		var_0.onTimer(var_4_0)

		return
	end, 1 / var_3_0, -1)

	return
end

function var_0_1.initEvent(arg_5_0)
	if not arg_5_0.handle then
		IsUnityEditor = var_1

		if var_1 then
			UpdateBeat = var_1
			arg_5_0.handle = var_1:CreateListener(arg_5_0.Update, arg_5_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_5_0.handle)
		end
	end

	arg_5_0:bind(var_0_1.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			local var_6_0 = arg_5_0

			var_3.resumeGame(var_6_0)

			local var_6_1 = arg_5_0

			var_3.onGameOver(var_6_1)
		else
			local var_6_2 = arg_5_0

			var_3.resumeGame(var_6_2)
		end

		return
	end)
	arg_5_0:bind(var_0_1.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_5_0

		var_3.gameStart(var_7_0)

		return
	end)
	arg_5_0:bind(var_0_1.OPEN_PAUSE_UI, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0.popUI

		var_3.popPauseUI(var_8_0)

		return
	end)
	arg_5_0:bind(var_0_1.OPEN_LEVEL_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_5_0.popUI

		var_3.popLeaveUI(var_9_0)

		return
	end)
	arg_5_0:bind(var_0_1.PAUSE_GAME, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 then
			local var_10_0 = arg_5_0

			var_3.pauseGame(var_10_0)
		else
			local var_10_1 = arg_5_0

			var_3.resumeGame(var_10_1)
		end

		return
	end)
	arg_5_0:bind(var_0_1.BACK_MENU, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_5_0.menuUI
		local var_11_1 = var_3.update
		local var_11_2 = arg_5_0

		var_11_1(var_11_0, var_5.GetMGHubData(var_11_2))

		local var_11_3 = arg_5_0.menuUI

		var_3.show(var_11_3, true)

		local var_11_4 = arg_5_0.gameUI

		var_3.show(var_11_4, false)

		local var_11_5 = arg_5_0.gameScene

		var_3.showContainer(var_11_5, false)

		local var_11_6 = arg_5_0
		local var_11_8

		if not var_3.getBGM(var_11_6) then
			pg = var_11_6

			local var_11_7 = var_11_6.CriMgr.GetInstance()

			if var_4.IsDefaultBGM(var_11_7) then
				pg = var_4
				var_11_8 = var_4.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_4
				var_11_8 = var_4.voice_bgm.NewMainScene.bgm
			end
		end

		if arg_5_0.bgm ~= var_11_8 then
			local var_11_9 = arg_5_0

			var_11_9.bgm = var_11_8
			pg = var_11_9

			local var_11_10 = var_11_9.BgmMgr.GetInstance()

			var_4.Push(var_11_10, arg_5_0.__cname, var_11_8)
		end

		return
	end)
	arg_5_0:bind(var_0_1.CLOSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_5_0

		var_3.closeView(var_12_0)

		return
	end)
	arg_5_0:bind(var_0_1.GAME_OVER, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_5_0

		var_3.onGameOver(var_13_0)

		return
	end)
	arg_5_0:bind(var_0_1.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg = var_2_10003

		local var_14_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_14_1 = var_3.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_14_2.type = var_2_10006
		pg = var_2_10006

		local var_14_3 = var_2_10006.gametip

		CastleGameVo = var_2_10007
		var_14_2.helps = var_14_3[var_2_10007.rule_tip].tip

		var_14_1(var_14_0, var_14_2)

		return
	end)
	arg_5_0:bind(var_0_1.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_5_0

		var_3.readyStart(var_15_0)

		return
	end)
	arg_5_0:bind(var_0_1.STORE_SERVER, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_5_0

		var_3.StoreDataToServer(var_16_0, {
			arg_16_1
		})

		return
	end)
	arg_5_0:bind(var_0_1.SUBMIT_GAME_SUCCESS, function(arg_17_0, arg_17_1, arg_17_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			local var_17_0 = arg_5_0

			var_3.SendSuccess(var_17_0, 0)
		end

		return
	end)
	arg_5_0:bind(var_0_1.ADD_SCORE, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_5_0

		var_3.addScore(var_18_0, arg_18_1.num)

		local var_18_1 = arg_5_0.gameUI

		var_3.addScore(var_18_1, arg_18_1)

		return
	end)

	return
end

function var_0_1.initUI(arg_19_0)
	findTF = var_1_10001
	arg_19_0.clickMask = var_1_10001(arg_19_0._tf, "clickMask")
	CastleGamePopUI = var_1
	arg_19_0.popUI = var_1.New(arg_19_0._tf, arg_19_0)

	local var_19_0 = arg_19_0.popUI

	var_1.clearUI(var_19_0)

	CastleGamingUI = var_1
	arg_19_0.gameUI = var_1.New(arg_19_0._tf, arg_19_0)
	CastleGameMenuUI = var_1
	arg_19_0.menuUI = var_1.New(arg_19_0._tf, arg_19_0)

	local var_19_1 = arg_19_0.menuUI

	var_1.update(var_19_1, arg_19_0:GetMGHubData())

	local var_19_2 = arg_19_0.menuUI

	var_1.show(var_19_2, true)

	return
end

function var_0_1.initController(arg_20_0)
	CastleGameScene = var_1_10001
	arg_20_0.gameScene = var_1_10001.New(arg_20_0._tf, arg_20_0)

	return
end

function var_0_1.Update(arg_21_0)
	if arg_21_0.gameStop or arg_21_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_21_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_21_1, var_21_2

		if var_21_0(var_1_10002.S) then
			var_21_1 = arg_21_0.gameUI
			var_21_2 = var_21_2.press
			KeyCode = var_1_10003

			var_21_2(var_21_1, var_1_10003.S, true)
		end

		Input = var_21_2

		local var_21_3 = var_21_2.GetKeyUp

		KeyCode = var_21_1

		local var_21_4, var_21_5

		if var_21_3(var_21_1.S) then
			var_21_4 = arg_21_0.gameUI
			var_21_5 = var_21_5.press
			KeyCode = var_1_10003

			var_21_5(var_21_4, var_1_10003.S, false)
		end

		Input = var_21_5

		local var_21_6 = var_21_5.GetKeyDown

		KeyCode = var_21_4

		local var_21_7, var_21_8

		if var_21_6(var_21_4.W) then
			var_21_7 = arg_21_0.gameUI
			var_21_8 = var_21_8.press
			KeyCode = var_1_10003

			var_21_8(var_21_7, var_1_10003.W, true)
		end

		Input = var_21_8

		local var_21_9 = var_21_8.GetKeyUp

		KeyCode = var_21_7

		local var_21_10, var_21_11

		if var_21_9(var_21_7.W) then
			var_21_10 = arg_21_0.gameUI
			var_21_11 = var_21_11.press
			KeyCode = var_1_10003

			var_21_11(var_21_10, var_1_10003.W, false)
		end

		Input = var_21_11

		local var_21_12 = var_21_11.GetKeyDown

		KeyCode = var_21_10

		local var_21_13, var_21_14

		if var_21_12(var_21_10.A) then
			var_21_13 = arg_21_0.gameUI
			var_21_14 = var_21_14.press
			KeyCode = var_1_10003

			var_21_14(var_21_13, var_1_10003.A, true)
		end

		Input = var_21_14

		local var_21_15 = var_21_14.GetKeyUp

		KeyCode = var_21_13

		local var_21_16, var_21_17

		if var_21_15(var_21_13.A) then
			var_21_16 = arg_21_0.gameUI
			var_21_17 = var_21_17.press
			KeyCode = var_1_10003

			var_21_17(var_21_16, var_1_10003.A, false)
		end

		Input = var_21_17

		local var_21_18 = var_21_17.GetKeyDown

		KeyCode = var_21_16

		local var_21_19, var_21_20

		if var_21_18(var_21_16.D) then
			var_21_19 = arg_21_0.gameUI
			var_21_20 = var_21_20.press
			KeyCode = var_1_10003

			var_21_20(var_21_19, var_1_10003.D, true)
		end

		Input = var_21_20

		local var_21_21 = var_21_20.GetKeyUp

		KeyCode = var_21_19

		if var_21_21(var_21_19.D) then
			local var_21_22 = arg_21_0.gameUI
			local var_21_23 = var_1.press

			KeyCode = var_1_10003

			var_21_23(var_21_22, var_1_10003.D, false)
		end
	end

	return
end

function var_0_1.readyStart(arg_22_0)
	arg_22_0.readyStartFlag = true
	CastleGameVo = var_1

	var_1.Prepare()

	local var_22_0 = arg_22_0.popUI

	var_1.readyStart(var_22_0)

	local var_22_1 = arg_22_0.menuUI

	var_1.show(var_22_1, false)

	local var_22_2 = arg_22_0.gameUI

	var_1.show(var_22_2, false)

	return
end

function var_0_1.gameStart(arg_23_0)
	arg_23_0.readyStartFlag = false
	arg_23_0.gameStartFlag = true
	arg_23_0.sendSuccessFlag = false

	local var_23_0 = arg_23_0.popUI

	var_1.popCountUI(var_23_0, false)

	local var_23_1 = arg_23_0.gameUI

	var_1.start(var_23_1)

	local var_23_2 = arg_23_0.gameUI

	var_1.show(var_23_2, true)

	local var_23_3 = arg_23_0.gameScene

	var_1.start(var_23_3)
	arg_23_0:timerStart()

	return
end

function var_0_1.changeSpeed(arg_24_0, arg_24_1)
	return
end

function var_0_1.onTimer(arg_25_0)
	arg_25_0:gameStep()

	return
end

function var_0_1.gameStep(arg_26_0)
	arg_26_0:stepRunTimeData()

	local var_26_0 = arg_26_0.gameScene

	var_1.step(var_26_0)

	local var_26_1 = arg_26_0.gameUI

	var_1.step(var_26_1)

	CastleGameVo = var_1

	if var_1.gameTime <= 0 then
		arg_26_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_27_0)
	if not arg_27_0.timer.running then
		local var_27_0 = arg_27_0.timer

		var_1.Start(var_27_0)
	end

	return
end

function var_0_1.timerResume(arg_28_0)
	if not arg_28_0.timer.running then
		local var_28_0 = arg_28_0.timer

		var_1.Start(var_28_0)
	end

	local var_28_1 = arg_28_0.gameScene

	var_1.resume(var_28_1)

	return
end

function var_0_1.timerStop(arg_29_0)
	if arg_29_0.timer.running then
		local var_29_0 = arg_29_0.timer

		var_1.Stop(var_29_0)
	end

	local var_29_1 = arg_29_0.gameScene

	var_1.stop(var_29_1)

	return
end

function var_0_1.stepRunTimeData(arg_30_0)
	Time = var_1_10001

	local var_30_0 = var_1_10001.deltaTime

	if 0.016 < var_30_0 then
		var_30_0 = 0.016
	end

	CastleGameVo = var_2
	CastleGameVo = var_1_10003
	var_2.gameTime = var_1_10003.gameTime - var_30_0
	CastleGameVo = var_2
	CastleGameVo = var_3
	var_2.gameStepTime = var_3.gameStepTime + var_30_0
	CastleGameVo = var_2
	var_2.deltaTime = var_30_0

	return
end

function var_0_1.addScore(arg_31_0, arg_31_1)
	CastleGameVo = var_1_10002
	CastleGameVo = var_1_10003
	var_1_10002.scoreNum = var_1_10003.scoreNum + arg_31_1

	return
end

function var_0_1.onGameOver(arg_32_0)
	if arg_32_0.settlementFlag then
		return
	end

	arg_32_0:timerStop()
	arg_32_0:clearController()

	arg_32_0.settlementFlag = true
	setActive = var_1

	var_1(arg_32_0.clickMask, true)

	LeanTween = var_1

	local var_32_0 = var_1.delayedCall

	go = var_2

	local var_32_1 = var_2(arg_32_0._tf)
	local var_32_2 = 0.1

	System = var_1_10004

	var_32_0(var_32_1, var_32_2, var_1_10004.Action(function()
		arg_32_0.settlementFlag = false

		local var_33_0 = arg_32_0

		var_33_0.gameStartFlag = false
		setActive = var_33_0

		var_33_0(arg_32_0.clickMask, false)

		local var_33_1 = arg_32_0.popUI

		var_0.updateSettlementUI(var_33_1)

		local var_33_2 = arg_32_0.popUI

		var_0.popSettlementUI(var_33_2, true)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_34_0)
	if not arg_34_0.gameStartFlag then
		return
	end

	if arg_34_0.readyStartFlag then
		return
	end

	if arg_34_0.settlementFlag then
		return
	end

	arg_34_0:pauseGame()

	local var_34_0 = arg_34_0.popUI

	var_1.popPauseUI(var_34_0)

	return
end

function var_0_1.clearController(arg_35_0)
	local var_35_0 = arg_35_0.gameScene

	var_1.clear(var_35_0)

	return
end

function var_0_1.pauseGame(arg_36_0)
	arg_36_0.gameStop = true

	arg_36_0:changeSpeed(0)
	arg_36_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_37_0)
	arg_37_0.gameStop = false

	arg_37_0:changeSpeed(1)
	arg_37_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_38_0)
	if arg_38_0.readyStartFlag then
		return
	end

	if not arg_38_0.gameStartFlag then
		arg_38_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_38_0.settlementFlag then
			return
		end

		local var_38_0 = arg_38_0.popUI

		var_1.backPressed(var_38_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_39_0, arg_39_1)
	return
end

function var_0_1.willExit(arg_40_0)
	if arg_40_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_40_0.handle)
	end

	if arg_40_0._tf then
		LeanTween = var_1

		local var_40_0 = var_1.isTweening

		go = var_1_10002

		if var_40_0(var_1_10002(arg_40_0._tf)) then
			LeanTween = var_1

			local var_40_1 = var_1.cancel

			go = var_2

			var_40_1(var_2(arg_40_0._tf))
		end
	end

	if arg_40_0.timer and arg_40_0.timer.running then
		local var_40_2 = arg_40_0.timer

		var_1.Stop(var_40_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_40_0.timer = nil

	return
end

return var_0_1
