class = var_0_10000

local var_0_0 = "SailBoatGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

var_0_1.LEVEL_GAME = "leavel game"
var_0_1.PAUSE_GAME = "pause game "
var_0_1.OPEN_PAUSE_UI = "open pause ui"
var_0_1.OPEN_LEVEL_UI = "open leave ui"
var_0_1.BACK_MENU = "back menu"
var_0_1.OPEN_EQUIP_UI = "open equip ui"
var_0_1.CLOSE_GAME = "close game"
var_0_1.SHOW_RULE = "show rule"
var_0_1.READY_START = "ready start"
var_0_1.COUNT_DOWN = "count down"
var_0_1.STORE_SERVER = "store server"
var_0_1.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_1.ADD_SCORE = "add score"
var_0_1.GAME_OVER = "game over"
var_0_1.USE_SKILL = "use skill"
var_0_1.JOYSTICK_ACTIVE_CHANGE = "joy stick active change"
import = var_1

local var_0_2 = var_1("view.miniGame.gameView.SailBoatGame.SailBoatGameVo")

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

	return
end

function var_0_1.initData(arg_4_0)
	var_0_2.Init(arg_4_0:GetMGData().id, arg_4_0:GetMGHubData().id)

	local var_4_0 = var_0_2.SetGameTpl

	findTF = var_2

	var_4_0(var_2(arg_4_0._tf, "tpl"))

	local var_4_1 = var_0_2.frameRate

	if 60 < var_4_1 then
		var_4_1 = 60
	end

	Timer = var_2
	arg_4_0.timer = var_2.New(function()
		local var_5_0 = arg_4_0

		var_0.onTimer(var_5_0)

		return
	end, 1 / var_4_1, -1)

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
	arg_6_0:bind(var_0_1.USE_SKILL, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0.gameScene

		var_3.useSkill(var_8_0)

		return
	end)
	arg_6_0:bind(var_0_1.COUNT_DOWN, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_6_0

		var_3.gameStart(var_9_0)

		return
	end)
	arg_6_0:bind(var_0_1.OPEN_EQUIP_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_6_0.equipUI

		var_3.show(var_10_0, true)

		local var_10_1 = arg_6_0.menuUI

		var_3.show(var_10_1, false)

		return
	end)
	arg_6_0:bind(var_0_1.OPEN_PAUSE_UI, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_6_0.popUI

		var_3.popPauseUI(var_11_0)

		return
	end)
	arg_6_0:bind(var_0_1.OPEN_LEVEL_UI, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_6_0.popUI

		var_3.popLeaveUI(var_12_0)

		return
	end)
	arg_6_0:bind(var_0_1.PAUSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 then
			local var_13_0 = arg_6_0

			var_3.pauseGame(var_13_0)
		else
			local var_13_1 = arg_6_0

			var_3.resumeGame(var_13_1)
		end

		return
	end)
	arg_6_0:bind(var_0_1.BACK_MENU, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_6_0.menuUI
		local var_14_1 = var_3.update
		local var_14_2 = arg_6_0

		var_14_1(var_14_0, var_5.GetMGHubData(var_14_2))

		local var_14_3 = arg_6_0.menuUI

		var_3.show(var_14_3, true)

		local var_14_4 = arg_6_0.gameUI

		var_3.show(var_14_4, false)

		local var_14_5 = arg_6_0.gameScene

		var_3.showContainer(var_14_5, false)

		local var_14_6 = arg_6_0
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

		if arg_6_0.bgm ~= var_14_8 then
			local var_14_9 = arg_6_0

			var_14_9.bgm = var_14_8
			pg = var_14_9

			local var_14_10 = var_14_9.BgmMgr.GetInstance()

			var_4.Push(var_14_10, arg_6_0.__cname, var_14_8)
		end

		local var_14_11 = arg_6_0

		var_4.initBgAnimation(var_14_11)

		return
	end)
	arg_6_0:bind(var_0_1.CLOSE_GAME, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_6_0

		var_3.closeView(var_15_0)

		return
	end)
	arg_6_0:bind(var_0_1.GAME_OVER, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_6_0

		var_3.onGameOver(var_16_0)

		return
	end)
	arg_6_0:bind(var_0_1.SHOW_RULE, function(arg_17_0, arg_17_1, arg_17_2)
		pg = var_2_10003

		local var_17_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_17_1 = var_3.ShowMsgBox
		local var_17_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_17_2.type = var_2_10006
		pg = var_2_10006
		var_17_2.helps = var_2_10006.gametip[var_0_2.rule_tip].tip

		var_17_1(var_17_0, var_17_2)

		return
	end)
	arg_6_0:bind(var_0_1.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_6_0

		var_3.readyStart(var_18_0)

		return
	end)
	arg_6_0:bind(var_0_1.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_6_0

		var_3.StoreDataToServer(var_19_0, {
			arg_19_1
		})

		return
	end)
	arg_6_0:bind(var_0_1.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			local var_20_0 = arg_6_0

			var_3.SendSuccess(var_20_0, 0)
		end

		return
	end)
	arg_6_0:bind(var_0_1.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_6_0

		var_3.addScore(var_21_0, arg_21_1.num)

		local var_21_1 = arg_6_0.gameUI

		var_3.addScore(var_21_1, arg_21_1)

		return
	end)
	arg_6_0:bind(var_0_1.JOYSTICK_ACTIVE_CHANGE, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_6_0.gameStartFlag then
			local var_22_0 = arg_6_0.gameScene

			var_3.joystickActive(var_22_0, arg_22_1)
		end

		return
	end)

	return
