class = var_0_10000

local var_0_0 = "BoatAdGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

import = var_0_0

local var_0_2 = var_0_0("view.miniGame.gameView.BoatAdGame.BoatAdGameVo")

function var_0_1.getUIName(arg_1_0)
	return var_0_2.game_ui
end

function var_0_1.getBGM(arg_2_0)
	return var_0_2.menu_bgm
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initEvent()
	arg_3_0:initUI()
	arg_3_0:checkGet()

	return
end

function var_0_1.checkGet(arg_4_0)
	if arg_4_0:GetMGHubData().ultimate and var_2 == 1 then
		return
	end

	if var_0_2.GetGameTimes() == 0 then
		if var_0_2.GetGameMaxTimes() > var_0_2.GetGameUseTimes() then
			return
		end

		pg = var_1_10006

		local var_4_0 = var_1_10006.m02
		local var_4_1 = var_6.sendNotification

		GAME = var_1_10008

		local var_4_2 = var_1_10008.SEND_MINI_GAME_OP
		local var_4_3 = {
			hubid = var_1.id
		}

		MiniGameOPCommand = var_10
		var_4_3.cmd = var_10.CMD_ULTIMATE
		var_4_3.args1 = {}

		var_4_1(var_4_0, var_4_2, var_4_3)
	end

	return
end

function var_0_1.initData(arg_5_0)
	var_0_2.Init(arg_5_0:GetMGData().id, arg_5_0:GetMGHubData().id)

	local var_5_0 = var_0_2.SetGameTpl

	findTF = var_2

	var_5_0(var_2(arg_5_0._tf, "tpl"))

	Application = var_5_0

	local var_5_1

	if var_5_0.targetFrameRate > 60 then
		var_5_1 = 60
	end

	arg_5_0.stepCount = 1 / var_5_1 * 0.9
	Time = var_2
	arg_5_0.realTimeStartUp = var_2.realtimeSinceStartup
	Timer = var_2
	arg_5_0.timer = var_2.New(function()
		Time = var_2_10000

		if var_2_10000.realtimeSinceStartup - arg_5_0.realTimeStartUp > arg_5_0.stepCount then
			local var_6_0 = arg_5_0

			var_0.onTimer(var_6_0)

			local var_6_1 = arg_5_0

			Time = var_6_0
			var_6_1.realTimeStartUp = var_6_0.realtimeSinceStartup
		end

		return
	end, 1 / var_5_1, -1)

	return
end

