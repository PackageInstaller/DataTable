class = var_0_10000

local var_0_0 = "LaunchBallGameView"

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
var_0_1.JOYSTICK_ACTIVE_CHANGE = "joy stick active change"
var_0_1.PRESS_SKILL = "press skill"

local var_0_2 = true

function var_0_1.getUIName(arg_1_0)
	LaunchBallGameVo = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.getBGM(arg_2_0)
	LaunchBallGameVo = var_1_10001

	return var_1_10001.game_bgm
end

function var_0_1.didEnter(arg_3_0)
	LaunchBallGameVo = var_1_10001

	if not var_1_10001.gameRoundData then
		LaunchBallGameVo = var_1

		var_1.initRoundData(3, 1)
	end

	arg_3_0:initData()
	arg_3_0:initEvent()
	arg_3_0:initUI()

	local var_3_0 = arg_3_0

	arg_3_0.initController(var_3_0)

	LaunchBallGameVo = var_1

	local var_3_1 = var_1.gameRoundData.type

	LaunchBallGameConst = var_3_0

	if var_3_1 == var_3_0.round_type_zhuanshu then
		LaunchBallGameVo = var_3_1

		local var_3_2 = var_3_1.SetPlayer

		LaunchBallGameVo = var_2

		var_3_2(var_2.gameRoundData.player_id)
		arg_3_0:readyStart()
	end

	return
end

function var_0_1.initData(arg_4_0)
	LaunchBallGameVo = var_1_10001

	var_1_10001.Init(arg_4_0:GetMGData().id, arg_4_0:GetMGHubData().id)

	LaunchBallGameVo = var_1
	var_1.game_room_flag = false
	LaunchBallGameVo = var_1

	local var_4_0 = var_1.frameRate

	if 60 < var_4_0 then
		var_4_0 = 60
	end

	Timer = var_2
	arg_4_0.timer = var_2.New(function()
		local var_5_0 = arg_4_0

		var_0.onTimer(var_5_0)

		return
	end, 1 / var_4_0, -1)

	return
end

