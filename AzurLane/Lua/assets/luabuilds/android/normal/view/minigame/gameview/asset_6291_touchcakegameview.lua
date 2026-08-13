class = var_0_10000

local var_0_0 = "TouchCakeGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

import = var_0_0

local var_0_2 = var_0_0("view.miniGame.gameView.TouchCakeGame.TouchCakeGameVo")

import = var_2

local var_0_3 = var_2("view.miniGame.gameView.TouchCakeGame.TouchCakeGameConst")

import = var_3

local var_0_4 = var_3("view.miniGame.gameView.TouchCakeGame.TouchCakeGameEvent")

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
			arg_6_0.handle = var_1:CreateListener(arg_6_0.UpdateBeat, arg_6_0)
			UpdateBeat = var_1

			var_1:AddListener(arg_6_0.handle)
		end
	end

	arg_6_0:bind(var_0_4.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
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
	arg_6_0:bind(var_0_4.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0

		var_3.gameStart(var_8_0)

		return
	end)
	arg_6_0:bind(var_0_4.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_6_0
		local var_9_1 = var_3.emit

		BaseUI = var_2_10005

		var_9_1(var_9_0, var_2_10005.ON_HOME)

		return
	end)
	arg_6_0:bind(var_0_4.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_6_0.popUI

		var_3.popPauseUI(var_10_0)

		return
	end)
	arg_6_0:bind(var_0_4.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_6_0.popUI

		var_3.popLeaveUI(var_11_0)

		return
	end)
	arg_6_0:bind(var_0_4.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			local var_12_0 = arg_6_0

			var_3.pauseGame(var_12_0)
		else
			local var_12_1 = arg_6_0

			var_3.resumeGame(var_12_1)
		end

		return
	end)
	arg_6_0:bind(var_0_4.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		arg_6_0.gameStop = false

		local var_13_0 = arg_6_0.gameScene

		var_3.resume(var_13_0)

		local var_13_1 = arg_6_0.menuUI
		local var_13_2 = var_3.update
		local var_13_3 = arg_6_0

		var_13_2(var_13_1, var_5.GetMGHubData(var_13_3))

		local var_13_4 = arg_6_0.menuUI

		var_3.show(var_13_4, true)

		local var_13_5 = arg_6_0.gameUI

		var_3.show(var_13_5, false)

		local var_13_6 = arg_6_0.gameScene

		var_3.showContainer(var_13_6, false)

		local var_13_7 = arg_6_0

		var_3.changeBgm(var_13_7, var_0_3.bgm_type_default)

		return
	end)
	arg_6_0:bind(var_0_4.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_6_0

		var_3.closeView(var_14_0)

		return
	end)
	arg_6_0:bind(var_0_4.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_6_0

		var_3.onGameOver(var_15_0)

		return
	end)
	arg_6_0:bind(var_0_4.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg = var_2_10003

		local var_16_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_16_1 = var_3.ShowMsgBox
		local var_16_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_16_2.type = var_2_10006
		pg = var_2_10006
		var_16_2.helps = var_2_10006.gametip[var_0_2.rule_tip].tip

		var_16_1(var_16_0, var_16_2)

		return
	end)
	arg_6_0:bind(var_0_4.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_6_0

		var_3.getRankData(var_17_0)

		local var_17_1 = arg_6_0.popUI

		var_3.showRank(var_17_1, true)

		return
	end)
	arg_6_0:bind(var_0_4.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_6_0

		var_3.readyStart(var_18_0)

		return
	end)
	arg_6_0:bind(var_0_4.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy = var_2_10003
		MiniGameProxy = var_2_10004

		local var_19_0 = var_2_10003(var_2_10004)

		var_3.UpdataHighScore(var_19_0, var_0_2.game_id, arg_19_1)

		return
	end)
	arg_6_0:bind(var_0_4.PRESS_DIRECT, function(arg_20_0, arg_20_1, arg_20_2)
		if arg_6_0.gameScene then
			local var_20_0 = arg_6_0.gameScene

			var_3.touchDirect(var_20_0, arg_20_1, true)
		end

		return
	end)
	arg_6_0:bind(var_0_4.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			local var_21_0 = arg_6_0

			var_3.SendSuccess(var_21_0, 0)
		end

		return
	end)
	arg_6_0:bind(var_0_4.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_6_0

		var_3.addScore(var_22_0, arg_22_1)

		local var_22_1 = arg_6_0.gameUI

		var_3.updateScore(var_22_1)

		return
	end)
	arg_6_0:bind(var_0_4.ADD_COMBO, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_6_0

		var_3.addCombo(var_23_0)

		local var_23_1 = arg_6_0.gameUI

		var_3.updateCombo(var_23_1)

		return
	end)
	arg_6_0:bind(var_0_4.PLAYER_DIZZI, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_6_0

		var_3.clearCombo(var_24_0)

		local var_24_1 = arg_6_0.gameUI

		var_3.updateCombo(var_24_1)

		return
	end)
	arg_6_0:bind(var_0_4.PLAYER_BOOM, function(arg_25_0, arg_25_1, arg_25_2)
		local var_25_0 = arg_6_0

		var_3.clearCombo(var_25_0)

		local var_25_1 = arg_6_0.gameUI

		var_3.updateCombo(var_25_1)

		return
	end)

	return
end

function var_0_1.initUI(arg_26_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001
		findTF = var_1_10002

		var_1_10001(var_1_10002(arg_26_0._tf, "tpl"), false)
	end

	findTF = var_1_10001
	arg_26_0.clickMask = var_1_10001(arg_26_0._tf, "clickMask")
	TouchCakePopUI = var_1
	arg_26_0.popUI = var_1.New(arg_26_0._tf, arg_26_0)

	local var_26_0 = arg_26_0.popUI

	var_1.clearUI(var_26_0)

	TouchCakeGamingUI = var_1
	arg_26_0.gameUI = var_1.New(arg_26_0._tf, arg_26_0)

	local var_26_1 = arg_26_0.gameUI

	var_1.show(var_26_1, false)

	TouchCakeMenuUI = var_1
	arg_26_0.menuUI = var_1.New(arg_26_0._tf, arg_26_0)

	local var_26_2 = arg_26_0.menuUI

	var_1.update(var_26_2, arg_26_0:GetMGHubData())

	local var_26_3 = arg_26_0.menuUI

	var_1.show(var_26_3, true)

	TouchCakeScene = var_1
	arg_26_0.gameScene = var_1.New(arg_26_0._tf, arg_26_0)

	return
end

function var_0_1.changeBgm(arg_27_0, arg_27_1)
	local var_27_0

	if arg_27_1 == var_0_3.bgm_type_default then
		if not arg_27_0:getBGM() then
			pg = var_3

			local var_27_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_27_1) then
				pg = var_3
				var_27_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_27_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	elseif arg_27_1 == var_0_3.bgm_type_menu then
		var_27_0 = var_0_2.menu_bgm
	elseif arg_27_1 == var_0_3.bgm_type_game then
		var_27_0 = var_0_2.game_bgm
	end

	if arg_27_0.bgm ~= var_27_0 then
		arg_27_0.bgm = var_27_0
		pg = var_3

		local var_27_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_27_2, arg_27_0.__cname, var_27_0)
	end

	return
