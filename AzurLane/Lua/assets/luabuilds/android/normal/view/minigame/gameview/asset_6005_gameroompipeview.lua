class = var_0_10000

local var_0_0 = "GameRoomPipeView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

import = var_0_0

local var_0_2 = var_0_0("view.miniGame.gameView.PipeGame.PipeGameVo")

function var_0_1.getUIName(arg_1_0)
	return var_0_2.game_room_ui
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

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.bind

	PipeGameEvent = var_1_10003

	var_6_1(var_6_0, var_1_10003.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			local var_7_0 = arg_6_0

			var_3.resumeGame(var_7_0)

			local var_7_1 = arg_6_0.gameScene

			var_3.setGameOver(var_7_1)
		else
			local var_7_2 = arg_6_0

			var_3.resumeGame(var_7_2)
		end

		return
	end)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_3(var_6_2, var_3.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_6_0

		var_3.gameStart(var_8_0)

		return
	end)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_5(var_6_4, var_3.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_6_0
		local var_9_1 = var_3.emit

		BaseUI = var_2_10005

		var_9_1(var_9_0, var_2_10005.ON_HOME)

		return
	end)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_7(var_6_6, var_3.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_6_0.popUI

		var_3.popPauseUI(var_10_0)

		return
	end)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_9(var_6_8, var_3.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_6_0.popUI

		var_3.popLeaveUI(var_11_0)

		return
	end)

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_11(var_6_10, var_3.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			local var_12_0 = arg_6_0

			var_3.pauseGame(var_12_0)
		else
			local var_12_1 = arg_6_0

			var_3.resumeGame(var_12_1)
		end

		return
	end)

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_13(var_6_12, var_3.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_6_0.menuUI
		local var_13_1 = var_3.update
		local var_13_2 = arg_6_0

		var_13_1(var_13_0, var_5.GetMGHubData(var_13_2))

		local var_13_3 = arg_6_0.menuUI

		var_3.show(var_13_3, true)

		local var_13_4 = arg_6_0.gameUI

		var_3.show(var_13_4, false)

		local var_13_5 = arg_6_0.gameScene

		var_3.showContainer(var_13_5, false)

		local var_13_6 = arg_6_0
		local var_13_7 = var_3.changeBgm

		PipeGameConst = var_5

		var_13_7(var_13_6, var_5.bgm_type_default)

		local var_13_8 = arg_6_0

		var_3.openCoinLayer(var_13_8, true)

		return
	end)

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_15(var_6_14, var_3.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_6_0

		var_3.closeView(var_14_0)

		return
	end)

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_17(var_6_16, var_3.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_6_0

		var_3.onGameOver(var_15_0)

		return
	end)

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_19(var_6_18, var_3.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_6_0

		var_3.openCoinLayer(var_16_0, not arg_16_1)

		return
	end)

	local var_6_20 = arg_6_0
	local var_6_21 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_21(var_6_20, var_3.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_6_0

		var_3.getRankData(var_17_0)

		local var_17_1 = arg_6_0.popUI

		var_3.showRank(var_17_1, arg_17_1)

		return
	end)

	local var_6_22 = arg_6_0
	local var_6_23 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_23(var_6_22, var_3.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_6_0

		var_3.readyStart(var_18_0)

		return
	end)

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_25(var_6_24, var_3.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy = var_2_10003
		MiniGameProxy = var_2_10004

		local var_19_0 = var_2_10003(var_2_10004)

		var_3.UpdataHighScore(var_19_0, var_0_2.game_id, arg_19_1)

		return
	end)

	local var_6_26 = arg_6_0
	local var_6_27 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_27(var_6_26, var_3.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_6_0

		var_3.SendSuccess(var_20_0, var_0_2.scoreNum)

		return
	end)

	local var_6_28 = arg_6_0
	local var_6_29 = arg_6_0.bind

	PipeGameEvent = var_3

	var_6_29(var_6_28, var_3.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_6_0

		var_3.addScore(var_21_0, arg_21_1.num)

		local var_21_1 = arg_6_0.gameUI

		var_3.addScore(var_21_1, arg_21_1)

		return
	end)

	return
end

function var_0_1.initUI(arg_22_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001
		findTF = var_1_10002

		var_1_10001(var_1_10002(arg_22_0._tf, "tpl"), false)
	end

	findTF = var_1_10001
	arg_22_0.clickMask = var_1_10001(arg_22_0._tf, "clickMask")
	PipeGamePopUI = var_1
	arg_22_0.popUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_0 = arg_22_0.popUI

	var_1.clearUI(var_22_0)

	PipeGamingUI = var_1
	arg_22_0.gameUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_1 = arg_22_0.gameUI

	var_1.show(var_22_1, false)

	PipeGameMenuUI = var_1
	arg_22_0.menuUI = var_1.New(arg_22_0._tf, arg_22_0)

	local var_22_2 = arg_22_0.menuUI

	var_1.update(var_22_2, arg_22_0:GetMGHubData())

	local var_22_3 = arg_22_0.menuUI

	var_1.setGameRoomUI(var_22_3, arg_22_0:getGameRoomData() and true or false)

	local var_22_4 = arg_22_0.menuUI

	var_1.show(var_22_4, true)

	PipeGameScene = var_1
	arg_22_0.gameScene = var_1.New(arg_22_0._tf, arg_22_0)

	return
end

function var_0_1.changeBgm(arg_23_0, arg_23_1)
	local var_23_0

	PipeGameConst = var_1_10003

	if arg_23_1 == var_1_10003.bgm_type_default then
		if not arg_23_0:getBGM() then
			pg = var_3

			local var_23_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_23_1) then
				pg = var_3
				var_23_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_23_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	else
		PipeGameConst = var_3

		if arg_23_1 == var_3.bgm_type_menu then
			var_23_0 = var_0_2.menu_bgm
		else
			PipeGameConst = var_3

			if arg_23_1 == var_3.bgm_type_game then
				var_23_0 = var_0_2.game_bgm
			end
		end
	end

	if arg_23_0.bgm ~= var_23_0 then
		arg_23_0.bgm = var_23_0
		pg = var_3

		local var_23_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_23_2, arg_23_0.__cname, var_23_0)
	end

	return