function var_0_1.initEvent(arg_6_0)
	if not arg_6_0.handle then
		IsUnityEditor = var_1

		if var_1 then
			UpdateBeat = var_1
			arg_6_0.handle = var_1:CreateListener(arg_6_0.Update, arg_6_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_6_0.handle)
		end
	end

	arg_6_0:bind(var_0_1.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			local var_7_0 = arg_6_0

			var_3.resumeGame(var_7_0)

			local var_7_1 = arg_6_0

			var_3.onGameOver(var_7_1)
		else
			local var_7_2 = arg_6_0

			var_3.resumeGame(var_7_2)
		end

		return
	end)
	arg_6_0:bind(var_0_1.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0

		var_3.gameStart(var_8_0)

		return
	end)
	arg_6_0:bind(var_0_1.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_6_0.popUI

		var_3.popPauseUI(var_9_0)

		return
	end)
	arg_6_0:bind(var_0_1.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_6_0.popUI

		var_3.popLeaveUI(var_10_0)

		return
	end)
	arg_6_0:bind(var_0_1.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			local var_11_0 = arg_6_0

			var_3.pauseGame(var_11_0)
		else
			local var_11_1 = arg_6_0

			var_3.resumeGame(var_11_1)
		end

		return
	end)
	arg_6_0:bind(var_0_1.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		LaunchBallGameVo = var_2_10003

		local var_12_0 = var_2_10003.gameRoundData.type

		LaunchBallGameConst = var_2_10004

		if var_12_0 ~= var_2_10004.round_type_wuxian then
			local var_12_1 = arg_6_0

			var_3.closeView(var_12_1)

			return
		end

		local var_12_2 = arg_6_0.menuUI
		local var_12_3 = var_3.update
		local var_12_4 = arg_6_0

		var_12_3(var_12_2, var_5.GetMGHubData(var_12_4))

		local var_12_5 = arg_6_0.menuUI

		var_3.show(var_12_5, true)

		local var_12_6 = arg_6_0.gameUI

		var_3.show(var_12_6, false)

		local var_12_7 = arg_6_0.gameScene

		var_3.showContainer(var_12_7, false)

		local var_12_8 = arg_6_0
		local var_12_10

		if not var_3.getBGM(var_12_8) then
			pg = var_12_8

			local var_12_9 = var_12_8.CriMgr.GetInstance()

			if var_4.IsDefaultBGM(var_12_9) then
				pg = var_4
				var_12_10 = var_4.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_4
				var_12_10 = var_4.voice_bgm.NewMainScene.bgm
			end
		end

		if arg_6_0.bgm ~= var_12_10 then
			local var_12_11 = arg_6_0

			var_12_11.bgm = var_12_10
			pg = var_12_11

			local var_12_12 = var_12_11.BgmMgr.GetInstance()

			var_4.Push(var_12_12, arg_6_0.__cname, var_12_10)
		end

		return
	end)
	arg_6_0:bind(var_0_1.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_6_0

		var_3.closeView(var_13_0)

		return
	end)
	arg_6_0:bind(var_0_1.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_6_0

		var_3.onGameOver(var_14_0)

		return
	end)
	arg_6_0:bind(var_0_1.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg = var_2_10003

		local var_15_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_15_1 = var_3.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_15_2.type = var_2_10006
		pg = var_2_10006

		local var_15_3 = var_2_10006.gametip

		LaunchBallGameVo = var_2_10007
		var_15_2.helps = var_15_3[var_2_10007.rule_tip].tip

		var_15_1(var_15_0, var_15_2)

		return
	end)
	arg_6_0:bind(var_0_1.READY_START, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_6_0

		var_3.readyStart(var_16_0)

		return
	end)
	arg_6_0:bind(var_0_1.STORE_SERVER, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_6_0

		var_3.StoreDataToServer(var_17_0, {
			arg_17_1
		})

		return
	end)
	arg_6_0:bind(var_0_1.SUBMIT_GAME_SUCCESS, function(arg_18_0, arg_18_1, arg_18_2)
		LaunchBallGameVo = var_2_10003

		local var_18_0 = var_2_10003.gameRoundData.type

		LaunchBallGameVo = var_2_10004

		local var_18_1 = var_2_10004.gameRoundData.type_index

		LaunchBallGameVo = var_2_10005

		local var_18_2 = var_2_10005.scoreNum

		LaunchBallGameVo = var_2_10006

		local var_18_3 = var_2_10006.UpdateGameResultData

		LaunchBallGameVo = var_2_10007

		local var_18_4 = var_2_10007.result_player

		LaunchBallGameVo = var_2_10008

		var_18_3(var_18_4, var_2_10008.selectPlayer)

		LaunchBallGameVo = var_18_3

		local var_18_5 = var_18_3.UpdateGameResultData

		LaunchBallGameVo = var_18_4

		local var_18_6 = var_18_4.result_round

		LaunchBallGameVo = var_8

		var_18_5(var_18_6, var_8.gameRoundData.id)

		LaunchBallActivityMgr = var_18_5

		local var_18_7 = var_18_5.GetGameAward

		ActivityConst = var_18_6

		var_18_7(var_18_6.MINIGAME_ZUMA, var_18_0, var_18_1, var_18_2)

		LaunchBallTaskMgr = var_18_7

		local var_18_8 = var_18_7.CheckTaskUpdate

		LaunchBallGameVo = var_7

		var_18_8(var_7.gameResultData)

		return
	end)
	arg_6_0:bind(var_0_1.ADD_SCORE, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_6_0

		var_3.addScore(var_19_0, arg_19_1.num)

		local var_19_1 = arg_6_0.gameUI

		var_3.addScore(var_19_1, arg_19_1)

		return
	end)
	arg_6_0:bind(var_0_1.JOYSTICK_ACTIVE_CHANGE, function(arg_20_0, arg_20_1, arg_20_2)
		if arg_6_0.gameStartFlag then
			local var_20_0 = arg_6_0.gameScene

			var_3.joystickActive(var_20_0, arg_20_1)
		end

		return
	end)
	arg_6_0:bind(var_0_1.PRESS_SKILL, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_6_0.gameScene

		var_3.useSkill(var_21_0)

		return
	end)

	return
end

function var_0_1.initUI(arg_22_0)
	findTF = var_1_10001
	arg_22_0.clickMask = var_1_10001(arg_22_0._tf, "clickMask")
	LaunchBallGamePopUI = var_1
	arg_22_0.popUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_0 = arg_22_0.popUI

	var_1.clearUI(var_22_0)

	LaunchBallGamingUI = var_1
	arg_22_0.gameUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_1 = arg_22_0.gameUI

	var_1.show(var_22_1, false)

	LaunchBallGameMenuUI = var_1
	arg_22_0.menuUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_2 = arg_22_0.menuUI

	var_1.update(var_22_2, arg_22_0:GetMGHubData())

	local var_22_3 = arg_22_0.menuUI

	var_1.show(var_22_3, true)

	return
end

function var_0_1.initController(arg_23_0)
	LaunchBallGameScene = var_1_10001
	arg_23_0.gameScene = var_1_10001.New(arg_23_0._tf, arg_23_0)

	return
end

