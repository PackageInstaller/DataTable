class = var_0_10000

local var_0_0 = "CrossRoadGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = 89

var_0_1.LEAVEL_GAME = "leavel game"
var_0_1.OPEN_LEAVEL_UI = "open leave ui"
var_0_1.SUB_LIFE = "sub life"
var_0_1.ADD_LIFE = "add life"
var_0_1.AGAIN = "reGameAgain"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	CrossRoadGameVo = var_1
	arg_1_0._gameVo = var_1.New(var_0_2)

	return
end

function var_0_1.getUIName(arg_2_0)
	CrossRoadGameConst = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.getBGM(arg_3_0)
	CrossRoadGameConst = var_1_10001

	return var_1_10001.menu_bgm
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()

	return
end

function var_0_1.initEvent(arg_5_0)
	if not arg_5_0.handle then
		UpdateBeat = var_1
		arg_5_0.handle = var_1:CreateListener(arg_5_0.OnUpdate, arg_5_0)
		UpdateBeat = var_1

		var_1:AddListener(arg_5_0.handle)
	end

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	CrossRoadGameView = var_1_10003

	var_5_1(var_5_0, var_1_10003.LEAVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			local var_6_0 = arg_5_0

			var_3.resumeGame(var_6_0)

			local var_6_1 = arg_5_0

			var_3.onGameOver(var_6_1, false)
		else
			local var_6_2 = arg_5_0

			var_3.resumeGame(var_6_2)
		end

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_3(var_5_2, var_3.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_5_0

		var_3.gameStart(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_5(var_5_4, var_3.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0
		local var_8_1 = var_3.emit

		BaseUI = var_2_10005

		var_8_1(var_8_0, var_2_10005.ON_HOME)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_7(var_5_6, var_3.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_5_0.popUI

		var_3.PopPauseUI(var_9_0)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	CrossRoadGameView = var_3

	var_5_9(var_5_8, var_3.OPEN_LEAVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_5_0.popUI

		var_3.PopLeaveUI(var_10_0)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_11(var_5_10, var_3.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			local var_11_0 = arg_5_0

			var_3.pauseGame(var_11_0)
		else
			local var_11_1 = arg_5_0

			var_3.resumeGame(var_11_1)
		end

		return
	end)

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_13(var_5_12, var_3.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_5_0.gameScene

		var_3.ShowContainer(var_12_0, false)

		local var_12_1 = arg_5_0
		local var_12_2 = var_3.changeBgm

		SortGameConst = var_5

		var_12_2(var_12_1, var_5.menu_bgm)

		local var_12_3 = arg_5_0

		var_3.closeView(var_12_3)

		return
	end)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_15(var_5_14, var_3.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_5_0

		var_3.closeView(var_13_0)

		return
	end)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_17(var_5_16, var_3.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg = var_2_10003

		local var_14_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_14_1 = var_3.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_14_2.type = var_2_10006
		pg = var_2_10006
		var_14_2.helps = var_2_10006.gametip.crossroad_minigame_help.tip

		var_14_1(var_14_0, var_14_2)

		return
	end)

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_19(var_5_18, var_3.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_5_0

		var_3.readyStart(var_15_0)

		return
	end)

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_21(var_5_20, var_3.ADD_SCORE, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_5_0

		var_3.addScore(var_16_0, arg_16_1.score)

		return
	end)

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.bind

	CrossRoadGameView = var_3

	var_5_23(var_5_22, var_3.SUB_LIFE, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_5_0

		var_3.changeLife(var_17_0, -1)

		return
	end)

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.bind

	CrossRoadGameView = var_3

	var_5_25(var_5_24, var_3.ADD_LIFE, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_5_0
		local var_18_1 = var_3.changeLife

		CrossRoadGameConst = var_2_10005

		var_18_1(var_18_0, var_2_10005.HONGCHA_GET_LIFE)

		return
	end)

	local var_5_26 = arg_5_0
	local var_5_27 = arg_5_0.bind

	CrossRoadGameView = var_3

	var_5_27(var_5_26, var_3.AGAIN, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = arg_5_0

		var_3.readyStart(var_19_0)

		return
	end)

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_29(var_5_28, var_3.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			local var_20_0 = arg_5_0

			var_3.SendSuccess(var_20_0, 0)

			getProxy = var_3
			MiniGameProxy = var_20_0

			local var_20_1 = var_3(var_20_0)

			var_3.UpdataHighScore(var_20_1, var_0_2, {
				arg_20_1.num,
				arg_20_1.cnt
			})
		end

		return
	end)

	return
end

function var_0_1.initUI(arg_21_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_21_0._tf, "tpl"), false)

	findTF = var_1_10001
	arg_21_0.clickMask = var_1_10001(arg_21_0._tf, "clickMask")
	findTF = var_1
	arg_21_0.menuUIbg1 = var_1(arg_21_0._tf, "ui/bg")
	findTF = var_1
	arg_21_0.menuUIbg2 = var_1(arg_21_0._tf, "ui/bg_1")
	CrossRoadPopUI = var_1
	arg_21_0.popUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_0 = arg_21_0.popUI

	var_1.ClearUI(var_21_0)

	CrossRoadGamingUI = var_1
	arg_21_0.gameUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_1 = arg_21_0.gameUI

	var_1.Show(var_21_1, false)

	CrossRoadMenuUI = var_1
	arg_21_0.menuUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_2 = arg_21_0.menuUI

	var_1.Update(var_21_2)

	local var_21_3 = arg_21_0.menuUI

	var_1.Show(var_21_3, true)

	setActive = var_1

	var_1(arg_21_0.menuUIbg1, true)

	setActive = var_1

	var_1(arg_21_0.menuUIbg2, true)

	CrossRoadScene = var_1
	arg_21_0.gameScene = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_4 = arg_21_0.gameScene

	var_1.ShowContainer(var_21_4, true)

	return
end

function var_0_1.changeBgm(arg_22_0, arg_22_1)
	local var_22_0

	PipeGameConst = var_1_10003

	if arg_22_1 == var_1_10003.bgm_type_default then
		if not arg_22_0:getBGM() then
			pg = var_3

			local var_22_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_22_1) then
				pg = var_3
				var_22_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_22_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	else
		PipeGameConst = var_3

		if arg_22_1 == var_3.bgm_type_menu then
			CrossRoadGameConst = var_3
			var_22_0 = var_3.menu_bgm
		else
			PipeGameConst = var_3

			if arg_22_1 == var_3.bgm_type_game then
				CrossRoadGameConst = var_3
				var_22_0 = var_3.game_bgm
			end
		end
	end

	if arg_22_0.bgm ~= var_22_0 then
		arg_22_0.bgm = var_22_0
		pg = var_3

		local var_22_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_22_2, arg_22_0.__cname, var_22_0)
	end

	return
end

function var_0_1.OnUpdate(arg_23_0)
	arg_23_0:gameStep()

	return
end

function var_0_1.readyStart(arg_24_0)
	arg_24_0.readyStartFlag = true

	local var_24_0 = arg_24_0._gameVo

	var_1.Prepare(var_24_0)

	local var_24_1 = arg_24_0.popUI

	var_1.ReadyStart(var_24_1)

	local var_24_2 = arg_24_0.menuUI

	var_1.Show(var_24_2, false)

	local var_24_3 = arg_24_0.gameUI

	var_1.Show(var_24_3, false)

	setActive = var_1

	var_1(arg_24_0.menuUIbg1, false)

	setActive = var_1

	var_1(arg_24_0.menuUIbg2, false)

	local var_24_4 = arg_24_0.gameScene

	var_1.Prepare(var_24_4)

	return
end

function var_0_1.gameStart(arg_25_0)
	arg_25_0.readyStartFlag = false
	arg_25_0.gameStartFlag = true
	arg_25_0.sendSuccessFlag = false

	local var_25_0 = arg_25_0.popUI

	var_1.PopCountUI(var_25_0, false)

	local var_25_1 = arg_25_0.gameUI

	var_1.Start(var_25_1)

	local var_25_2 = arg_25_0.gameUI

	var_1.Show(var_25_2, true)

	local var_25_3 = arg_25_0.gameScene

	var_1.Start(var_25_3)
	arg_25_0:timerStart()

	local var_25_4 = arg_25_0
	local var_25_5 = arg_25_0.changeBgm

	PipeGameConst = var_3

	var_25_5(var_25_4, var_3.bgm_type_game)

	return
end

function var_0_1.gameStep(arg_26_0)
	if arg_26_0.gameStartFlag and not arg_26_0.gameStop and not arg_26_0.settlementFlag then
		arg_26_0:stepRunTimeData()

		local var_26_0 = arg_26_0.gameUI

		var_1.Step(var_26_0)

		local var_26_1 = arg_26_0.gameScene

		var_1.Step(var_26_1)

		local var_26_2 = arg_26_0._gameVo

		if var_1.GetTime(var_26_2) <= 0 then
			arg_26_0:onGameOver()
		end
	end

	return
end

function var_0_1.timerStart(arg_27_0)
	arg_27_0.gamestop = false

	return
end

function var_0_1.timerStop(arg_28_0)
	arg_28_0.gamestop = true

	local var_28_0 = arg_28_0.gameScene

	var_1.Stop(var_28_0)

	return
end

function var_0_1.stepRunTimeData(arg_29_0)
	local var_29_0 = arg_29_0._gameVo
	local var_29_1 = var_1.Step

	Time = var_1_10003

	var_29_1(var_29_0, var_1_10003.deltaTime)

	return
end

function var_0_1.addScore(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._gameVo

	var_2.AddScore(var_30_0, arg_30_1)

	return
end

function var_0_1.changeLife(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._gameVo

	if var_2.GetLife(var_31_0) + arg_31_1 <= 0 then
		arg_31_0:onGameOver()

		return
	end

	local var_31_1 = arg_31_0._gameVo

	var_4.changeLife(var_31_1, arg_31_1)

	return
end

function var_0_1.onGameOver(arg_32_0, arg_32_1)
	if arg_32_0.settlementFlag then
		return
	end

	arg_32_0:timerStop()

	local var_32_0 = arg_32_0._gameVo

	var_2.SetSettlement(var_32_0, true)

	arg_32_0.settlementFlag = true
	arg_32_0.gameStartFlag = false
	setActive = var_2

	var_2(arg_32_0.clickMask, true)

	LeanTween = var_2

	local var_32_1 = var_2.delayedCall

	go = var_3

	local var_32_2 = var_3(arg_32_0._tf)
	local var_32_3 = 0.1

	System = var_1_10005

	var_32_1(var_32_2, var_32_3, var_1_10005.Action(function()
		arg_32_0.settlementFlag = false

		local var_33_0 = arg_32_0

		var_0.clearController(var_33_0)

		local var_33_1 = arg_32_0._gameVo

		var_0.SetSettlement(var_33_1, false)

		setActive = var_0

		var_0(arg_32_0.clickMask, false)

		local var_33_2 = arg_32_0.popUI

		var_0.UpdateSettlementUI(var_33_2)

		local var_33_3 = arg_32_0.popUI

		var_0.PopSettlementUI(var_33_3, true)

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

	var_1.PopPauseUI(var_34_0)

	return
end

function var_0_1.clearController(arg_35_0)
	local var_35_0 = arg_35_0.gameScene

	var_1.Clear(var_35_0)

	return
end

function var_0_1.pauseGame(arg_36_0)
	arg_36_0.gameStop = true

	arg_36_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_37_0)
	arg_37_0.gameStop = false

	arg_37_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_38_0)
	if arg_38_0.gameStartFlag and not arg_38_0.settlementFlag and not arg_38_0.readyStartFlag then
		local var_38_0 = arg_38_0.popUI

		var_1.BackPressed(var_38_0)
	end

	if not arg_38_0.gameStartFlag and not arg_38_0.settlementFlag and not arg_38_0.readyStartFlag then
		local var_38_1 = arg_38_0.menuUI

		var_1.Show(var_38_1, false)
		arg_38_0:closeView()
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

	local var_40_0

	if arg_40_0._tf then
		LeanTween = var_40_0
		var_40_0 = var_40_0.isTweening
		go = var_1_10002

		if var_40_0(var_1_10002(arg_40_0._tf)) then
			LeanTween = var_40_0
			var_40_0 = var_40_0.cancel
			go = var_2

			var_40_0(var_2(arg_40_0._tf))
		end
	end

	Time = var_40_0
	var_40_0.timeScale = 1

	if arg_40_0._gameVo then
		local var_40_1 = arg_40_0._gameVo

		var_1.Clear(var_40_1)

		arg_40_0._gameVo = nil
	end

	return
end

return var_0_1