end

function var_0_1.UpdateBeat(arg_28_0)
	if arg_28_0.gameStop or arg_28_0.settlementFlag or not arg_28_0.gameStartFlag then
		return
	end

	Input = var_1

	local var_28_0 = var_1.GetKeyDown

	KeyCode = var_1_10002

	local var_28_1, var_28_2

	if var_28_0(var_1_10002.A) then
		var_28_1 = arg_28_0.gameScene
		var_28_2 = var_28_2.press
		KeyCode = var_1_10003

		var_28_2(var_28_1, var_1_10003.A, true)
	else
		Input = var_28_2

		local var_28_3 = var_28_2.GetKeyDown

		KeyCode = var_28_1

		if var_28_3(var_28_1.D) then
			local var_28_4 = arg_28_0.gameScene
			local var_28_5 = var_1.press

			KeyCode = var_1_10003

			var_28_5(var_28_4, var_1_10003.D, true)
		end
	end

	return
end

function var_0_1.readyStart(arg_29_0)
	arg_29_0.readyStartFlag = true

	var_0_2.Prepare()

	local var_29_0 = arg_29_0.popUI

	var_1.readyStart(var_29_0)

	local var_29_1 = arg_29_0.menuUI

	var_1.show(var_29_1, false)

	local var_29_2 = arg_29_0.gameUI

	var_1.show(var_29_2, false)

	return