function var_0_1.initEvent(arg_7_0)
	if not arg_7_0.handle then
		IsUnityEditor = var_1

		if var_1 then
			UpdateBeat = var_1
			arg_7_0.handle = var_1:CreateListener(arg_7_0.Update, arg_7_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_7_0.handle)
		end
	end

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bind

	SimpleMGEvent = var_1_10003

	var_7_1(var_7_0, var_1_10003.LEVEL_GAME, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_1 then
			local var_8_0 = arg_7_0

			var_3.resumeGame(var_8_0)

			local var_8_1 = arg_7_0

			var_3.onGameOver(var_8_1)
		else
			local var_8_2 = arg_7_0

			var_3.resumeGame(var_8_2)
		end

		return
	end)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_3(var_7_2, var_3.USE_SKILL, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_7_0.gameScene

		var_3.useSkill(var_9_0, arg_9_1)

		return
	end)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_5(var_7_4, var_3.COUNT_DOWN, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_7_0

		var_3.gameStart(var_10_0)

		return
	end)

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_7(var_7_6, var_3.OPEN_PAUSE_UI, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_7_0.popUI

		var_3.popPauseUI(var_11_0)

		return
	end)

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_9(var_7_8, var_3.OPEN_LEVEL_UI, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_7_0.popUI

		var_3.popLeaveUI(var_12_0)

		return
	end)

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_11(var_7_10, var_3.PAUSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 then
			local var_13_0 = arg_7_0

			var_3.pauseGame(var_13_0)
		else
			local var_13_1 = arg_7_0

			var_3.resumeGame(var_13_1)
		end

		return
	end)

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_13(var_7_12, var_3.BACK_MENU, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_7_0.menuUI
		local var_14_1 = var_3.update
		local var_14_2 = arg_7_0

		var_14_1(var_14_0, var_5.GetMGHubData(var_14_2))

		local var_14_3 = arg_7_0.menuUI

		var_3.show(var_14_3, true)

		local var_14_4 = arg_7_0.gameUI

		var_3.show(var_14_4, false)

		local var_14_5 = arg_7_0.gameScene

		var_3.showContainer(var_14_5, false)

		local var_14_6 = arg_7_0
		local var_14_8

		if not var_3.getBGM(var_14_6) then
			pg = var_14_6

			local var_14_7 = var_14_6.CriMgr.GetInstance()

			if var_4.IsDefaultBGM(var_14_7) then
				pg = var_4
				var_14_8 = var_4.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_4
				var_14_8 = var_4.voice_bgm.NewMainScene.bgm
			end
		end

		if arg_7_0.bgm ~= var_14_8 then
			local var_14_9 = arg_7_0

			var_14_9.bgm = var_14_8
			pg = var_14_9

			local var_14_10 = var_14_9.BgmMgr.GetInstance()

			var_4.Push(var_14_10, arg_7_0.__cname, var_14_8)
		end

		local var_14_11 = arg_7_0

		var_4.checkGet(var_14_11)

		return
	end)

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_15(var_7_14, var_3.CLOSE_GAME, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_7_0

		var_3.closeView(var_15_0)

		return
	end)

	local var_7_16 = arg_7_0
	local var_7_17 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_17(var_7_16, var_3.BACK_HOME, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_7_0
		local var_16_1 = var_3.emit

		BaseUI = var_2_10005

		var_16_1(var_16_0, var_2_10005.ON_HOME)

		return
	end)

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_19(var_7_18, var_3.GAME_OVER, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_7_0

		var_3.onGameOver(var_17_0, arg_17_1)

		return
	end)

	local var_7_20 = arg_7_0
	local var_7_21 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_21(var_7_20, var_3.SHOW_RULE, function(arg_18_0, arg_18_1, arg_18_2)
		pg = var_2_10003

		local var_18_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_18_1 = var_3.ShowMsgBox
		local var_18_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_18_2.type = var_2_10006
		pg = var_2_10006
		var_18_2.helps = var_2_10006.gametip[var_0_2.rule_tip].tip

		var_18_1(var_18_0, var_18_2)

		return
	end)

	local var_7_22 = arg_7_0
	local var_7_23 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_23(var_7_22, var_3.READY_START, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_7_0

		var_3.readyStart(var_19_0)

		return
	end)

	local var_7_24 = arg_7_0
	local var_7_25 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_25(var_7_24, var_3.STORE_SERVER, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_7_0

		var_3.StoreDataToServer(var_20_0, {
			arg_20_1
		})

		return
	end)

	local var_7_26 = arg_7_0
	local var_7_27 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_27(var_7_26, var_3.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not arg_7_0.sendSuccessFlag then
			arg_7_0.sendSuccessFlag = true

			local var_21_0 = arg_7_0

			var_3.SendSuccess(var_21_0, 0)
		end

		local var_21_1 = var_0_2.char
		local var_21_2 = var_3.getHp(var_21_1)
		local var_21_3 = var_0_2.scoreNum
		local var_21_4 = var_0_2.GetGameUseTimes() + 1

		math = var_2_10006

		local var_21_5 = var_2_10006.floor(var_0_2.gameStepTime)

		pg = var_7

		local var_21_6 = var_7.m02
		local var_21_7 = var_7.sendNotification

		GAME = var_2_10009

		local var_21_8 = var_2_10009.SEND_MINI_GAME_OP
		local var_21_9 = {}
		local var_21_10 = arg_7_0

		var_21_9.hubid = var_11.GetMGHubData(var_21_10).id
		MiniGameOPCommand = var_11
		var_21_9.cmd = var_11.CMD_SUCCESS_DATA
		var_21_9.args1 = {
			var_21_3,
			var_21_4,
			var_21_5
		}

		var_21_7(var_21_6, var_21_8, var_21_9)

		return
	end)

	local var_7_28 = arg_7_0
	local var_7_29 = arg_7_0.bind

	SimpleMGEvent = var_3

	var_7_29(var_7_28, var_3.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_7_0

		var_3.addScore(var_22_0, arg_22_1)

		return
	end)

	local var_7_30 = arg_7_0
	local var_7_31 = arg_7_0.bind

	BoatAdGameEvent = var_3

	var_7_31(var_7_30, var_3.OPEN_AD_WINDOW, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_7_0

		var_3.pauseGame(var_23_0)

		local var_23_1 = arg_7_0.popUI

		var_3.oepnAd(var_23_1)

		return
	end)

	local var_7_32 = arg_7_0
	local var_7_33 = arg_7_0.bind

	BoatAdGameEvent = var_3

	var_7_33(var_7_32, var_3.CLOSE_AD_UI, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_7_0

		var_3.resumeGame(var_24_0)

		return
	end)

	return