function var_0_1.Update(arg_24_0)
	if arg_24_0.gameStop or arg_24_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_24_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_24_1

		if var_24_0(var_1_10002.S) and arg_24_0.timer then
			var_24_1 = arg_24_0

			arg_24_0.timerStop(var_24_1)
		end

		Input = var_1

		local var_24_2 = var_1.GetKeyUp

		KeyCode = var_24_1

		local var_24_3, var_24_4

		if var_24_2(var_24_1.S) then
			var_24_3 = arg_24_0.gameUI
			var_24_4 = var_24_4.press
			KeyCode = var_1_10003

			var_24_4(var_24_3, var_1_10003.S, false)
		end

		Input = var_24_4

		local var_24_5 = var_24_4.GetKeyDown

		KeyCode = var_24_3

		local var_24_6

		if var_24_5(var_24_3.W) and arg_24_0.timer then
			var_24_6 = arg_24_0

			arg_24_0.timerStart(var_24_6)
		end

		Input = var_1

		local var_24_7 = var_1.GetKeyUp

		KeyCode = var_24_6

		local var_24_8, var_24_9

		if var_24_7(var_24_6.W) then
			var_24_8 = arg_24_0.gameUI
			var_24_9 = var_24_9.press
			KeyCode = var_1_10003

			var_24_9(var_24_8, var_1_10003.W, false)
		end

		Input = var_24_9

		local var_24_10 = var_24_9.GetKeyDown

		KeyCode = var_24_8

		local var_24_11, var_24_12

		if var_24_10(var_24_8.A) then
			var_24_11 = arg_24_0.gameUI
			var_24_12 = var_24_12.press
			KeyCode = var_1_10003

			var_24_12(var_24_11, var_1_10003.A, true)
		end

		Input = var_24_12

		local var_24_13 = var_24_12.GetKeyUp

		KeyCode = var_24_11

		local var_24_14, var_24_15

		if var_24_13(var_24_11.A) then
			var_24_14 = arg_24_0.gameUI
			var_24_15 = var_24_15.press
			KeyCode = var_1_10003

			var_24_15(var_24_14, var_1_10003.A, false)
		end

		Input = var_24_15

		local var_24_16 = var_24_15.GetKeyDown

		KeyCode = var_24_14

		local var_24_17, var_24_18

		if var_24_16(var_24_14.D) then
			var_24_17 = arg_24_0.gameUI
			var_24_18 = var_24_18.press
			KeyCode = var_1_10003

			var_24_18(var_24_17, var_1_10003.D, true)
		end

		Input = var_24_18

		local var_24_19 = var_24_18.GetKeyUp

		KeyCode = var_24_17

		local var_24_20, var_24_21

		if var_24_19(var_24_17.D) then
			var_24_20 = arg_24_0.gameUI
			var_24_21 = var_24_21.press
			KeyCode = var_1_10003

			var_24_21(var_24_20, var_1_10003.D, false)
		end

		Input = var_24_21

		local var_24_22 = var_24_21.GetKeyDown

		KeyCode = var_24_20

		if var_24_22(var_24_20.J) then
			arg_24_0:onTimer()
		end
	end

	return
end

function var_0_1.readyStart(arg_25_0)
	arg_25_0.readyStartFlag = true
	LaunchBallGameVo = var_1

	var_1.Prepare()

	local var_25_0 = arg_25_0.popUI

	var_1.readyStart(var_25_0)

	local var_25_1 = arg_25_0.menuUI

	var_1.show(var_25_1, false)

	local var_25_2 = arg_25_0.gameUI

	var_1.show(var_25_2, false)

	return
end

function var_0_1.gameStart(arg_26_0)
	LaunchBallGameConst = var_1_10001

	local var_26_0 = var_1_10001.map_data

	LaunchBallGameVo = var_1_10002

	local var_26_1 = var_26_0[var_1_10002.gameRoundData.map].bgm

	pg = var_2

	local var_26_2 = var_2.BgmMgr.GetInstance()

	var_2.Push(var_26_2, arg_26_0.__cname, var_26_1)

	arg_26_0.bgm = var_26_1
	arg_26_0.readyStartFlag = false
	arg_26_0.gameStartFlag = true
	arg_26_0.sendSuccessFlag = false

	local var_26_3 = arg_26_0.popUI

	var_2.popCountUI(var_26_3, false)

	local var_26_4 = arg_26_0.gameUI

	var_2.start(var_26_4)

	local var_26_5 = arg_26_0.gameUI

	var_2.show(var_26_5, true)

	local var_26_6 = arg_26_0.gameScene

	var_2.start(var_26_6)
	arg_26_0:timerStart()

	return
end

function var_0_1.changeSpeed(arg_27_0, arg_27_1)
	return
end

function var_0_1.onTimer(arg_28_0)
	arg_28_0:gameStep()

	return