end

function var_0_1.UpdateBeat(arg_24_0)
	if arg_24_0.gameStop or arg_24_0.settlementFlag then
		return
	end

	return
end

function var_0_1.readyStart(arg_25_0)
	arg_25_0.readyStartFlag = true

	var_0_2.Prepare()

	local var_25_0 = arg_25_0.popUI

	var_1.readyStart(var_25_0)

	local var_25_1 = arg_25_0.menuUI

	var_1.show(var_25_1, false)

	local var_25_2 = arg_25_0.gameUI

	var_1.show(var_25_2, false)
	arg_25_0:openCoinLayer(false)

	return
end

function var_0_1.gameStart(arg_26_0)
	arg_26_0.readyStartFlag = false
	arg_26_0.gameStartFlag = true
	arg_26_0.sendSuccessFlag = false

	local var_26_0 = arg_26_0.popUI

	var_1.popCountUI(var_26_0, false)

	local var_26_1 = arg_26_0.gameUI

	var_1.start(var_26_1)

	local var_26_2 = arg_26_0.gameUI

	var_1.show(var_26_2, true)

	local var_26_3 = arg_26_0.gameScene

	var_1.start(var_26_3)
	arg_26_0:timerStart()

	local var_26_4 = arg_26_0
	local var_26_5 = arg_26_0.changeBgm

	PipeGameConst = var_3

	var_26_5(var_26_4, var_3.bgm_type_game)

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

	var_1.step(var_29_0, var_0_2.deltaTime)

	local var_29_1 = arg_29_0.gameUI

	var_1.step(var_29_1, var_0_2.deltaTime)

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

	var_0_2.gameTime = var_0_2.gameTime - var_33_0

	if not var_0_2.startSettlement then
		var_0_2.gameDragTime = var_0_2.gameDragTime - var_33_0

		if var_0_2.gameDragTime < 0 then
			var_0_2.gameDragTime = 0
		end
	end

	var_0_2.gameStepTime = var_0_2.gameStepTime + var_33_0
	var_0_2.deltaTime = var_33_0

	return
end

function var_0_1.addScore(arg_34_0, arg_34_1)
	var_0_2.scoreNum = var_0_2.scoreNum + arg_34_1

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

function var_0_1.getRankData(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.m02
	local var_41_1 = var_1.sendNotification

	GAME = var_1_10003

	var_41_1(var_41_0, var_1_10003.MINI_GAME_FRIEND_RANK, {
		id = var_0_2.game_id,
		callback = function(arg_42_0)
			local var_42_0 = {}

			for iter_42_0 = 1, #arg_42_0 do
				local var_42_1 = {}

				pairs = var_2_10007

				for iter_42_1, iter_42_2 in var_2_10007(arg_42_0[iter_42_0]) do
					var_42_1[iter_42_1] = iter_42_2
				end

				table = var_2_10007

				var_2_10007.insert(var_42_0, var_42_1)
			end

			table = var_2

			var_2.sort(var_42_0, function(arg_43_0, arg_43_1)
				if arg_43_0.score ~= arg_43_1.score then
					return arg_43_0.score > arg_43_1.score
				elseif arg_43_0.time_data ~= arg_43_1.time_data then
					return arg_43_0.time_data > arg_43_1.time_data
				else
					return arg_43_0.player_id < arg_43_1.player_id
				end

				return
			end)

			local var_42_2 = arg_41_0.popUI

			var_2.updateRankData(var_42_2, var_42_0)

			return
		end
	})

	return
end

function var_0_1.onBackPressed(arg_44_0)
	if arg_44_0.readyStartFlag then
		return
	end

	if not arg_44_0.gameStartFlag then
		return
	else
		if arg_44_0.settlementFlag then
			return
		end

		local var_44_0 = arg_44_0.popUI

		var_1.backPressed(var_44_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_45_0, arg_45_1)
	return
end

function var_0_1.willExit(arg_46_0)
	if arg_46_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_46_0.handle)
	end

	if arg_46_0._tf then
		LeanTween = var_1

		local var_46_0 = var_1.isTweening

		go = var_1_10002

		if var_46_0(var_1_10002(arg_46_0._tf)) then
			LeanTween = var_1

			local var_46_1 = var_1.cancel

			go = var_2

			var_46_1(var_2(arg_46_0._tf))
		end
	end

	if arg_46_0.timer and arg_46_0.timer.running then
		local var_46_2 = arg_46_0.timer

		var_1.Stop(var_46_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_46_0.timer = nil

	var_0_2.Clear()

	return
end

return var_0_1