end

function var_0_1.initUI(arg_23_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001
		findTF = var_1_10002

		var_1_10001(var_1_10002(arg_23_0._tf, "tpl"), false)
	end

	findTF = var_1_10001
	arg_23_0.clickMask = var_1_10001(arg_23_0._tf, "clickMask")
	SailBoatGamePopUI = var_1
	arg_23_0.popUI = var_1.New(arg_23_0._tf, arg_23_0)

	local var_23_0 = arg_23_0.popUI

	var_1.clearUI(var_23_0)

	SailBoatGamingUI = var_1
	arg_23_0.gameUI = var_1.New(arg_23_0._tf, arg_23_0)

	local var_23_1 = arg_23_0.gameUI

	var_1.show(var_23_1, false)

	SailBoatGameMenuUI = var_1
	arg_23_0.menuUI = var_1.New(arg_23_0._tf, arg_23_0)

	local var_23_2 = arg_23_0.menuUI

	var_1.update(var_23_2, arg_23_0:GetMGHubData())

	local var_23_3 = arg_23_0.menuUI

	var_1.show(var_23_3, true)

	SailBoatEquipUI = var_1
	arg_23_0.equipUI = var_1.New(arg_23_0._tf, arg_23_0)

	local var_23_4 = arg_23_0.equipUI

	var_1.show(var_23_4, false)

	SailBoatGameScene = var_1
	arg_23_0.gameScene = var_1.New(arg_23_0._tf, arg_23_0)

	arg_23_0:initBgAnimation()

	return
end

function var_0_1.initBgAnimation(arg_24_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_24_0 = var_1_10001(var_1_10002)
	local var_24_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_24_2 = var_24_1(var_24_0, var_1_10003.BOAT_QIAN_SHAO_ZHAN)

	getProxy = var_24_0
	TaskProxy = var_3

	local var_24_3 = var_24_0(var_3)
	local var_24_4 = {
		"Phase_00",
		"Phase_01",
		"Phase_02",
		"Phase_03",
		"Phase_04",
		"Phase_05",
		"Phase_06",
		"Phase_07"
	}
	local var_24_5 = var_24_2:getConfig("config_data")
	local var_24_6 = var_24_2.data3
	local var_24_7 = var_24_3

	if var_24_3.getFinishTaskById(var_24_7, var_24_5[var_24_6][1]) ~= nil then
		var_24_7 = var_24_3

		if var_24_3.getFinishTaskById(var_24_7, var_24_5[var_24_6][2]) ~= nil then
			var_24_6 = var_24_6 + 1
		end
	end

	GetComponent = var_6
	findTF = var_24_7

	local var_24_8 = var_24_7(arg_24_0._tf, "sceneBg/1")

	typeof = var_8
	Animator = var_9

	local var_24_9 = var_6(var_24_8, var_8(var_9))

	var_6.Play(var_24_9, var_24_4[var_24_6])

	return
end

function var_0_1.Update(arg_25_0)
	if arg_25_0.gameStop or arg_25_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_25_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_25_1, var_25_2

		if var_25_0(var_1_10002.S) then
			var_25_1 = arg_25_0.gameUI
			var_25_2 = var_25_2.press
			KeyCode = var_1_10003

			var_25_2(var_25_1, var_1_10003.S, true)
		end

		Input = var_25_2

		local var_25_3 = var_25_2.GetKeyUp

		KeyCode = var_25_1

		local var_25_4, var_25_5

		if var_25_3(var_25_1.S) then
			var_25_4 = arg_25_0.gameUI
			var_25_5 = var_25_5.press
			KeyCode = var_1_10003

			var_25_5(var_25_4, var_1_10003.S, false)
		end

		Input = var_25_5

		local var_25_6 = var_25_5.GetKeyDown

		KeyCode = var_25_4

		local var_25_7, var_25_8

		if var_25_6(var_25_4.W) then
			var_25_7 = arg_25_0.gameUI
			var_25_8 = var_25_8.press
			KeyCode = var_1_10003

			var_25_8(var_25_7, var_1_10003.W, true)
		end

		Input = var_25_8

		local var_25_9 = var_25_8.GetKeyUp

		KeyCode = var_25_7

		local var_25_10, var_25_11

		if var_25_9(var_25_7.W) then
			var_25_10 = arg_25_0.gameUI
			var_25_11 = var_25_11.press
			KeyCode = var_1_10003

			var_25_11(var_25_10, var_1_10003.W, false)
		end

		Input = var_25_11

		local var_25_12 = var_25_11.GetKeyDown

		KeyCode = var_25_10

		local var_25_13, var_25_14

		if var_25_12(var_25_10.A) then
			var_25_13 = arg_25_0.gameUI
			var_25_14 = var_25_14.press
			KeyCode = var_1_10003

			var_25_14(var_25_13, var_1_10003.A, true)
		end

		Input = var_25_14

		local var_25_15 = var_25_14.GetKeyUp

		KeyCode = var_25_13

		local var_25_16, var_25_17

		if var_25_15(var_25_13.A) then
			var_25_16 = arg_25_0.gameUI
			var_25_17 = var_25_17.press
			KeyCode = var_1_10003

			var_25_17(var_25_16, var_1_10003.A, false)
		end

		Input = var_25_17

		local var_25_18 = var_25_17.GetKeyDown

		KeyCode = var_25_16

		local var_25_19, var_25_20

		if var_25_18(var_25_16.D) then
			var_25_19 = arg_25_0.gameUI
			var_25_20 = var_25_20.press
			KeyCode = var_1_10003

			var_25_20(var_25_19, var_1_10003.D, true)
		end

		Input = var_25_20

		local var_25_21 = var_25_20.GetKeyUp

		KeyCode = var_25_19

		local var_25_22, var_25_23

		if var_25_21(var_25_19.D) then
			var_25_22 = arg_25_0.gameUI
			var_25_23 = var_25_23.press
			KeyCode = var_1_10003

			var_25_23(var_25_22, var_1_10003.D, false)
		end

		Input = var_25_23

		local var_25_24 = var_25_23.GetKeyDown

		KeyCode = var_25_22

		if var_25_24(var_25_22.J) then
			local var_25_25 = arg_25_0.gameScene
			local var_25_26 = var_1.press

			KeyCode = var_1_10003

			var_25_26(var_25_25, var_1_10003.J, true)
		end
	end

	return
end

function var_0_1.readyStart(arg_26_0)
	arg_26_0.readyStartFlag = true

	var_0_2.Prepare()

	local var_26_0 = arg_26_0.popUI

	var_1.readyStart(var_26_0)

	local var_26_1 = arg_26_0.menuUI

	var_1.show(var_26_1, false)

	local var_26_2 = arg_26_0.gameUI

	var_1.show(var_26_2, false)

	local var_26_3 = arg_26_0.equipUI

	var_1.show(var_26_3, false)

	setActive = var_1
	findTF = var_26_3

	var_1(var_26_3(arg_26_0._tf, "sceneBg"), false)

	return
end

function var_0_1.gameStart(arg_27_0)
	arg_27_0.readyStartFlag = false
	arg_27_0.gameStartFlag = true
	arg_27_0.sendSuccessFlag = false

	local var_27_0 = arg_27_0.popUI

	var_1.popCountUI(var_27_0, false)

	local var_27_1 = arg_27_0.gameUI

	var_1.start(var_27_1)

	local var_27_2 = arg_27_0.gameUI

	var_1.show(var_27_2, true)

	if arg_27_0.bgm ~= var_0_2.game_bgm then
		arg_27_0.bgm = var_0_2.game_bgm
		pg = var_1

		local var_27_3 = var_1.BgmMgr.GetInstance()

		var_1.Push(var_27_3, arg_27_0.__cname, var_0_2.game_bgm)
	end

	local var_27_4 = arg_27_0.gameScene

	var_1.start(var_27_4)
	arg_27_0:timerStart()

	return
end

function var_0_1.changeSpeed(arg_28_0, arg_28_1)
	return
end

function var_0_1.onTimer(arg_29_0)
	arg_29_0:gameStep()

	return
end

function var_0_1.gameStep(arg_30_0)
	arg_30_0:stepRunTimeData()

	local var_30_0 = arg_30_0.gameScene

	var_1.step(var_30_0, var_0_2.deltaTime)

	local var_30_1 = arg_30_0.gameUI

	var_1.step(var_30_1, var_0_2.deltaTime)

	if var_0_2.gameTime <= 0 then
		arg_30_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_31_0)
	if not arg_31_0.timer.running then
		local var_31_0 = arg_31_0.timer

		var_1.Start(var_31_0)
	end

	return
end

function var_0_1.timerResume(arg_32_0)
	if not arg_32_0.timer.running then
		local var_32_0 = arg_32_0.timer

		var_1.Start(var_32_0)
	end

	local var_32_1 = arg_32_0.gameScene

	var_1.resume(var_32_1)

	return
end

function var_0_1.timerStop(arg_33_0)
	if arg_33_0.timer.running then
		local var_33_0 = arg_33_0.timer

		var_1.Stop(var_33_0)
	end

	local var_33_1 = arg_33_0.gameScene

	var_1.stop(var_33_1)

	return
end

function var_0_1.stepRunTimeData(arg_34_0)
	Time = var_1_10001

	local var_34_0

	if var_1_10001.deltaTime > 0.016 then
		var_34_0 = 0.016
	end

	var_0_2.gameTime = var_0_2.gameTime - var_34_0
	var_0_2.gameStepTime = var_0_2.gameStepTime + var_34_0
	var_0_2.deltaTime = var_34_0

	local var_34_1 = var_0_2.GetSceneSpeed()

	var_34_1.x = var_0_2.moveAmount.x * var_34_0
	var_34_1.y = var_0_2.moveAmount.y * var_34_0

	var_0_2.SetSceneSpeed(var_34_1)

	return
end

function var_0_1.addScore(arg_35_0, arg_35_1)
	var_0_2.scoreNum = var_0_2.scoreNum + arg_35_1

	return
end

function var_0_1.onGameOver(arg_36_0)
	if arg_36_0.settlementFlag then
		return
	end

	arg_36_0:timerStop()
	arg_36_0:clearController()

	arg_36_0.settlementFlag = true
	setActive = var_1

	var_1(arg_36_0.clickMask, true)

	LeanTween = var_1

	local var_36_0 = var_1.delayedCall

	go = var_2

	local var_36_1 = var_2(arg_36_0._tf)
	local var_36_2 = 0.1

	System = var_1_10004

	var_36_0(var_36_1, var_36_2, var_1_10004.Action(function()
		arg_36_0.settlementFlag = false

		local var_37_0 = arg_36_0

		var_37_0.gameStartFlag = false
		setActive = var_37_0

		var_37_0(arg_36_0.clickMask, false)

		local var_37_1 = arg_36_0.popUI

		var_0.updateSettlementUI(var_37_1)

		local var_37_2 = arg_36_0.popUI

		var_0.popSettlementUI(var_37_2, true)

		return
	end))

	setActive = var_36_0
	findTF = var_36_1

	var_36_0(var_36_1(arg_36_0._tf, "sceneBg"), true)

	return
end

function var_0_1.OnApplicationPaused(arg_38_0)
	if not arg_38_0.gameStartFlag then
		return
	end

	if arg_38_0.readyStartFlag then
		return
	end

	if arg_38_0.settlementFlag then
		return
	end

	arg_38_0:pauseGame()

	local var_38_0 = arg_38_0.popUI

	var_1.popPauseUI(var_38_0)

	return
end

function var_0_1.clearController(arg_39_0)
	local var_39_0 = arg_39_0.gameScene

	var_1.clear(var_39_0)

	return
end

function var_0_1.pauseGame(arg_40_0)
	arg_40_0.gameStop = true

	arg_40_0:changeSpeed(0)
	arg_40_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_41_0)
	arg_41_0.gameStop = false

	arg_41_0:changeSpeed(1)
	arg_41_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_42_0)
	if arg_42_0.readyStartFlag then
		return
	end

	if not arg_42_0.gameStartFlag then
		arg_42_0:emit(var_0_1.ON_BACK_PRESSED)

		return
	else
		if arg_42_0.settlementFlag then
			return
		end

		local var_42_0 = arg_42_0.popUI

		var_1.backPressed(var_42_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_43_0, arg_43_1)
	return
end

function var_0_1.willExit(arg_44_0)
	if arg_44_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_44_0.handle)
	end

	if arg_44_0._tf then
		LeanTween = var_1

		local var_44_0 = var_1.isTweening

		go = var_1_10002

		if var_44_0(var_1_10002(arg_44_0._tf)) then
			LeanTween = var_1

			local var_44_1 = var_1.cancel

			go = var_2

			var_44_1(var_2(arg_44_0._tf))
		end
	end

	if arg_44_0.timer and arg_44_0.timer.running then
		local var_44_2 = arg_44_0.timer

		var_1.Stop(var_44_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_44_0.timer = nil

	var_0_2.Clear()

	return
end

return var_0_1