end

function var_0_1.gameStep(arg_29_0)
	arg_29_0:stepRunTimeData()

	local var_29_0 = arg_29_0.gameScene

	var_1.step(var_29_0)

	local var_29_1 = arg_29_0.gameUI

	var_1.step(var_29_1)

	LaunchBallGameVo = var_1

	if var_1.gameTime <= 0 then
		arg_29_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_30_0)
	if not arg_30_0.timer.running then
		local var_30_0 = arg_30_0.timer

		var_1.Start(var_30_0)
	end

	return
end

function var_0_1.timerResume(arg_31_0)
	if not arg_31_0.timer.running then
		local var_31_0 = arg_31_0.timer

		var_1.Start(var_31_0)
	end

	local var_31_1 = arg_31_0.gameScene

	var_1.resume(var_31_1)

	return
end

function var_0_1.timerStop(arg_32_0)
	if arg_32_0.timer.running then
		local var_32_0 = arg_32_0.timer

		var_1.Stop(var_32_0)
	end

	local var_32_1 = arg_32_0.gameScene

	var_1.stop(var_32_1)

	return
end

function var_0_1.stepRunTimeData(arg_33_0)
	Time = var_1_10001

	local var_33_0 = var_1_10001.deltaTime

	if 0.016 < var_33_0 then
		var_33_0 = 0.016
	end

	LaunchBallGameVo = var_2
	LaunchBallGameVo = var_1_10003
	var_2.gameTime = var_1_10003.gameTime - var_33_0
	LaunchBallGameVo = var_2
	LaunchBallGameVo = var_3
	var_2.gameStepTime = var_3.gameStepTime + var_33_0
	LaunchBallGameVo = var_2
	var_2.deltaTime = var_33_0

	return
end

function var_0_1.addScore(arg_34_0, arg_34_1)
	LaunchBallGameVo = var_1_10002
	LaunchBallGameVo = var_1_10003
	var_1_10002.scoreNum = var_1_10003.scoreNum + arg_34_1

	return
end

function var_0_1.onGameOver(arg_35_0)
	if arg_35_0.settlementFlag then
		return
	end

	arg_35_0:timerStop()
	arg_35_0:clearController()

	arg_35_0.settlementFlag = true
	setActive = var_1

	var_1(arg_35_0.clickMask, true)

	LeanTween = var_1

	local var_35_0 = var_1.delayedCall

	go = var_2

	local var_35_1 = var_2(arg_35_0._tf)
	local var_35_2 = 0.1

	System = var_1_10004

	var_35_0(var_35_1, var_35_2, var_1_10004.Action(function()
		arg_35_0.settlementFlag = false

		local var_36_0 = arg_35_0

		var_36_0.gameStartFlag = false
		setActive = var_36_0

		var_36_0(arg_35_0.clickMask, false)

		local var_36_1 = arg_35_0.popUI

		var_0.updateSettlementUI(var_36_1)

		local var_36_2 = arg_35_0.popUI

		var_0.popSettlementUI(var_36_2, true)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_37_0)
	if not arg_37_0.gameStartFlag then
		return
	end

	if arg_37_0.readyStartFlag then
		return
	end

	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:pauseGame()

	local var_37_0 = arg_37_0.popUI

	var_1.popPauseUI(var_37_0)

	return
end

function var_0_1.clearController(arg_38_0)
	local var_38_0 = arg_38_0.gameScene

	var_1.clear(var_38_0)

	return
end

function var_0_1.pauseGame(arg_39_0)
	arg_39_0.gameStop = true

	arg_39_0:changeSpeed(0)
	arg_39_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_40_0)
	arg_40_0.gameStop = false

	arg_40_0:changeSpeed(1)
	arg_40_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_41_0)
	if arg_41_0.readyStartFlag then
		return
	end

	if not arg_41_0.gameStartFlag then
		arg_41_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_41_0.settlementFlag then
			return
		end

		local var_41_0 = arg_41_0.popUI

		var_1.backPressed(var_41_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_42_0, arg_42_1)
	return
end

function var_0_1.willExit(arg_43_0)
	if arg_43_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_43_0.handle)
	end

	if arg_43_0._tf then
		LeanTween = var_1

		local var_43_0 = var_1.isTweening

		go = var_1_10002

		if var_43_0(var_1_10002(arg_43_0._tf)) then
			LeanTween = var_1

			local var_43_1 = var_1.cancel

			go = var_2

			var_43_1(var_2(arg_43_0._tf))
		end
	end

	if arg_43_0.timer and arg_43_0.timer.running then
		local var_43_2 = arg_43_0.timer

		var_1.Stop(var_43_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_43_0.timer = nil

	return
end

return var_0_1