end

function var_0_1.initUI(arg_25_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001
		findTF = var_1_10002

		var_1_10001(var_1_10002(arg_25_0._tf, "tpl"), false)
	end

	findTF = var_1_10001
	arg_25_0.clickMask = var_1_10001(arg_25_0._tf, "clickMask")
	BoatAdGamePopUI = var_1
	arg_25_0.popUI = var_1.New(arg_25_0._tf, arg_25_0)

	local var_25_0 = arg_25_0.popUI

	var_1.clearUI(var_25_0)

	BoatAdGamingUI = var_1
	arg_25_0.gameUI = var_1.New(arg_25_0._tf, arg_25_0)

	local var_25_1 = arg_25_0.gameUI

	var_1.show(var_25_1, false)

	BoatAdGameMenuUI = var_1
	arg_25_0.menuUI = var_1.New(arg_25_0._tf, arg_25_0)

	local var_25_2 = arg_25_0.menuUI

	var_1.update(var_25_2, arg_25_0:GetMGHubData())

	local var_25_3 = arg_25_0.menuUI

	var_1.show(var_25_3, true)

	BoatAdGameScene = var_1
	arg_25_0.gameScene = var_1.New(arg_25_0._tf, arg_25_0)

	return
end

function var_0_1.Update(arg_26_0)
	if arg_26_0.gameStop or arg_26_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_26_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_26_1, var_26_2

		if var_26_0(var_1_10002.S) then
			var_26_1 = arg_26_0.gameUI
			var_26_2 = var_26_2.press
			KeyCode = var_1_10003

			var_26_2(var_26_1, var_1_10003.S, true)
		end

		Input = var_26_2

		local var_26_3 = var_26_2.GetKeyUp

		KeyCode = var_26_1

		local var_26_4, var_26_5

		if var_26_3(var_26_1.S) then
			var_26_4 = arg_26_0.gameUI
			var_26_5 = var_26_5.press
			KeyCode = var_1_10003

			var_26_5(var_26_4, var_1_10003.S, false)
		end

		Input = var_26_5

		local var_26_6 = var_26_5.GetKeyDown

		KeyCode = var_26_4

		local var_26_7, var_26_8

		if var_26_6(var_26_4.W) then
			var_26_7 = arg_26_0.gameUI
			var_26_8 = var_26_8.press
			KeyCode = var_1_10003

			var_26_8(var_26_7, var_1_10003.W, true)
		end

		Input = var_26_8

		local var_26_9 = var_26_8.GetKeyUp

		KeyCode = var_26_7

		local var_26_10, var_26_11

		if var_26_9(var_26_7.W) then
			var_26_10 = arg_26_0.gameUI
			var_26_11 = var_26_11.press
			KeyCode = var_1_10003

			var_26_11(var_26_10, var_1_10003.W, false)
		end

		Input = var_26_11

		local var_26_12 = var_26_11.GetKeyDown

		KeyCode = var_26_10

		local var_26_13, var_26_14

		if var_26_12(var_26_10.A) then
			var_26_13 = arg_26_0.gameUI
			var_26_14 = var_26_14.press
			KeyCode = var_1_10003

			var_26_14(var_26_13, var_1_10003.A, true)
		end

		Input = var_26_14

		local var_26_15 = var_26_14.GetKeyUp

		KeyCode = var_26_13

		local var_26_16, var_26_17

		if var_26_15(var_26_13.A) then
			var_26_16 = arg_26_0.gameUI
			var_26_17 = var_26_17.press
			KeyCode = var_1_10003

			var_26_17(var_26_16, var_1_10003.A, false)
		end

		Input = var_26_17

		local var_26_18 = var_26_17.GetKeyDown

		KeyCode = var_26_16

		local var_26_19, var_26_20

		if var_26_18(var_26_16.D) then
			var_26_19 = arg_26_0.gameUI
			var_26_20 = var_26_20.press
			KeyCode = var_1_10003

			var_26_20(var_26_19, var_1_10003.D, true)
		end

		Input = var_26_20

		local var_26_21 = var_26_20.GetKeyUp

		KeyCode = var_26_19

		local var_26_22, var_26_23

		if var_26_21(var_26_19.D) then
			var_26_22 = arg_26_0.gameUI
			var_26_23 = var_26_23.press
			KeyCode = var_1_10003

			var_26_23(var_26_22, var_1_10003.D, false)
		end

		Input = var_26_23

		local var_26_24 = var_26_23.GetKeyDown

		KeyCode = var_26_22

		if var_26_24(var_26_22.J) then
			local var_26_25 = arg_26_0.gameScene
			local var_26_26 = var_1.press

			KeyCode = var_1_10003

			var_26_26(var_26_25, var_1_10003.J, true)
		end
	end

	return
end

function var_0_1.readyStart(arg_27_0)
	arg_27_0.readyStartFlag = true

	var_0_2.Prepare()

	local var_27_0 = arg_27_0.popUI

	var_1.readyStart(var_27_0)

	local var_27_1 = arg_27_0.menuUI

	var_1.show(var_27_1, false)

	local var_27_2 = arg_27_0.gameUI

	var_1.show(var_27_2, false)

	setActive = var_1
	findTF = var_27_2

	var_1(var_27_2(arg_27_0._tf, "sceneBg"), false)

	return
end

function var_0_1.gameStart(arg_28_0)
	arg_28_0.readyStartFlag = false
	arg_28_0.gameStartFlag = true
	arg_28_0.sendSuccessFlag = false

	local var_28_0 = arg_28_0.popUI

	var_1.popCountUI(var_28_0, false)

	local var_28_1 = arg_28_0.gameUI

	var_1.start(var_28_1)

	local var_28_2 = arg_28_0.gameUI

	var_1.show(var_28_2, true)

	if arg_28_0.bgm ~= var_0_2.game_bgm then
		arg_28_0.bgm = var_0_2.game_bgm
		pg = var_1

		local var_28_3 = var_1.BgmMgr.GetInstance()

		var_1.Push(var_28_3, arg_28_0.__cname, var_0_2.game_bgm)
	end

	local var_28_4 = arg_28_0.gameScene

	var_1.start(var_28_4)
	arg_28_0:timerStart()

	return
end

function var_0_1.changeSpeed(arg_29_0, arg_29_1)
	return
end

function var_0_1.onTimer(arg_30_0)
	arg_30_0:gameStep()

	return
end

function var_0_1.gameStep(arg_31_0)
	arg_31_0:stepRunTimeData()

	local var_31_0 = arg_31_0.gameScene

	var_1.step(var_31_0, var_0_2.deltaTime)

	local var_31_1 = arg_31_0.gameUI

	var_1.step(var_31_1, var_0_2.deltaTime)

	if var_0_2.gameTime <= 0 then
		arg_31_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_32_0)
	if not arg_32_0.timer.running then
		Time = var_1
		arg_32_0.realTimeStartUp = var_1.realtimeSinceStartup

		local var_32_0 = arg_32_0.timer

		var_1.Start(var_32_0)
	end

	return