end

function var_0_1.gameStart(arg_30_0)
	arg_30_0.readyStartFlag = false
	arg_30_0.gameStartFlag = true
	arg_30_0.sendSuccessFlag = false

	local var_30_0 = arg_30_0.popUI

	var_1.popCountUI(var_30_0, false)

	local var_30_1 = arg_30_0.gameUI

	var_1.start(var_30_1)

	local var_30_2 = arg_30_0.gameUI

	var_1.show(var_30_2, true)

	local var_30_3 = arg_30_0.gameScene

	var_1.start(var_30_3)
	arg_30_0:timerStart()
	arg_30_0:changeBgm(var_0_3.bgm_type_game)

	return
end

function var_0_1.onTimer(arg_31_0)
	arg_31_0:gameStep()

	return
end

function var_0_1.gameStep(arg_32_0)
	arg_32_0:stepRunTimeData()

	local var_32_0 = arg_32_0.gameScene

	var_1.step(var_32_0, var_0_2.deltaTime)

	local var_32_1 = arg_32_0.gameUI

	var_1.step(var_32_1, var_0_2.deltaTime)

	if var_0_2.gameTime <= 0 then
		var_0_2.gameTime = 0

		arg_32_0:onGameOver()
	end

	return
end

function var_0_1.timerStart(arg_33_0)
	if not arg_33_0.timer.running then
		local var_33_0 = arg_33_0.timer

		var_1.Start(var_33_0)
	end

	return
end

function var_0_1.timerResume(arg_34_0)
	if not arg_34_0.timer.running then
		local var_34_0 = arg_34_0.timer

		var_1.Start(var_34_0)
	end

	local var_34_1 = arg_34_0.gameScene

	var_1.resume(var_34_1)

	return
end

function var_0_1.timerStop(arg_35_0)
	if arg_35_0.timer.running then
		local var_35_0 = arg_35_0.timer

		var_1.Stop(var_35_0)
	end

	return
end

function var_0_1.stepRunTimeData(arg_36_0)
	Time = var_1_10001

	local var_36_0 = var_1_10001.deltaTime

	var_0_2.gameTime = var_0_2.gameTime - var_36_0
	var_0_2.gameStepTime = var_0_2.gameStepTime + var_36_0
	var_0_2.deltaTime = var_36_0

	return
end

function var_0_1.addScore(arg_37_0, arg_37_1)
	var_0_2.scoreNum = var_0_2.scoreNum + arg_37_1

	return
end

function var_0_1.addCombo(arg_38_0)
	var_0_2.comboNum = var_0_2.comboNum + 1

	return
end

function var_0_1.clearCombo(arg_39_0)
	var_0_2.comboNum = 0

	return
end