end

function var_0_1.timerResume(arg_33_0)
	if not arg_33_0.timer.running then
		Time = var_1
		arg_33_0.realTimeStartUp = var_1.realtimeSinceStartup

		local var_33_0 = arg_33_0.timer

		var_1.Start(var_33_0)
	end

	local var_33_1 = arg_33_0.gameScene

	var_1.resume(var_33_1)

	return
end

function var_0_1.timerStop(arg_34_0)
	if arg_34_0.timer.running then
		local var_34_0 = arg_34_0.timer

		var_1.Stop(var_34_0)
	end

	local var_34_1 = arg_34_0.gameScene

	var_1.stop(var_34_1)

	return
end

function var_0_1.stepRunTimeData(arg_35_0)
	Time = var_1_10001

	local var_35_0 = var_1_10001.realtimeSinceStartup - arg_35_0.realTimeStartUp

	var_0_2.gameTime = var_0_2.gameTime - var_35_0
	var_0_2.gameStepTime = var_0_2.gameStepTime + var_35_0
	var_0_2.deltaTime = var_35_0

	return
end

function var_0_1.addScore(arg_36_0, arg_36_1)
	var_0_2.scoreNum = var_0_2.scoreNum + arg_36_1

	return
end

function var_0_1.onGameOver(arg_37_0, arg_37_1)
	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:timerStop()
	arg_37_0:clearController()

	arg_37_0.settlementFlag = true
	setActive = var_2

	var_2(arg_37_0.clickMask, true)

	LeanTween = var_2

	local var_37_0 = var_2.delayedCall

	go = var_3

	local var_37_1 = var_3(arg_37_0._tf)
	local var_37_2 = 0.1

	System = var_1_10005

	var_37_0(var_37_1, var_37_2, var_1_10005.Action(function()
		arg_37_0.settlementFlag = false

		local var_38_0 = arg_37_0

		var_38_0.gameStartFlag = false
		setActive = var_38_0

		var_38_0(arg_37_0.clickMask, false)

		local var_38_1 = arg_37_0.popUI

		var_0.updateSettlementUI(var_38_1)

		local var_38_2 = arg_37_0.popUI

		var_0.popSettlementUI(var_38_2, true)

		return
	end))

	setActive = var_37_0
	findTF = var_37_1

	var_37_0(var_37_1(arg_37_0._tf, "sceneBg"), true)

	return
end

function var_0_1.OnApplicationPaused(arg_39_0)
	if not arg_39_0.gameStartFlag then
		return
	end

	if arg_39_0.readyStartFlag then
		return
	end

	if arg_39_0.settlementFlag then
		return
	end

	arg_39_0:pauseGame()

	local var_39_0 = arg_39_0.popUI

	var_1.popPauseUI(var_39_0)

	return
end

function var_0_1.clearController(arg_40_0)
	local var_40_0 = arg_40_0.gameScene

	var_1.clear(var_40_0)

	return
end

function var_0_1.pauseGame(arg_41_0)
	arg_41_0.gameStop = true

	arg_41_0:changeSpeed(0)
	arg_41_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_42_0)
	arg_42_0.gameStop = false

	arg_42_0:changeSpeed(1)
	arg_42_0:timerResume()

	return
end

function var_0_1.onBackPressed(arg_43_0)
	if arg_43_0.readyStartFlag then
		return
	end

	if not arg_43_0.gameStartFlag then
		arg_43_0:emit(var_0_1.ON_BACK_PRESSED)

		return
	else
		if arg_43_0.settlementFlag then
			return
		end

		local var_43_0 = arg_43_0.popUI

		var_1.backPressed(var_43_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_44_0, arg_44_1)
	return
end

function var_0_1.willExit(arg_45_0)
	if arg_45_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_45_0.handle)
	end

	if arg_45_0._tf then
		LeanTween = var_1

		local var_45_0 = var_1.isTweening

		go = var_1_10002

		if var_45_0(var_1_10002(arg_45_0._tf)) then
			LeanTween = var_1

			local var_45_1 = var_1.cancel

			go = var_2

			var_45_1(var_2(arg_45_0._tf))
		end
	end

	if arg_45_0.timer and arg_45_0.timer.running then
		local var_45_2 = arg_45_0.timer

		var_1.Stop(var_45_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_45_0.timer = nil

	var_0_2.Clear()

	return
end

return var_0_1