function var_0_1.onGameOver(arg_40_0)
	if arg_40_0.settlementFlag then
		return
	end

	arg_40_0:pauseGame()
	arg_40_0:clearController()

	arg_40_0.settlementFlag = true
	setActive = var_1

	var_1(arg_40_0.clickMask, true)

	LeanTween = var_1

	local var_40_0 = var_1.delayedCall

	go = var_2

	local var_40_1 = var_2(arg_40_0._tf)
	local var_40_2 = 0.1

	System = var_1_10004

	var_40_0(var_40_1, var_40_2, var_1_10004.Action(function()
		arg_40_0.settlementFlag = false

		local var_41_0 = arg_40_0

		var_41_0.gameStartFlag = false
		setActive = var_41_0

		var_41_0(arg_40_0.clickMask, false)

		local var_41_1 = arg_40_0.popUI

		var_0.updateSettlementUI(var_41_1)

		local var_41_2 = arg_40_0.popUI

		var_0.popSettlementUI(var_41_2, true)

		local var_41_3 = arg_40_0

		var_0.OnApplicationPaused(var_41_3)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_42_0)
	if not arg_42_0.gameStartFlag then
		return
	end

	if arg_42_0.readyStartFlag then
		return
	end

	if arg_42_0.settlementFlag then
		return
	end

	arg_42_0:pauseGame()

	local var_42_0 = arg_42_0.popUI

	var_1.popPauseUI(var_42_0)

	return
end

function var_0_1.clearController(arg_43_0)
	local var_43_0 = arg_43_0.gameScene

	var_1.clear(var_43_0)

	return
end

function var_0_1.pauseGame(arg_44_0)
	arg_44_0.gameStop = true

	local var_44_0 = arg_44_0.gameScene

	var_1.stop(var_44_0)
	arg_44_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_45_0)
	arg_45_0.gameStop = false

	local var_45_0 = arg_45_0.gameScene

	var_1.resume(var_45_0)
	arg_45_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_46_0)
	if arg_46_0.readyStartFlag then
		return
	end

	if not arg_46_0.gameStartFlag then
		arg_46_0:closeView()

		return
	else
		if arg_46_0.settlementFlag then
			return
		end

		local var_46_0 = arg_46_0.popUI

		var_1.backPressed(var_46_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_47_0, arg_47_1)
	return
end

function var_0_1.getRankData(arg_48_0)
	pg = var_1_10001

	local var_48_0 = var_1_10001.m02
	local var_48_1 = var_1.sendNotification

	GAME = var_1_10003

	var_48_1(var_48_0, var_1_10003.MINI_GAME_FRIEND_RANK, {
		id = var_0_2.game_id,
		callback = function(arg_49_0)
			local var_49_0 = {}

			for iter_49_0 = 1, #arg_49_0 do
				local var_49_1 = {}

				pairs = var_2_10007

				for iter_49_1, iter_49_2 in var_2_10007(arg_49_0[iter_49_0]) do
					var_49_1[iter_49_1] = iter_49_2
				end

				table = var_2_10007

				var_2_10007.insert(var_49_0, var_49_1)
			end

			table = var_2

			var_2.sort(var_49_0, function(arg_50_0, arg_50_1)
				if arg_50_0.score ~= arg_50_1.score then
					return arg_50_0.score > arg_50_1.score
				elseif arg_50_0.time_data ~= arg_50_1.time_data then
					return arg_50_0.time_data > arg_50_1.time_data
				else
					return arg_50_0.player_id < arg_50_1.player_id
				end

				return
			end)

			local var_49_2 = arg_48_0.popUI

			var_2.updateRankData(var_49_2, var_49_0)

			return
		end
	})

	return
end

function var_0_1.willExit(arg_51_0)
	if arg_51_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_51_0.handle)
	end

	if arg_51_0._tf then
		LeanTween = var_1

		local var_51_0 = var_1.isTweening

		go = var_1_10002

		if var_51_0(var_1_10002(arg_51_0._tf)) then
			LeanTween = var_1

			local var_51_1 = var_1.cancel

			go = var_2

			var_51_1(var_2(arg_51_0._tf))
		end
	end

	if arg_51_0.timer and arg_51_0.timer.running then
		local var_51_2 = arg_51_0.timer

		var_1.Stop(var_51_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_51_0.timer = nil

	if arg_51_0.gameUI then
		local var_51_3 = arg_51_0.gameUI

		var_1.dispose(var_51_3)
	end

	var_0_2.Clear()

	return
end

return var_0_1
